package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class SampleItem extends DBObject {
	private Integer id;
	private Integer sampleId;
	private String itemName;
	private String itemAge;
	private Double itemVol;
	private String itemVolUnit;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSampleId() {
		return sampleId;
	}

	public void setSampleId(Integer sampleId) {
		this.sampleId = sampleId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemAge() {
		return itemAge;
	}

	public void setItemAge(String itemAge) {
		this.itemAge = itemAge;
	}

	public Double getItemVol() {
		return itemVol;
	}

	public void setItemVol(Double itemVol) {
		this.itemVol = itemVol;
	}

	public String getItemVolUnit() {
		return itemVolUnit;
	}

	public void setItemVolUnit(String itemVolUnit) {
		this.itemVolUnit = itemVolUnit;
	}
}