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
import com.mooo.mycoz.dbobj.wineBranch.StoreProduct;
import com.mooo.mycoz.dbobj.wineShared.Product;
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class StoreTypeAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ProductAction.class);

	public String list(HttpServletRequest request,
			HttpServletResponse response) {
		String value = null;
		try {
			Store store = new Store();
			
			value = request.getParameter("storeName");
			if(!StringUtils.isNull(value)){
				store.setLike("storeName", value);
			}
			
			value = request.getParameter("StoreKey");
			if(!StringUtils.isNull(value)){
				store.setLike("storeKey", value);
			}

			store.addOrderBy("id DESC");

			Page page = new Page();
			page.buildComponent(request,store.count());
			store.setRecord(page.getOffset(), page.getPageSize());
			List<?> stores = store.searchAndRetrieveList();

			request.setAttribute("stores", stores);

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
			Product product = new Product();
			product.setGreater("id", 0);
			request.setAttribute("products", product.searchAndRetrieveList());
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
			
			Store store=new Store();
			ParamUtil.bindData(request,store,"store");
			
			int storeId = IDGenerator.getNextID(tx.getConnection(),Store.class);
			store.setId(storeId);
			
			store.add(tx.getConnection());
			
			String[] productId =  request.getParameterValues("productId");

			if(productId!=null && productId.length>0){
				for(int i=0;i<productId.length;i++){
					Integer id = new Integer(productId[i]);
					
					StoreProduct storeProduct = new StoreProduct();
					storeProduct.setId(IDGenerator.getNextID(tx.getConnection(), StoreProduct.class));
					storeProduct.setStoreId(store.getId());
					storeProduct.setProductId(id);
					
					storeProduct.add(tx.getConnection());
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
			
			Store store=new Store();
			store.setId(new Integer(storeId));
			store.retrieve();

			request.setAttribute("store", store);
			
			Product product = new Product();
			product.setGreater("id", 0);
			request.setAttribute("products", product.searchAndRetrieveList());
			
			StoreProduct storeProduct = new StoreProduct();
			storeProduct.setStoreId(store.getId());
			request.setAttribute("nowProducts", storeProduct.searchAndRetrieveList());
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
			
			Store store=new Store();
			ParamUtil.bindData(request, store, "store");
			
			store.update(tx.getConnection());
			
			String[] productId =  request.getParameterValues("productId");

			if(productId!=null){
				for(int i=0;i<productId.length;i++){
					StoreProduct storeProduct = new StoreProduct();
					storeProduct.setProductId(new Integer(productId[i]));
					storeProduct.setStoreId(store.getId());
					
					if(storeProduct.count()<1){
						storeProduct.setId(IDGenerator.getNextID(tx.getConnection(),StoreProduct.class));
						storeProduct.add(tx.getConnection());
					}
				}
				
				StoreProduct storeProduct = new StoreProduct();
				storeProduct.setStoreId(store.getId());
				
				List<Object> products = storeProduct.searchAndRetrieveList(tx.getConnection());
				for(Object bean:products){
					storeProduct=(StoreProduct)bean;

					boolean remove = false;
					
					for(int i=0;i<productId.length;i++){
						int dId = new Integer(productId[i]); 
						
						if(dId==storeProduct.getProductId()){
							remove = true;
							break;
						}
					}
					
					if(!remove){
						storeProduct.delete(tx.getConnection());
					}
				}
			}else{//delete all
				StoreProduct storeProduct = new StoreProduct();
				storeProduct.setStoreId(store.getId());
				
				List<Object> stores = storeProduct.searchAndRetrieveList(tx.getConnection());
				for(Object bean:stores){
					storeProduct=(StoreProduct)bean;
					storeProduct.delete(tx.getConnection());
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
				
				StoreProduct storeProduct = new StoreProduct();
				storeProduct.setStoreId(id);

				List<Object> stores = storeProduct.searchAndRetrieveList(tx.getConnection());
				for(Object bean:stores){
					storeProduct=(StoreProduct)bean;
					storeProduct.delete(tx.getConnection());
				}
				
				Store store=new Store();
				store.setId(id);
				store.delete(tx.getConnection());
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
