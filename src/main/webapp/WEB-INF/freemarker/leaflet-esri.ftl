<html>
<head>
  <meta charset=utf-8 />
  <title>Clustering points</title>
  <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />

  <!-- Load Leaflet from CDN-->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/leaflet/0.7.3/leaflet.css" />
  <script src="https://cdn.jsdelivr.net/leaflet/0.7.3/leaflet.js"></script>
   <!-- <link rel="stylesheet" href="css/screen.css" />-->
  <!-- Load Esri Leaflet from CDN -->
  <script src="https://cdn.jsdelivr.net/leaflet.esri/1.0.0/esri-leaflet.js"></script>

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
<script src="https://cdn.jsdelivr.net/leaflet.esri.clustered-feature-layer/1.0.2/esri-leaflet-clustered-feature-layer.js"></script>

<div id="map"></div>

<script>
  var map = L.map('map').setView([59.16579977535506,10.412690012433009], 7);
 /* var map = L.map('map').setView([13.7500, 100.4833], 7);*/
  L.esri.basemapLayer('Streets').addTo(map);
  var stops=L.esri.clusteredFeatureLayer({
     /* url: 'https://services.arcgis.com/rOo16HdIMeOBI4Mb/arcgis/rest/services/Trimet_Transit_Stops/FeatureServer/0',*/
      url:'http://services6.arcgis.com/MPFq870JSx7gki1d/arcgis/rest/services/propectous/FeatureServer/0',
      spiderfyOnMaxZoom:true,
      maxClusterRadius:100,
      removeOutsideVisibleBounds:true
      /*spiderfyOnMaxZoom:false,
      showCoverageOnHover:true,
      animateAddingMarkers:true,
      disableClusteringAtZoom: 10,
      polygonOptions: {
          color: '#2d84c8',
          weight: 4,
          opacity: 1,
          fillOpacity: 0.5
      },*/
    /*url:'http://services6.arcgis.com/MPFq870JSx7gki1d/arcgis/rest/services/test/FeatureServer/0'*/
    /*url:'http://services6.arcgis.com/MPFq870JSx7gki1d/ArcGIS/rest/services/example/FeatureServer/0'*/
  }).addTo(map);

  stops.bindPopup(function(feature){
      return L.Util.template('<strong>{title}</strong><br><img height="120" src="http://bearing:9079/api/frontier/v1/mediacontents/{image}" />', feature.properties);
  });
</script>

</body>
</html>
