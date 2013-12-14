package com.mooo.mycoz.dbobj.wineShared;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.mooo.mycoz.db.DBObject;

public class UserType extends DBObject  {
	private Integer id;
	private String abbreviation;
	private String definition;
	private Integer categoryId;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAbbreviation() {
		return abbreviation;
	}
	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}
	public String getDefinition() {
		return definition;
	}
	public void setDefinition(String definition) {
		this.definition = definition;
	}
	public Integer getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}
	
	public Map<Integer,String> values(String categoryId) throws SQLException{

		Map<Integer,String> values = new LinkedHashMap<Integer,String>();

		if (categoryId == null || categoryId.equals(""))
			return values;
		
		setCategoryId(new Integer(categoryId));

        List<Object> results = this.searchAndRetrieveList();
        
		for(Object obj:results){
        	UserType userType = (UserType) obj;
        	values.put(userType.getId(),userType.getDefinition());
        }
		return values;
	}
}