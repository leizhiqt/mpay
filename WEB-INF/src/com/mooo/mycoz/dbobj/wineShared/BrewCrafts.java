package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class BrewCrafts extends DBObject {
	private Integer id;
	private String craftsName;
	private String craftsDesc;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCraftsName() {
		return craftsName;
	}

	public void setCraftsName(String craftsName) {
		this.craftsName = craftsName;
	}

	public String getCraftsDesc() {
		return craftsDesc;
	}

	public void setCraftsDesc(String craftsDesc) {
		this.craftsDesc = craftsDesc;
	}
}