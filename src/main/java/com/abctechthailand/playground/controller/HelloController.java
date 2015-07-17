package com.abctechthailand.playground.controller;

import biweekly.Biweekly.*;
import biweekly.ICalendar;
import com.abctechthailand.playground.component.CalendarComponent;
import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.model.Event;
import net.fortuna.ical4j.data.ParserException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.net.URISyntaxException;
import java.net.URL;
import java.text.ParseException;

/**
 *
 */

@Controller //tell spring, this is our controller
public class HelloController {

    @Autowired
    private CalendarComponent calendar;

    //tell spring to call this method if someone make request to this path
    @RequestMapping("/sayhello.html")
    public String sayHello(Model model) {
        return "index";
    }

    @RequestMapping(value = "/generatecalendar.ics", method = RequestMethod.GET)
    public String generatecalendar(Model model, HttpServletRequest request) throws IOException, URISyntaxException {
        String icalStr = calendar.generateEvent();
//        URL url = new URL(request.getRequestURL().toString());
//        BufferedInputStream bis = new BufferedInputStream(url.openStream());
//        FileOutputStream fis = new FileOutputStream(icalStr);
//        byte[] buffer = new byte[1024];
//        int count = 0;
//        while((count = bis.read(buffer,0,1024)) != -1)
//        {
//            fis.write(buffer, 0, count);
//        }
//        fis.close();
//        bis.close();
        return "calendar";
    }

    @RequestMapping(value = "/calendar.html")
    public String calendar(Model model, HttpServletRequest request) throws IOException, URISyntaxException {
//        String baseUrl = StringUtils.substringBefore(request.getRequestURL().toString(), "/playground");
//        model.addAttribute("url", baseUrl + "/playground/generatecalendar.ics");
        return "calendar";
    }
}
