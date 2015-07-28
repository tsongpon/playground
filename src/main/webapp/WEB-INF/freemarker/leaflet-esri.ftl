<html>
<head>
  <meta charset=utf-8 />
  <title>Clustering points</title>
  <meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
    <#--<link rel="stylesheet" href="css/screen.css" />-->
  <!-- Load Leaflet from CDN-->
    <link rel="stylesheet" href="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.css" />
    <script src="http://cdn.leafletjs.com/leaflet-0.7.3/leaflet.js"></script>
    <#--<script src="js/leaflet/leaflet.js"></script>-->
   <!-- <link rel="stylesheet" href="css/screen.css" />-->
  <!-- Load Esri Leaflet from CDN -->
  <#--<script src="https://cdn.jsdelivr.net/leaflet.esri/1.0.0/esri-leaflet.js"></script>-->
    <script src="js/leaflet/esri-leaflet.js.map"></script>

    <#--<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/Leaflet/Leaflet.markercluster/v0.4.0/dist/MarkerCluster.Default.css">-->
    <link rel="stylesheet" type="text/css" href="css/leaflet/MarkerCluster.Default.css">
    <#--<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/Leaflet/Leaflet.markercluster/v0.4.0/dist/MarkerCluster.css">-->
    <link rel="stylesheet" type="text/css" href="css/leaflet/MarkerCluster.css">
    <#--<script src="https://cdn.rawgit.com/Leaflet/Leaflet.markercluster/v0.4.0/dist/leaflet.markercluster.js"></script>-->
    <script src="js/leaflet/leaflet.markercluster-src.js"></script>
    <!-- Load Clustered Feature Layer from CDN -->
    <script src="js/leaflet/esri-leaflet-clustered-feature-layer.js.map"></script>
    <script src='js/jquery-1.11.0.min.js'></script>

  <style>
    body { margin:0; padding:0; }
    #map { position: absolute; top:0; bottom:0; right:0; left:0; }
    .popup {
        text-align:center;
    }
    .popup .slideshow .image        { display:none; }
    .popup .slideshow .image.active { display:block; }
    .popup .slideshow img {
        width:100%;
    }
    .popup .slideshow .caption {
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
        /* background: transparent; */
    }

    #query {
        position: absolute;
        top: 10px;
        right: 10px;
        z-index: 10;
        background: white;
        padding: 1em;
    }

    #query select {
        font-size: 16px;
    }
  </style>
</head>
<body>


<div id="map"></div>
<div id="query" class="leaflet-bar">
    <label>
        Property Type
        <select id="propertyType">
            <option value="" selected="selected">Any</option>
            <option value="Boligtomt">Boligtomt</option>
            <option value="Enebolig">Enebolig</option>
            <option value="Fritid/hytteanlegg">Fritid/hytteanleggg</option>
            <option value="Fritidsbolig">Fritidsbolig</option>
            <option value="Hytte">Hytte</option>
            <option value="Hyttetomt">Hyttetomt</option>
            <option value="Kontor">Kontor</option>
            <option value="Kontorlokale">Kontorlokale</option>
            <option value="Leilighet">Leilighet</option>
            <option value="Næringstomt">Næringstomt</option>
        </select>
    </label>
</div>
<script>
  var map = L.map('map').setView([65.56579977535506,10.002690012433009], 5);
  var clusterLayer;
 /* var map = L.map('map').setView([13.7500, 100.4833], 7);*/
  L.esri.basemapLayer('Streets').addTo(map);

  function makeClusters(query) {
      if(query) {
          clusterLayer = L.esri.clusteredFeatureLayer({
              /* url: 'https://services.arcgis.com/rOo16HdIMeOBI4Mb/arcgis/rest/services/Trimet_Transit_Stops/FeatureServer/0',*/
              url: 'http://services6.arcgis.com/MPFq870JSx7gki1d/arcgis/rest/services/property/FeatureServer/0',
              spiderfyOnMaxZoom: true,
              sliderPopupOnSameCoordinate: true,
              maxClusterRadius: 100,
              removeOutsideVisibleBounds: true,
              where: query,
          }).addTo(map);
      }else{
          clusterLayer = L.esri.clusteredFeatureLayer({
              /* url: 'https://services.arcgis.com/rOo16HdIMeOBI4Mb/arcgis/rest/services/Trimet_Transit_Stops/FeatureServer/0',*/
              url: 'http://services6.arcgis.com/MPFq870JSx7gki1d/arcgis/rest/services/property/FeatureServer/0',
              spiderfyOnMaxZoom: true,
              sliderPopupOnSameCoordinate: true,
              maxClusterRadius: 100,
              removeOutsideVisibleBounds: true,
              //where:"type='Enebolig'"
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
      }
      clusterLayer.bindPopup(function(feature){
          var prop=feature.properties;
          var img_content='<img  src="http://g.api.no/obscura/API/image/r1/zett/230x153unifiedrc/1437391364000/'+prop['picture']+'" />'
          var info_content='<strong><a target="_blank" href="http://www.siste.no/vis/rubrikk/eiendomsprospekt/'+prop['id']+'.html">'+prop['title']+'</a></strong></br>';
          info_content+='<b>price:</b>'+prop['price']+'</br>';
          info_content+='<b>rooms:</b>'+prop['rooms']+'</br>';
          info_content+='<b>area:</b>'+prop['roomarea']+'</br>';
          info_content+='<b>company:</b>'+prop['company'];
          var slideshowContent= '<div class="image active">'+img_content+'<div class="caption">' +  info_content + '</div></div>';
          var popupContent = '<div class="popup"><div class="slideshow">' +
                  slideshowContent +
                  '</div></div>';
          return popupContent;
          //return L.Util.template('<strong>{title}</strong><br>{type}<br>price:{price}<br>total room:{rooms}<br>room area{roomarea}<br><img height="120" src="http://g.api.no/obscura/API/image/r1/zett/230x153unifiedrc/1437391364000/{picture}" />', feature.properties);
      },{
          closeButton: true,
          minWidth: 320
      });
  }
  makeClusters();
  var propertyType = document.getElementById('propertyType');
  propertyType.addEventListener('change', function(){
      map.removeLayer(clusterLayer)
      var q='';
      if(propertyType.value!='') {
         q="type='" + propertyType.value + "'";
      }
      makeClusters(q);
  });
  $('#map').on('click', '.popup .cycle a', function() {
      var $slideshow = $('.slideshow'),
              $newSlide;

      if ($(this).hasClass('prev')) {
          $newSlide = $slideshow.find('.active').prev();
          if ($newSlide.index() < 0) {
              $newSlide = $('.image').last();
          }
      } else {
          $newSlide = $slideshow.find('.active').next();
          if ($newSlide.index() < 0) {
              $newSlide = $('.image').first();
          }
      }

      $slideshow.find('.active').removeClass('active').hide();
      $newSlide.addClass('active').show();
      return false;
  });
</script>
</body>
</html>
