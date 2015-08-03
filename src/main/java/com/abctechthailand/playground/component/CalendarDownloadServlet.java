package com.abctechthailand.playground.component;

import biweekly.Biweekly;
import biweekly.ICalendar;
import biweekly.component.VAlarm;
import biweekly.component.VEvent;
import biweekly.parameter.Related;
import biweekly.property.*;
import biweekly.util.Duration;
import com.abctechthailand.playground.PlaygroundProperties;
import com.abctechthailand.playground.transport.frontier.AdObjectFrontierTransport;
import com.abctechthailand.playground.transport.frontier.AttributeFrontierTransport;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("download.ics")
@Service
public class CalendarDownloadServlet extends HttpServlet {
    private static final Logger LOGGER = LoggerFactory.getLogger(CalendarDownloadServlet.class);
//    08.07.2015 18:00 - 18:00
    public static final String ISO8601_DATE_PATTERN = "dd.MM.yyyy HH:mm'";

    public void download(AdObjectFrontierTransport transport, String zettUrl, HttpServletResponse response) throws IOException, URISyntaxException {

        LOGGER.debug("ad id: {}", transport.getObjectId());
        ICalendar icals = new ICalendar();

        Location location = new Location(transport.getAddress().getPrimaryAddress()
                + transport.getAddress().getPostLocation());
        Organizer organizer = new Organizer("tum", "tum@abctech-thailand.com");

        VEvent event = new VEvent();
        List<AttributeFrontierTransport> attr = transport.getAttributes().stream()
                .filter(each -> "Visning".equals(each.getLabel())).collect(Collectors.toList());

        DateTimeFormatter formatter = DateTimeFormat.forPattern(ISO8601_DATE_PATTERN);
        Date dateStart = null;
        Date dateEnd = null;
        if(attr.get(0) != null){
            String [] dateStartStr = attr.get(0).getValue().split(" -");
            dateStart = DateTime.parse(dateStartStr[0], formatter).toDate();
        }
        event.setDateStart(dateStart);

        if(attr.get(1) != null){
            String [] dateEndStr = attr.get(1).getValue().split(" -");
            dateEnd = DateTime.parse(dateEndStr[0], formatter).toDate();
        }
        event.setDateEnd(dateEnd);
        
        event.setUrl(zettUrl + "/" + transport.getObjectId());
        event.setLocation(location);
        event.setOrganizer(organizer);
        event.setSummary("Booking for interesting in ad id: " + transport.getObjectId());
        event.setDescription(transport.getTitle() + "/" + transport.getShortDescription());
        event.addContact(transport.getContacts().get(0).getName() + "/" + transport.getContacts().get(0).getEmail());

        Duration duration = Duration.builder().prior(true).minutes(5).build();
        duration.add(new DateTime().toDate());
        Trigger trigger = new Trigger(duration, Related.START);
        String subject = "Reminder: Meeting in 5 minutes";
        String body = "Let attention in this meeting";
        List<String> mailTo = Arrays.asList("ni@abctech-thailand.com");
        VAlarm email = VAlarm.email(trigger, subject, body, mailTo);

        event.setComponent(email);

//        event.addAlarm(email);

        icals.addEvent(event);
        String calendarText = Biweekly.write(icals).go();
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
