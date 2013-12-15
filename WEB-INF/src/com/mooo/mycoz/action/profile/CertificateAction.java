package com.mooo.mycoz.action.profile;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.Certificate;
import com.mooo.mycoz.dbobj.wineShared.CreditType;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class CertificateAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ProductAction.class);

	public String list(HttpServletRequest request,
			HttpServletResponse response) {
		String value = null;
		Integer sessionId = ActionSession.getInteger(request,
				ActionSession.USER_SESSION_KEY);
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Certificate.class, "certificate");
			
			value = request.getParameter("certificateCode");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("certificate", "certificateCode", value);
			}
			
			dbobject.setRetrieveField("certificate", "id");
			dbobject.setRetrieveField("certificate", "certificateCode");
			dbobject.setRetrieveField("certificate", "issuingAuthority");
			dbobject.setRetrieveField("certificate", "issueDate");
			dbobject.setRetrieveField("certificate", "valid");
			dbobject.setRetrieveField("certificate", "certificateType");

			dbobject.setOrderBy("certificate", "id", "DESC");

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

		return "success";
		
	}
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			Certificate certificate=new Certificate();
			ParamUtil.bindData(request, certificate,"certificate");
			
			int certificateId = IDGenerator.getNextID(tx.getConnection(),Certificate.class);
			certificate.setId(certificateId);
			
			certificate.add(tx.getConnection());
			
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
		String certificateId = null;
		try{
			certificateId = request.getParameter("id");
			if(certificateId==null)
				throw new Exception("Please chose object");
			
			Certificate certificate=new Certificate();
			certificate.setId(new Integer(certificateId));
			certificate.retrieve();

			request.setAttribute("certificate", certificate);
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
			
			Certificate certificate=new Certificate();
			ParamUtil.bindData(request, certificate, "certificate");
			
			certificate.update(tx.getConnection());
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			//return "promptEdit";
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
				
				Certificate certificate=new Certificate();
				certificate.setId(id);
				certificate.delete(tx.getConnection());
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
