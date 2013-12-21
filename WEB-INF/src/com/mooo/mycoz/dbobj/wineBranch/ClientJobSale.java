package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class ClientJobSale extends DBObject {
	private Integer id;
	private Integer clientJobId;
	private Integer productId;
	private String saleName;
	private Double salePrice;
	private String brand;
	private String modelNo;
	private Integer branchId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getClientJobId() {
		return clientJobId;
	}

	public void setClientJobId(Integer clientJobId) {
		this.clientJobId = clientJobId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getSaleName() {
		return saleName;
	}

	public void setSaleName(String saleName) {
		this.saleName = saleName;
	}

	public Double getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(Double salePrice) {
		this.salePrice = salePrice;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getModelNo() {
		return modelNo;
	}

	public void setModelNo(String modelNo) {
		this.modelNo = modelNo;
	}

	public Integer getBranchId() {
		return branchId;
	}

	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}
}
