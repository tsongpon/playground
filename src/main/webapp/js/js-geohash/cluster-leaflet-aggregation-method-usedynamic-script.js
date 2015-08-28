
var map;
var markers;
var geohashCells;
var precision;
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

    //var bound=Geohash.bounds(cluster.key);
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
                                    top_left:cluster.cell.bounds.top_left,
                                    bottom_right:cluster.cell.bounds.bottom_right
                                    //top_left: {
                                    //    "lat": bound.ne.lat,
                                    //    "lon": bound.sw.lon
                                    //},
                                    //bottom_right: {
                                    //    "lat": bound.sw.lat,
                                    //    "lon": bound.ne.lon
                                    //}
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
            createPopup(points,marker);
            markers.addLayer(marker);

        });
}

function createPopup(points,marker){

    if(points.length>1){
        console.log("multiple points");
        console.log(points);
    }
    if(points.length==1) {
        marker_info = points[0];
        var point = marker_info;
        var id = point._source.id;
        var title = point._source.title;
        var image = point._source.media[0];
        var attributes = point._source.attributes;
        var company = point._source.company;

        var img_content = "";
        if (image != null) {
            var img_content = '<img  src="http://g.api.no/obscura/API/image/r1/zett/230x153unifiedrc/1437391364000/' + image.reference + '" />'
        }
        var info_content = '<strong><a target="_blank" href="http://www.siste.no/vis/rubrikk/eiendomsprospekt/' + id + '.html">' + title + '</a></strong></br>';
        if (attributes != null) {
            info_content += '<b>price:</b>' + attributes.price + '</br>';
            info_content += '<b>rooms:</b>' + attributes.rooms + '</br>';
            info_content += '<b>area:</b>' + attributes.primaryroomarea + '</br>';

        }
        if (company != null) {
            info_content += '<b>company:</b>' + company.title;
        }
        var popupContents = '<div class="content">' + img_content + '<div class="caption">' + info_content + '</div></div>';
    }else{


        var slideshowContent="";
        var naviButton='<div class="cycle">' +
            '<a href="#" class="prev">&laquo; Previous</a>&nbsp;&nbsp;' +
            '<a href="#" class="next">Next &raquo;</a>' +
            '</div>';

        for(var j in points)
        {
            marker_info = points[j];
            var point = marker_info;
            var id = point._source.id;
            var title = point._source.title;
            var image = point._source.media[0];
            var attributes = point._source.attributes;
            var company = point._source.company;

            var img_content = "";
            if (image != null) {
                var img_content = '<img  src="http://g.api.no/obscura/API/image/r1/zett/230x153unifiedrc/1437391364000/' + image.reference + '" />'
            }
            var info_content = '<strong><a target="_blank" href="http://www.siste.no/vis/rubrikk/eiendomsprospekt/' + id + '.html">' + title + '</a></strong></br>';
            if (attributes != null) {
                info_content += '<b>price:</b>' + attributes.price + '</br>';
                info_content += '<b>rooms:</b>' + attributes.rooms + '</br>';
                info_content += '<b>area:</b>' + attributes.primaryroomarea + '</br>';

            }
            if (company != null) {
                info_content += '<b>company:</b>' + company.title;
            }
            var popupContent = '<div class="content">' + img_content + '<div class="caption">' + info_content + '</div></div>';

            if(j==0) {
                slideshowContent += '<div class="slider active">'+popupContent+naviButton+'</div>';
            }else{
                slideshowContent += '<div class="slider">'+popupContent+naviButton+'</div>';
            }
        }
        // Create custom popup content
        var popupContents =  '<div class="popup">' +
            '<div class="slideshow">' +
            slideshowContent +
            '</div></div>';

    }


    marker.bindPopup(popupContents,{closeButton: true,minWidth: 320});
}
function makeCluster(){
    zoomLev = map.getZoom();
    if(zoomLev<=4){
        precision=1;
    }else if(zoomLev<=4){
        precision=2;
    }else if(zoomLev<=9){
        precision=3;
    }else if(zoomLev<=11){
        precision=4;
    }else if(zoomLev<=13){
        precision=5;
    }else{
        precision=12;
    }

  console.log("zoom:"+zoomLev);
    console.log("prec:"+precision);
    $.ajax({
            url: elasticsearchUrl,
           // url: "http://" + window.location.hostname + ":9093/api/pipek/v1/ads/search",
            contentType: "text/json",
            type: "POST",
            data: JSON.stringify({
                "query": {
                    "match_all": {}
                },
                "aggs": {
                    "filtered_cells": {
                        "filter": {
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
                        },
                        "aggs": {
                            "cells": {
                                "geohash_grid": {
                                    "field": "location",
                                    "precision": precision
                                },
                                "aggs": {
                                    "cell": {
                                        "geo_bounds": {
                                            "field": "location"
                                        }
                                    },
                                    "center_lat": {
                                        "avg": {
                                            "script": "doc['location'].lat"
                                        }
                                    },
                                    "center_lon": {
                                        "avg": {
                                            "script": "doc['location'].lon"
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
        //var clusters = data.facets.places.clusters;
        var clusters=data.aggregations.filtered_cells.cells.buckets;
       // console.log(clusters);
        for (var i = 0; i < clusters.length; i++) {
            addMarker(clusters[i]
            );
            //addGeohashCell(clusters[i]);

        }

    });

    map.addLayer(markers);
    map.addLayer(geohashCells);

}

function addMarker(cluster) {
    //var lat = cluster.center_lat.value;
    //var lon = cluster.center_lon.value;
    var totalChild=cluster.doc_count;

    if(totalChild==1||zoomLev>13){
       addSingleMarker(cluster);
    }else{
        //var lat=(cluster.cell.bounds.bottom_right.lat+cluster.cell.bounds.top_left.lat)/2;
        //var lon=(cluster.cell.bounds.bottom_right.lon+cluster.cell.bounds.top_left.lon)/2;

        var lat = cluster.center_lat.value;
        var lon = cluster.center_lon.value;

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

        zoomLev
        var marker =new  L.marker(L.latLng(lat, lon), {
            icon:markerIcon});
        marker.on('click', function(e) {
            map.setView(e.latlng, map.getZoom() + 1);
        });

        markers.addLayer(marker);
    }
}

function addGeohashCell(cluster) {
    //var southWest = L.latLng(cluster.cell.bounds.bottom_right.lat, cluster.cell.bounds.top_left.lon),
    //    northEast = L.latLng(cluster.cell.bounds.top_left.lat, cluster.cell.bounds.bottom_right.lon),
    //    bounds = L.latLngBounds(southWest, northEast);

    var bound=Geohash.bounds(cluster.key);
    bounds = L.latLngBounds(bound.sw, bound.ne);
    geohashCells.addLayer(L.rectangle(bounds, {color: "#03f", weight: 1,fillOpacity:0.05,opacity:0.05}));
}
