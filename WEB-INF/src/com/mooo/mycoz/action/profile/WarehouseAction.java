package com.mooo.mycoz.action.profile;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.Warehouse;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class WarehouseAction  extends BaseSupport {

	private static Log log = LogFactory.getLog(WarehouseAction.class);
	
	public String listWarehouse(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(Warehouse.class, "warehouse");

			dbobject.setForeignKey("winery", "id","warehouse", "enterpriseId");
			
			value = request.getParameter("wineryId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("winery", "id", new Integer(value));
			}
			
			value = request.getParameter("warehouseName");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("warehouse", "warehouseName", value);
			}
			
			value = request.getParameter("contact");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("warehouse", "contact", value);
			}
			
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("warehouse", "id");
			dbobject.setRetrieveField("warehouse", "warehouseName");
			dbobject.setRetrieveField("warehouse", "contact");
			dbobject.setRetrieveField("warehouse", "address");
			dbobject.setRetrieveField("warehouse", "zipcode");
			dbobject.setRetrieveField("warehouse", "telephone");
			
			dbobject.setOrderBy("warehouse", "id","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();
			
			request.setAttribute("results", results);
			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));
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
			Warehouse warehouse = new Warehouse();
			ParamUtil.bindData(request, warehouse,"warehouse");
			
			int warehouseId = IDGenerator.getNextID(tx.getConnection(),Warehouse.class);
			warehouse.setId(warehouseId);
			warehouse.add(tx.getConnection());
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "listWarehouse";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String warehouseId = null;
		try{
			warehouseId = request.getParameter("id");
			if(warehouseId==null)
				throw new Exception("Please chose object");
			
			Warehouse warehouse = new Warehouse();
			warehouse.setId(new Integer(warehouseId));
			warehouse.retrieve();

			request.setAttribute("warehouse", warehouse);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		
		try{
			
			Warehouse warehouse = new Warehouse();
			ParamUtil.bindData(request, warehouse, "warehouse");
			
			warehouse.update();
		}catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}
		return "listWarehouse";
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
				
				Warehouse warehouse = new Warehouse();
				warehouse.setId(id);
				warehouse.delete(tx.getConnection());
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
		return "listWarehouse";
	}
	
}
