package com.mooo.mycoz.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.dbobj.wineBranch.Document;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexAction  extends BaseSupport {

	private static Log log = LogFactory.getLog(IndexAction.class);

	public String home(HttpServletRequest request,HttpServletResponse response) {
		if(log.isDebugEnabled()) log.debug("success");

		try {
			Document document = new Document();

			request.setAttribute("results", document.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		
		return "success";
	}
	
	
	public String browseDocument(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");

		try {
				String id =  request.getParameter("id");
			
				if(id==null) throw new Exception("Please chose object");
			
				Document document = new Document();
				document.setId(new Integer(id));
				
				document.retrieve();
				
				request.setAttribute("document", document);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String questionnaire(HttpServletRequest request, HttpServletResponse response) {

		return "success";
	}
}
