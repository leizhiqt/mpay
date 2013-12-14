package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class WineryMap extends DBObject{
	private Integer id;
	private Integer userId;
	private Integer wineryId;
	private Integer branchId;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
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
}
