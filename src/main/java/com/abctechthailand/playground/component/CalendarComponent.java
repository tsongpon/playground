package com.abctechthailand.playground.component;

import biweekly.Biweekly;
import biweekly.Biweekly.*;
import biweekly.ICalendar;
import biweekly.component.VEvent;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.DateTime;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.model.Event.Gadget;
import com.google.api.services.calendar.model.Event;
import com.google.api.services.calendar.model.EventDateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.util.WebUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class CalendarComponent {

    private static final Logger LOG = LoggerFactory.getLogger(CalendarComponent.class);

    public String generateEvent() throws IOException, URISyntaxException {
        ICalendar icals = new ICalendar();
        VEvent event = new VEvent();
        event.setDateStart(new Date());
        event.setDateEnd(new Date());
        event.setSummary("Word of the Day");
        event.setDescription("time and date for the \"visning\"\n" +
                "address of the property\n" +
                "link to prospect\n" +
                "name, e-mail address and telephone number to the broker\n" +
                "ad-id number");
        icals.addEvent(event);

//        File root = new File("./calendardata");
//        if (!root.exists()) {
//            root.mkdirs();
//        }
//        File file = new File("calendar.ics");
//        Biweekly.write(icals).go(file);
        return Biweekly.write(icals).go();
    }
}
