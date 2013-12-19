package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class Store extends DBObject {
	private Integer id;
	private String storeKey;
	private String storeName;
	private String storeAddress;

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
}
