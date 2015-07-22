<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>Cluster</title>
    <link rel="stylesheet" href="http://js.arcgis.com/3.14/dijit/themes/tundra/tundra.css">
    <link rel="stylesheet" href="http://js.arcgis.com/3.14/esri/css/esri.css">

      <style>
          html,body, #map {
              height: 100%;
              margin: 0;
              padding: 0;
          }
          .roundedCorners {
              border-radius: 10px;
              box-shadow: 4px 4px 8px #adadad;
          }
          #lppanel {
              position: absolute;
              height: 100px;
              font-family: arial;
              top: 10px;
              margin: 5px;
              padding: 5px;
              z-index: 40;
              background: #fff;
              color: #444;
              width: 200px;
              right: 10px;
              box-shadow: 0 0 5px #888;
          }
          /* center the image in the  */
          .esriViewPopup .gallery { margin: 0 auto !important; }
          /* CSS for Cluster Layer */
          #clusters_layer > circle { cursor: pointer; }
          #clusters_layer > text { cursor: pointer; }
      </style>
    <script>
      var dojoConfig = { 
        paths: {
          extras: location.pathname.replace(/\/[^/]+$/, '')
        }
      };
    </script>
    <script src="http://js.arcgis.com/3.14/"></script>
    <script>
      var map;
      require(["esri/config"], function(esriConfig) {
          esriConfig.defaults.io.corsEnabledServers.push("http://services6.arcgis.com");
      });
      require([
        'dojo/parser', 
        'dojo/ready',
        'dojo/_base/array',
        'dojo/_base/Color',
        'dojo/dom-style',
        'dojo/query',
        'esri/map', 
        'esri/request',
        'esri/graphic',
        'esri/geometry/Extent',

        'esri/symbols/SimpleMarkerSymbol',
        'esri/symbols/SimpleLineSymbol',
        'esri/symbols/SimpleFillSymbol',
        'esri/symbols/PictureMarkerSymbol',
        'esri/renderers/ClassBreaksRenderer',

        'esri/layers/GraphicsLayer',
        'esri/SpatialReference',
        'esri/dijit/PopupTemplate',
        'esri/geometry/Point',
        'esri/geometry/webMercatorUtils',
        'extras/js/ClusterFeatureLayer',

        'dijit/layout/BorderContainer', 
        'dijit/layout/ContentPane', 
        'dojo/domReady!'
      ], function(
        parser, ready, arrayUtils, Color, domStyle, query,
        Map, esriRequest, Graphic, Extent,
        SimpleMarkerSymbol, SimpleLineSymbol, SimpleFillSymbol, PictureMarkerSymbol, ClassBreaksRenderer,
        GraphicsLayer, SpatialReference, PopupTemplate, Point, webMercatorUtils,
        ClusterFeatureLayer
      ) {
        ready(function() {
          parser.parse();
          var clusterLayers;
          var popupOptions = {
            'markerSymbol': new SimpleMarkerSymbol('circle', 20, null, new Color([0, 0, 0, 0.25])),
            'marginLeft': '20',
            'marginTop': '20'
          };
          map = new Map('map', {
            basemap: 'streets',
            //center: [-118.182, 33.913],
              center: [10.412690012433009,59.16579977535506],
            zoom: 7
          });
          map.on('load', function() {
              // hide the popup's ZoomTo link as it doesn't make sense for cluster features
              domStyle.set(query('a.action.zoomTo')[0], 'display', 'none');
              clusterLayers=getCluster();
              map.addLayer(clusterLayers);
              query("#lplist").on("change", function(e) {
                  var value = e.currentTarget.value;
                  if (clusterLayers) {
                      map.removeLayer(clusterLayers);
                      clusterLayers = null;
                  }
                  switch (value) {
                      case "all":
                          clusterLayers = getCluster();
                          break;
                      default:
                          clusterLayers = getCluster("type='" + value + "'");
                  }
                  if (clusterLayers) {
                      map.addLayer(clusterLayers);
                  }
              });

          });
          // close the info window when the map is clicked
          map.on('click', cleanUp);
          // close the info window when esc is pressed
          map.on('key-down', function(e) {
            if (e.keyCode === 27) {
                cleanUp();
            }
          });


          function getCluster(featureQuery) {
              var popupTemplate = new PopupTemplate({
                  "title": "",
                  "fieldInfos": [/*{
                      "fieldName": "id",
                      "label": "Ad",
                      visible: true
                  }, */{
                      "fieldName": "title",
                      "label": "Title",
                      visible: true
                  }, {
                      "fieldName": "type",
                      "label": "Type",
                      visible: true
                  }, {
                      "fieldName": "price",
                      "label": "Price",
                      visible: true
                  }, {
                      "fieldName": "rooms",
                      "label": "Total Room",
                      visible: true
                  }, {
                      "fieldName": "roomarea",
                      "label": "Room Area",
                      visible: true
                  }, {
                      "fieldName": "company",
                      "label": "Company Name",
                      visible: true
                  }],
                  "mediaInfos": [{
                      "title": "",
                      "caption": "",
                      "type": "image",
                      "value": {
                          "sourceURL": "http://g.api.no/obscura/API/image/r1/zett/230x153unifiedrc/1437391364000/{companylogo}",
                      }
                  },{
                      "title": "",
                      "caption": "",
                      "type": "image",
                      "value": {
                          "sourceURL": "http://g.api.no/obscura/API/image/r1/zett/230x153unifiedrc/1437391364000/{picture}",
                      }
                  }]
              });

              var picBaseUrl = 'http://static.arcgis.com/images/Symbols/Shapes/';
              var defaultSym = new PictureMarkerSymbol(picBaseUrl + 'GreenPin1LargeB.png', 64, 64);
              var renderer = new ClassBreaksRenderer(defaultSym, 'clusterCount');

              var clusterLayer=null;
             if(featureQuery) {
                 clusterLayer= new ClusterFeatureLayer({
                     'url': 'http://services6.arcgis.com/MPFq870JSx7gki1d/arcgis/rest/services/RealEstate/FeatureServer/0',
                     'where':featureQuery,
                     'distance': 100,
                     'id': 'clusters',
                     'labelColor': '#fff',
                     'resolution': map.extent.getWidth() / map.width,
                     'singleColor': '#888',
                     'singleTemplate': popupTemplate,
                     'useDefaultSymbol': false,
                     'zoomOnClick': true,
                     'showSingles': false,
                     'singleSymbol': defaultSym,
                     'singleRenderer': renderer,
                     'MODE_SNAPSHOT': true,
                     'objectIdField': 'OBJECTID' // define the objectid field
                 });
             }else{
                 clusterLayer= new ClusterFeatureLayer({
                     'url': 'http://services6.arcgis.com/MPFq870JSx7gki1d/arcgis/rest/services/RealEstate/FeatureServer/0',
                     'distance': 100,
                     'id': 'clusters',
                     'labelColor': '#fff',
                     'resolution': map.extent.getWidth() / map.width,
                     'singleColor': '#888',
                     'singleTemplate': popupTemplate,
                     'useDefaultSymbol': false,
                     'zoomOnClick': true,
                     'showSingles': false,
                     'singleSymbol': defaultSym,
                     'singleRenderer': renderer,
                     'MODE_SNAPSHOT': true,
                     'objectIdField': 'OBJECTID' // define the objectid field
                 });
             }
            return clusterLayer;
          }

          function cleanUp() {
            map.infoWindow.hide();
            clusterLayer.clearSingles();
          }

          function error(err) {
            console.log('something failed: ', err);
          }

          // show cluster extents...
          // never called directly but useful from the console 
          window.showExtents = function() {
            var extents = map.getLayer('clusterExtents');
            if ( extents ) {
              map.removeLayer(extents);
            }
            extents = new GraphicsLayer({ id: 'clusterExtents' });
            var sym = new SimpleFillSymbol().setColor(new Color([205, 193, 197, 0.5]));

            arrayUtils.forEach(clusterLayer._clusters, function(c, idx) {
              var e = c.attributes.extent;
              extents.add(new Graphic(new Extent(e[0], e[1], e[2], e[3], map.spatialReference), sym));
            }, this);
            map.addLayer(extents, 0);
          }
        });
      });
    </script>
  </head>
  <body>
   <!-- <div data-dojo-type="dijit/layout/BorderContainer"
         data-dojo-props="design:'headline',gutters:false"
         style="width: 100%; height: 100%; margin: 0;">-->
      <div id="map"
           data-dojo-type="dijit.layout.ContentPane"
           data-dojo-props="region:'center'">
          <div id="lppanel" class="roundedCorners">
              <table>
                  <tr>
                      <td style="padding:5px;">
                          <div style="font-size: 16pt; font-weight:bold;">
                              Choose Bolig Type:
                          </div>
                          <div style="padding:10px;">
                              <select id="lplist">
                                  <option value="all" selected="selected">All</option>
                                  <option value="Hytte">Hytte</option>
                                  <option value="Fritidsbolig">Fritidsbolig</option>
                              </select>
                          </div>
                      </td>
                  </tr>
              </table>
          </div>
      </div>
    <!--</div>-->
  </body>
</html>

