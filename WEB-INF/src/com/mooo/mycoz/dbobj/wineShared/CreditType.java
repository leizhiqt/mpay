package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class CreditType extends DBObject {
	private Integer id;
	private String creditName;
	private Integer cycleTotal;
	private String cycleUnit;
	private Double creditRate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCreditName() {
		return creditName;
	}

	public void setCreditName(String creditName) {
		this.creditName = creditName;
	}

	public Integer getCycleTotal() {
		return cycleTotal;
	}

	public void setCycleTotal(Integer cycleTotal) {
		this.cycleTotal = cycleTotal;
	}

	public String getCycleUnit() {
		return cycleUnit;
	}

	public void setCycleUnit(String cycleUnit) {
		this.cycleUnit = cycleUnit;
	}

	public Double getCreditRate() {
		return creditRate;
	}

	public void setCreditRate(Double creditRate) {
		this.creditRate = creditRate;
	}
}
