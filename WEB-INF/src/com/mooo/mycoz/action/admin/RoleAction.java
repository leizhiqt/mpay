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
import com.mooo.mycoz.dbobj.wineFrameWork.Action;
import com.mooo.mycoz.dbobj.wineFrameWork.AuthRole;
import com.mooo.mycoz.dbobj.wineFrameWork.GroupRoleMapping;
import com.mooo.mycoz.dbobj.wineFrameWork.Method;
import com.mooo.mycoz.dbobj.wineFrameWork.Role;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class RoleAction extends BaseSupport{
	private static Log log = LogFactory.getLog(RoleAction.class);

	public String listRole(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(BranchCategory.class, "branchCategory");
			dbobject.addTable(Role.class, "role");

			dbobject.setForeignKey("role", "categoryId", "branchCategory", "id");

			value = request.getParameter("definition");
			if(!StringUtils.isNull(value))
				dbobject.setLike("role","definition", value);
			
			value = request.getParameter("description");
			if(!StringUtils.isNull(value))
				dbobject.setLike("role","description", value);
			
			String branchCategory = ActionSession.getBranchCategory(request);
			if(!StringUtils.isNull(branchCategory)){
				dbobject.setField("branchCategory","abbreviation", branchCategory);
			}
			
			dbobject.setRetrieveField("role","id");
			dbobject.setRetrieveField("role","definition");
			dbobject.setRetrieveField("role","description");
			dbobject.setRetrieveField("branchCategory","definition");

			dbobject.setOrderBy("role","id");

			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> roles = dbobject.searchAndRetrieveList();
			
			request.setAttribute("roles", roles);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		request.setAttribute("categorys", ActionSession.getBranchCategoryValues(request));
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		try {
			Role role = new Role();
			ParamUtil.bindData(request, role,"role");
			
			role.setId(IDGenerator.getNextInt(Role.class));
			
			role.add();

			request.setAttribute("message", "processAdd successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			return "promptAdd";
		}
		return "listRole";
	}

	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		
		try {
			String[] ids =  request.getParameterValues("id");

			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				Role role = new Role();
				role.setId( new Integer(ids[i]));
				role.retrieve();
				
				role.delete();
			}

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "listRole";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		
		try {
				String id =  request.getParameter("id");
				
				if(id==null)
					throw new Exception("Please chose object");
			
				Role role = new Role();
				role.setId( new Integer(id));
				role.retrieve();
				
				request.setAttribute("role", role);
				
				request.setAttribute("categorys", ActionSession.getBranchCategoryValues(request));
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "listRole";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		try {
			Role role = new Role();
			ParamUtil.bindData(request, role,"role");
			
			role.update();
			
			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		}
		return "listRole";
	}
	
	public String promptAuthRole(HttpServletRequest request,HttpServletResponse response) {
		try {
			String id =  request.getParameter("id");
			
			if(id==null)
				throw new Exception("Please chose one object");
			
			Role role = new Role();
			role.setId(new Integer(id));
			role.retrieve();
			
			request.setAttribute("roleId", role.getId());
			request.setAttribute("roleName", role.getDefinition());

			//List AuthRoles
			
			AuthRole authRole = new AuthRole();
			authRole.setRoleId(role.getId());
			request.setAttribute("authRoles", authRole.searchAndRetrieveList());
			
			MultiDBObject mdb = new MultiDBObject();
			mdb.addTable(Action.class, "action");
			mdb.addTable(Method.class, "method");

			mdb.setForeignKey("method", "actionId", "action", "id");

			mdb.setRetrieveField("action", "cls");
			mdb.setRetrieveField("action", "definition");
			mdb.setRetrieveField("method", "methodName");
			mdb.setRetrieveField("method", "id");
			
			mdb.setOrderBy("action","cls");
			
			Page page = new Page();
			page.buildComponent(request, mdb.count());
			mdb.setRecord(page.getOffset(),page.getPageSize());
			
			List<Object> methods = mdb.searchAndRetrieveList();
			
			request.setAttribute("methods", methods);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "listRole";
		}
		return "success";
	}
	
	public String processAuthRole(HttpServletRequest request,HttpServletResponse response) {
		
		if (log.isDebugEnabled()) log.debug("processEditAuthRole");

		String roleId = null;
		String methodId[] = null;
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			roleId = request.getParameter("id");
			
			methodId = request.getParameterValues("methodId");
			
			if(roleId !=null){
				
				if(methodId!=null){
					for(int i=0;i<methodId.length;i++){
						AuthRole authRole = new AuthRole();
						authRole.setRoleId(new Integer(roleId));
						authRole.setMethodId(new Integer(methodId[i]));
						
						if(authRole.count()<1){
							authRole.setId(IDGenerator.getNextID(tx.getConnection(),AuthRole.class));
							authRole.add(tx.getConnection());
						}
					}
					
					AuthRole authRole = new AuthRole();
					authRole.setRoleId(new Integer(roleId));
					
					List<Object> oauthRoles = authRole.searchAndRetrieveList(tx.getConnection());
					for(Object bean:oauthRoles){
						authRole=(AuthRole)bean;
	
						boolean remove = false;
						
						for(int i=0;i<methodId.length;i++){
							int dId = new Integer(methodId[i]); 
							
							if(dId==authRole.getMethodId()){
								remove = true;
								break;
							}
						}
						
						if(!remove){
							authRole.delete(tx.getConnection());
						}
					}
				}else{//delete all
					AuthRole authRole = new AuthRole();
					authRole.setRoleId(new Integer(roleId));
					
					List<Object> oauthRoles = authRole.searchAndRetrieveList(tx.getConnection());
					for(Object bean:oauthRoles){
						authRole=(AuthRole)bean;
						authRole.delete(tx.getConnection());
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
		return "promptAuthRole";
	}
	
	public String promptAssignGroup(HttpServletRequest request,HttpServletResponse response) {
		String roleId = null;
		try {
			roleId =  request.getParameter("id");
			
			if(roleId==null)
				throw new Exception("Please chose one object");
			
			Role role = new Role();
			role.setId(new Integer(roleId));
			role.retrieve();
			
			request.setAttribute("roleId", role.getId());
			request.setAttribute("roleName", role.getDefinition());
			
			request.setAttribute("userGroups", ActionSession.getGroupValues(request));
			
			GroupRoleMapping groupRoleMapping = new GroupRoleMapping();
			groupRoleMapping.setRoleId(new Integer(roleId));
			
			request.setAttribute("groupRoleMappings", groupRoleMapping.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "listRole";
		}
		return "success";
	}
	
	public String processAssignGroup(HttpServletRequest request,HttpServletResponse response) {
		
		if (log.isDebugEnabled()) log.debug("processAssignGroup");

		String roleId = null;
		String groupId[] = null;
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			roleId = request.getParameter("id");
			groupId = request.getParameterValues("groupId");
			
			if(roleId !=null ){
					if(groupId!=null){
						for(int i=0;i<groupId.length;i++){
							GroupRoleMapping groupRoleMapping = new GroupRoleMapping();
							groupRoleMapping.setRoleId(new Integer(roleId));
							groupRoleMapping.setGroupId(new Integer(groupId[i]));
							
							if(groupRoleMapping.count()<1){
								groupRoleMapping.setId(IDGenerator.getNextID(tx.getConnection(),GroupRoleMapping.class));
								groupRoleMapping.add(tx.getConnection());
							}
						}
						
						GroupRoleMapping groupRoleMapping = new GroupRoleMapping();
						groupRoleMapping.setRoleId(new Integer(roleId));
						
						List<Object> oMappings = groupRoleMapping.searchAndRetrieveList(tx.getConnection());
						for(Object bean:oMappings){
							groupRoleMapping=(GroupRoleMapping)bean;
		
							boolean remove = false;
							
							for(int i=0;i<groupId.length;i++){
								int dId = new Integer(groupId[i]); 
								
								if(dId==groupRoleMapping.getGroupId()){
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
					groupRoleMapping.setRoleId(new Integer(roleId));
					
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
		return "promptAssignGroup";
	}
}
