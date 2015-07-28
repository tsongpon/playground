package com.abctechthailand.playground.component;

import biweekly.Biweekly;
import biweekly.ICalendar;
import biweekly.component.VEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URISyntaxException;
import java.util.Date;

@WebServlet("download.ics")
public class CalendarDownloadServlet extends HttpServlet {

    private static final int BYTES_DOWNLOAD = 4096;

    public void download(HttpServletRequest request, HttpServletResponse response) throws IOException, URISyntaxException {

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
        String calendarText=Biweekly.write(icals).go();
        OutputStream out = response.getOutputStream();

        response.setContentType("text/calendar");
        response.setHeader("Content-Disposition",
                String.format("attachment; filename=\"%s\"", "calendar.ics"));

        byte[] b = calendarText.getBytes();
        out.write(b);
        out.flush();
        out.close();
    }
}
