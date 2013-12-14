package com.mooo.mycoz.dbobj.wineBranch;

import java.sql.SQLException;
import com.mooo.mycoz.db.DBObject;

public class Card extends DBObject{
	private Integer id;
	private Integer wineJarId;
	private String rfidcode;
	private String uuid;
	private Integer wineryId;
	private String position;
	private Integer cardTypeId;
	private Integer processId;
	private Integer branchId;
	private String remark;
	
	public Integer getId() {
	return id;
	}
	public void setId(Integer id) {
	 this.id = id;
	}
	public Integer getWineJarId() {
	return wineJarId;
	}
	public void setWineJarId(Integer wineJarId) {
	 this.wineJarId = wineJarId;
	}
	public String getRfidcode() {
	return rfidcode;
	}
	public void setRfidcode(String rfidcode) {
	 this.rfidcode = rfidcode;
	}
	public String getUuid() {
	return uuid;
	}
	public void setUuid(String uuid) {
	 this.uuid = uuid;
	}
	
	public Integer getWineryId() {
		return wineryId;
	}

	public void setWineryId(Integer wineryId) {
		this.wineryId = wineryId;
	}
	
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	public Integer getCardTypeId() {
		return cardTypeId;
	}
	public void setCardTypeId(Integer cardTypeId) {
		this.cardTypeId = cardTypeId;
	}
	public Integer getProcessId() {
		return processId;
	}
	public void setProcessId(Integer processId) {
		this.processId = processId;
	}
	public Integer getBranchId() {
		return branchId;
	}
	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	//Extension methods
	public WineJar getWineJar() {
		
		if(this.getWineJarId()==null){
			return null;
		}
		
		WineJar wineJar = new WineJar();
		wineJar.setId(this.getWineJarId());
		try {
			wineJar.retrieve();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return wineJar;
	}
	
	public Winery getWinery() {
		Winery winery = new Winery();
		try {
			winery.setId(this.getWineryId());
			
			winery.retrieve();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return winery;
	}
}