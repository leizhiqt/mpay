package com.mooo.mycoz.action.setup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class BranchCategoryAction extends BaseSupport {

	private static Log log = LogFactory.getLog(BranchCategoryAction.class);

	public String list(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			BranchCategory branchCategory = new BranchCategory();
			
			value = request.getParameter("query_abbreviation");
			if(!StringUtils.isNull(value))
				branchCategory.setLike("abbreviation", value);
			
			value = request.getParameter("query_definition");
			if(!StringUtils.isNull(value))
				branchCategory.setLike("definition", value);
			
			Page page = new Page();
			page.buildComponent(request, branchCategory.count());
			branchCategory.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> results = branchCategory.searchAndRetrieveList();
			
			request.setAttribute("results", results);
			
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		try {
			BranchCategory branchCategory = new BranchCategory();
			ParamUtil.bindData(request, branchCategory,"branchCategory");
			branchCategory.setId(IDGenerator.getNextInt(BranchCategory.class));
			
			branchCategory.add();

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
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			String[] ids =  request.getParameterValues("id");

			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				BranchCategory branchCategory = new BranchCategory();
				branchCategory.setId( new Integer(ids[i]));
				branchCategory.retrieve(tx.getConnection());
				
				branchCategory.delete(tx.getConnection());
			}
			
			tx.commit();

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			tx.rollback();
			
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "list";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		
		try {
			String id =  request.getParameter("id");
		
			if(id==null)
				throw new Exception("Please chose object");
		
				request.setAttribute("branchs", IDGenerator.getValues(Branch.class));

				BranchCategory bean = new BranchCategory();
				bean.setId( new Integer(id));
				bean.retrieve();
				
				request.setAttribute("branchCategory", bean);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			return "list";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		try {
			BranchCategory branchCategory = new BranchCategory();
			ParamUtil.bindData(request, branchCategory,"branchCategory");
			branchCategory.update();
			
			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			return "promptEdit";
		}
		return "list";
	}
}
