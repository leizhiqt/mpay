package com.mooo.mycoz.action.profile;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.BrewJob;
import com.mooo.mycoz.dbobj.wineBranch.BrewJobDetail;
import com.mooo.mycoz.dbobj.wineShared.BrewPoint;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class BrewJobDetailAction extends BaseSupport {

	private static Log log = LogFactory.getLog(BrewJobDetailAction.class);
	
	public String listBrewJobDetail(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(BrewJobDetail.class, "brewJobDetail");
			dbobject.addTable(BrewPoint.class, "brewPoint");
			dbobject.addTable(BrewJob.class, "brewJob");

			dbobject.setForeignKey("brewJobDetail", "brewJobId","brewJob", "id");
			dbobject.setForeignKey("brewJobDetail", "jobPointId","brewPoint", "id");
			
			value = request.getParameter("brewJobId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("brewJob", "id", new Integer(value));
			}
			
			value = request.getParameter("jobPointId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("brewPoint", "id", new Integer(value));
			}
			
			value = request.getParameter("jobPeople");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("brewJobDetail", "jobPeople", value);
			}
			
			dbobject.setRetrieveField("brewJob", "brewNumber");
			dbobject.setRetrieveField("brewPoint", "pointName");
			dbobject.setRetrieveField("brewJobDetail", "id");
			dbobject.setRetrieveField("brewJobDetail", "jobDate");
			dbobject.setRetrieveField("brewJobDetail", "jobPeople");

			dbobject.setOrderBy("brewJobDetail", "id","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();
			BrewJob brewJob = new BrewJob();
			BrewPoint brewPoint = new BrewPoint();
			
			request.setAttribute("results", results);
			request.setAttribute("brewJobs", brewJob.searchAndRetrieveList());
			request.setAttribute("brewPoints", brewPoint.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		BrewJob brewJob = new BrewJob();
		BrewPoint brewPoint = new BrewPoint();
		List<Object> brewJobList = null;
		List<Object> brewPointList = null;
		try {
			brewJobList = brewJob.searchAndRetrieveList();
			brewPointList = brewPoint.searchAndRetrieveList();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
			return "listBrewJobDetail";
		}
		request.setAttribute("brewJobs", brewJobList);
		request.setAttribute("brewPoints", brewPointList);
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			BrewJobDetail brewJobDetail = new BrewJobDetail();
			ParamUtil.bindData(request, brewJobDetail,"brewJobDetail");
			
			int brewJobId = IDGenerator.getNextID(tx.getConnection(),BrewJobDetail.class);
			brewJobDetail.setId(brewJobId);
			brewJobDetail.setJobDate(new Date());
			brewJobDetail.add(tx.getConnection());
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "listBrewJobDetail";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String brewJobDetailId = null;
		try{
			brewJobDetailId = request.getParameter("id");
			if(brewJobDetailId==null)
				throw new Exception("Please chose object");
			
			BrewJobDetail brewJobDetail = new BrewJobDetail();
			brewJobDetail.setId(new Integer(brewJobDetailId));
			brewJobDetail.retrieve();

			BrewJob brewJob = new BrewJob();
			BrewPoint brewPoint = new BrewPoint();
			
			request.setAttribute("brewJobDetail", brewJobDetail);
			request.setAttribute("brewJobs", brewJob.searchAndRetrieveList());
			request.setAttribute("brewPoints", brewPoint.searchAndRetrieveList());
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
			
			BrewJobDetail brewJobDetail = new BrewJobDetail();
			ParamUtil.bindData(request, brewJobDetail, "brewJobDetail");
			
			brewJobDetail.update(tx.getConnection());
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}finally {
			tx.end();
		}
		return "listBrewJobDetail";
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
				
				BrewJobDetail brewJobDetail = new BrewJobDetail();
				brewJobDetail.setId(id);
				brewJobDetail.delete(tx.getConnection());
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
		return "listBrewJobDetail";
	}
	
}
