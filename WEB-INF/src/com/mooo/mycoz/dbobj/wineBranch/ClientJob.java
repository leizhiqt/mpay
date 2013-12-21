package com.mooo.mycoz.dbobj.wineBranch;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class ClientJob extends DBObject {
	private Integer id;
	private Integer clientId;
	private Double totalPrice;
	private Double selfAmount;
	private Integer financialProductId;
	private String jobNo;
	private Double totalPay;
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

	public Double getTotalPay() {
		return totalPay;
	}

	public void setTotalPay(Double totalPay) {
		this.totalPay = totalPay;
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