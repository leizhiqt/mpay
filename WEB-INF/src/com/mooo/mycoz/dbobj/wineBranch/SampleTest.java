package com.mooo.mycoz.dbobj.wineBranch;

import java.util.Date;

import com.mooo.mycoz.db.DBObject;

public class SampleTest extends DBObject {
	private Integer id;
	private Integer sampleId;
	private String generalTesting;
	private String chemistryTesting;
	private String plasticTesting;
	private Date testingDate;
	private String reportNo;
	private String testingPerson;
	private String testTools;
	private String testNorm;

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

	public String getGeneralTesting() {
		return generalTesting;
	}

	public void setGeneralTesting(String generalTesting) {
		this.generalTesting = generalTesting;
	}

	public String getChemistryTesting() {
		return chemistryTesting;
	}

	public void setChemistryTesting(String chemistryTesting) {
		this.chemistryTesting = chemistryTesting;
	}

	public String getPlasticTesting() {
		return plasticTesting;
	}

	public void setPlasticTesting(String plasticTesting) {
		this.plasticTesting = plasticTesting;
	}

	public Date getTestingDate() {
		return testingDate;
	}

	public void setTestingDate(Date testingDate) {
		this.testingDate = testingDate;
	}

	public String getReportNo() {
		return reportNo;
	}

	public void setReportNo(String reportNo) {
		this.reportNo = reportNo;
	}

	public String getTestingPerson() {
		return testingPerson;
	}

	public void setTestingPerson(String testingPerson) {
		this.testingPerson = testingPerson;
	}

	public String getTestTools() {
		return testTools;
	}

	public void setTestTools(String testTools) {
		this.testTools = testTools;
	}

	public String getTestNorm() {
		return testNorm;
	}

	public void setTestNorm(String testNorm) {
		this.testNorm = testNorm;
	}
}
