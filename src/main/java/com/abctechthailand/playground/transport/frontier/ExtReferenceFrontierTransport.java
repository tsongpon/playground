package com.abctechthailand.playground.transport.frontier;
/**
 *
 */

public class ExtReferenceFrontierTransport {

    private Integer externalReferenceId;
    private Integer objectId;
    private Integer typeValue;
    private String system;
    private String systemVersion;
    private String source;
    private String reference;

    public Integer getExternalReferenceId() {
        return externalReferenceId;
    }

    public void setExternalReferenceId(Integer externalReferenceId) {
        this.externalReferenceId = externalReferenceId;
    }

    public Integer getObjectId() {
        return objectId;
    }

    public void setObjectId(Integer objectId) {
        this.objectId = objectId;
    }

    public Integer getTypeValue() {
        return typeValue;
    }

    public void setTypeValue(Integer typeValue) {
        this.typeValue = typeValue;
    }

    public String getSystem() {
        return system;
    }

    public void setSystem(String system) {
        this.system = system;
    }

    public String getSystemVersion() {
        return systemVersion;
    }

    public void setSystemVersion(String systemVersion) {
        this.systemVersion = systemVersion;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }
}
