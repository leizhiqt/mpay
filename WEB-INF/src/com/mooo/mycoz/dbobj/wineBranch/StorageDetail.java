package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class StorageDetail extends DBObject {
	private Integer id;
	private Integer itemId;
	private Integer accountId;
	private String storageName;
	private Double quanItem;
	private Double itemVol;
	private String volUnit;
	private String storageType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getItemId() {
		return itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public Integer getAccountId() {
		return accountId;
	}

	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}

	public String getStorageName() {
		return storageName;
	}

	public void setStorageName(String storageName) {
		this.storageName = storageName;
	}

	public Double getQuanItem() {
		return quanItem;
	}

	public void setQuanItem(Double quanItem) {
		this.quanItem = quanItem;
	}

	public Double getItemVol() {
		return itemVol;
	}

	public void setItemVol(Double itemVol) {
		this.itemVol = itemVol;
	}

	public String getVolUnit() {
		return volUnit;
	}

	public void setVolUnit(String volUnit) {
		this.volUnit = volUnit;
	}

	public String getStorageType() {
		return storageType;
	}

	public void setStorageType(String storageType) {
		this.storageType = storageType;
	}
}