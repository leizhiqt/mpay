package com.mooo.mycoz.framework;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineBranch.WineryMap;
import com.mooo.mycoz.dbobj.wineFrameWork.WorkGroup;
import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;
import com.mooo.mycoz.framework.util.IDGenerator;

public class ActionSession {
	public static final String USER_SESSION_KEY = "UserSessionKey";
	public static final String BRANCH_SESSION_KEY = "BranchId";
	public static final String USER_NAME_KEY = "UserName";
	public static final String IP = "IP";
	
	public static String getSession(HttpServletRequest request,String key){
		return (String)request.getSession().getAttribute(key);
	}
	
	public static Integer getInteger(HttpServletRequest request,String key){
		return (Integer)request.getSession().getAttribute(key);
	}
	
	public static List<Object> getWinerys(HttpServletRequest request,boolean enable){
		List<Object> retrieveList = null;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(WineryMap.class, "wineryMap");

			dbobject.setForeignKey("wineryMap", "wineryId", "winery", "id");
			
			if(enable)
				dbobject.setField("winery", "stateId",2);
			
			dbobject.setField("wineryMap", "userId",getInteger(request,USER_SESSION_KEY));

			dbobject.setRetrieveField("winery", "id");
			dbobject.setRetrieveField("winery", "enterpriseName");
			
			retrieveList = dbobject.searchAndRetrieveList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return retrieveList;
	}
	
	public static Map<Integer,String> getGroupValues(HttpServletRequest request){
		Map<Integer,String> groups = new LinkedHashMap<Integer,String>();
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(WorkGroup.class, "workGroup");
			dbobject.addTable(Branch.class, "branch");
			dbobject.addTable(BranchCategory.class, "branchCategory");
			
			dbobject.setForeignKey("workGroup", "branchId", "branch", "id");
			dbobject.setForeignKey("branch", "categoryId", "branchCategory", "id");
			
			Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
			if(branchId!=null){
				dbobject.setField("branch","id", branchId);
			}
			
			dbobject.setRetrieveField("workGroup", "id");
			dbobject.setRetrieveField("workGroup", "definition");

			dbobject.setGroupBy("workGroup", "id");
			
			List results = dbobject.searchAndRetrieveList();
			for(Object obj:results){
				Map row = (Map) obj;
				WorkGroup workGroup = (WorkGroup) row.get("workGroup");
				groups.put(workGroup.getId(), workGroup.getDefinition());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return groups;
	}
	
	public static Map<Integer,String> getUsers(HttpServletRequest request){
		Map<Integer,String> users = new LinkedHashMap<Integer,String>();
		try {
			User user = new User();
			user.setBranchId(getInteger(request,BRANCH_SESSION_KEY));
			
			List results = user.searchAndRetrieveList();
			for(Object obj:results){
				user = (User) obj;
				users.put(user.getId(), user.getName());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	public static String getWineryValues(HttpServletRequest request,boolean enable){
		
		StringBuffer buffer = new StringBuffer();
		try {
				List<Object> retrieveList = getWinerys(request,enable);
				
				boolean isHead = true;
				Winery winery =null;
				
				for(Object obj:retrieveList){
					if(isHead) {
						isHead = false;
					}else{
						buffer.append(",");
					}
					Map row =(HashMap)obj;
					winery = (Winery)row.get("winery");
					
					buffer.append(winery.getId());
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return buffer.toString();
	}
	
	public static String getWineryValues(HttpServletRequest request){
		return getWineryValues(request,false);
	}
	
	public static String getBranchCategory(HttpServletRequest request){
		return IDGenerator.getBranchCategory(getInteger(request,USER_SESSION_KEY));
	}
	
	public static Map<Integer,String> getBranchValues(HttpServletRequest request){
		Map<Integer,String> values = new LinkedHashMap<Integer,String>();
		Integer branchId = getInteger(request,BRANCH_SESSION_KEY);

		try {
			Branch branch = new Branch();
			if(branchId!=null && branchId>1)
				branch.setId(branchId);
			
			List<?> results = branch.searchAndRetrieveList();
			for(Object obj:results){
				branch = (Branch) obj;
				
				values.put(branch.getId(), branch.getDefinition());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return values;
	}
	
	public static Map<Integer,String> getBranchCategoryValues(HttpServletRequest request){
		Map<Integer,String> values = new LinkedHashMap<Integer,String>();
		Integer branchId = getInteger(request,BRANCH_SESSION_KEY);

		try {
			BranchCategory branchCategory = new BranchCategory();
			if(branchId!=null && branchId>1)
				branchCategory.setAbbreviation(getBranchCategory(request));
			
			List<?> results = branchCategory.searchAndRetrieveList();
			for(Object obj:results){
				branchCategory = (BranchCategory) obj;
				
				values.put(branchCategory.getId(), branchCategory.getDefinition());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return values;
	}
}
