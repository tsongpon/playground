<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
    <title>Cluster</title>
    <link rel="stylesheet" href="http://js.arcgis.com/3.11/dijit/themes/tundra/tundra.css">
    <link rel="stylesheet" href="http://js.arcgis.com/3.11/esri/css/esri.css">
    <style>
      html, body { height: 100%; width:100%; margin: 0; padding: 0; }
      #map{ margin: 0; padding: 0; }

      /* center the image in the popup */
      .esriViewPopup .gallery { margin: 0 auto !important; }
      /* CSS for Cluster Layer */
      #clusters_layer > circle { cursor: pointer; }
      #clusters_layer > text { cursor: pointer; }
    </style>

    <script>
      // helpful for understanding dojoConfig.packages vs. dojoConfig.paths:
      // http://www.sitepen.com/blog/2013/06/20/dojo-faq-what-is-the-difference-packages-vs-paths-vs-aliases/
      var dojoConfig = { 
        paths: {
          extras: location.pathname.replace(/\/[^/]+$/, '')
        }
      };
    </script>
    <script src="http://js.arcgis.com/3.11/"></script>
    <script>
      var map;
      require([
         'esri/urlUtils',
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
        urlUtils,parser, ready, arrayUtils, Color, domStyle, query,
        Map, esriRequest, Graphic, Extent,
        SimpleMarkerSymbol, SimpleLineSymbol, SimpleFillSymbol, PictureMarkerSymbol, ClassBreaksRenderer,
        GraphicsLayer, SpatialReference, PopupTemplate, Point, webMercatorUtils,
        ClusterFeatureLayer
      ) {
        urlUtils.addProxyRule({
              urlPrefix: "http://services6.arcgis.com",
              proxyUrl: "http://192.168.50.32:9000/playground/proxy.jsp"});

        ready(function() {
          parser.parse();
          var clusterLayer;
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
            addClusters();
          });

          function addClusters(resp) {
            // popupTemplate to work with attributes specific to this dataset
            /*var popupTemplate = PopupTemplate({
              'title': '',
              'fieldInfos': [{
                'fieldName': 'title',
                'label': 'Title: ',
                visible: true
              }, {
                'fieldName': 'image',
                'label': 'Image: ',
                visible: true
              }]
            });*/
              var popupTemplate = new PopupTemplate({
                  "title": "",
                  "fieldInfos": [{
                      "fieldName": "id",
                      "label": "Ad",
                      visible: true
                  }, {
                      "fieldName": "title",
                      "label": "Title",
                      visible: true
                  }],
                  "mediaInfos": [{
                      "title": "",
                      "caption": "",
                      "type": "image",
                      "value": {
                          "sourceURL": "http://bearing:9079/api/frontier/v1/mediacontents/{image}",
                      }
                  }]
              });

              var picBaseUrl = 'http://static.arcgis.com/images/Symbols/Shapes/';
              var defaultSym = new PictureMarkerSymbol(picBaseUrl + 'GreenPin1LargeB.png', 32, 32);
              var renderer = new ClassBreaksRenderer(defaultSym, 'clusterCount');
            /*
            var popupTemplate = PopupTemplate({
              'title': '',
              'fieldInfos': [{
                'fieldName': 'CaseNum',
                'label': 'Case Number: ',
                visible: true
              }, {
                'fieldName': 'Block',
                'label': 'Block: ',
                visible: true
              }, {
                'fieldName': 'Descrip',
                'label': 'Description: ',
                visible: true
              }]
            });
            */

            // cluster layer that uses OpenLayers style clustering
            // class break renderer service
            // http://services.arcgis.com/V6ZHFr6zdgNZuVG0/ArcGIS/rest/services/CTAStationStats/FeatureServer/0
            // simple renderer service
            // http://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/ChicagoCrime/FeatureServer/0
            clusterLayer = new ClusterFeatureLayer({
             // 'url': 'http://services.arcgis.com/V6ZHFr6zdgNZuVG0/ArcGIS/rest/services/CT2010_pts/FeatureServer/0',
              'url':'http://services6.arcgis.com/MPFq870JSx7gki1d/arcgis/rest/services/propectous/FeatureServer/0',
              'distance': 100,
              'id': 'clusters',
              'labelColor': '#fff',
              'resolution': map.extent.getWidth() / map.width,
              'singleColor': '#888',
              'singleTemplate': popupTemplate,
              'useDefaultSymbol': false,
                'zoomOnClick':false,
                'showSingles':false,
                'singleSymbol':defaultSym,
                'singleRenderer':renderer,
              'objectIdField': 'OBJECTID' // define the objectid field
            });
            //var picBaseUrl = 'http://static.arcgis.com/images/Symbols/Shapes/';
           // var defaultSym = new PictureMarkerSymbol(picBaseUrl + 'GreenPin1LargeB.png', 32, 32);
           // var renderer = new ClassBreaksRenderer(defaultSym, 'clusterCount');
            var sls = SimpleLineSymbol;
            var sms = SimpleMarkerSymbol;

            var small = new sms('circle', 20,
                        new sls(sls.STYLE_SOLID, new Color([255,191,0,0.25]), 15),
                        new Color([255,191,0,0.5]));

            var medium = new sms('circle', 30,
                                      new sls(sls.STYLE_SOLID, new Color([148,0,211,0.25]), 15),
                                      new Color([148,0,211,0.5]));
            var large = new sms('circle', 50,
                        new sls(sls.STYLE_SOLID, new Color([255,0,0,0.25]), 15),
                        new Color([255,0,0,0.5]));

            renderer.addBreak(2, 10, small);
            renderer.addBreak(10, 25, medium);
            renderer.addBreak(25, 5000, large);
            // Providing a ClassBreakRenderer is also optional
            //clusterLayer.setRenderer(renderer);
            map.addLayer(clusterLayer);

            // close the info window when the map is clicked
            map.on('click', cleanUp);
            // close the info window when esc is pressed
            map.on('key-down', function(e) {
              if (e.keyCode === 27) {
                cleanUp();
              }
            });
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
    <div data-dojo-type="dijit/layout/BorderContainer"
         data-dojo-props="design:'headline',gutters:false"
         style="width: 100%; height: 100%; margin: 0;">
      <div id="map"
           data-dojo-type="dijit/layout/ContentPane"
           data-dojo-props="region:'center'">
      </div>
    </div>
  </body>
</html>

