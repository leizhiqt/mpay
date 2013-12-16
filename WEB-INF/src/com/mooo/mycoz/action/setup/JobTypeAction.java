package com.mooo.mycoz.action.setup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class JobTypeAction extends BaseSupport {

private static Log log = LogFactory.getLog(JobTypeAction.class);

	public String listJobType(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			JobType jobType = new JobType();
			
			jobType.setLike("jobKey",request.getParameter("jobKey"));
			jobType.setLike("jobName",request.getParameter("jobName"));
			jobType.setLike("nextState",request.getParameter("nextState"));
			jobType.setLike("jobCategory",request.getParameter("jobCategory"));
			
			Page page = new Page();
			page.buildComponent(request, jobType.count());
			
			jobType.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> jobTypes = jobType.searchAndRetrieveList();
			
			request.setAttribute("jobTypes", jobTypes);
			
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			JobType jobType = new JobType();
			jobType.setId(IDGenerator.getNextInt(JobType.class));
			
			ParamUtil.bindData(request, jobType,"jobType");
			
			jobType.add();

			request.setAttribute("message", "processAdd successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptAdd";
		}
		return "listJobType";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		
		try {
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				JobType bean = new JobType();
				bean.setId( new Integer(ids[i]));
				bean.retrieve();
				
				bean.delete();
			}

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "listJobType";
		}
		return "listJobType";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
			
		try {
			String id =  request.getParameter("id");
			
			if(id==null)
				throw new Exception("Please select modify object");
			
				JobType bean = new JobType();
				bean.setId( new Integer(id));
				bean.retrieve();
				
				request.setAttribute("jobType", bean);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "listJobType";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		try {
			JobType jobType = new JobType();
			ParamUtil.bindData(request, jobType,"jobType");
			
			jobType.update();

			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		}
		return "listJobType";
	}
}