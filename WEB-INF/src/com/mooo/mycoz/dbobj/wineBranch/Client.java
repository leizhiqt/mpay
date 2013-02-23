package com.mooo.mycoz.dbobj.wineBranch;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class Client extends DBObject {
	private Integer id;
	private String clientName;
	private String photoPath;
	private String idNo;
	private Date idEndDate;
	private String idValidDate;// 未添加
	private String idAuthority;
	private String otherNo;
	private Integer age;
	private String mobilePhone;
	private String mobileAddress;
	private String sex;
	private String marry;
	private Integer childs;
	private String housing;
	private String educationId;
	private String homePhoneName;
	private String homePhone;
	private String telePhone;
	private String email;
	private String spuseName;
	private String spuseMobile;
	private String idSpuse;
	private String spuseHirer;
	private String spuseOfficePhone;
	private String spuseExtPhone;
	private Integer censusAddressBookId;// 户籍地址
	private Integer livingAddressBookId;// 现居地址
	private Integer livingMonth;
	
	private String homeName;
	private String homeType;
	private String homeTelephone;
	private Integer homeAddressBookId;// 家庭成员地址
	private String otherContacts;
	private String otherNexus;
	private String otherPhone;
	//无销售顾问备注
	private Double masterInMonth;
	private Double otherInMonth;
	private Double homeInMonth;
	private Double otherIncome;
	private String onShortName;
	private String onFullName;
	private String onDivision;
	private String onCompanyName;
	private String onWorkTime;
	private String onSector;
	private String onOffice;
	private String onFeature;
	private String onOfficePhone;
	private String onExtPhone;
	private Integer officeAddressBookId;// 单位信息
	private String financeName;
	private Double saleAmount;
	private Double selfAmount;
	private Integer branchId;

	private String qq;
	private String tbao;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getIdNo() {
		return idNo;
	}

	public void setIdNo(String idNo) {
		this.idNo = idNo;
	}

	public Date getIdEndDate() {
		return idEndDate;
	}

	public void setIdEndDate(Date idEndDate) {
		this.idEndDate = idEndDate;
	}

	public String getIdValidDate() {
		return idValidDate;
	}

	public void setIdValidDate(String idValidDate) {
		this.idValidDate = idValidDate;
	}

	public String getIdAuthority() {
		return idAuthority;
	}

	public void setIdAuthority(String idAuthority) {
		this.idAuthority = idAuthority;
	}

	public String getOtherNo() {
		return otherNo;
	}

	public void setOtherNo(String otherNo) {
		this.otherNo = otherNo;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getMobilePhone() {
		return mobilePhone;
	}

	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}

	public String getMobileAddress() {
		return mobileAddress;
	}

	public void setMobileAddress(String mobileAddress) {
		this.mobileAddress = mobileAddress;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getMarry() {
		return marry;
	}

	public void setMarry(String marry) {
		this.marry = marry;
	}

	public Integer getChilds() {
		return childs;
	}

	public void setChilds(Integer childs) {
		this.childs = childs;
	}

	public String getHousing() {
		return housing;
	}

	public void setHousing(String housing) {
		this.housing = housing;
	}

	public String getEducationId() {
		return educationId;
	}

	public String getPhotoPath() {
		return photoPath;
	}

	public void setPhotoPath(String photoPath) {
		this.photoPath = photoPath;
	}

	public void setEducationId(String educationId) {
		this.educationId = educationId;
	}

	public String getHomePhoneName() {
		return homePhoneName;
	}

	public void setHomePhoneName(String homePhoneName) {
		this.homePhoneName = homePhoneName;
	}

	public String getHomePhone() {
		return homePhone;
	}

	public void setHomePhone(String homePhone) {
		this.homePhone = homePhone;
	}

	public String getTelePhone() {
		return telePhone;
	}

	public void setTelePhone(String telePhone) {
		this.telePhone = telePhone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSpuseName() {
		return spuseName;
	}

	public void setSpuseName(String spuseName) {
		this.spuseName = spuseName;
	}

	public String getSpuseMobile() {
		return spuseMobile;
	}

	public void setSpuseMobile(String spuseMobile) {
		this.spuseMobile = spuseMobile;
	}

	public String getIdSpuse() {
		return idSpuse;
	}

	public void setIdSpuse(String idSpuse) {
		this.idSpuse = idSpuse;
	}

	public String getSpuseHirer() {
		return spuseHirer;
	}

	public void setSpuseHirer(String spuseHirer) {
		this.spuseHirer = spuseHirer;
	}

	public String getSpuseOfficePhone() {
		return spuseOfficePhone;
	}

	public void setSpuseOfficePhone(String spuseOfficePhone) {
		this.spuseOfficePhone = spuseOfficePhone;
	}

	public String getSpuseExtPhone() {
		return spuseExtPhone;
	}

	public void setSpuseExtPhone(String spuseExtPhone) {
		this.spuseExtPhone = spuseExtPhone;
	}

	public Integer getCensusAddressBookId() {
		return censusAddressBookId;
	}

	public void setCensusAddressBookId(Integer censusAddressBookId) {
		this.censusAddressBookId = censusAddressBookId;
	}

	public Integer getLivingAddressBookId() {
		return livingAddressBookId;
	}

	public void setLivingAddressBookId(Integer livingAddressBookId) {
		this.livingAddressBookId = livingAddressBookId;
	}

	public String getHomeName() {
		return homeName;
	}

	public void setHomeName(String homeName) {
		this.homeName = homeName;
	}

	public String getHomeType() {
		return homeType;
	}

	public void setHomeType(String homeType) {
		this.homeType = homeType;
	}

	public String getHomeTelephone() {
		return homeTelephone;
	}

	public void setHomeTelephone(String homeTelephone) {
		this.homeTelephone = homeTelephone;
	}

	public Integer getHomeAddressBookId() {
		return homeAddressBookId;
	}

	public void setHomeAddressBookId(Integer homeAddressBookId) {
		this.homeAddressBookId = homeAddressBookId;
	}

	public String getOtherContacts() {
		return otherContacts;
	}

	public void setOtherContacts(String otherContacts) {
		this.otherContacts = otherContacts;
	}

	public String getOtherNexus() {
		return otherNexus;
	}

	public void setOtherNexus(String otherNexus) {
		this.otherNexus = otherNexus;
	}

	public String getOtherPhone() {
		return otherPhone;
	}

	public void setOtherPhone(String otherPhone) {
		this.otherPhone = otherPhone;
	}

	public Double getMasterInMonth() {
		return masterInMonth;
	}

	public void setMasterInMonth(Double masterInMonth) {
		this.masterInMonth = masterInMonth;
	}

	public Double getOtherInMonth() {
		return otherInMonth;
	}

	public void setOtherInMonth(Double otherInMonth) {
		this.otherInMonth = otherInMonth;
	}

	public Double getHomeInMonth() {
		return homeInMonth;
	}

	public void setHomeInMonth(Double homeInMonth) {
		this.homeInMonth = homeInMonth;
	}

	public Double getOtherIncome() {
		return otherIncome;
	}

	public void setOtherIncome(Double otherIncome) {
		this.otherIncome = otherIncome;
	}

	public String getOnShortName() {
		return onShortName;
	}

	public void setOnShortName(String onShortName) {
		this.onShortName = onShortName;
	}

	public String getOnFullName() {
		return onFullName;
	}

	public void setOnFullName(String onFullName) {
		this.onFullName = onFullName;
	}

	public String getOnDivision() {
		return onDivision;
	}

	public void setOnDivision(String onDivision) {
		this.onDivision = onDivision;
	}

	public String getOnCompanyName() {
		return onCompanyName;
	}

	public void setOnCompanyName(String onCompanyName) {
		this.onCompanyName = onCompanyName;
	}

	public String getOnWorkTime() {
		return onWorkTime;
	}

	public void setOnWorkTime(String onWorkTime) {
		this.onWorkTime = onWorkTime;
	}

	public String getOnSector() {
		return onSector;
	}

	public void setOnSector(String onSector) {
		this.onSector = onSector;
	}

	public String getOnOffice() {
		return onOffice;
	}

	public void setOnOffice(String onOffice) {
		this.onOffice = onOffice;
	}

	public String getOnFeature() {
		return onFeature;
	}

	public void setOnFeature(String onFeature) {
		this.onFeature = onFeature;
	}

	public String getOnOfficePhone() {
		return onOfficePhone;
	}

	public void setOnOfficePhone(String onOfficePhone) {
		this.onOfficePhone = onOfficePhone;
	}

	public String getOnExtPhone() {
		return onExtPhone;
	}

	public void setOnExtPhone(String onExtPhone) {
		this.onExtPhone = onExtPhone;
	}

	public Integer getOfficeAddressBookId() {
		return officeAddressBookId;
	}

	public void setOfficeAddressBookId(Integer officeAddressBookId) {
		this.officeAddressBookId = officeAddressBookId;
	}

	public String getFinanceName() {
		return financeName;
	}

	public void setFinanceName(String financeName) {
		this.financeName = financeName;
	}

	public Double getSaleAmount() {
		return saleAmount;
	}

	public void setSaleAmount(Double saleAmount) {
		this.saleAmount = saleAmount;
	}

	public Double getSelfAmount() {
		return selfAmount;
	}

	public void setSelfAmount(Double selfAmount) {
		this.selfAmount = selfAmount;
	}

	public Integer getBranchId() {
		return branchId;
	}

	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getTbao() {
		return tbao;
	}

	public void setTbao(String tbao) {
		this.tbao = tbao;
	}

	public Integer getLivingMonth() {
		return livingMonth;
	}

	public void setLivingMonth(Integer livingMonth) {
		this.livingMonth = livingMonth;
	}
	
}