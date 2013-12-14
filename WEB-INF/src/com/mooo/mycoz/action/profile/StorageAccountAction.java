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
import com.mooo.mycoz.dbobj.wineBranch.Product;
import com.mooo.mycoz.dbobj.wineBranch.StorageAccount;
import com.mooo.mycoz.dbobj.wineBranch.StorageDetail;
import com.mooo.mycoz.dbobj.wineBranch.Warehouse;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineShared.WarehouseItem;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class StorageAccountAction  extends BaseSupport {

	private static Log log = LogFactory.getLog(StorageAccountAction.class);
	
	public String list(HttpServletRequest request,HttpServletResponse response) {
		String value = null;

		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(Warehouse.class, "warehouse");
			dbobject.addTable(StorageAccount.class, "storageAccount");
			dbobject.addTable(Product.class, "product");

			dbobject.setForeignKey("winery", "id","warehouse", "enterpriseId");
			dbobject.setForeignKey("warehouse", "id","storageAccount", "warehouseId");
			dbobject.setForeignKey("product", "id","storageAccount", "productId");
			
			value = request.getParameter("warehouseName");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("warehouse", "warehouseName", value);
			}

			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("warehouse", "warehouseName");
			dbobject.setRetrieveField("product", "productName");
			
			dbobject.setRetrieveField("storageAccount", "batchNumber");
			dbobject.setRetrieveField("storageAccount", "storageDate");
			dbobject.setRetrieveField("storageAccount", "storagePeople");
			dbobject.setRetrieveField("storageAccount", "id");

			dbobject.setOrderBy("storageAccount", "id","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();
			
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
		String id=null;
		try{
			request.setAttribute("dcTypes", IDGenerator.getDcType());

			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));

			request.setAttribute("warehouseItems", IDGenerator.getValues(WarehouseItem.class,"id","itemName"));
			
			id = request.getParameter("id");
			if(StringUtils.isNull(id)){
				id = (String)request.getAttribute("id");
			}
			
			if(!StringUtils.isNull(id)){
				request.setAttribute("id", id);

				StorageAccount storageAccount = new StorageAccount();
				storageAccount.setId(new Integer(id));
				storageAccount.retrieve();
				
				request.setAttribute("storageAccount", storageAccount);

				MultiDBObject dbobject = new MultiDBObject();
				dbobject.addTable(WarehouseItem.class, "warehouseItem");
				dbobject.addTable(StorageDetail.class, "storageDetail");

				dbobject.setForeignKey("warehouseItem", "id","storageDetail", "itemId");
				dbobject.setField("storageDetail", "accountId",storageAccount.getId());

				dbobject.setRetrieveField("warehouseItem", "itemName");
				dbobject.setRetrieveField("storageDetail", "storageName");
				dbobject.setRetrieveField("storageDetail", "quanItem");
				dbobject.setRetrieveField("storageDetail", "itemVol");
				dbobject.setRetrieveField("storageDetail", "volUnit");
				dbobject.setRetrieveField("storageDetail", "storageType");

				request.setAttribute("results", dbobject.searchAndRetrieveList());
			}
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}

	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		return "success";
	}
	
	public String processItemAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processItemAdd");
		String value=null;
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			StorageAccount storageAccount = new StorageAccount();
			ParamUtil.bindData(request, storageAccount,"storageAccount");
			
			value = request.getParameter("product");
			StringUtils.noNull(value);
			
			Product product = new Product();
			product.setProductName(value);
			product.retrieve();

			request.setAttribute("product", value);

			storageAccount.setProductId(product.getId());
			
			value = request.getParameter("warehouse");
			StringUtils.noNull(value);
			
			Warehouse warehouse =  new Warehouse();
			warehouse.setWarehouseName(value);
			warehouse.retrieve();
			
			request.setAttribute("warehouse", value);
			storageAccount.setWarehouseId(warehouse.getId());

			Integer newId  = storageAccount.getId();
			
			if(newId == null){
				newId = IDGenerator.getNextID(tx.getConnection(),StorageAccount.class);
				storageAccount.setId(newId);
				storageAccount.add(tx.getConnection());
			}else{
				storageAccount.update(tx.getConnection());
			}
			request.setAttribute("id", newId.toString());

			request.setAttribute("storageAccount", storageAccount);

			StorageDetail storageDetail = new StorageDetail();
			ParamUtil.bindData(request, storageDetail,"storageDetail");
			storageDetail.setAccountId(storageAccount.getId());

			newId = IDGenerator.getNextID(tx.getConnection(),StorageDetail.class);
			storageDetail.setId(newId);
			storageDetail.add(tx.getConnection());
			
			tx.commit();
			
			request.setAttribute("message", "Operating successfully");
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "promptAdd";
	}

	public String processItemDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			Integer id = new Integer(0);
			
			Warehouse warehouse = new Warehouse();
			warehouse.setId(id);
			warehouse.delete(tx.getConnection());
			
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
	
	public String processItemUpdate(HttpServletRequest request, HttpServletResponse response) {
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
		return "list";
	}
}
