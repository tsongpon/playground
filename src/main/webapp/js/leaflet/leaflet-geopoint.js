
var map;
var markers;
var batchSize;
function initialize(divId,id){
    initMap(divId);
}

function initMap(divId){
    var tiles = L.tileLayer.provider('Esri.WorldStreetMap', {
        //maxZoom: 10,
       // spiderfyOnMaxZoom:true
    }),latlng = L.latLng(59.16579977535506,10.412690012433009);

   map = L.map('map', {center: latlng, zoom: 4, layers: [tiles]});
   batchSize=500;
}
function makeCluster(){
    $.ajax({
            url:"http://bed.snap1.api.no/api/pipek/v1/ads/search",
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
            dataType: "json"}
    ).done(function(data){
            var offset = 0;
            while (offset < data.hits.total) {
                renderCluster(offset)
                offset=offset+batchSize;
            }
        });
}

function renderCluster(offset){
    markers = L.markerClusterGroup();
    $.ajax({
            // url: "http://" + window.location.hostname + ":9093/api/pipek/v1/ads/search",
            // url: "http://192.168.50.32:9093/api/pipek/v1/ads/search",
            //url:"http://bearing.dev.abctech-thailand.com/api/pipek/v1/ads/search",
            url:"http://bed.snap1.api.no/api/pipek/v1/ads/search",
            async: true,
            cache: true,
            contentType: "text/json",
            type: "POST",
            data: JSON.stringify({
                from:offset,
                size:batchSize,
                sort : [{ "id" : "asc" }],
                _source: ["id","title","location"],
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
    )
        .done(function(data){

            var points = data.hits.hits;
            //console.log('received ' + points.length + ' point');
            for (var i = 0; i < points.length; i++) {
                addMarker(
                    points[i]._source.location.lat,
                    points[i]._source.location.lon,
                    points[i]._source.title
                );

            }

        });
    map.addLayer(markers);

}
function addMarker(lat, lon, title) {
    var marker = L.marker(L.latLng(lat, lon), { title: title });
    marker.bindPopup(title);
    markers.addLayer(marker);

}

