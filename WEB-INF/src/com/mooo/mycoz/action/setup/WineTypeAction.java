package com.mooo.mycoz.action.setup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.dbobj.wineShared.WineType;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class WineTypeAction extends BaseSupport {

private static Log log = LogFactory.getLog(WineTypeAction.class);

	public String listWineType(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			WineType wineType = new WineType();
			
			wineType.setLike("abbreviation",request.getParameter("query_abbreviation"));
			wineType.setLike("definition",request.getParameter("query_definition"));
			
			Page page = new Page();
			page.buildComponent(request, wineType.count());
			
			wineType.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> wineTypes = wineType.searchAndRetrieveList();
			
			request.setAttribute("wineTypes", wineTypes);
			
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
			WineType wineType = new WineType();
			wineType.setId(IDGenerator.getNextInt(WineType.class));
			
			ParamUtil.bindData(request, wineType,"wineType");
			
			wineType.add();

			request.setAttribute("message", "processAdd successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptAdd";
		}
		return "listWineType";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null || ids.length==0)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				WineType bean = new WineType();
				bean.setId( new Integer(ids[i]));
				bean.retrieve();
				
				bean.delete();
			}

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "listWineType";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			String id =  request.getParameter("id");
			
			if(id==null)
				throw new Exception("Please chose object");
			
			WineType bean = new WineType();
			bean.setId( new Integer(id));
			bean.retrieve();
			
			request.setAttribute("wineType", bean);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			WineType wineType = new WineType();
			ParamUtil.bindData(request, wineType,"wineType");
			
			wineType.update();
			
			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		}
		return "listWineType";
	}
}