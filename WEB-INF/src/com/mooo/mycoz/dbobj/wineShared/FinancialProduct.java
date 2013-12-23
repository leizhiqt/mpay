package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class FinancialProduct extends DBObject {
	private Integer id;
	private String financialName;
	private Integer cycleTotal;
	private String cycleUnit;
	private Double creditRate;
	private Double financialMax;
	private Double minPayPercent;
	private Double naturalRate;
	private Double vouchRate;
	private Double chargeRate;
	private Double financialMin;
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getFinancialName() {
		return financialName;
	}

	public void setFinancialName(String financialName) {
		this.financialName = financialName;
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

	public Double getFinancialMax() {
		return financialMax;
	}

	public void setFinancialMax(Double financialMax) {
		this.financialMax = financialMax;
	}

	public Double getMinPayPercent() {
		return minPayPercent;
	}

	public void setMinPayPercent(Double minPayPercent) {
		this.minPayPercent = minPayPercent;
	}

	public Double getNaturalRate() {
		return naturalRate;
	}

	public void setNaturalRate(Double naturalRate) {
		this.naturalRate = naturalRate;
	}

	public Double getVouchRate() {
		return vouchRate;
	}

	public void setVouchRate(Double vouchRate) {
		this.vouchRate = vouchRate;
	}

	public Double getChargeRate() {
		return chargeRate;
	}

	public void setChargeRate(Double chargeRate) {
		this.chargeRate = chargeRate;
	}

	public Double getFinancialMin() {
		return financialMin;
	}

	public void setFinancialMin(Double financialMin) {
		this.financialMin = financialMin;
	}
	
}