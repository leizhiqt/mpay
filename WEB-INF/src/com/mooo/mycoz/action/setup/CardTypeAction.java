package com.mooo.mycoz.action.setup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.dbobj.wineShared.CardType;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class CardTypeAction extends BaseSupport {

private static Log log = LogFactory.getLog(CardTypeAction.class);

	public String list(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			CardType CardType = new CardType();
			
			CardType.setLike("cardTypeKey",request.getParameter("cardTypeKey"));
			CardType.setLike("cardTypeName",request.getParameter("cardTypeName"));
			
			Page page = new Page();
			page.buildComponent(request, CardType.count());
			
			CardType.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> CardTypes = CardType.searchAndRetrieveList();
			
			request.setAttribute("CardTypes", CardTypes);
			
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
			CardType cardType = new CardType();
			cardType.setId(IDGenerator.getNextInt(CardType.class));
			
			ParamUtil.bindData(request, cardType,"cardType");
			
			cardType.add();

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
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				CardType bean = new CardType();
				bean.setId( new Integer(ids[i]));
				bean.retrieve();
				
				bean.delete();
			}

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "list";
		}
		return "list";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
			
		try {
			String id =  request.getParameter("id");
			
			if(id==null)
				throw new Exception("Please select modify object");
			
				CardType bean = new CardType();
				bean.setId( new Integer(id));
				bean.retrieve();
				
				request.setAttribute("cardType", bean);
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
			CardType cardType = new CardType();
			ParamUtil.bindData(request, cardType,"cardType");

			cardType.update();

			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		}
		return "list";
	}
}