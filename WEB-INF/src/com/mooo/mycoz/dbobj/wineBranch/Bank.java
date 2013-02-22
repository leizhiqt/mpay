package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class Bank extends DBObject {
	private Integer id;
	private Integer clientId;
	private String debitCard;
	private String bankName;
	private String autoPay;
	private Integer branchId;
	private Double monthPay;

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

	public String getDebitCard() {
		return debitCard;
	}

	public void setDebitCard(String debitCard) {
		this.debitCard = debitCard;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getAutoPay() {
		return autoPay;
	}

	public void setAutoPay(String autoPay) {
		this.autoPay = autoPay;
	}

	public Integer getBranchId() {
		return branchId;
	}

	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}

	public Double getMonthPay() {
		return monthPay;
	}

	public void setMonthPay(Double monthPay) {
		this.monthPay = monthPay;
	}
}
