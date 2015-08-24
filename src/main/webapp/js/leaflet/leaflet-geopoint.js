
var map;
var markers;
var batchSize;
var serviceUrl;
function initialize(divId,id){
    initMap(divId);
}

function initMap(divId){
    var tiles = L.tileLayer.provider('Esri.WorldStreetMap'),latlng = L.latLng(63.0,12.0);
        //serviceUrl="http://bearing.dev.abctech-thailand.com/api/pipek/v1/ads/search";
   serviceUrl="http://bed.snap1.api.no/api/pipek/v1/ads/search";
   map = L.map('map', {center: latlng, zoom: 5, layers: [tiles]});
   batchSize=300;

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
                query: {
                    filtered: {
                        query: {
                            match_all: {}
                        },
                        "filter" : {
                            "exists" : { "field" : "location" }
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
                query: {
                    filtered: {
                        query: {
                            match_all: {}
                        },
                        "filter" : {
                            "exists" : { "field" : "location" }
                        }
                    }
                }
            }),
            dataType: "json"}
    ).done(function(data){
            var points = data.hits.hits;
            //console.log('received ' + points.length + ' point');
            for (var i = 0; i < points.length; i++) {
                addMarker(
                    points[i]
                );
            }
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

