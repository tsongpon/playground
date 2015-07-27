package com.abctechthailand.playground.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MapClusterController {
    @RequestMapping("pointcluster0.html")
    public String renderPointCluster(Model model) {
        return "pointcluster";
    }
    @RequestMapping("pointcluster1.html")
    public String renderPointClusterESRI(Model model) {
        return "pointcluster-esri";
    }
    @RequestMapping("markercluster0.html")
    public String renderLeafletMarkerClusterOrigin(Model model) {
        return "leaflet-orig";
    }
    @RequestMapping("markercluster1.html")
    public String renderLeafletMarkerClusterESRI(Model model) {
        return "leaflet-esri";
    }
    @RequestMapping("markercluster2.html")
    public String renderLeafletMarkerClusterESRIStyle(Model model) {
        return "leaflet-esri2";
    }
    @RequestMapping("test.html")
    public String test(Model model) {
        return "test";
    }
}
