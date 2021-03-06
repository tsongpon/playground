<!DOCTYPE html>
<html>
<head>
  <title>Leaflet debug page</title>

  <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7/leaflet.css" />
  <script src="http://cdn.leafletjs.com/leaflet-0.7/leaflet.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" href="css/screen.css" />

  <link rel="stylesheet" href="css/MarkerCluster.css" />
  <link rel="stylesheet" href="css/MarkerCluster.Default.css" />
    <script src="https://cdn.rawgit.com/Leaflet/Leaflet.markercluster/v0.4.0/dist/leaflet.markercluster.js"></script>
  <script src="data/realworld.388.js"></script>
</head>
<body>

<div id="map"></div>

<script type="text/javascript">

  var tiles = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            maxZoom: 18,
            spiderfyOnMaxZoom:true,
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors, Points &copy 2012 LINZ'
          }),latlng = L.latLng(-37.821, 175.22);

  var map = L.map('map', {center: latlng, zoom: 15, layers: [tiles]});

  var markers = L.markerClusterGroup();

  for (var i = 0; i < addressPoints.length; i++) {
    var a = addressPoints[i];
    var title = a[2];
    var marker = L.marker(L.latLng(a[0], a[1]), { title: title });
    marker.bindPopup(title);
    markers.addLayer(marker);
  }

  map.addLayer(markers);

</script>
</body>
</html>
