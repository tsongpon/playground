<html>

<head>
    <style type="text/css">
        html, body{
            height:100%;
            margin:0px;
            padding:0px;
            width:100%;
        }
        #map{
            height:100%;
            width:100%;
        }
    </style>
</head>
<body>
<div id="slider"></div>
<div id="map"></div>
<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/leaflet/leaflet-geopoint.js"></script>
<link rel="stylesheet" href="css/leaflet/leaflet.css" />
<script src="js/leaflet/leaflet.js"></script>
<script src="js/leaflet-providers.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="css/screen.css" />

<link rel="stylesheet" href="css/MarkerCluster.css" />
<link rel="stylesheet" href="css/MarkerCluster.Default.css" />
<script src="js/leaflet.markercluster.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        initialize('map');
        makeCluster();
    });

</script>
</body>
</html>
