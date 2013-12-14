package com.mooo.mycoz.dbobj.wineBranch;

import com.mooo.mycoz.db.DBObject;


public class FileTree extends DBObject{

	private Integer id;

	private Integer parentId;
	private Integer childId;
	private Integer levelId;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public Integer getChildId() {
		return childId;
	}
	public void setChildId(Integer childId) {
		this.childId = childId;
	}

	public Integer getLevelId() {
		return levelId;
	}

	public void setLevelId(Integer levelId) {
		this.levelId = levelId;
	}
	
}
