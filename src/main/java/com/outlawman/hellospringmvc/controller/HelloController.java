package com.outlawman.hellospringmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;

/**
 *
 */

@Controller //tell spring, this is our controller
public class HelloController {

    //tell spring to call this method if someone make request to this path
    @RequestMapping("sayhello.html")
    public String sayHello(Model model) {
        //Add date object to model and named it as 'time',
        //jsp view can access this boject
        model.addAttribute("time", new Date());
        //tell spring which jsp file will use for render response
        return "hello";
    }
}
