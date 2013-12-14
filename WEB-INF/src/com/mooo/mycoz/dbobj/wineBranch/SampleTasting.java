package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;

public class SampleTasting extends DBObject {
	private Integer id;
	private Integer sampleId;
	private Integer tasterId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSampleId() {
		return sampleId;
	}

	public void setSampleId(Integer sampleId) {
		this.sampleId = sampleId;
	}

	public Integer getTasterId() {
		return tasterId;
	}

	public void setTasterId(Integer tasterId) {
		this.tasterId = tasterId;
	}
}
