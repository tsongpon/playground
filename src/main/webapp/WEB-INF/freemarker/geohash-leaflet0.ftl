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

        .marker-cluster-large
        {
            width:50px;
            height:50px;
            border-radius:50%;
            color:#fff;
            line-height:50px;
            text-align:center;
            background:red;
            opacity: 0.8;
            filter: alpha(opacity=80);
        }

        .marker-cluster-medium
        {
            width:40px;
            height:40px;
            border-radius:50%;
            color:#fff;
            line-height:40px;
            text-align:center;
            background:orange;
            opacity: 0.8;
            filter: alpha(opacity=80);
        }

        .marker-cluster-small
        {
            width:30px;
            height:30px;
            border-radius:50%;
            color:#fff;
            line-height:30px;
            text-align:center;
            background:green;
            opacity: 0.8;
            filter: alpha(opacity=80);
        }
    </style>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
</head>
<body>
<div id="slider"></div>
<div id="map"></div>


<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
<#--<script type="text/javascript" src="js/js-geohash/jquery-ui.js"></script>-->
<script type="text/javascript" src="js/js-geohash/cluster-leaflet-plugin.js"></script>
<link rel="stylesheet" href="css/leaflet/leaflet.css" />
<script src="js/leaflet/leaflet.js"></script>
<script src="js/leaflet-providers.js"></script>

<script type="text/javascript">

    $(document).ready(function() {
        initialize('map');
    });

</script>
</body>
</html>
