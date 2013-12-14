package com.mooo.mycoz.dbobj.wineFrameWork;

import com.mooo.mycoz.db.DBObject;

public class Role extends DBObject{
	private Integer id;
	private String definition;
	private String description;
	private Integer categoryId;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDefinition() {
		return definition;
	}

	public void setDefinition(String definition) {
		this.definition = definition;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
}
