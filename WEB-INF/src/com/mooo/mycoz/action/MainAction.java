package com.mooo.mycoz.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.framework.ActionSession;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainAction extends BaseSupport {

	private static Log log = LogFactory.getLog(MainAction.class);

	public String menu(HttpServletRequest request,HttpServletResponse response) {
		return "success";
	}
	
	public String menuTop(HttpServletRequest request,HttpServletResponse response) {
		try {
			Integer sessionId= ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
			
			HttpSession session = request.getSession(true);
			Object cobj = session.getAttribute("javax.servlet.jsp.jstl.fmt.locale.session");
			if (log.isDebugEnabled()) log.debug("fmt locale: " + cobj);
			if (log.isDebugEnabled()) log.debug("sessionId:"+sessionId);
			
			Branch branch = new Branch();
			branch.setId(ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY));
			branch.retrieve();
			
			request.setAttribute("branchName", branch.getDefinition());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return "success";
	}
}
