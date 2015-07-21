package com.abctechthailand.playground.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 */
@Controller
public class FacebookShareController {
    @RequestMapping("facebookshare.html")
    public String renderfacebookshare(Model model) {
        return "facebookshare";
    }

}
