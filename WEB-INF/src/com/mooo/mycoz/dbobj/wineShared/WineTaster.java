package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class WineTaster extends DBObject {
	private Integer id;
	private String tasterName;
	private String tasterLicense;
	private String tasterCategory;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTasterName() {
		return tasterName;
	}

	public void setTasterName(String tasterName) {
		this.tasterName = tasterName;
	}

	public String getTasterLicense() {
		return tasterLicense;
	}

	public void setTasterLicense(String tasterLicense) {
		this.tasterLicense = tasterLicense;
	}

	public String getTasterCategory() {
		return tasterCategory;
	}

	public void setTasterCategory(String tasterCategory) {
		this.tasterCategory = tasterCategory;
	}
}