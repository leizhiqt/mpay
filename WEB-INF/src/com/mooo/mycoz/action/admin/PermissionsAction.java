package com.mooo.mycoz.action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;



public class PermissionsAction extends BaseSupport {

private static Log log = LogFactory.getLog(PermissionsAction.class);

	public String menu(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("menu");
		return "success";
	}
}