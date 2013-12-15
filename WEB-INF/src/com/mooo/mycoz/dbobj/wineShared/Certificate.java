package com.mooo.mycoz.dbobj.wineShared;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class Certificate extends DBObject {
	private Integer id;
	private String certificateCode;
	private String issuingAuthority;
	private Date issueDate;
	private Integer valid;
	private String certificateType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCertificateCode() {
		return certificateCode;
	}

	public void setCertificateCode(String certificateCode) {
		this.certificateCode = certificateCode;
	}

	public String getIssuingAuthority() {
		return issuingAuthority;
	}

	public void setIssuingAuthority(String issuingAuthority) {
		this.issuingAuthority = issuingAuthority;
	}

	public Date getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	public Integer getValid() {
		return valid;
	}

	public void setValid(Integer valid) {
		this.valid = valid;
	}

	public String getCertificateType() {
		return certificateType;
	}

	public void setCertificateType(String certificateType) {
		this.certificateType = certificateType;
	}
}