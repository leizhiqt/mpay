package com.mooo.mycoz.dbobj.wineBranch;

import java.util.*;

import com.mooo.mycoz.db.DBObject;

public class BrewJobDetail extends DBObject {
	private Integer id;
	private Integer brewJobId;
	private Integer jobPointId;
	private Date jobDate;
	private String jobPeople;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getBrewJobId() {
		return brewJobId;
	}

	public void setBrewJobId(Integer brewJobId) {
		this.brewJobId = brewJobId;
	}

	public Integer getJobPointId() {
		return jobPointId;
	}

	public void setJobPointId(Integer jobPointId) {
		this.jobPointId = jobPointId;
	}

	public Date getJobDate() {
		return jobDate;
	}

	public void setJobDate(Date jobDate) {
		this.jobDate = jobDate;
	}

	public String getJobPeople() {
		return jobPeople;
	}

	public void setJobPeople(String jobPeople) {
		this.jobPeople = jobPeople;
	}
}