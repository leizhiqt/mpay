package com.mooo.mycoz.action.setup;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.WarehouseItem;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class WarehouseItemAction  extends BaseSupport {

	private static Log log = LogFactory.getLog(WarehouseItemAction.class);
	
	public String list(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			WarehouseItem warehouseItem = new WarehouseItem();

			value = request.getParameter("itemName");
			if(!StringUtils.isNull(value)){
				warehouseItem.setLike("itemName", value);
			}
			
			value = request.getParameter("storageMode");
			if(!StringUtils.isNull(value)){
				warehouseItem.setLike("storageMode", value);
			}
			
			Page page = new Page();
			page.buildComponent(request, warehouseItem.count());
			warehouseItem.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = warehouseItem.searchAndRetrieveList();
			
			request.setAttribute("results", results);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));

		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");

		Transaction tx=new Transaction();
		try {
			tx.start();
			WarehouseItem warehouseItem = new WarehouseItem();
			ParamUtil.bindData(request, warehouseItem,"warehouseItem");
			
			int warehouseId = IDGenerator.getNextID(tx.getConnection(),WarehouseItem.class);
			warehouseItem.setId(warehouseId);
			warehouseItem.add(tx.getConnection());
			
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
		String warehouseId = null;
		try{
			warehouseId = request.getParameter("id");
			if(warehouseId==null)
				throw new Exception("Please chose object");
			
			WarehouseItem warehouseItem = new WarehouseItem();
			warehouseItem.setId(new Integer(warehouseId));
			warehouseItem.retrieve();

			request.setAttribute("warehouseItem", warehouseItem);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		
		try{
			
			WarehouseItem warehouseItem = new WarehouseItem();
			ParamUtil.bindData(request, warehouseItem, "warehouseItem");
			
			warehouseItem.update();
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
				
				WarehouseItem warehouseItem = new WarehouseItem();
				warehouseItem.setId(id);
				warehouseItem.delete(tx.getConnection());
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
