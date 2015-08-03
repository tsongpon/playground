package com.abctechthailand.playground.transport.frontier;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class AddressFrontierTransport {
    @JsonProperty("address_id")
    private Integer addressId;

    @JsonProperty("primary_address")
    private String primaryAddress;

    @JsonProperty("secondary_address")
    private String secondaryAddress;

    @JsonProperty("post_code")
    private String postCode;

    @JsonProperty("post_location")
    private String postLocation;

    @JsonProperty("geography")
    private String geography;

    public AddressFrontierTransport() {
        //Intentional, empty constructor
    }

    public AddressFrontierTransport(Integer addressId, String primaryAddress, String secondaryAddress, String postCode, String postLocation, String geography) {
        this.addressId = addressId;
        this.primaryAddress = primaryAddress;
        this.secondaryAddress = secondaryAddress;
        this.postCode = postCode;
        this.postLocation = postLocation;
        this.geography = geography;
    }

    public String getGeography() {
        return geography;
    }

    public void setGeography(String geography) {
        this.geography = geography;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public String getPrimaryAddress() {
        return primaryAddress;
    }

    public void setPrimaryAddress(String primaryAddress) {
        this.primaryAddress = primaryAddress;
    }

    public String getSecondaryAddress() {
        return secondaryAddress;
    }

    public void setSecondaryAddress(String secondaryAddress) {
        this.secondaryAddress = secondaryAddress;
    }

    public String getPostCode() {
        return postCode;
    }

    public void setPostCode(String postCode) {
        this.postCode = postCode;
    }

    public String getPostLocation() {
        return postLocation;
    }

    public void setPostLocation(String postLocation) {
        this.postLocation = postLocation;
    }

}
