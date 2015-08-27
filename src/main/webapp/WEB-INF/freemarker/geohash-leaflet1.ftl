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

    <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
</head>
<body>
<div id="slider"></div>
<div id="map"></div>


<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="js/js-geohash/latlon-geohash.js"></script>
<#--<script type="text/javascript" src="js/js-geohash/jquery-ui.js"></script>-->
<script type="text/javascript" src="js/js-geohash/cluster-leaflet-aggregation-method-usedynamic-script.js"></script>
<link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7/leaflet.css" />
<script src="js/leaflet/leaflet.js"></script>
<script src="js/leaflet-providers.js"></script>

<script type="text/javascript">

    $(document).ready(function() {
        initialize('map');
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
