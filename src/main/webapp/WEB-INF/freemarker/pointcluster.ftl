<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
  <title>Cluster</title>
  <link rel="stylesheet" href="http://js.arcgis.com/3.14/dijit/themes/tundra/tundra.css">
  <link rel="stylesheet" href="http://js.arcgis.com/3.14/esri/css/esri.css">
  <style>
    html, body { height: 100%; width: 100%; margin: 0; padding: 0; }
    #map{ margin: 0; padding: 0; }

    /* center the image in the popup */
    .esriViewPopup .gallery { margin: 0 auto !important; }
  </style>

  <script>
    var dojoConfig = {
      paths: {
        extras: location.pathname.replace(/\/[^/]+$/, "") + "/js"
      }
    };
  </script>
  <script src="http://js.arcgis.com/3.14/"></script>
  <script>
    var map;
    require(["esri/config"], function(esriConfig) {
        esriConfig.defaults.io.corsEnabledServers.push("http://bed.api.no/api/pipek");
    });
    require([
      "dojo/parser",
      "dojo/ready",
      "dojo/_base/json",
      "esri/Color",
      "dojo/dom-style",
      "dojo/query",

      "esri/map",
      "esri/request",
      "esri/graphic",
      "esri/geometry/Extent",

      "esri/symbols/SimpleMarkerSymbol",
      "esri/symbols/SimpleFillSymbol",
      "esri/symbols/SimpleLineSymbol",
      "esri/symbols/PictureMarkerSymbol",
      "esri/renderers/ClassBreaksRenderer",

      "esri/layers/GraphicsLayer",
      "esri/SpatialReference",
      "esri/dijit/PopupTemplate",
      "esri/geometry/Point",
      "esri/geometry/webMercatorUtils",
      "extras/ClusterLayer",

      "dijit/layout/BorderContainer",
      "dijit/layout/ContentPane",
      "dojo/domReady!"

    ], function(
            parser, ready, dojoJson, Color, domStyle, query,
            Map, esriRequest, Graphic, Extent,
            SimpleMarkerSymbol, SimpleLineSymbol, SimpleFillSymbol, PictureMarkerSymbol, ClassBreaksRenderer,
            GraphicsLayer, SpatialReference, PopupTemplate, Point, webMercatorUtils,
            ClusterLayer
    ) {
      ready(function() {

        parser.parse();

        var clusterLayer;
        var popupOptions = {
          "markerSymbol": new SimpleMarkerSymbol("circle", 20, null, new Color([0, 0, 0, 0.25])),
          "marginLeft": "20",
          "marginTop": "20"
        };
        map = new Map("map", {
          basemap: "streets",
          center: [10.412690012433009,59.16579977535506],
          zoom: 7
        });

        map.on("load", function() {
          // hide the popup's ZoomTo link as it doesn't make sense for cluster features
          domStyle.set(query("a.action.zoomTo")[0], "display", "none");
          var requestHandle = esriRequest({
             // url: "data/1000-photos.json",
              url: "http://bed.api.no/api/pipek/v1/ads/search/?q=category_id:16200&fields=id,title,media.reference,company.title,company.media.reference,attributes.price,attributes.rooms,attributes.primaryroomarea,attributes.propertytype,attributes.mapcoordinatelat,attributes.mapcoordinatelon&size=5000",
              handleAs: "json"
          });
          requestHandle.then(addClusters, error);
        });

        function addClusters(response, io){
            var wgs = new SpatialReference({
                "wkid": 4326
            });
            console.log(response);
            var obj=response.hits.hits;
            var arr = {};
            var data = new Array();
            var i=0;
            for(var res in obj){
                if(obj.hasOwnProperty(res)){
                    var fields= obj[res].fields;
                    if(fields['attributes.mapcoordinatelon']!=null&&fields['attributes.mapcoordinatelat']!=null) {
                        var latlng = new Point(parseFloat(fields['attributes.mapcoordinatelon'][0]), parseFloat(fields['attributes.mapcoordinatelat'][0]), wgs);
                        var webMercator = webMercatorUtils.geographicToWebMercator(latlng);
                        var picture=fields['media.reference']!=null?fields['media.reference'][0]:"";
                        var attributes = {
                            "Title": fields['title'][0],
                            "Picture": picture
                            /*"Type": fields['attributes.propertytype'][0],
                            "Price": fields['attributes.price'][0],
                            "Rooms": fields['attributes.rooms'][0],
                            "RoomArea": fields['attributes.roomarea'][0],
                            "Picture": fields['media.referencee'][0],
                            "Company": fields['company.title'][0],
                            "CompanyLogo":fields['company.media.reference'][0]*/
                        };
                        var value = {
                            "x": webMercator.x,
                            "y": webMercator.y,
                            "attributes": attributes
                        };
                        data.push(value);
                        i++;
                    }
                }
            }
            console.log(i);
            var popupTemplate = new PopupTemplate({
                "title": "",
                "fieldInfos": [
                {
                    "fieldName": "Title",
                    "label": "Title",
                    visible: true
                }],
                "mediaInfos": [
                 {
                    "title": "",
                    "caption": "",
                    "type": "image",
                    "value": {
                        "sourceURL": "http://g.api.no/obscura/API/image/r1/zett/230x153unifiedrc/1437391364000/{Picture}",
                    }
                }]
            });

            clusterLayer = new ClusterLayer({
                "data": data,
                "distance": 100,
                "id": "clusters",
                "labelColor": "#fff",
                "labelOffset": 10,
                "resolution": map.extent.getWidth() / map.width,
                "singleColor": "#888",
                "showSingles":false,
                "maxSingles":10000,
                "singleTemplate": popupTemplate
            });

            var defaultSym = new SimpleMarkerSymbol().setSize(4);


            var picBaseUrl = "http://static.arcgis.com/images/Symbols/Shapes/";
            var blue = new PictureMarkerSymbol(picBaseUrl + "BluePin1LargeB.png", 32, 32).setOffset(0, 15);
            var green = new PictureMarkerSymbol(picBaseUrl + "GreenPin1LargeB.png", 64, 64).setOffset(0, 15);
            var red = new PictureMarkerSymbol(picBaseUrl + "RedPin1LargeB.png", 72, 72).setOffset(0, 15);

            var sls = SimpleLineSymbol;
            var sms = SimpleMarkerSymbol;
            /*var defaultSym= new sms(
                    sms.STYLE_CIRCLE, 14,
                    new sls(
                            sls.STYLE_SOLID,
                            new Color([255,255,0]), 2
                    ),
                    new Color([0,191,255,0.75])
            );
*/
            var renderer = new ClassBreaksRenderer(defaultSym, "clusterCount");
            /*var small = new sms('circle', 30,
                    new sls(new Color([255,125,0,0.25]), 10),
                    new Color([255,125,0,0.5]));

            var medium = new sms('circle', 40,
                    new sms(new Color([255,0,250,0.25]), 10),
                    new Color([255,0,250,0.5]));
            var large = new sms('circle', 50,
                    new sls(new Color([255,0,0,0.25]), 10),
                    new Color([255,0,0,0.5]));
*/

            renderer.addBreak(0, 2, blue);
            renderer.addBreak(2, 200, green);
            renderer.addBreak(200, Infinity, red);

            clusterLayer.setRenderer(renderer);
            map.addLayer(clusterLayer);

            // close the info window when the map is clicked
            map.on("click", cleanUp);
            // close the info window when esc is pressed
            map.on("key-down", function(e) {
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
          console.log("something failed: ", err);
        }

        // show cluster extents...
        // never called directly but useful from the console
        window.showExtents = function() {
          var extents = map.getLayer("clusterExtents");
          if ( extents ) {
            map.removeLayer(extents);
          }
          extents = new GraphicsLayer({ id: "clusterExtents" });
          var sym = new SimpleFillSymbol().setColor(new Color([205, 193, 197, 0.5]));

          arrayUtils.forEach(clusterLayer._clusters, function(c, idx) {
            var e = c.attributes.extent;
            extents.add(new Graphic(new Extent(e[0], e[1], e[2], e[3], map.spatialReference), sym));
          }, this);
          map.addLayer(extents, 0);
        };
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
