package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class SaleItem extends DBObject {
	private Integer id;
	private Integer saleId;
	private Double salePrice;
	private String saleCurr;
	private Integer saleVol;
	private String volUnit;
	private Integer sampleId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSaleId() {
		return saleId;
	}

	public void setSaleId(Integer saleId) {
		this.saleId = saleId;
	}

	public Double getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(Double salePrice) {
		this.salePrice = salePrice;
	}

	public String getSaleCurr() {
		return saleCurr;
	}

	public void setSaleCurr(String saleCurr) {
		this.saleCurr = saleCurr;
	}

	public Integer getSaleVol() {
		return saleVol;
	}

	public void setSaleVol(Integer saleVol) {
		this.saleVol = saleVol;
	}

	public String getVolUnit() {
		return volUnit;
	}

	public void setVolUnit(String volUnit) {
		this.volUnit = volUnit;
	}

	public Integer getSampleId() {
		return sampleId;
	}

	public void setSampleId(Integer sampleId) {
		this.sampleId = sampleId;
	}
}