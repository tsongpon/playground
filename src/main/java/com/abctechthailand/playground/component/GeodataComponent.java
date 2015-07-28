package com.abctechthailand.playground.component;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.core.util.MultivaluedMapImpl;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;

import javax.ws.rs.core.MultivaluedMap;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Logger;

public class GeodataComponent {

    //private static final String FEATURESERVICEURI="http://services6.arcgis.com/MPFq870JSx7gki1d/arcgis/rest/services/propectous/FeatureServer/0/addFeatures";
   // private static final String PROSPECTOUSURI="http://bearing:9093/api/pipek/v1/ads/search/?pretty=true&q=*&fields=id,title,media.reference,attributes.mapcoordinatelat,attributes.mapcoordinatelon&size=200";

    private static final String FEATURESERVICEURI="http://services6.arcgis.com/MPFq870JSx7gki1d/ArcGIS/rest/services/property/FeatureServer/0/addFeatures";
    private static final String PROSPECTOUSURI="http://bed.api.no/api/pipek/v1/ads/search/?q=category_id:16300&fields=id,title,media.reference,company.title,company.media.reference,attributes.price,attributes.rooms,attributes.primaryroomarea,attributes.propertytype,attributes.mapcoordinatelat,attributes.mapcoordinatelon&size=5000";

    public void addFeature(String features){
        Client client = Client.create();
        MultivaluedMap<String, String> params = new MultivaluedMapImpl();
        params.add("f", "pjson");
        params.add("features", features);
        params.add("rollbackOnFailure", Boolean.TRUE.toString());
        try {
        WebResource webResource = client.resource(FEATURESERVICEURI);
        ClientResponse response = webResource.type("application/x-www-form-urlencoded").accept("application/json")
                .post(ClientResponse.class, params);

        }catch (Exception e){
            System.out.println("ERROR");
        }


    }

    public String readData(){
        Client client = Client.create();
        try {
            WebResource webResource = client.resource(PROSPECTOUSURI);
            ClientResponse response = webResource.type("application/json").get(ClientResponse.class);
            if (response.getStatus() == HttpStatus.OK.value()) {
                return response.getEntity(String.class);
            } else {
                System.out.println("ERROR");
                return null;
            }
        }catch (Exception e){
            System.out.println("ERROR");
            return null;
        }
    }

    public void saveFeatures(){
        GeodataComponent geodataComponent=new GeodataComponent();
        ObjectMapper mapper = new ObjectMapper();
        String data=geodataComponent.readData();
        try {
            JsonNode rootObj = mapper.readTree(data);
            Iterator<JsonNode> ite=rootObj.get("hits").get("hits").getElements();
            int i=0;
            while (ite.hasNext()) {
                JsonNode hitsObj = ite.next();
                JsonNode fieldsObj=hitsObj.get("fields");
                String feature=getFeatures(fieldsObj);
                if(!StringUtils.isEmpty(feature)){
                    System.out.println("save feature for ad:"+i);
                    addFeature(feature);
                    i++;
                }
            }



        } catch (IOException e) {
            System.out.println("ERROR");
        }
    }

    public String getFeatures(JsonNode fieldsObj){
        String id=fieldsObj.get("id").get(0).asText();
        String title=fieldsObj.get("title").get(0).asText();

        Double lon=null;
        Double lat=null;
        String media_references="";
        String type="";
        Double price=0.0;
        Double area=0.0;
        Integer rooms=0;
        String companyTitle="";
        String companyLogo="";

        if(fieldsObj.get("attributes.mapcoordinatelon")!=null) {
            lon = fieldsObj.get("attributes.mapcoordinatelon").get(0).asDouble();
        }
        if(fieldsObj.get("attributes.mapcoordinatelat")!=null) {
            lat = fieldsObj.get("attributes.mapcoordinatelat").get(0).asDouble();
        }
        if(fieldsObj.get("media.reference")!=null) {
            media_references = fieldsObj.get("media.reference").get(0).asText();
        }

        if(fieldsObj.get("attributes.propertytype")!=null) {
            type = fieldsObj.get("attributes.propertytype").get(0).asText();
        }

        if(fieldsObj.get("attributes.price")!=null) {
            price = fieldsObj.get("attributes.price").get(0).asDouble();
        }
        if(fieldsObj.get("attributes.primaryroomarea")!=null) {
            area = fieldsObj.get("attributes.primaryroomarea").get(0).asDouble();
        }
        if(fieldsObj.get("attributes.rooms")!=null) {
            rooms = fieldsObj.get("attributes.rooms").get(0).asInt();
        }
        if(fieldsObj.get("company.title")!=null) {
            companyTitle = fieldsObj.get("company.title").get(0).asText();
        }

        if(fieldsObj.get("company.media.reference")!=null) {
            companyLogo = fieldsObj.get("company.media.reference").get(0).asText();
        }

        if(lat!=null&lon!=null){
            String feature="[{'geometry' : {'x' : "+lon+", 'y' :"+lat+"},  'attributes' : {'id' :'"+id+"','title' : '"+title+"'," +
                    "'picture' : '"+media_references+"','type':'"+type+"','price':"+price+",'roomarea':"+area+",'rooms':"+rooms+"," +
                    "'company':'"+companyTitle+"','companylogo':'"+companyLogo+"','link':''}}]";
            return  feature;
        }
        return null;
    }

    public static void main(String[] args) {
        GeodataComponent geodataComponent=new GeodataComponent();
       // String features="[{'geometry' : {'x' : 11.37594262547355, 'y' :59.07860718175513 },  'attributes' : {'id' :3001741,'title' : 'BJØRKELANGEN* Sentrumsnær 3-roms endeleilighet i 1.etasje - Terrasse m/gode solforhold - Rolige omgivelser','image' : '00/2e/002ef48cafacf5a50c599e0eb9affb9f'}}]";
        //geodataComponent.addFeature(features);
        geodataComponent.saveFeatures();
    }
}
