package com.mooo.mycoz.action.operation.label;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;



public class LabelAction extends BaseSupport {

private static Log log = LogFactory.getLog(LabelAction.class);

	public String menu(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("menu");
		return "success";
	}
}