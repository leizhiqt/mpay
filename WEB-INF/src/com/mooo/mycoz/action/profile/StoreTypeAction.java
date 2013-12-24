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
import com.mooo.mycoz.dbobj.wineShared.StoreType;
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
			
			StoreType storeType=new StoreType();
			ParamUtil.bindData(request,storeType,"storeType");
			
			int storeId = IDGenerator.getNextID(tx.getConnection(),StoreType.class);
			storeType.setId(storeId);
			
			storeType.add(tx.getConnection());
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
			
			Product product = new Product();
			product.setGreater("id", 0);
			request.setAttribute("products", product.searchAndRetrieveList());
			
			StoreProduct storeProduct = new StoreProduct();
			storeProduct.setStoreId(storeType.getId());
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
			
			StoreType storeType=new StoreType();
			ParamUtil.bindData(request, storeType, "storeType");
			
			storeType.update(tx.getConnection());
			
			String[] productId =  request.getParameterValues("productId");

			if(productId!=null){
				for(int i=0;i<productId.length;i++){
					StoreProduct storeProduct = new StoreProduct();
					storeProduct.setProductId(new Integer(productId[i]));
					storeProduct.setStoreId(storeType.getId());
					
					if(storeProduct.count()<1){
						storeProduct.setId(IDGenerator.getNextID(tx.getConnection(),StoreProduct.class));
						storeProduct.add(tx.getConnection());
					}
				}
				
				StoreProduct storeProduct = new StoreProduct();
				storeProduct.setStoreId(storeType.getId());
				
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
				storeProduct.setStoreId(storeType.getId());
				
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
