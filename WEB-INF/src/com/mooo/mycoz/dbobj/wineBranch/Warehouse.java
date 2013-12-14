package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class Warehouse extends DBObject {
	private Integer id;
	private Integer enterpriseId;
	private String warehouseName;
	private String contact;
	private String address;
	private String zipcode;
	private String telephone;
	public Integer getId() {
	return id;
	}
	public void setId(Integer id) {
	 this.id = id;
	}
	public Integer getEnterpriseId() {
	return enterpriseId;
	}
	public void setEnterpriseId(Integer enterpriseId) {
	 this.enterpriseId = enterpriseId;
	}
	public String getWarehouseName() {
	return warehouseName;
	}
	public void setWarehouseName(String warehouseName) {
	 this.warehouseName = warehouseName;
	}
	public String getContact() {
	return contact;
	}
	public void setContact(String contact) {
	 this.contact = contact;
	}
	public String getAddress() {
	return address;
	}
	public void setAddress(String address) {
	 this.address = address;
	}
	public String getZipcode() {
	return zipcode;
	}
	public void setZipcode(String zipcode) {
	 this.zipcode = zipcode;
	}
	public String getTelephone() {
	return telephone;
	}
	public void setTelephone(String telephone) {
	 this.telephone = telephone;
	}
}