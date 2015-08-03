package com.abctechthailand.playground.transport.frontier;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AdAttributeElementTransport {

    private Integer order;
    private String name;
    private Integer type;
    private String label;
    private boolean isNumeric;

    @JsonProperty("is_numeric")
    public boolean isNumeric() {
        return isNumeric;
    }

    @JsonProperty("is_numeric")
    public void setIsNumeric(boolean isNumeric) {
        this.isNumeric = isNumeric;
    }

    public Integer getOrder() {
        return order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }
}