package com.abctechthailand.playground.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 */

@Controller //tell spring, this is our controller
public class HelloController {

    //tell spring to call this method if someone make request to this path
    @RequestMapping("sayhello.html")
    public String sayHello(Model model) {
        return "index";
    }
}
