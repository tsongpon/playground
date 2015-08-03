package com.abctechthailand.playground.transport.frontier;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ContactFrontierTransport {

    @JsonProperty("id")
    private Integer contactId;

    @JsonProperty("name")
    private String name;

    @JsonProperty("email")
    private String email;

    @JsonProperty("description")
    private String description;

    @JsonProperty("contact_fields")
    private List<ContactAttributeFrontierTransport> contactAttributes;

    public Integer getContactId() {
        return contactId;
    }

    public void setContactId(Integer contactId) {
        this.contactId = contactId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<ContactAttributeFrontierTransport> getContactAttributes() {
        return contactAttributes;
    }

    public void setContactAttributes(List<ContactAttributeFrontierTransport> contactAttributes) {
        this.contactAttributes = contactAttributes;
    }
}
