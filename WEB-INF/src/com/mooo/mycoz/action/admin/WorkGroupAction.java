package com.mooo.mycoz.action.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.GroupMember;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineFrameWork.GroupRoleMapping;
import com.mooo.mycoz.dbobj.wineFrameWork.Role;
import com.mooo.mycoz.dbobj.wineFrameWork.WorkGroup;
import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class WorkGroupAction extends BaseSupport{
	private static Log log = LogFactory.getLog(WorkGroupAction.class);

	public String listWorkGroup(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(WorkGroup.class, "workGroup");
			dbobject.addTable(Branch.class, "branch");
			dbobject.addTable(BranchCategory.class, "branchCategory");
			
			dbobject.setForeignKey("workGroup", "branchId", "branch", "id");
			dbobject.setForeignKey("branch", "categoryId", "branchCategory", "id");

			value = request.getParameter("definition");
			if(!StringUtils.isNull(value))
				dbobject.setLike("workGroup", "definition", value);
			
			value = request.getParameter("description");
			if(!StringUtils.isNull(value))
				dbobject.setLike("workGroup", "description", value);
			
			if(sessionId>1 && branchId!=null){
				dbobject.setField("branch","id", branchId);
			}
			
			dbobject.setRetrieveField("workGroup", "id");
			dbobject.setRetrieveField("workGroup", "definition");
			dbobject.setRetrieveField("workGroup", "description");
			dbobject.setRetrieveField("workGroup", "branchId");
			dbobject.setRetrieveField("branch", "definition");
			dbobject.setRetrieveField("branchCategory", "definition");

			dbobject.setOrderBy("workGroup", "id");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> results = dbobject.searchAndRetrieveList();
			
			request.setAttribute("results", results);
			
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		request.setAttribute("branchs", ActionSession.getBranchValues(request));
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		try {
			WorkGroup workGroup = new WorkGroup();
			ParamUtil.bindData(request, workGroup,"workGroup");
			
			workGroup.setId(IDGenerator.getNextInt(WorkGroup.class));
			
			workGroup.add();

			request.setAttribute("message", "processAdd successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		}
		return "listWorkGroup";
	}

	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		
		try {
			String[] ids =  request.getParameterValues("id");

			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				WorkGroup workGroup = new WorkGroup();
				workGroup.setId( new Integer(ids[i]));
				workGroup.retrieve();
				
				workGroup.delete();
			}
			
			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "listWorkGroup";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		
		try {
			String id =  request.getParameter("id");
			
			if(id==null)
				throw new Exception("Please chose object");
			
			WorkGroup workGroup = new WorkGroup();
			workGroup.setId( new Integer(id));
			workGroup.retrieve();
			
			request.setAttribute("workGroup", workGroup);
			
			request.setAttribute("branchs", ActionSession.getBranchValues(request));
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "listWorkGroup";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		try {
			WorkGroup workGroup = new WorkGroup();
			ParamUtil.bindData(request, workGroup,"workGroup");
			
			workGroup.update();
			
			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}
		return "listWorkGroup";
	}
	
	public String promptAssignUser(HttpServletRequest request,HttpServletResponse response) {
		try {
			String groupId =  request.getParameter("id");
			String branchId =  request.getParameter("branchId");

			if(groupId==null)
				throw new Exception("Please chose one object");
			
			WorkGroup workGroup = new WorkGroup();
			workGroup.setId(new Integer(groupId));
			workGroup.setBranchId(new Integer(branchId));
			workGroup.retrieve();
			
			request.setAttribute("branchId", branchId);

			request.setAttribute("groupId", workGroup.getId());
			request.setAttribute("groupName", workGroup.getDefinition());

			User user  = new User();
			user.setBranchId(new Integer(branchId));
			user.setActive("Y");
			request.setAttribute("users", user.searchAndRetrieveList());
			
			GroupMember groupMember = new GroupMember();
			groupMember.setGroupId(new Integer(groupId));
			groupMember.setBranchId(new Integer(branchId));

			request.setAttribute("groupMembers", groupMember.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "listWorkGroup";
		}
		return "success";
	}
	
	public String processAssignUser(HttpServletRequest request,HttpServletResponse response) {
		
		if (log.isDebugEnabled()) log.debug("processEditGroupMember");

		String groupId = null;
		String userId[] = null;
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			groupId = request.getParameter("id");
			userId = request.getParameterValues("userId");
			String branchId =  request.getParameter("branchId");

			if(groupId !=null && branchId !=null){
				
				if(userId!=null){
					for(int i=0;i<userId.length;i++){
						GroupMember groupMember = new GroupMember();
						groupMember.setGroupId(new Integer(groupId));
						groupMember.setUserId(new Integer(userId[i]));
						groupMember.setBranchId(new Integer(branchId));

						System.out.println(userId[i]+":"+branchId);
						
						if(groupMember.count()<1){
							groupMember.setId(IDGenerator.getNextID(tx.getConnection(),GroupMember.class));
							groupMember.add(tx.getConnection());
						}
					}
					
					GroupMember groupMember = new GroupMember();
					groupMember.setGroupId(new Integer(groupId));
					groupMember.setBranchId(new Integer(branchId));

					List<Object> ogroupMembers = groupMember.searchAndRetrieveList(tx.getConnection());
					for(Object bean:ogroupMembers){
						groupMember=(GroupMember)bean;
	
						boolean remove = false;
						
						for(int i=0;i<userId.length;i++){
							int dId = new Integer(userId[i]); 
							
							if(dId==groupMember.getUserId()){
								remove = true;
								break;
							}
						}
						
						if(!remove){
							groupMember.delete(tx.getConnection());
						}
					}
				}else{//delete all
					GroupMember groupMember = new GroupMember();
					groupMember.setGroupId(new Integer(groupId));
					groupMember.setBranchId(new Integer(branchId));

					List<Object> ogroupMembers = groupMember.searchAndRetrieveList(tx.getConnection());
					for(Object bean:ogroupMembers){
						groupMember=(GroupMember)bean;
						groupMember.delete(tx.getConnection());
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
		return "promptAssignUser";
	}
	
	
	public String promptAssignRole(HttpServletRequest request,HttpServletResponse response) {
		String groupId = null;
		try {
			groupId =  request.getParameter("id");
			
			if(groupId==null)
				throw new Exception("Please chose one object");
			
			WorkGroup workGroup = new WorkGroup();
			workGroup.setId(new Integer(groupId));
			workGroup.retrieve();
			
			request.setAttribute("groupId", workGroup.getId());
			request.setAttribute("groupName", workGroup.getDefinition());
			
			request.setAttribute("userRoles", IDGenerator.getValues(Role.class));
			
			GroupRoleMapping groupRoleMapping = new GroupRoleMapping();
			groupRoleMapping.setGroupId(new Integer(groupId));
			request.setAttribute("groupRoleMappings", groupRoleMapping.searchAndRetrieveList());
			
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "listWorkGroup";
		}
		return "success";
	}
	
	public String processAssignRole(HttpServletRequest request,HttpServletResponse response) {
		
		if (log.isDebugEnabled()) log.debug("processAssignRole");

		String groupId = null;
		String roleId[] = null;
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			groupId = request.getParameter("id");
			roleId = request.getParameterValues("roleId");
			
			if(groupId !=null ){
				if(roleId!=null){
					for(int i=0;i<roleId.length;i++){
						GroupRoleMapping groupRoleMapping = new GroupRoleMapping();
						groupRoleMapping.setGroupId(new Integer(groupId));
						groupRoleMapping.setRoleId(new Integer(roleId[i]));
	
						if(groupRoleMapping.count()<1){
							groupRoleMapping.setId(IDGenerator.getNextID(tx.getConnection(),GroupRoleMapping.class));
							groupRoleMapping.add(tx.getConnection());
						}
					}
					
					GroupRoleMapping groupRoleMapping = new GroupRoleMapping();
					groupRoleMapping.setGroupId(new Integer(groupId));
					
					List<Object> oMappings = groupRoleMapping.searchAndRetrieveList(tx.getConnection());
					for(Object bean:oMappings){
						groupRoleMapping=(GroupRoleMapping)bean;
	
						boolean remove = false;
						
						for(int i=0;i<roleId.length;i++){
							int dId = new Integer(roleId[i]); 
							
							if(dId==groupRoleMapping.getRoleId()){
								remove = true;
								break;
							}
						}
						
						if(!remove){
							groupRoleMapping.delete(tx.getConnection());
						}
					}
				}else{//delete all
					
					GroupRoleMapping groupRoleMapping = new GroupRoleMapping();
					groupRoleMapping.setGroupId(new Integer(groupId));

					List<Object> oMappings = groupRoleMapping.searchAndRetrieveList(tx.getConnection());
					for(Object bean:oMappings){
						groupRoleMapping=(GroupRoleMapping)bean;
						groupRoleMapping.delete(tx.getConnection());
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
		return "promptAssignRole";
	}
}
