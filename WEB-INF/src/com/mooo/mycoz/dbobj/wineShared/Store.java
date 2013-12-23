package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class Store extends DBObject {
	private Integer id;
	private String storeKey;
	private String storeName;
	private String storeAddress;
	private Integer storeTypeId;
	private String storeBankName;
	private String storeBankNo;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getStoreKey() {
		return storeKey;
	}

	public void setStoreKey(String storeKey) {
		this.storeKey = storeKey;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getStoreAddress() {
		return storeAddress;
	}

	public void setStoreAddress(String storeAddress) {
		this.storeAddress = storeAddress;
	}

	public Integer getStoreTypeId() {
		return storeTypeId;
	}

	public void setStoreTypeId(Integer storeTypeId) {
		this.storeTypeId = storeTypeId;
	}

	public String getStoreBankName() {
		return storeBankName;
	}

	public void setStoreBankName(String storeBankName) {
		this.storeBankName = storeBankName;
	}

	public String getStoreBankNo() {
		return storeBankNo;
	}

	public void setStoreBankNo(String storeBankNo) {
		this.storeBankNo = storeBankNo;
	}
}