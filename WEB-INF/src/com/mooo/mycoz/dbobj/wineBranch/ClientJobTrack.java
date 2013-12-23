package com.mooo.mycoz.dbobj.wineBranch;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class ClientJobTrack extends DBObject {
	private Integer id;
	private Integer clientJobId;
	private Integer userId;
	private Integer jobTypeId;
	private String jobRemark;
	private Integer processId;
	private Integer branchId;
	private Date jobDate;
	private String nbf;
	private String nbc;
	private String nbs;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getClientJobId() {
		return clientJobId;
	}

	public void setClientJobId(Integer clientJobId) {
		this.clientJobId = clientJobId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getJobTypeId() {
		return jobTypeId;
	}

	public void setJobTypeId(Integer jobTypeId) {
		this.jobTypeId = jobTypeId;
	}

	public String getJobRemark() {
		return jobRemark;
	}

	public void setJobRemark(String jobRemark) {
		this.jobRemark = jobRemark;
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

	public Date getJobDate() {
		return jobDate;
	}

	public void setJobDate(Date jobDate) {
		this.jobDate = jobDate;
	}

	public String getNbf() {
		return nbf;
	}

	public void setNbf(String nbf) {
		this.nbf = nbf;
	}

	public String getNbc() {
		return nbc;
	}

	public void setNbc(String nbc) {
		this.nbc = nbc;
	}

	public String getNbs() {
		return nbs;
	}

	public void setNbs(String nbs) {
		this.nbs = nbs;
	}
}