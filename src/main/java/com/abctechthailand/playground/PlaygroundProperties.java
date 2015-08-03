package com.abctechthailand.playground;

import no.api.gaia.apiproperties.GaiaApiProperties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Properties;

@Component
public class PlaygroundProperties implements InitializingBean {
    private static final Logger log = LoggerFactory.getLogger(PlaygroundProperties.class);
    private Properties properties = null;

    private GaiaApiProperties apiPropertiesManager;

    @Override
    public void afterPropertiesSet() throws IOException {
        properties = new Properties();
        properties.load(PlaygroundProperties.class.getResourceAsStream("/playground.properties"));
    }

    protected String getValue(String propertyName) {
        String value = null;

        if (apiPropertiesManager != null && apiPropertiesManager.getGlobalProperty(propertyName) != null) {
            value = apiPropertiesManager.getGlobalProperty(propertyName).getValue();
        }
        if (value == null) { // fallback
            value = properties.getProperty(propertyName);
        }
        return value;
    }

    /**
     * @return frontier url
     */
    public String getFrontierUrl() {
        return getValue("frontier.url");
    }

    public String getZettServerHost() {
        return getValue("transition.zett.url");
    }

}
