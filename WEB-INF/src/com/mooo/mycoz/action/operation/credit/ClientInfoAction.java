package com.mooo.mycoz.action.operation.credit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;

public class ClientInfoAction extends BaseSupport {

private static Log log = LogFactory.getLog(ClientInfoAction.class);

	public String list(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("list");
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		return "listCard";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		return "list";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		return "success";
	}

}
