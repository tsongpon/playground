package com.abctechthailand.playground.transport.frontier;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class AdObjectFrontierTransport {
    @JsonProperty("id")
    private Integer objectId;

    @JsonProperty("data_type")
    private Integer dataType;

    @JsonProperty("state")
    private Integer publishingStatus;

    @JsonProperty("transaction_type")
    private Integer transactionType;

    @Deprecated
    @JsonProperty("transaction_status")
    private Integer transactionStatus;

    @JsonProperty("transaction_changed_time")
    private String transactionChangeTime;

    @JsonProperty("zett_code")
    private String zettCode;

    @JsonProperty("contact_privacy_status")
    private Integer contactPrivacyStatus;

    @JsonProperty("expired_notification_status")
    private Integer expireNotificationStatus;

    @JsonProperty("temporary_company_id")
    private Integer temporaryCompanyId;

    @JsonProperty("category_id")
    private Integer categoryId;

    @JsonProperty("print_adobject_id")
    private Integer printAdObjectId;

    @JsonProperty("company_id")
    private Integer companyId;

    @JsonProperty("additional_companies")
    private List<Integer> additionalCompanies;

    @JsonProperty("company")
    private CompanyFrontierTransport companyObject;

    @JsonProperty("address_id")
    private Integer addressId;

    @JsonProperty("address")
    private AddressFrontierTransport address;

    @JsonProperty("adObject_category")
    private AdObjectCategoryFrontierTransport adObjectCategory; // object of the main category

    @JsonProperty("adObject_categories")
    private List<AdObjectCategoryFrontierTransport> adObjectCategories = new ArrayList<>();

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

    @JsonProperty("contacts")
    private List<ContactFrontierTransport> contacts = new ArrayList<>();

    @JsonProperty("fields")
    private List<AttributeFrontierTransport> attributes = new ArrayList<>();

    @JsonProperty("media")
    private List<MediaFrontierTransport> media = new ArrayList<>();

    @JsonProperty("extref")
    private List<ExtReferenceFrontierTransport> externalReferences = new ArrayList<>();

    @JsonProperty("bookings")
    private List<BookingFrontierTransport> bookings = new ArrayList<>();

    @JsonProperty("is_commercial")
    private boolean isCommercial;

    public boolean isCommercial() {
        return isCommercial;
    }

    public void setCommercial(boolean isCommercial) {
        this.isCommercial = isCommercial;
    }

    public Integer getDataType() {
        return dataType;
    }

    public void setDataType(Integer dataType) {
        this.dataType = dataType;
    }

    public Integer getPublishingStatus() {
        return publishingStatus;
    }

    public void setPublishingStatus(Integer publishingStatus) {
        this.publishingStatus = publishingStatus;
    }

    public String getTransactionChangeTime() {
        return transactionChangeTime;
    }

    public void setTransactionChangeTime(String transactionChangeTime) {
        this.transactionChangeTime = transactionChangeTime;
    }

    public String getZettCode() {
        return zettCode;
    }

    public void setZettCode(String zettCode) {
        this.zettCode = zettCode;
    }

    public Integer getContactPrivacyStatus() {
        return contactPrivacyStatus;
    }

    public void setContactPrivacyStatus(Integer contactPrivacyStatus) {
        this.contactPrivacyStatus = contactPrivacyStatus;
    }

    public Integer getExpireNotificationStatus() {
        return expireNotificationStatus;
    }

    public void setExpireNotificationStatus(Integer expireNotificationStatus) {
        this.expireNotificationStatus = expireNotificationStatus;
    }

    public Integer getTemporaryCompanyId() {
        return temporaryCompanyId;
    }

    public void setTemporaryCompanyId(Integer temporaryCompanyId) {
        this.temporaryCompanyId = temporaryCompanyId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getPrintAdObjectId() {
        return printAdObjectId;
    }

    public void setPrintAdObjectId(Integer printAdObjectId) {
        this.printAdObjectId = printAdObjectId;
    }

    public CompanyFrontierTransport getCompanyObject() {
        return companyObject;
    }

    public void setCompanyObject(CompanyFrontierTransport companyObject) {
        this.companyObject = companyObject;
    }

    public List<Integer> getAdditionalCompanies() {
        return additionalCompanies;
    }

    public void setAdditionalCompanies(List<Integer> additionalCompanies) {
        this.additionalCompanies = additionalCompanies;
    }

    public AddressFrontierTransport getAddress() {
        return address;
    }

    public void setAddress(AddressFrontierTransport address) {
        this.address = address;
    }

    public AdObjectCategoryFrontierTransport getAdObjectCategory() {
        return adObjectCategory;
    }

    public void setAdObjectCategory(AdObjectCategoryFrontierTransport adObjectCategory) {
        this.adObjectCategory = adObjectCategory;
    }

    public List<AdObjectCategoryFrontierTransport> getAdObjectCategories() {
        return adObjectCategories;
    }

    public void setAdObjectCategories(List<AdObjectCategoryFrontierTransport> adObjectCategories) {
        this.adObjectCategories = adObjectCategories;
    }

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

    public Integer getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(Integer transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    public List<ContactFrontierTransport> getContacts() {
        return contacts;
    }

    public void setContacts(List<ContactFrontierTransport> contacts) {
        this.contacts = contacts;
    }

    public List<AttributeFrontierTransport> getAttributes() {
        return attributes;
    }

    public void setAttributes(List<AttributeFrontierTransport> attributes) {
        this.attributes = attributes;
    }

    public List<MediaFrontierTransport> getMedia() {
        return media;
    }

    public void setMedia(List<MediaFrontierTransport> media) {
        this.media = media;
    }

    public List<ExtReferenceFrontierTransport> getExternalReferences() {
        return externalReferences;
    }

    public void setExternalReferences(List<ExtReferenceFrontierTransport> externalReferences) {
        this.externalReferences = externalReferences;
    }

    public Integer getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Integer companyId) {
        this.companyId = companyId;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public Integer getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(Integer transactionType) {
        this.transactionType = transactionType;
    }

    public List<BookingFrontierTransport> getBookings() {
        return bookings;
    }

    public void setBookings(List<BookingFrontierTransport> bookings) {
        this.bookings = bookings;
    }
}
