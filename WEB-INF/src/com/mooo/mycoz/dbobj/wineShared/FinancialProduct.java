package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class FinancialProduct extends DBObject {
	private Integer id;
	private String financialName;
	private Integer cycleTotal;
	private String cycleUnit;
	private Double creditRate;
	private Double financialMax;
	private Integer productId;
	private Double minPayPercent;

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

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Double getMinPayPercent() {
		return minPayPercent;
	}

	public void setMinPayPercent(Double minPayPercent) {
		this.minPayPercent = minPayPercent;
	}
}