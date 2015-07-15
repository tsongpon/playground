<!DOCTYPE html>
<html>
<head>
    <meta charset=utf-8 />
    <title>Styling clusters</title>
    <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />

    <!-- Load Leaflet from CDN-->
    <link rel="stylesheet" href="//cdn.jsdelivr.net/leaflet/0.7.3/leaflet.css" />
    <script src="//cdn.jsdelivr.net/leaflet/0.7.3/leaflet.js"></script>

    <!-- Load Esri Leaflet from CDN -->
    <script src="//cdn.jsdelivr.net/leaflet.esri/1.0.0/esri-leaflet.js"></script>

    <style>
        body { margin:0; padding:0; }
        #map { position: absolute; top:0; bottom:0; right:0; left:0; }
    </style>
</head>
<body>

<!-- Include Leaflet.markercluster via rawgit.com, do not use in production -->
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/Leaflet/Leaflet.markercluster/v0.4.0/dist/MarkerCluster.Default.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/Leaflet/Leaflet.markercluster/v0.4.0/dist/MarkerCluster.css">
<script src="https://cdn.rawgit.com/Leaflet/Leaflet.markercluster/v0.4.0/dist/leaflet.markercluster.js"></script>

<!-- Load Clustered Feature Layer from CDN -->
<script src="http://cdn.jsdelivr.net/leaflet.esri.clustered-feature-layer/1.0.2/esri-leaflet-clustered-feature-layer.js"></script>

<style>
    .cluster {
        background: #2d84c8;
        border-radius: 50%;
        text-align: center;
        color: white;
        font-weight: 700;
        border: 1px solid #2d84c8;
        font-family: monospace;
    }

    .cluster:before {
        content: ' ';
        position: absolute;
        border-radius: 50%;
        z-index: -1;
        top: 1px;
        left: 1px;
        right: 1px;
        bottom: 1px;
        border: 1px solid white;
    }

    .digits-1 {
        font-size: 14px;
        height: 28px;
        width: 28px;
        line-height: 28px;
        margin-top: -14px;
        margin-left: -14px;
    }

    .digits-2 {
        font-size: 16px;
        height: 34px;
        width: 34px;
        line-height: 35px;
        margin-top: -17px;
        margin-left: -17px;
    }

    .digits-2:before {
        border-width: 2px;
    }

    .digits-3 {
        font-size: 18px;
        height: 48px;
        width: 47px;
        line-height: 47px;
        border-width: 3px;
        margin-top: -24px;
        margin-left: -24px;
    }

    .digits-3:before {
        border-width: 3px;
    }

    .digits-4 {
        font-size: 18px;
        height: 58px;
        width: 58px;
        line-height: 57px;
        border-width: 4px;
        margin-top: -29px;
        margin-left: -29px;
    }

    .digits-4:before {
        border-width: 4px;
    }
</style>

<div id="map"></div>

<script>
    var map = L.map('map').setView([45.5276173643906, -122.66736388203228], 13);

    // Add ArcGIS Online basemap
    L.esri.basemapLayer('Gray').addTo(map);

    // Define some icons that represent our bus stops
    var icons = {
        north: L.icon({
            iconUrl: 'http://esri.github.io/esri-leaflet/img/bus-stop-north.png',
            iconRetinaUrl: 'http://esri.github.io/esri-leaflet/img/bus-stop-north@2x.png',
            iconSize: [27, 31],
            iconAnchor: [13.5, 17.5],
            popupAnchor: [0, -11],
        }),
        south: L.icon({
            iconUrl: 'http://esri.github.io/esri-leaflet/img/bus-stop-south.png',
            iconRetinaUrl: 'http://esri.github.io/esri-leaflet/img/bus-stop-south@2x.png',
            iconSize: [27, 31],
            iconAnchor: [13.5, 13.5],
            popupAnchor: [0, -11],
        }),
        east: L.icon({
            iconUrl: 'http://esri.github.io/esri-leaflet/img/bus-stop-east.png',
            iconRetinaUrl: 'http://esri.github.io/esri-leaflet/img/bus-stop-east@2x.png',
            iconSize: [31, 27],
            iconAnchor: [13.5, 17.5],
            popupAnchor: [0, -11],
        }),
        west: L.icon({
            iconUrl: 'http://esri.github.io/esri-leaflet/img/bus-stop-west.png',
            iconRetinaUrl: 'http://esri.github.io/esri-leaflet/img/bus-stop-west@2x.png',
            iconSize: [31, 27],
            iconAnchor: [17.5, 13.5],
            popupAnchor: [0, -11],
        }),
    };

    // create a new cluster layer
    var stops = L.esri.clusteredFeatureLayer({
        url: 'https://services.arcgis.com/rOo16HdIMeOBI4Mb/arcgis/rest/services/stops/FeatureServer/0',
        spiderfyOnMaxZoom:false,
        disableClusteringAtZoom: 16,
        polygonOptions: {
            color: '#2d84c8',
            weight: 4,
            opacity: 1,
            fillOpacity: 0.5
        },
        // this function defines how the icons
        // representing  clusters are created
        iconCreateFunction: function(cluster) {
            // get the number of items in the cluster
            var count = cluster.getChildCount();

            // figure out how many digits long the number is
            var digits = (count+'').length;

            // return a new L.DivIcon with our classes so we can
            // style them with CSS. Take a look at the CSS in
            // the <head> to see these styles. You have to set
            // iconSize to null if you want to use CSS to set the
            // width and height.
            return new L.divIcon({
                html: count,
                className:'cluster digits-'+digits,
                iconSize: null
            });
        },

        // this function defines how individual markers
        // are created. You can see we are using the
        // direction from the feature to get the icon
        pointToLayer: function (geojson, latlng) {
            var direction = (geojson.properties.direction) ? geojson.properties.direction.toLowerCase() : 'none';
            return L.marker(latlng, {
                icon: icons[direction]
            });
        }
    }).addTo(map);

    stops.bindPopup(function(feature){
        return L.Util.template('<strong>{stop_name}</strong><br>{stop_desc}', feature.properties);
    });
</script>

</body>
</html>
