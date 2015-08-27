package com.abctechthailand.playground.component;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(value = "recaptcha.html")
@Service
public class RecaptchaServlet {
    public String doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // get reCAPTCHA request param
        String gRecaptchaResponse = request
                .getParameter("g-recaptcha-response");
        System.out.println(gRecaptchaResponse);
        boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);

        // logging example
        System.out.println("Captcha Verify: " + verify);

        if (!verify) {
            return null;
        }
        return "result";
    }
}
