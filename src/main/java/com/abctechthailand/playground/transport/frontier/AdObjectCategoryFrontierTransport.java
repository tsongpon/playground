package com.abctechthailand.playground.transport.frontier;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class AdObjectCategoryFrontierTransport {

    @JsonProperty(value = "category_id")
    private Integer categoryId;

    @JsonProperty(value = "name")
    private String name;

    @JsonProperty(value = "full_name")
    private String fullName;

    @JsonProperty(value = "type")
    private String type;

    @JsonProperty(value = "parent")
    private Integer parent;

    @JsonProperty(value = "link")
    private Integer link;

    @JsonProperty(value = "deprecated")
    private Boolean deprecated;

    @JsonProperty(value = "numbering")
    private Integer numbering;

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
    }

    public Integer getLink() {
        return link;
    }

    public void setLink(Integer link) {
        this.link = link;
    }

    public Boolean getDeprecated() {
        return deprecated;
    }

    public void setDeprecated(Boolean deprecated) {
        this.deprecated = deprecated;
    }

    public Integer getNumbering() {
        return numbering;
    }

    public void setNumbering(Integer numbering) {
        this.numbering = numbering;
    }
}
