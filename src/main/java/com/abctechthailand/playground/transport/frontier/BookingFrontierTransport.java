package com.abctechthailand.playground.transport.frontier;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 */
public class BookingFrontierTransport {

    @JsonProperty("date_from")
    private String dateFrom;

    @JsonProperty("date_to")
    private String dateTo;

    @JsonProperty("product")
    private String product;

    @JsonProperty("publications")
    private String [] publications;

    @JsonProperty("ext_booking_id")
    private Integer extBookingId;

    public String getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(String dateFrom) {
        this.dateFrom = dateFrom;
    }

    public String getDateTo() {
        return dateTo;
    }

    public void setDateTo(String dateTo) {
        this.dateTo = dateTo;
    }

    public String getProduct() {
        return product;
    }

    public void setProduct(String product) {
        this.product = product;
    }

    public String[] getPublications() {
        return publications;
    }

    public void setPublications(String[] publications) {
        this.publications = publications;
    }

    public Integer getExtBookingId() {
        return extBookingId;
    }

    public void setExtBookingId(Integer extBookingId) {
        this.extBookingId = extBookingId;
    }
}
