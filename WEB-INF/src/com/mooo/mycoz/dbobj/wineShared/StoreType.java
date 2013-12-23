package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class StoreType extends DBObject {
	private Integer id;
	private String typeKey;
	private String typeName;
	private String typeBankName;
	private String typeBankNo;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTypeKey() {
		return typeKey;
	}

	public void setTypeKey(String typeKey) {
		this.typeKey = typeKey;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getTypeBankName() {
		return typeBankName;
	}

	public void setTypeBankName(String typeBankName) {
		this.typeBankName = typeBankName;
	}

	public String getTypeBankNo() {
		return typeBankNo;
	}

	public void setTypeBankNo(String typeBankNo) {
		this.typeBankNo = typeBankNo;
	}
}
