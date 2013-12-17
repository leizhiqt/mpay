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
	private Integer financialProductId;
	private String jobNo;
	private Double creditAmount;
	private Double downAmount;
	private Date firstpayDate;
	private Date repaymentDate;
	private String byUse;
	private Date jobDate;
	private Integer branchId;

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

	public Double getDownAmount() {
		return downAmount;
	}

	public void setDownAmount(Double downAmount) {
		this.downAmount = downAmount;
	}

	public Date getFirstpayDate() {
		return firstpayDate;
	}

	public void setFirstpayDate(Date firstpayDate) {
		this.firstpayDate = firstpayDate;
	}

	public Date getRepaymentDate() {
		return repaymentDate;
	}

	public void setRepaymentDate(Date repaymentDate) {
		this.repaymentDate = repaymentDate;
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
}