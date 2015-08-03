package com.abctechthailand.playground.component;

import com.abctechthailand.playground.PlaygroundProperties;
import com.abctechthailand.playground.transport.frontier.AdObjectFrontierTransport;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

@Component
public class FrontierComponent {
    private static final Logger LOGGER = LoggerFactory.getLogger(FrontierComponent.class);
    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private PlaygroundProperties properties;

//    @Autowired
//    public void setTransitionProperties(PlaygroundProperties properties) {
//        this.properties = properties;
//    }
//
//    @Autowired
//    public void setRestTemplate(RestTemplate restTemplate) {
//        this.restTemplate = restTemplate;
//    }

    public AdObjectFrontierTransport fetchAdById(Integer id){
        AdObjectFrontierTransport adObject = null;

        try {
            adObject = restTemplate.getForObject(properties.getFrontierUrl()+ "/v1/ads/{id}",
                    AdObjectFrontierTransport.class, id);
            LOGGER.debug("Got Ad id {} from frontier",adObject.getObjectId());
        }catch (HttpClientErrorException e){
            LOGGER.error("AdObject id {} is not found", id);
//            throw new RetrievingAdException("AdObject is not found", e);
        }catch (ResourceAccessException e) {
            LOGGER.error("Frontier failed connection!!", e);
//            throw new RetrievingAdException("AdObject is not found", e);
        }catch (RestClientException e){
            LOGGER.error("AdObject id {} is not found", id);
//            throw new RetrievingAdException("AdObject is not found", e);
        }

        return adObject;
    }
}
