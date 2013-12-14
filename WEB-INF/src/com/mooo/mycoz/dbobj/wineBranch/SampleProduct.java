package com.mooo.mycoz.dbobj.wineBranch;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class SampleProduct extends DBObject {
	private Integer id;
	private Integer productId;
	private String sampleName;
	private Date buildDate;
	private String buildPeople;
	private String isPost;
	private Double expertScore;
	private Date tastingStartTime;
	private Date tastingEndTime;
	private String tastingSite;
	private Double drunkLevel;
	private String tastingComment;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getSampleName() {
		return sampleName;
	}

	public void setSampleName(String sampleName) {
		this.sampleName = sampleName;
	}

	public Date getBuildDate() {
		return buildDate;
	}

	public void setBuildDate(Date buildDate) {
		this.buildDate = buildDate;
	}

	public String getBuildPeople() {
		return buildPeople;
	}

	public void setBuildPeople(String buildPeople) {
		this.buildPeople = buildPeople;
	}

	public String getIsPost() {
		return isPost;
	}

	public void setIsPost(String isPost) {
		this.isPost = isPost;
	}

	public Double getExpertScore() {
		return expertScore;
	}

	public void setExpertScore(Double expertScore) {
		this.expertScore = expertScore;
	}

	public Date getTastingStartTime() {
		return tastingStartTime;
	}

	public void setTastingStartTime(Date tastingStartTime) {
		this.tastingStartTime = tastingStartTime;
	}

	public Date getTastingEndTime() {
		return tastingEndTime;
	}

	public void setTastingEndTime(Date tastingEndTime) {
		this.tastingEndTime = tastingEndTime;
	}

	public String getTastingSite() {
		return tastingSite;
	}

	public void setTastingSite(String tastingSite) {
		this.tastingSite = tastingSite;
	}

	public Double getDrunkLevel() {
		return drunkLevel;
	}

	public void setDrunkLevel(Double drunkLevel) {
		this.drunkLevel = drunkLevel;
	}

	public String getTastingComment() {
		return tastingComment;
	}

	public void setTastingComment(String tastingComment) {
		this.tastingComment = tastingComment;
	}
}