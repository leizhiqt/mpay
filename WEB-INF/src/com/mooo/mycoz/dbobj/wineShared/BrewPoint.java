package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class BrewPoint extends DBObject {
	private Integer id;
	private Integer brewCraftsId;
	private String pointName;
	private String pointDesc;
	private Integer pointOrder;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getBrewCraftsId() {
		return brewCraftsId;
	}

	public void setBrewCraftsId(Integer brewCraftsId) {
		this.brewCraftsId = brewCraftsId;
	}

	public String getPointName() {
		return pointName;
	}

	public void setPointName(String pointName) {
		this.pointName = pointName;
	}

	public String getPointDesc() {
		return pointDesc;
	}

	public void setPointDesc(String pointDesc) {
		this.pointDesc = pointDesc;
	}

	public Integer getPointOrder() {
		return pointOrder;
	}

	public void setPointOrder(Integer pointOrder) {
		this.pointOrder = pointOrder;
	}
}