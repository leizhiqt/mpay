package com.mooo.mycoz.dbobj.wineBranch;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import com.mooo.mycoz.db.DBObject;
import com.mooo.mycoz.dbobj.wineShared.JobType;

public class CardJob extends DBObject{
	private Integer id;
	private Date jobDate;
	private Integer cardId;
	private Integer userId;
	private Integer jobTypeId;
	private String  remark;
	private String  spotNormal;
	private String  cardNormal;
	private String  isPost;
	private Integer processId;
	private Integer branchId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getJobDate() {
		return jobDate;
	}

	public void setJobDate(Date jobDate) {
		this.jobDate = jobDate;
	}

	public Integer getCardId() {
		return cardId;
	}

	public void setCardId(Integer cardId) {
		this.cardId = cardId;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getSpotNormal() {
		return spotNormal;
	}

	public void setSpotNormal(String spotNormal) {
		this.spotNormal = spotNormal;
	}

	public String getCardNormal() {
		return cardNormal;
	}

	public void setCardNormal(String cardNormal) {
		this.cardNormal = cardNormal;
	}

	public String getIsPost() {
		return isPost;
	}

	public void setIsPost(String isPost) {
		this.isPost = isPost;
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

	//Extension methods
	public JobType getJobType() {
		
		if(this.getJobTypeId()==null){
			return null;
		}
		
		JobType jobType = new JobType();
		jobType.setId(this.getJobTypeId());
		try {
			jobType.retrieve();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return jobType;
	}
	
	public User getUser() {
		User user = new User();
		user.setId(this.getUserId());
		try {
			user.retrieve();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public List getImages() {
		List images=null;
		try {
			CardJobImage jobImage = new CardJobImage();
			jobImage.setCardJobId(this.getId());
			images=jobImage.searchAndRetrieveList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return images;
	}
}
