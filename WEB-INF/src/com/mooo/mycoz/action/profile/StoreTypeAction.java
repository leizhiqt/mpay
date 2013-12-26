package com.mooo.mycoz.action.profile;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.dbobj.wineShared.StoreType;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class StoreTypeAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ProductAction.class);

	public String list(HttpServletRequest request,
			HttpServletResponse response) {
		String value = null;
		try {
			StoreType storeType = new StoreType();
			
			value = request.getParameter("typeName");
			if(!StringUtils.isNull(value)){
				storeType.setLike("typeName", value);
			}
			
			value = request.getParameter("typeKey");
			if(!StringUtils.isNull(value)){
				storeType.setLike("typeKey", value);
			}
			storeType.addOrderBy("typeKey");

			Page page = new Page();
			page.buildComponent(request,storeType.count());
			storeType.setRecord(page.getOffset(), page.getPageSize());
			List<?> storeTypes = storeType.searchAndRetrieveList();

			request.setAttribute("storeTypes", storeTypes);

			if (log.isDebugEnabled())
				log.debug("list success");

		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		} 
		return "list";
	}
	public String  promptAdd(HttpServletRequest request,
			HttpServletResponse response){
		
		if (log.isDebugEnabled())log.debug("promptAdd");
		try {
			Store store = new Store();
			store.setGreater("id", 0);
			store.addOrderBy("storeName");
			request.setAttribute("stores", store.searchAndRetrieveList());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return "success";
		
	}
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			StoreType storeType=new StoreType();
			ParamUtil.bindData(request,storeType,"storeType");
			
			int nextId = IDGenerator.getNextID(tx.getConnection(),StoreType.class);
			storeType.setId(nextId);
			storeType.add(tx.getConnection());
			
			String[] storeId =  request.getParameterValues("storeId");

			if(storeId!=null && storeId.length>0){
				for(int i=0;i<storeId.length;i++){
					Store store = new Store();
					store.setId(new Integer(storeId[i]));
					store.setStoreTypeId(storeType.getId());
					
					store.add(tx.getConnection());
				}
			}
			
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
		String storeId = null;
		try{
			storeId = request.getParameter("id");
			if(storeId==null){
				request.setAttribute("error", "请选择商店！");
				return "list";
			}
			
			StoreType storeType=new StoreType();
			storeType.setId(new Integer(storeId));
			storeType.retrieve();

			request.setAttribute("storeType", storeType);
			
			Store store = new Store();
			store.setGreater("id", 0);
			store.addOrderBy("storeName");
			request.setAttribute("stores", store.searchAndRetrieveList());
			
			Store orgStore = new Store();
			orgStore.setStoreTypeId(storeType.getId());
			request.setAttribute("orgStores", orgStore.searchAndRetrieveList());

		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		Transaction tx=new Transaction();
		try{
			tx.start();
			
			StoreType storeType=new StoreType();
			ParamUtil.bindData(request, storeType, "storeType");
			
			storeType.update(tx.getConnection());
			
			String[] storeId =  request.getParameterValues("storeId");

			if(storeId!=null){
				for(int i=0;i<storeId.length;i++){
					Store store = new Store();
					store.setId(new Integer(storeId[i]));
					if(store.count()<1){
						store.setId(IDGenerator.getNextID(tx.getConnection(),Store.class));
						store.add(tx.getConnection());
					}else {
						store.setStoreTypeId(storeType.getId());
						store.update(tx.getConnection());
					}
				}
					
				Store store = new Store();
				store.setStoreTypeId(storeType.getId());
				
				List<Object> stores = store.searchAndRetrieveList(tx.getConnection());
				for(Object bean:stores){
					store=(Store)bean;

					boolean remove = false;
					
					for(int i=0;i<storeId.length;i++){
						int dId = new Integer(storeId[i]); 
						
						if(dId==store.getId()){
							remove = true;
							break;
						}
					}
					
					if(!remove){
						store.setStoreTypeId(0);
						store.update(tx.getConnection());
					}
				}
			}else{//delete all
				Store store = new Store();
				store.setStoreTypeId(storeType.getId());
				
				List<Object> stores = store.searchAndRetrieveList(tx.getConnection());
				for(Object bean:stores){
					store=(Store)bean;
					store.setStoreTypeId(0);
					store.update(tx.getConnection());
				}
			}
			
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}finally {
			tx.end();
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
				
				Store store = new Store();
				store.setId(id);

				List<Object> stores = store.searchAndRetrieveList(tx.getConnection());
				for(Object bean:stores){
					store=(Store)bean;
					store.delete(tx.getConnection());
				}
				
				StoreType storeType=new StoreType();
				storeType.setId(id);
				storeType.delete(tx.getConnection());
			}
			
			tx.commit();
			
			request.setAttribute("message", "商店删除成功！");
		} catch (Exception e) {
			tx.rollback();
			
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", "商店已使用，删除失败！");
		} finally {
			tx.end();
		}
		return "list";
	}
}
