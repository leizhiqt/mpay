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
import com.mooo.mycoz.dbobj.wineShared.CreditType;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class CreditTypeAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ProductAction.class);

	public String list(HttpServletRequest request,
			HttpServletResponse response) {
		String value = null;
		Integer sessionId = ActionSession.getInteger(request,
				ActionSession.USER_SESSION_KEY);
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(CreditType.class, "creditType");
			
			value = request.getParameter("creditName");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("creditType", "creditName", value);
			}
			
			dbobject.setRetrieveField("creditType", "id");
			dbobject.setRetrieveField("creditType", "creditName");
			dbobject.setRetrieveField("creditType", "cycleTotal");
			dbobject.setRetrieveField("creditType", "cycleUnit");
			dbobject.setRetrieveField("creditType", "creditRate");

			dbobject.setOrderBy("creditType", "id", "DESC");

			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(), page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();

			request.setAttribute("results", results);

			if (log.isDebugEnabled())
				log.debug("list success");

		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		} 
		return "list";
	}
	public String  promptAdd(HttpServletRequest request,
			HttpServletResponse response){
		
		if (log.isDebugEnabled())log.debug("promptAdd");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

		request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));
		return "success";
		
	}
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			CreditType creditType = new CreditType();
			ParamUtil.bindData(request, creditType,"creditType");
			
			int creditTypeId = IDGenerator.getNextID(tx.getConnection(),CreditType.class);
			creditType.setId(creditTypeId);
			
			creditType.add(tx.getConnection());
			
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
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String creditTypeId = null;
		try{
			creditTypeId = request.getParameter("id");
			if(creditTypeId==null)
				throw new Exception("Please chose object");
			
			CreditType creditType = new CreditType();
			creditType.setId(new Integer(creditTypeId));
			creditType.retrieve();

			request.setAttribute("creditType", creditType);
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
			
			CreditType creditType = new CreditType();
			ParamUtil.bindData(request, creditType, "creditType");
			
			creditType.update(tx.getConnection());
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
				
				CreditType creditType = new CreditType();
				creditType.setId(id);
				creditType.delete(tx.getConnection());
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
