
var map;
var markers;
var geohashCells;
var factor;
//var elasticsearchUrl="http://" + window.location.hostname + ":9093/api/pipek/v1/ads/search";
var elasticsearchUrl="http://bearing.dev.abctech-thailand.com/api/pipek/v1/ads/search";
//var elasticsearchUrl="http://bed.snap1.api.no/api/pipek/v1/ads/search";
function initialize(divId){

    initMap(divId);

}

function initMap(divId){
    var tiles = L.tileLayer.provider('Esri.WorldStreetMap', {
    }),latlng = L.latLng(63,12);
    markers = new L.FeatureGroup();
    geohashCells=new L.FeatureGroup();
    map = L.map('map', {center: latlng, zoom: 5, layers: [tiles]});
    makeCluster();
    //map.on('click', function(e) {
    //    map.setView(e.latlng, map.getZoom() + 1);
    //    clearMarkers();
    //    clearGeohashCell
    //});
    map.on('zoomend', function(e) {
        clearMarkers();
        clearGeohashCell
        makeCluster();
    });
    map.on('dragend', function(e) {
        clearMarkers();
        clearGeohashCell
        makeCluster();
    });
    map.on('resize', function(e) {
        clearMarkers();
        clearGeohashCell
        makeCluster();
    });

}

function clearMarkers(){
    map.removeLayer(markers);
    markers = new L.FeatureGroup();
}
function clearGeohashCell(){
    map.removeLayer(geohashCells);
    geohashCells = new L.FeatureGroup();
}
function addSingleMarker(cluster){
    $.ajax({
            url: elasticsearchUrl,
            contentType: "text/json",
            type: "POST",
            data: JSON.stringify({
                query: {
                    filtered: {
                        query: {
                            match_all: {}
                        },
                        filter: {
                            geo_bounding_box: {
                                location: {
                                    top_left: {
                                        "lat": cluster.geohash_cell.top_left.lat,
                                        "lon": cluster.geohash_cell.top_left.lon
                                    },
                                    bottom_right: {
                                        "lat": cluster.geohash_cell.bottom_right.lat,
                                        "lon": cluster.geohash_cell.bottom_right.lon
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
            var lat=points[0]._source.location.lat;
            var lon=points[0]._source.location.lon;
            var marker =new  L.marker(L.latLng(lat, lon));
            createPopup(points[0],marker);
            markers.addLayer(marker);

        });
}

function createPopup(marker_info,marker){
    var point=marker_info;
    var id=point._source.id;
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
    marker.bindPopup(popupContent,{closeButton: true,minWidth: 320});
}
function makeCluster(){
    zoomLev = map.getZoom();
    if(zoomLev<=2){
        factor=1;
    }else if(zoomLev<=7){
        factor=0.80;
    }else if(zoomLev<=9){
        factor=0.7;
    }else if(zoomLev<=11){
        factor=0.6;
    }else if(zoomLev<=13){
        factor=0.5;
    }else{
        factor=0.1;
    }

    console.log("zoom:"+zoomLev);
    console.log("factor:"+factor);
    $.ajax({
            url: elasticsearchUrl,
           // url: "http://" + window.location.hostname + ":9093/api/pipek/v1/ads/search",
            contentType: "text/json",
            type: "POST",
            data: JSON.stringify({
                query: {
                    filtered: {
                        query: {
                            match_all: {}
                        },
                        filter: {
                            geo_bounding_box: {
                                location: {
                                    top_left: {
                                        "lat": map.getBounds().getNorthEast().lat,
                                        "lon": map.getBounds().getSouthWest().lng
                                    },
                                    bottom_right: {
                                        "lat": map.getBounds().getSouthWest().lat,
                                        "lon": map.getBounds().getNorthEast().lng
                                    }
                                }
                            }
                        }
                    }
                },
                facets: {
                    places: {
                        geohash: {
                            field: "location",
                            factor: factor,
                            show_geohash_cell: true
                        }
                    }
                }
            }),
            dataType: "json"}
    ).done(function(data){
        //var clusters = data.facets.places.clusters;
        var clusters = data.facets.places.clusters;
       // console.log(clusters);
        for (var i = 0; i < clusters.length; i++) {
            addMarker(clusters[i]
            );
           // addGeohashCell(clusters[i].geohash_cell);

        }

    });

    map.addLayer(markers);
    map.addLayer(geohashCells);

}

function addMarker(cluster) {
    var totalChild=cluster.total;
    if(totalChild==1){
       addSingleMarker(cluster);
    }else{
        var lat = cluster.center.lat;
        var lon = cluster.center.lon;
        var markerIcon = L.divIcon({
            className: 'marker-cluster-small',
            html: '<b>' + totalChild + '</b>',
            iconSize: [30, 30]
        });
        if(totalChild>=100) {
            markerIcon = L.divIcon({
                className: 'marker-cluster-medium',
                html: '<b>' + totalChild + '</b>',
                iconSize: [40, 40]
            });
        }
        if(totalChild>=500) {
            markerIcon = L.divIcon({
                className: 'marker-cluster-large',
                html: '<b>' + totalChild + '</b>',
                iconSize: [50, 50]
            });
        }
        var marker =new  L.marker(L.latLng(lat, lon), {
            icon:markerIcon});
        marker.on('click', function(e) {
            map.setView(e.latlng, map.getZoom() + 1);
        });

        markers.addLayer(marker);
    }
}
function addGeohashCell(geohashCell) {
    var southWest = L.latLng(geohashCell.bottom_right.lat, geohashCell.top_left.lon),
        northEast = L.latLng(geohashCell.top_left.lat, geohashCell.bottom_right.lon),
        bounds = L.latLngBounds(southWest, northEast);
    geohashCells.addLayer(L.rectangle(bounds, {color: "#03f", weight: 1,fillOpacity:0.05,opacity:0.05}));
}

