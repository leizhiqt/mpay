package com.mooo.mycoz.dbobj.wineFrameWork;

import com.mooo.mycoz.db.DBObject;

public class AuthRole extends DBObject{
	
	private Integer id;
	private Integer roleId;
	private Integer methodId;
	public Integer getId() {
	return id;
	}
	public void setId(Integer id) {
	 this.id = id;
	}
	public Integer getRoleId() {
	return roleId;
	}
	public void setRoleId(Integer roleId) {
	 this.roleId = roleId;
	}
	public Integer getMethodId() {
	return methodId;
	}
	public void setMethodId(Integer methodId) {
	 this.methodId = methodId;
	}
}
