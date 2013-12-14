package com.mooo.mycoz.dbobj.wineBranch;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class Winery extends DBObject {
	private Integer id;
	private String shortName;
	private String enterpriseName;
	private String address;
	private String telephone;
	private String zipcode;
	private String mobilePhone;
	private Integer branchId;
	private Integer stateId;
	private String enterpriseCode;
	private String enterpriseName1;
	private String contact;
	private String telephone1;
	private String hygieneLicense;
	private String businessLicence;
	private Date createDate;
	private String isConfirm;
	private String introduction;
	private Double totalPits;
	private Double averageAgePits;
	private Double hightAgePits;
	private Double nissan;
	private Double nissanTop;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getEnterpriseName() {
		return enterpriseName;
	}

	public void setEnterpriseName(String enterpriseName) {
		this.enterpriseName = enterpriseName;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public Integer getBranchId() {
		return branchId;
	}

	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}

	public Integer getStateId() {
		return stateId;
	}

	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}

	public String getEnterpriseCode() {
		return enterpriseCode;
	}

	public void setEnterpriseCode(String enterpriseCode) {
		this.enterpriseCode = enterpriseCode;
	}

	public String getEnterpriseName1() {
		return enterpriseName1;
	}

	public void setEnterpriseName1(String enterpriseName1) {
		this.enterpriseName1 = enterpriseName1;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getTelephone1() {
		return telephone1;
	}

	public void setTelephone1(String telephone1) {
		this.telephone1 = telephone1;
	}

	public String getHygieneLicense() {
		return hygieneLicense;
	}

	public void setHygieneLicense(String hygieneLicense) {
		this.hygieneLicense = hygieneLicense;
	}

	public String getBusinessLicence() {
		return businessLicence;
	}

	public void setBusinessLicence(String businessLicence) {
		this.businessLicence = businessLicence;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getIsConfirm() {
		return isConfirm;
	}

	public void setIsConfirm(String isConfirm) {
		this.isConfirm = isConfirm;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Double getTotalPits() {
		return totalPits;
	}

	public void setTotalPits(Double totalPits) {
		this.totalPits = totalPits;
	}

	public Double getAverageAgePits() {
		return averageAgePits;
	}

	public void setAverageAgePits(Double averageAgePits) {
		this.averageAgePits = averageAgePits;
	}

	public Double getHightAgePits() {
		return hightAgePits;
	}

	public void setHightAgePits(Double hightAgePits) {
		this.hightAgePits = hightAgePits;
	}

	public Double getNissan() {
		return nissan;
	}

	public void setNissan(Double nissan) {
		this.nissan = nissan;
	}

	public Double getNissanTop() {
		return nissanTop;
	}

	public void setNissanTop(Double nissanTop) {
		this.nissanTop = nissanTop;
	}
}