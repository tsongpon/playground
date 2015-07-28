package com.abctechthailand.playground.controller;

import com.abctechthailand.playground.component.CalendarDownloadServlet;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URISyntaxException;

/**
 *
 */

@Controller //tell spring, this is our controller
public class HelloController{

    //tell spring to call this method if someone make request to this path
    @RequestMapping("/sayhello.html")
    public String sayHello(Model model) {
        return "index";
    }

    @RequestMapping(value = "/calendar.html")
    public String calendar(Model model) throws IOException, URISyntaxException {
        return "calendar";
    }

    @RequestMapping(value = "/download.ics")
    public void downloadCalendar(HttpServletRequest request, HttpServletResponse response) throws IOException, URISyntaxException {
        CalendarDownloadServlet fileServlet = new CalendarDownloadServlet();
        fileServlet.download(request, response);
    }

}
