package com.mooo.mycoz.action.setup;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;



public class LocationAction extends BaseSupport {

private static Log log = LogFactory.getLog(LocationAction.class);

	public String menu(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("menu");
		return "success";
	}
}