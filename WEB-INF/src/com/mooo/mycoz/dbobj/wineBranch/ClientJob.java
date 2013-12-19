package com.mooo.mycoz.dbobj.wineBranch;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class ClientJob extends DBObject {
	private Integer id;
	private Integer clientId;
	private Integer storeId;
	private Integer oProductId;
	private Double oPrice;
	private Integer tProductId;
	private Double tPrice;
	private Double totalPrice;
	private Double selfAmount;
	private Integer financialProductId;
	private String jobNo;
	private Double creditAmount;
	private Double firstpayAmount;
	private Date firstpayDate;
	private Double monthOfPay;
	private Date monthOfDate;
	private String byUse;
	private Date jobDate;
	private Integer branchId;
	private String privateKey;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getClientId() {
		return clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Integer getOProductId() {
		return oProductId;
	}

	public void setOProductId(Integer oProductId) {
		this.oProductId = oProductId;
	}

	public Double getOPrice() {
		return oPrice;
	}

	public void setOPrice(Double oPrice) {
		this.oPrice = oPrice;
	}

	public Integer getTProductId() {
		return tProductId;
	}

	public void setTProductId(Integer tProductId) {
		this.tProductId = tProductId;
	}

	public Double getTPrice() {
		return tPrice;
	}

	public void setTPrice(Double tPrice) {
		this.tPrice = tPrice;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Double getSelfAmount() {
		return selfAmount;
	}

	public void setSelfAmount(Double selfAmount) {
		this.selfAmount = selfAmount;
	}

	public Integer getFinancialProductId() {
		return financialProductId;
	}

	public void setFinancialProductId(Integer financialProductId) {
		this.financialProductId = financialProductId;
	}

	public String getJobNo() {
		return jobNo;
	}

	public void setJobNo(String jobNo) {
		this.jobNo = jobNo;
	}

	public Double getCreditAmount() {
		return creditAmount;
	}

	public void setCreditAmount(Double creditAmount) {
		this.creditAmount = creditAmount;
	}

	public Double getFirstpayAmount() {
		return firstpayAmount;
	}

	public void setFirstpayAmount(Double firstpayAmount) {
		this.firstpayAmount = firstpayAmount;
	}

	public Date getFirstpayDate() {
		return firstpayDate;
	}

	public void setFirstpayDate(Date firstpayDate) {
		this.firstpayDate = firstpayDate;
	}

	public Double getMonthOfPay() {
		return monthOfPay;
	}

	public void setMonthOfPay(Double monthOfPay) {
		this.monthOfPay = monthOfPay;
	}

	public Date getMonthOfDate() {
		return monthOfDate;
	}

	public void setMonthOfDate(Date monthOfDate) {
		this.monthOfDate = monthOfDate;
	}

	public String getByUse() {
		return byUse;
	}

	public void setByUse(String byUse) {
		this.byUse = byUse;
	}

	public Date getJobDate() {
		return jobDate;
	}

	public void setJobDate(Date jobDate) {
		this.jobDate = jobDate;
	}

	public Integer getBranchId() {
		return branchId;
	}

	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}

	public String getPrivateKey() {
		return privateKey;
	}

	public void setPrivateKey(String privateKey) {
		this.privateKey = privateKey;
	}
}