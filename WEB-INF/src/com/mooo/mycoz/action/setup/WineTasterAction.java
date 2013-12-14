package com.mooo.mycoz.action.setup;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.WineTaster;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class WineTasterAction  extends BaseSupport {

	private static Log log = LogFactory.getLog(WineTasterAction.class);
	
	public String list(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			WineTaster wineTaster = new WineTaster();

			value = request.getParameter("query_tasterName");
			if(!StringUtils.isNull(value)){
				wineTaster.setLike("tasterName", value);
			}
			
			value = request.getParameter("query_tasterLicense");
			if(!StringUtils.isNull(value)){
				wineTaster.setLike("tasterLicense", value);
			}
			
			Page page = new Page();
			page.buildComponent(request, wineTaster.count());
			wineTaster.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = wineTaster.searchAndRetrieveList();
			
			request.setAttribute("results", results);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		List<String> categorys = new ArrayList<String>();
		categorys.add("Expert");
		categorys.add("Profession");
		request.setAttribute("categorys", categorys);
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");

		Transaction tx=new Transaction();
		try {
			tx.start();
			WineTaster wineTaster = new WineTaster();
			ParamUtil.bindData(request, wineTaster,"wineTaster");
			
			int newId = IDGenerator.getNextID(tx.getConnection(),WineTaster.class);
			wineTaster.setId(newId);
			wineTaster.add(tx.getConnection());
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "list";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String id = null;
		try{
			id = request.getParameter("id");
			if(id==null)
				throw new Exception("Please chose object");
			
			WineTaster wineTaster = new WineTaster();
			wineTaster.setId(new Integer(id));
			wineTaster.retrieve();

			request.setAttribute("wineTaster", wineTaster);
			
			List<String> categorys = new ArrayList<String>();
			categorys.add("Expert");
			categorys.add("Profession");
			request.setAttribute("categorys", categorys);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		try{
			WineTaster wineTaster = new WineTaster();
			ParamUtil.bindData(request, wineTaster, "wineTaster");
			
			wineTaster.update();
		}catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}
		return "list";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				Integer id = new Integer(ids[i]);
				
				WineTaster wineTaster = new WineTaster();
				wineTaster.setId(id);
				wineTaster.delete(tx.getConnection());
			}
			
			tx.commit();
			
			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			tx.rollback();
			
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "list";
	}
	
}
