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
import com.mooo.mycoz.dbobj.wineBranch.Product;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.I18n;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class BrewJobAction extends BaseSupport {

	private static Log log = LogFactory.getLog(BrewJobAction.class);
	
	public String listBrewJob(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Product.class, "product");
			dbobject.addTable(BrewJob.class, "brewJob");

			dbobject.setForeignKey("product", "id","brewJob", "productId");
			
			value = request.getParameter("productId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("product", "id", new Integer(value));
			}
			
			value = request.getParameter("brewNumber");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("brewJob", "brewNumber", value);
			}
			
			dbobject.setRetrieveField("product", "styleName");
			dbobject.setRetrieveField("brewJob", "id");
			dbobject.setRetrieveField("brewJob", "brewNumber");
			dbobject.setRetrieveField("brewJob", "quantity");
			dbobject.setRetrieveField("brewJob", "unit");
			dbobject.setRetrieveField("brewJob", "jobState");
			dbobject.setRetrieveField("brewJob", "jobDate");

			dbobject.setOrderBy("brewJob", "id","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();
			Product product = new Product();
			
			request.setAttribute("results", results);
			request.setAttribute("products", product.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		Product product = new Product();
		List<Object> list = null;
		try {
			list = product.searchAndRetrieveList();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
			return "listBrewJob";
		}
		request.setAttribute("products", list);
		request.setAttribute("jobStats", IDGenerator.getJobStates());
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		
		String qString = request.getParameter("brewJob.quantity");
		double qDouble = 0.0d;
		try{
			qDouble = Double.valueOf(qString);
		}catch(NumberFormatException e){
			request.setAttribute("error",  I18n.getValue("QuantityMustBeNumber"));
			return "promptAdd";
		}

		if(qDouble >= 1000.0d){
			request.setAttribute("error",  I18n.getValue("QuantityMustBeLessThanThousand"));
			return "promptAdd";
		}
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			BrewJob brewJob = new BrewJob();
			ParamUtil.bindData(request, brewJob,"brewJob");
			
			int brewJobId = IDGenerator.getNextID(tx.getConnection(),BrewJob.class);
			brewJob.setId(brewJobId);
			brewJob.setJobDate(new Date());
			brewJob.add(tx.getConnection());
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "listBrewJob";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
//		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String brewJobId = null;
		try{
			brewJobId = request.getParameter("id");
			if(brewJobId==null)
				throw new Exception("Please chose object");
			
			BrewJob brewJob = new BrewJob();
			brewJob.setId(new Integer(brewJobId));
			brewJob.retrieve();

			Product product = new Product();
			request.setAttribute("brewJob", brewJob);
			request.setAttribute("products", product.searchAndRetrieveList());
			request.setAttribute("jobStats", IDGenerator.getJobStates());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		String qString = request.getParameter("brewJob.quantity");
		double qDouble = 0.0d;
		try{
			qDouble = Double.valueOf(qString);
		}catch(NumberFormatException e){
			request.setAttribute("error",  I18n.getValue("QuantityMustBeNumber"));
			return "promptEdit";
		}

		if(qDouble >= 1000.0d){
			request.setAttribute("error",  I18n.getValue("QuantityMustBeLessThanThousand"));
			return "promptEdit";
		}
		
		Transaction tx=new Transaction();
		try{
			tx.start();
			
			BrewJob brewJob = new BrewJob();
			ParamUtil.bindData(request, brewJob, "brewJob");
			
			brewJob.update(tx.getConnection());
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}finally {
			tx.end();
		}
		return "listBrewJob";
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
				
				BrewJob brewJob = new BrewJob();
				brewJob.setId(id);
				brewJob.delete(tx.getConnection());
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
		return "listBrewJob";
	}
	
}
