package com.mooo.mycoz.action.profile;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.BrewCrafts;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class BrewCraftsAction  extends BaseSupport {

	private static Log log = LogFactory.getLog(BrewCraftsAction.class);
	
	public String listBrewCrafts(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			BrewCrafts brewCrafts = new BrewCrafts();
			
			value = request.getParameter("craftsName");
			if(!StringUtils.isNull(value)){
				brewCrafts.setLike("craftsName", value);
			}
			
			value = request.getParameter("craftsDesc");
			if(!StringUtils.isNull(value)){
				brewCrafts.setLike("craftsDesc", value);
			}
			
			Page page = new Page();
			page.buildComponent(request, brewCrafts.count());
			brewCrafts.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = brewCrafts.searchAndRetrieveList();
			
			request.setAttribute("results", results);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			BrewCrafts brewCrafts = new BrewCrafts();
			ParamUtil.bindData(request, brewCrafts,"brewCrafts");
			
			int brewCraftsId = IDGenerator.getNextID(tx.getConnection(),BrewCrafts.class);
			brewCrafts.setId(brewCraftsId);
			brewCrafts.add(tx.getConnection());
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "listBrewCrafts";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String brewCraftsId = null;
		try{
			brewCraftsId = request.getParameter("id");
			if(brewCraftsId==null)
				throw new Exception("Please chose object");
			
			BrewCrafts brewCrafts = new BrewCrafts();
			brewCrafts.setId(new Integer(brewCraftsId));
			brewCrafts.retrieve();

			request.setAttribute("brewCrafts", brewCrafts);
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
			
			BrewCrafts brewCrafts = new BrewCrafts();
			ParamUtil.bindData(request, brewCrafts, "brewCrafts");
			
			brewCrafts.update(tx.getConnection());
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}finally {
			tx.end();
		}
		return "listBrewCrafts";
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
				
				BrewCrafts brewCrafts = new BrewCrafts();
				brewCrafts.setId(id);
				brewCrafts.delete(tx.getConnection());
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
		return "listBrewCrafts";
	}
	
}