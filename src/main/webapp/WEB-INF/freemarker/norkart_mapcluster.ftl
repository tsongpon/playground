<html>
<head>
        <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
        <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
        <link rel="stylesheet" href="http://www.webatlas.no/sh/3/v/220415/webatlas.css" />
        <script src="http://www.webatlas.no/sh/3/v/220415/webatlas.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/MarkerCluster.css" />
        <link rel="stylesheet" href="css/MarkerCluster.Default.css" />
        <script src="js/leaflet/leaflet.markercluster-geopoint-src.js"></script>
        <script src="js/leaflet/leaflet.spin.js"></script>
        <script src="js/leaflet/spin.min.js"></script>

        <style>
            body { margin:0; padding:0; }
            #map { position: absolute; top:0; bottom:0; right:0; left:0; }
            .content {
                text-align:center;
            }
            .slideshow .slider        { display:none; }
            .slideshow .slider.active { display:block; }
            .content img {
                width:100%;
            }
            .content .caption {
                background:#eee;
                padding:10px;
            }
            .popup .cycle {
                padding:10px 0 20px;
            }
            .popup .cycle a.prev { float:left; }
            .popup .cycle a.next { float:right; }

            popup-close-button {
                position: absolute;
                top: 0;
                right: 0;
                padding: 4px 4px 0 0;
                text-align: center;
                width: 18px;
                height: 14px;
                font: 16px/14px Tahoma, Verdana, sans-serif;
                color: #c3c3c3;
                text-decoration: none;
                font-weight: bold;
            }
        </style>

</head>
<body>
<div id="slider"></div>
<div id="map"></div>

<script type="text/javascript">
    var map;
    var markers;
    var batchSize;
    var serviceUrl;
    var mapCenter;
    var mapZoom;

    $(document).ready(function() {
        initialize('map');
        makeCluster();
    });

    function initialize(divId,id){
        initMap(divId);
    }

    function initMap(divId){
        mapCenter=L.latLng(63.0,12.0);
        mapZoom=10;
        serviceUrl="http://bed.snap1.api.no/api/pipek/v1/ads/search";
        batchSize=1000;
        map = new WebatlasMap('map', {customer: 'WAPI_JS_V3_WikiDemo'});
        map.setView(mapCenter,mapZoom);
    }
    function makeCluster(){

        map.spin(true);
        $.ajax({
                    url:serviceUrl,
                    async: true,
                    cache: true,
                    contentType: "text/json",
                    type: "POST",
                    data: JSON.stringify({
                        fields: [],
                        "query": {
                            "filtered": {
                                "query": {
                                    "filtered": {
                                        "filter": {
                                            "nested": {
                                                "path": "bookings",
                                                "filter": {
                                                    "and": {
                                                        "filters": [
                                                            {
                                                                "term": {
                                                                    "bookings.product": "prospectus"
                                                                }
                                                            },
                                                            {
                                                                "term": {
                                                                    "bookings.publications": "www.tb.no"
                                                                }
                                                            }
                                                        ]
                                                    }
                                                }

                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }),
                    dataType: "json"
                }
        ).done(function(data){
                    var offset = 0;
                    while (offset < data.hits.total) {
                        renderCluster(offset)
                        offset = offset + batchSize;
                    }
                }).error(function () {
                    map.spin(false);
                });
    }

    function renderCluster(offset){
        markers = L.markerClusterGroup({sliderPopupOnSameCoordinate: true});
        $.ajax({
                    url: serviceUrl,
                    async: true,
                    cache: true,
                    contentType: "text/json",
                    type: "POST",
                    data: JSON.stringify({
                        from:offset,
                        size:batchSize,
                        sort : [{ "id" : "asc" }],
                        _source: ["id","title","location","media.reference","attributes.propertytype","attributes.price","attributes.primaryroomarea","attributes.rooms","company.title","company.media.reference"],
                        "query": {
                            "filtered": {
                                "query": {
                                    "filtered": {
                                        "filter": {
                                            "nested": {
                                                "path": "bookings",
                                                "filter": {
                                                    "and": {
                                                        "filters": [
                                                            {
                                                                "term": {
                                                                    "bookings.product": "prospectus"
                                                                }
                                                            },
                                                            {
                                                                "term": {
                                                                    "bookings.publications": "www.tb.no"
                                                                }
                                                            }
                                                        ]
                                                    }
                                                }

                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }),
                    dataType: "json"}
        ).done(function(data){
                    var points = data.hits.hits;
                    //console.log('received ' + points.length + ' point');
                    var sumlon=0;
                    var sumlat=0;
                    var count=0;
                    for (var i = 0; i < points.length; i++) {
                        if(points[i]._source.location!=null)
                        {
                            addMarker(
                                    points[i]
                            );
                            sumlat=sumlat+points[i]._source.location.lat;
                            sumlon=sumlon+points[i]._source.location.lon;
                            count++;
                        }
                    }
                    mapCenter=L.latLng(sumlat/count,sumlon/count);
                    map.panTo(mapCenter, mapZoom, {animation: true});
                    map.spin(false);
                });

        map.addLayer(markers);
    }
    function addMarker(point) {
        var id=point._source.id;
        var lat=point._source.location.lat;
        var lon=point._source.location.lon;
        var title=point._source.title;
        var image=point._source.media[0];
        var attributes=point._source.attributes;
        var company=point._source.company;

        var img_content="";
        if(image!=null){
            var img_content='<img  src="http://g.api.no/obscura/API/image/r1/zett/230x153unifiedrc/1437391364000/'+image.reference+'" />'
        }
        var info_content='<strong><a target="_blank" href="http://www.siste.no/vis/rubrikk/eiendomsprospekt/'+id+'.html">'+title+'</a></strong></br>';
        if(attributes!=null){
            info_content+='<b>price:</b>'+attributes.price+'</br>';
            info_content+='<b>rooms:</b>'+attributes.rooms+'</br>';
            info_content+='<b>area:</b>'+attributes.primaryroomarea+'</br>';

        }
        if(company!=null) {
            info_content += '<b>company:</b>' + company.title;
        }
        var popupContent = '<div class="content">' + img_content+'<div class="caption">' +  info_content + '</div></div>';


        var LeafIcon = L.Icon.extend({
            options: {
                shadowUrl: 'http://cdn.leafletjs.com/leaflet-0.7/images/marker-shadow.png'
            }
        });

        var markerIcon = new LeafIcon({iconUrl: 'http://cdn.leafletjs.com/leaflet-0.7/images/marker-icon.png'});
        var marker = L.marker(L.latLng(lat, lon), { icon: markerIcon,title: title,defaultPopup:popupContent }); //add extra option to give default popup content
        marker.bindPopup(popupContent,{closeButton: true,minWidth: 320});
        markers.addLayer(marker);

    }

    $('#map').on('click', '.popup .cycle a', function() {
        var $slideshow = $('.popup'),
                $newSlide;

        if ($(this).hasClass('prev')) {
            $newSlide = $slideshow.find('.active').prev();
            if ($newSlide.index() < 0) {
                $newSlide = $('.slider').last();
            }
        } else {
            $newSlide = $slideshow.find('.active').next();
            if ($newSlide.index() < 0) {
                $newSlide = $('.slider').first();
            }
        }

        $slideshow.find('.active').removeClass('active').hide();
        $newSlide.addClass('active').show();
        return false;
    });


</script>
</body>
</html>
