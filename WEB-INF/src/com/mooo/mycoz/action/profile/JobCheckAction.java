package com.mooo.mycoz.action.profile;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.JobCheck;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;


public class JobCheckAction extends BaseSupport {

	private static Log log = LogFactory.getLog(JobCheckAction.class);
	
	public String list(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			JobCheck jobCheck = new JobCheck();

			value = request.getParameter("checkName");
			if(!StringUtils.isNull(value)){
				jobCheck.setLike("checkName", value);
			}
			
			jobCheck.addOrderBy("id DESC");
			
			Page page = new Page();
			page.buildComponent(request, jobCheck.count());
			jobCheck.setRecord(page.getOffset(),page.getPageSize());
			List<?> jobChecks = jobCheck.searchAndRetrieveList();
			
			request.setAttribute("jobChecks", jobChecks);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");

		try {
			String jobTypes[] = {"R","A","C"};
			request.setAttribute("jobTypes", jobTypes);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			JobCheck jobCheck = new JobCheck();
			ParamUtil.bindData(request, jobCheck,"jobCheck");
			
			int jobCheckId = IDGenerator.getNextID(tx.getConnection(),JobCheck.class);
			jobCheck.setId(jobCheckId);
			
			jobCheck.add(tx.getConnection());
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "list";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String jobCheckId = null;
		try{
			jobCheckId = request.getParameter("id");
			if(jobCheckId==null)
				throw new Exception("Please chose object");
			
			JobCheck jobCheck = new JobCheck();
			jobCheck.setId(new Integer(jobCheckId));
			jobCheck.retrieve();

			request.setAttribute("jobCheck", jobCheck);
			
			String jobTypes[] = {"R","A","C"};
			request.setAttribute("jobTypes", jobTypes);
			
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		Transaction tx=new Transaction();
		try{
			tx.start();
			
			JobCheck jobCheck = new JobCheck();
			ParamUtil.bindData(request, jobCheck, "jobCheck");
			
			jobCheck.update(tx.getConnection());
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}finally {
			tx.end();
		}
		return "list";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				Integer id = new Integer(ids[i]);
				
				JobCheck jobCheck = new JobCheck();
				jobCheck.setId(id);
				jobCheck.delete(tx.getConnection());
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
	
}