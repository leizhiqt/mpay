package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class WarehouseItem extends DBObject {
	private Integer id;
	private String itemName;
	private Integer usefulLife;
	private String storageMode;
	private Integer itemVolume;
	private String volUtil;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Integer getUsefulLife() {
		return usefulLife;
	}

	public void setUsefulLife(Integer usefulLife) {
		this.usefulLife = usefulLife;
	}

	public String getStorageMode() {
		return storageMode;
	}

	public void setStorageMode(String storageMode) {
		this.storageMode = storageMode;
	}

	public Integer getItemVolume() {
		return itemVolume;
	}

	public void setItemVolume(Integer itemVolume) {
		this.itemVolume = itemVolume;
	}

	public String getVolUtil() {
		return volUtil;
	}

	public void setVolUtil(String volUtil) {
		this.volUtil = volUtil;
	}
}