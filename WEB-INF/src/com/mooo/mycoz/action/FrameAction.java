package com.mooo.mycoz.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.framework.ActionSession;

public class FrameAction {
	private static Log log = LogFactory.getLog(FrameAction.class);

	public String execute(HttpServletRequest request,HttpServletResponse response) {
		try {
			if (log.isDebugEnabled()) log.debug("execute begin!");

			HttpSession session = request.getSession(true);
			Integer userID = (Integer) session.getAttribute(ActionSession.USER_SESSION_KEY);
			
			boolean isAuthenticated = (null != userID && userID >0);
			
			User user = new User();
			user.setId(userID);
			user.retrieve();
			
			request.setAttribute("UserName", user.getName());
			
			if (!isAuthenticated) {
				return "promptLogin";
			}
			
			if (log.isDebugEnabled()) log.debug("execute OK!");
		} catch (Exception e) {
			if (log.isErrorEnabled())log.error("Exception Load error of: " + e.getMessage());
		}
		return "success";
	}
}