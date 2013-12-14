package com.mooo.mycoz.action.setup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.dbobj.wineShared.WineLevel;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class WineLevelAction extends BaseSupport {

private static Log log = LogFactory.getLog(WineLevelAction.class);

	public String listWineLevel(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			WineLevel wineLevel = new WineLevel();
			
			wineLevel.setLike("abbreviation",request.getParameter("query_abbreviation"));
			wineLevel.setLike("definition",request.getParameter("query_definition"));
			
			Page page = new Page();
			page.buildComponent(request, wineLevel.count());
			
			wineLevel.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> wineLevels = wineLevel.searchAndRetrieveList();
			
			request.setAttribute("wineLevels", wineLevels);
			
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
			WineLevel wineLevel = new WineLevel();
			wineLevel.setId(IDGenerator.getNextInt(WineLevel.class));
			
			ParamUtil.bindData(request, wineLevel,"wineLevel");
			
			wineLevel.add();

			request.setAttribute("message", "processAdd successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			return "promptAdd";
		}
		return "listWineLevel";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null || ids.length==0)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				WineLevel bean = new WineLevel();
				bean.setId( new Integer(ids[i]));
				bean.retrieve();
				
				bean.delete();
			}

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "listWineLevel";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		String id =  request.getParameter("id");
		try {
			if(StringUtils.isNull(id))
				throw new Exception("Please select object");
			
				WineLevel bean = new WineLevel();
				bean.setId( new Integer(id));
				bean.retrieve();
				
				request.setAttribute("wineLevel", bean);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "listWineLevel";
		}
		return "success";
	}
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			WineLevel wineLevel = new WineLevel();
			ParamUtil.bindData(request, wineLevel,"wineLevel");
			
			wineLevel.update();
			
			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		}
		return "listWineLevel";
	}
}