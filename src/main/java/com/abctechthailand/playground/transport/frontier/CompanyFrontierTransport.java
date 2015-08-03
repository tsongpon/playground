package com.abctechthailand.playground.transport.frontier;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

/**
 *
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class CompanyFrontierTransport {
    @JsonProperty("id")
    private Integer objectId;

    @JsonProperty("data_table")
    private String dataTable;

    @JsonProperty("status")
    private Integer statusValue;

    @JsonProperty("admin_status")
    private Integer adminStatusValue;

    @JsonProperty("category")
    private String category;

    @JsonProperty("title")
    private String title;

    @JsonProperty("short_description")
    private String shortDescription;

    @JsonProperty("publish_from_time")
    private String publishFromTime;

    @JsonProperty("publish_to_time")
    private String publishToTime;

    @JsonProperty("system_created_time")
    private String systemCreatedTime;

    @JsonProperty("created_by")
    private String createdBy;

    @JsonProperty("created_time")
    private String createdTime;

    @JsonProperty("system_modified_time")
    private String systemModifiedTime;

    @JsonProperty("modified_by")
    private String modifiedBy;

    @JsonProperty("modified_time")
    private String modifiedTime;

    @JsonProperty("deleted_by")
    private String deletedBy;

    @JsonProperty("deleted_time")
    private String deletedTime;

    @JsonProperty("parent_id")
    private Integer parentId;

    @JsonProperty("billing_company_id")
    private Integer billingCompanyId;

    @JsonProperty("address_id")
    private Integer addressId;

    @JsonProperty("makereport")
    private Boolean makereport;

    @JsonProperty("package_deal")
    private Integer packagedeal;

    @JsonProperty("address")
    private AddressFrontierTransport addressTransport;

    @JsonProperty("contacts")
    private List<ContactFrontierTransport> contactTransports;

    @JsonProperty("fields")
    private List<AttributeFrontierTransport> attributeTransports;

    @JsonProperty("media")
    private List<MediaFrontierTransport> mediaTransports;

    @JsonProperty("subcompanies")
    private List<Integer> subCompanies;

    public Integer getObjectId() {
        return objectId;
    }

    public void setObjectId(Integer objectId) {
        this.objectId = objectId;
    }

    public String getDataTable() {
        return dataTable;
    }

    public void setDataTable(String dataTable) {
        this.dataTable = dataTable;
    }

    public Integer getStatusValue() {
        return statusValue;
    }

    public void setStatusValue(Integer statusValue) {
        this.statusValue = statusValue;
    }

    public Integer getAdminStatusValue() {
        return adminStatusValue;
    }

    public void setAdminStatusValue(Integer adminStatusValue) {
        this.adminStatusValue = adminStatusValue;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getPublishFromTime() {
        return publishFromTime;
    }

    public void setPublishFromTime(String publishFromTime) {
        this.publishFromTime = publishFromTime;
    }

    public String getPublishToTime() {
        return publishToTime;
    }

    public void setPublishToTime(String publishToTime) {
        this.publishToTime = publishToTime;
    }

    public String getSystemCreatedTime() {
        return systemCreatedTime;
    }

    public void setSystemCreatedTime(String systemCreatedTime) {
        this.systemCreatedTime = systemCreatedTime;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(String createdTime) {
        this.createdTime = createdTime;
    }

    public String getSystemModifiedTime() {
        return systemModifiedTime;
    }

    public void setSystemModifiedTime(String systemModifiedTime) {
        this.systemModifiedTime = systemModifiedTime;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public String getModifiedTime() {
        return modifiedTime;
    }

    public void setModifiedTime(String modifiedTime) {
        this.modifiedTime = modifiedTime;
    }

    public String getDeletedBy() {
        return deletedBy;
    }

    public void setDeletedBy(String deletedBy) {
        this.deletedBy = deletedBy;
    }

    public String getDeletedTime() {
        return deletedTime;
    }

    public void setDeletedTime(String deletedTime) {
        this.deletedTime = deletedTime;
    }

    public List<ContactFrontierTransport> getContactTransports() {
        return contactTransports;
    }

    public void setContactTransports(List<ContactFrontierTransport> contactTransports) {
        this.contactTransports = contactTransports;
    }

    public List<AttributeFrontierTransport> getAttributeTransports() {
        return attributeTransports;
    }

    public void setAttributeTransports(List<AttributeFrontierTransport> attributeTransports) {
        this.attributeTransports = attributeTransports;
    }

    public List<MediaFrontierTransport> getMediaTransports() {
        return mediaTransports;
    }

    public void setMediaTransports(List<MediaFrontierTransport> mediaTransports) {
        this.mediaTransports = mediaTransports;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getBillingCompanyId() {
        return billingCompanyId;
    }

    public void setBillingCompanyId(Integer billingCompanyId) {
        this.billingCompanyId = billingCompanyId;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public Boolean getMakereport() {
        return makereport;
    }

    public void setMakereport(Boolean makereport) {
        this.makereport = makereport;
    }

    public Integer getPackagedeal() {
        return packagedeal;
    }

    public void setPackagedeal(Integer packagedeal) {
        this.packagedeal = packagedeal;
    }

    public AddressFrontierTransport getAddressTransport() {
        return addressTransport;
    }

    public void setAddressTransport(AddressFrontierTransport addressTransport) {
        this.addressTransport = addressTransport;
    }

    public List<Integer> getSubCompanies() {
        return subCompanies;
    }

    public void setSubCompanies(List<Integer> subCompanies) {
        this.subCompanies = subCompanies;
    }
}
