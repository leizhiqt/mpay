package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class ClientJobCheck extends DBObject {
	private Integer id;
	private Integer jobTrackId;
	private Integer jobCheckId;
	private String checkRemark;
	private Integer branchId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getJobTrackId() {
		return jobTrackId;
	}

	public void setJobTrackId(Integer jobTrackId) {
		this.jobTrackId = jobTrackId;
	}

	public Integer getJobCheckId() {
		return jobCheckId;
	}

	public void setJobCheckId(Integer jobCheckId) {
		this.jobCheckId = jobCheckId;
	}

	public String getCheckRemark() {
		return checkRemark;
	}

	public void setCheckRemark(String checkRemark) {
		this.checkRemark = checkRemark;
	}

	public Integer getBranchId() {
		return branchId;
	}

	public void setBranchId(Integer branchId) {
		this.branchId = branchId;
	}
}