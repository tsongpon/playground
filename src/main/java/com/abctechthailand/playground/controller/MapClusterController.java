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

    @RequestMapping("geohashcluster0.html")
    public String renderGeohash0(Model model) {
        return "geohash-leaflet0";
    }

    @RequestMapping("geohashcluster1.html")
    public String renderGeohash1(Model model) {
        return "geohash-leaflet1";
    }

    @RequestMapping("geohashcluster2.html")
    public String renderGeohash2(Model model) {
        return "geohash-leaflet2";
    }

    //show map clustering (by leaflet lib) on Geodata Map by giving data from elasticsearch
    @RequestMapping("geodata_mapcluster.html")
    public String renderMapClusterOnGeodataMap(Model model) {
        return "geodata_mapcluster";
    }
    //show map clustering (by leaflet lib) on Norkart Map by giving data from elasticsearch
    @RequestMapping("norkart_mapcluster.html")
    public String renderMapClusterOnNorkartMap(Model model) {
        return "norkart_mapcluster";
    }
}
