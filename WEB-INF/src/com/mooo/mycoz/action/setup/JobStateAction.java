package com.mooo.mycoz.action.setup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.dbobj.wineShared.JobState;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class JobStateAction extends BaseSupport {

private static Log log = LogFactory.getLog(JobStateAction.class);

	public String list(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			JobState wineJarState = new JobState();
			
			wineJarState.setLike("shortName",request.getParameter("shortName"));
			wineJarState.setLike("fullName",request.getParameter("fullName"));
			
			Page page = new Page();
			page.buildComponent(request, wineJarState.count());
			
			wineJarState.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> wineJarStates = wineJarState.searchAndRetrieveList();
			
			request.setAttribute("result", wineJarStates);
			
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
			JobState wineJarState = new JobState();
			wineJarState.setId(IDGenerator.getNextInt(JobState.class));
			
			ParamUtil.bindData(request, wineJarState,"wineJarState");
			
			wineJarState.add();

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
				JobState bean = new JobState();
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
		if (log.isDebugEnabled())log.debug("SetupAction list");
		String id =  request.getParameter("id");
		try {
			if(StringUtils.isNull(id))
				throw new Exception("Please select object");
			
				JobState bean = new JobState();
				bean.setId( new Integer(id));
				bean.retrieve();
				
				request.setAttribute("wineJarState", bean);
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
			JobState wineJarState = new JobState();
			ParamUtil.bindData(request, wineJarState,"wineJarState");
			
			wineJarState.update();
			
			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		}
		return "list";
	}
}