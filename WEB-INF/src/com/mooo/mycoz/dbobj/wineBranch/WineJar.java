package com.mooo.mycoz.dbobj.wineBranch;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class WineJar extends DBObject {
	private Integer id;
	private String jarNumber;
	private Double volume;
	private String district;
	private Integer wineTypeId;
	private Integer wineLevelId;
	private Double alcohol;
	private Date createDate;
	private String material;
	private String remark;
	private Integer wineryId;
	private Integer branchId;
	private Integer bankId;
	private Double price;
	private Integer orgCurrencyId;
	private Integer unitId;
	private Integer stateId;
	private Double perimeter;
	private Double totalHeight;
	private Double clearHeight;
	private Double outsideHeight;
	private Double density;
	private Double weight;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getJarNumber() {
		return jarNumber;
	}

	public void setJarNumber(String jarNumber) {
		this.jarNumber = jarNumber;
	}

	public Double getVolume() {
		return volume;
	}

	public void setVolume(Double volume) {
		this.volume = volume;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public Integer getWineTypeId() {
		return wineTypeId;
	}

	public void setWineTypeId(Integer wineTypeId) {
		this.wineTypeId = wineTypeId;
	}

	public Integer getWineLevelId() {
		return wineLevelId;
	}

	public void setWineLevelId(Integer wineLevelId) {
		this.wineLevelId = wineLevelId;
	}

	public Double getAlcohol() {
		return alcohol;
	}

	public void setAlcohol(Double alcohol) {
		this.alcohol = alcohol;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getMaterial() {
		return material;
	}

	public void setMaterial(String material) {
		this.material = material;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getWineryId() {
		return wineryId;
	}

	public void setWineryId(Integer wineryId) {
		this.wineryId = wineryId;
	}

	public Integer getBranchId() {
		return branchId;
	}

	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}

	public Integer getBankId() {
		return bankId;
	}

	public void setBankId(Integer bankId) {
		this.bankId = bankId;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getOrgCurrencyId() {
		return orgCurrencyId;
	}

	public void setOrgCurrencyId(Integer orgCurrencyId) {
		this.orgCurrencyId = orgCurrencyId;
	}

	public Integer getUnitId() {
		return unitId;
	}

	public void setUnitId(Integer unitId) {
		this.unitId = unitId;
	}

	public Integer getStateId() {
		return stateId;
	}

	public void setStateId(Integer stateId) {
		this.stateId = stateId;
	}

	public Double getPerimeter() {
		return perimeter;
	}

	public void setPerimeter(Double perimeter) {
		this.perimeter = perimeter;
	}

	public Double getTotalHeight() {
		return totalHeight;
	}

	public void setTotalHeight(Double totalHeight) {
		this.totalHeight = totalHeight;
	}

	public Double getClearHeight() {
		return clearHeight;
	}

	public void setClearHeight(Double clearHeight) {
		this.clearHeight = clearHeight;
	}

	public Double getDensity() {
		return density;
	}

	public void setDensity(Double density) {
		this.density = density;
	}

	public Double getWeight() {
		return weight;
	}

	public void setWeight(Double weight) {
		this.weight = weight;
	}

	public Double getOutsideHeight() {
		return outsideHeight;
	}

	public void setOutsideHeight(Double outsideHeight) {
		this.outsideHeight = outsideHeight;
	}
}
