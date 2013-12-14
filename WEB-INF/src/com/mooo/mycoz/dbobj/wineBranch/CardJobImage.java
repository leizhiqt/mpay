package com.mooo.mycoz.dbobj.wineBranch;


import com.mooo.mycoz.db.DBObject;

public class CardJobImage extends DBObject{
	private Integer id;
	private Integer cardJobId;
	private String  filePath;
	private Integer branchId;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCardJobId() {
		return cardJobId;
	}
	public void setCardJobId(Integer cardJobId) {
		this.cardJobId = cardJobId;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public Integer getBranchId() {
		return branchId;
	}
	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}

}
