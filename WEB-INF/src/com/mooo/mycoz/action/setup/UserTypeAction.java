package com.mooo.mycoz.action.setup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;
import com.mooo.mycoz.dbobj.wineShared.UserType;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class UserTypeAction extends BaseSupport {

private static Log log = LogFactory.getLog(UserTypeAction.class);

	public String list(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("list");
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(UserType.class, "userType");
			dbobject.addTable(BranchCategory.class, "branchCategory");
			
			dbobject.setForeignKey("userType", "categoryId", "branchCategory", "id");
			
			dbobject.setLike("userType","abbreviation",request.getParameter("query_abbreviation"));
			dbobject.setLike("userType","definition",request.getParameter("query_definition"));

			dbobject.setRetrieveField("userType","id");
			dbobject.setRetrieveField("userType","abbreviation");
			dbobject.setRetrieveField("userType","definition");
			dbobject.setRetrieveField("branchCategory","definition");
			
			dbobject.setOrderBy("branchCategory","id");
			dbobject.setOrderBy("userType","id");
			
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
		request.setAttribute("categorys", IDGenerator.getValues(BranchCategory.class));
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			UserType userType = new UserType();
			userType.setId(IDGenerator.getNextInt(UserType.class));
			
			ParamUtil.bindData(request, userType,"userType");
			
			userType.add();
			
			request.setAttribute("message", "processAdd successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptAdd";
		}
		return "list";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null || ids.length==0)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				UserType bean = new UserType();
				bean.setId( new Integer(ids[i]));
				bean.retrieve();
				
				bean.delete();
			}

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "list";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String id =  request.getParameter("id");
		try {
			if(StringUtils.isNull(id))
				throw new Exception("Please select object");
			
				UserType bean = new UserType();
				bean.setId( new Integer(id));
				bean.retrieve();
				
				request.setAttribute("userType", bean);
				
				request.setAttribute("categorys", IDGenerator.getValues(BranchCategory.class));
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "list";
		}
		return "success";
	}
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			UserType userType = new UserType();
			ParamUtil.bindData(request, userType,"userType");
			
			userType.update();

			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		}
		return "list";
	}
}