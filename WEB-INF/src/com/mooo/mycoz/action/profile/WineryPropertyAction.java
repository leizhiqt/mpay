package com.mooo.mycoz.action.profile;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineBranch.WineryMap;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.util.IDGenerator;

public class WineryPropertyAction extends BaseSupport {

	private static Log log = LogFactory.getLog(WineryPropertyAction.class);
	
	public String promptWinery(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAssignUser");
		String value = null;
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		try {
			Winery winery = new Winery();
			
			String branchCategory = ActionSession.getBranchCategory(request);
			if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Regulators")){
				
				if(branchId!=null){
					winery.setBranchId(branchId);
				}
			}
			request.setAttribute("winerys", winery.searchAndRetrieveList());

			request.setAttribute("users", ActionSession.getUsers(request));
			
			value = request.getParameter("wineryId");
			if(value !=null){
				WineryMap wineryMap = new WineryMap();
				wineryMap.setWineryId(new Integer(value));
				wineryMap.setBranchId(branchId);
				
				request.setAttribute("wineryMaps", wineryMap.searchAndRetrieveList());
			}
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processWinery(HttpServletRequest request, HttpServletResponse response) {
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);

		String wineryId = null;
		String userId[] = null;
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			wineryId = request.getParameter("wineryId");
			userId = request.getParameterValues("userId");
			
			if(wineryId !=null){
				
				if(userId!=null){
					for(int i=0;i<userId.length;i++){
						WineryMap wineryMap = new WineryMap();
						wineryMap.setWineryId(new Integer(wineryId));
						wineryMap.setUserId(new Integer(userId[i]));
						wineryMap.setBranchId(branchId);
						
						if(wineryMap.count()<1){
							wineryMap.setId(IDGenerator.getNextID(tx.getConnection(),WineryMap.class));
							wineryMap.add(tx.getConnection());
						}
					}
					
					WineryMap wineryMap = new WineryMap();
					wineryMap.setWineryId(new Integer(wineryId));
					wineryMap.setBranchId(branchId);
					
					List<Object> ogroupMembers = wineryMap.searchAndRetrieveList(tx.getConnection());
					for(Object bean:ogroupMembers){
						wineryMap=(WineryMap)bean;
	
						boolean remove = false;
						
						for(int i=0;i<userId.length;i++){
							int dId = new Integer(userId[i]); 
							
							if(dId==wineryMap.getUserId()){
								remove = true;
								break;
							}
						}
						
						if(!remove){
							wineryMap.delete(tx.getConnection());
						}
					}
				}else{//delete all
					WineryMap wineryMap = new WineryMap();
					wineryMap.setWineryId(new Integer(wineryId));
					wineryMap.setBranchId(branchId);
					
					List<Object> ogroupMembers = wineryMap.searchAndRetrieveList(tx.getConnection());
					for(Object bean:ogroupMembers){
						wineryMap=(WineryMap)bean;
						wineryMap.delete(tx.getConnection());
					}
				}
			}
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "promptWinery";
	}
	
	public String promptUser(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAssignUser");
		String value = null;
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		try {
			Winery winery = new Winery();

			String branchCategory = ActionSession.getBranchCategory(request);
			if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Regulators")){
				if(branchId!=null){
					winery.setBranchId(branchId);
				}
			}
			request.setAttribute("winerys", winery.searchAndRetrieveList());
			
			request.setAttribute("users", ActionSession.getUsers(request));
			
			value = request.getParameter("userId");
			if(value !=null){
				WineryMap wineryMap = new WineryMap();
				wineryMap.setUserId(new Integer(value));
				wineryMap.setBranchId(branchId);
				request.setAttribute("wineryMaps", wineryMap.searchAndRetrieveList());
			}
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processUser(HttpServletRequest request, HttpServletResponse response) {
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);

		String userId= null;
		String wineryId[] = null;
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			userId = request.getParameter("userId");
			wineryId = request.getParameterValues("wineryId");

			if(userId !=null){
				
				if(wineryId!=null){
					for(int i=0;i<wineryId.length;i++){
						WineryMap wineryMap = new WineryMap();
						wineryMap.setUserId(new Integer(userId));
						wineryMap.setWineryId(new Integer(wineryId[i]));
						wineryMap.setBranchId(branchId);
						
						if(wineryMap.count()<1){
							wineryMap.setId(IDGenerator.getNextID(tx.getConnection(),WineryMap.class));
							wineryMap.add(tx.getConnection());
						}
					}
					
					WineryMap wineryMap = new WineryMap();
					wineryMap.setUserId(new Integer(userId));
					wineryMap.setBranchId(branchId);
					
					List<Object> ogroupMembers = wineryMap.searchAndRetrieveList(tx.getConnection());
					for(Object bean:ogroupMembers){
						wineryMap=(WineryMap)bean;
	
						boolean remove = false;
						
						for(int i=0;i<wineryId.length;i++){
							int dId = new Integer(wineryId[i]); 
							
							if(dId==wineryMap.getWineryId()){
								remove = true;
								break;
							}
						}
						
						if(!remove){
							wineryMap.delete(tx.getConnection());
						}
					}
				}else{//delete all
					WineryMap wineryMap = new WineryMap();
					wineryMap.setUserId(new Integer(userId));
					wineryMap.setBranchId(branchId);
					
					List<Object> ogroupMembers = wineryMap.searchAndRetrieveList(tx.getConnection());
					for(Object bean:ogroupMembers){
						wineryMap=(WineryMap)bean;
						wineryMap.delete(tx.getConnection());
					}
				}
			}
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "promptUser";
	}
}