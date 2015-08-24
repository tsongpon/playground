<html>

<head>

        <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
        <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="js/leaflet/leaflet-geopoint.js"></script>
        <link rel="stylesheet" href="css/leaflet/leaflet.css" />
        <script src="js/leaflet/leaflet.js"></script>
        <script src="js/leaflet-providers.js"></script>
        <#--<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">-->
        <#--<link rel="stylesheet" href="css/screen.css" />-->

        <link rel="stylesheet" href="css/MarkerCluster.css" />
        <link rel="stylesheet" href="css/MarkerCluster.Default.css" />
        <#--<script src="js/leaflet.markercluster.js"></script>-->
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
    $(document).ready(function() {
        initialize('map');
        makeCluster();
    });

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
