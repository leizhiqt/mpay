package com.mooo.mycoz.action.profile;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.DBObject;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.FinancialCategory;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.dbobj.wineShared.Product;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;
import com.sun.org.apache.bcel.internal.generic.NEW;

public class FinancialProductAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ProductAction.class);

	public String list(HttpServletRequest request,
			HttpServletResponse response) {
		String value = null;
		try {
			 FinancialProduct financialProduct = new FinancialProduct();
			
			value = request.getParameter("creditName");
			if(!StringUtils.isNull(value)){
				financialProduct.setLike("financialName", value);
			}
			String rate=request.getParameter("creditName");
			if(!StringUtils.isNull(rate)){
				financialProduct.setLike("financialName", rate);
			}
			financialProduct.setGreater("id", 0);
			financialProduct.addOrderBy("id DESC");

			Page page = new Page();
			page.buildComponent(request, financialProduct.count());
			financialProduct.setRecord(page.getOffset(), page.getPageSize());
			List<?> financials = financialProduct.searchAndRetrieveList();

			request.setAttribute("financials", financials);

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
		Product product=new Product();
		product.setGreater("id", 0);
		try {
			request.setAttribute("products", product.searchAndRetrieveList());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			FinancialProduct financialProduct = new FinancialProduct();
			ParamUtil.bindData(request, financialProduct,"financialProduct");
			
			int financialProductId = IDGenerator.getNextID(tx.getConnection(),FinancialProduct.class);
			financialProduct.setId(financialProductId);
			financialProduct.add(tx.getConnection());
			String [] productId=request.getParameterValues("productId");
			for(int i=0;i<productId.length;i++){
				Integer	id=IDGenerator.getNextID(tx.getConnection(),FinancialCategory.class);
				FinancialCategory financialCategory=new FinancialCategory();
				financialCategory.setFinancialId(financialProductId);
				financialCategory.setProductId(new Integer(productId[i]));
				financialCategory.setId(id);
				financialCategory.add(tx.getConnection());
			}
			
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "list";
	}
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		//Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String financialProductId = null;
		try{
			financialProductId = request.getParameter("id");
			if(financialProductId==null){
				throw new Exception("Please chose object");
			}		
			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(new Integer(financialProductId));
			financialProduct.retrieve();
			//处理选中的
			MultiDBObject multiDBObject=new MultiDBObject();
			multiDBObject.addTable(FinancialCategory.class, "financialCategory");
			multiDBObject.addTable(FinancialProduct.class, "financialProduct");
			multiDBObject.addTable(Product.class, "product");
			multiDBObject.setForeignKey("financialCategory", "productId", "product", "id");
			multiDBObject.setForeignKey("financialCategory", "financialId", "financialProduct", "id");
			multiDBObject.setField("financialProduct", "id", financialProductId);
			multiDBObject.setGreater("product", "id", 0);
			multiDBObject.setRetrieveField("product", "productName");
			multiDBObject.setRetrieveField("product", "id");
			request.setAttribute("result", multiDBObject.searchAndRetrieveList());
			//处理总共的
			Product product=new Product();
			request.setAttribute("products", product.searchAndRetrieveList());
			
			
			request.setAttribute("financialProduct", financialProduct);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("error", e.getMessage());
			return "list";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		Transaction tx=new Transaction();
		try{
			tx.start();
			
			FinancialProduct financialProduct = new FinancialProduct();
			ParamUtil.bindData(request, financialProduct, "financialProduct");
			financialProduct.update(tx.getConnection());
			//首先全删
			FinancialCategory financialCategory=new FinancialCategory();
			financialCategory.setFinancialId(financialProduct.getId());
			financialCategory.delete(tx.getConnection());
			//再加进去
			
			String [] productId=request.getParameterValues("productId");
			for(int i=0;i<productId.length;i++){
				Integer	id=IDGenerator.getNextID(tx.getConnection(),FinancialCategory.class);
				FinancialCategory financialCategory1=new FinancialCategory();
				financialCategory1.setFinancialId(financialProduct.getId());
				financialCategory1.setProductId(new Integer(productId[i]));
				financialCategory1.setId(id);
				financialCategory1.add(tx.getConnection());
			}
			
			for (String string : productId) {
				
			}
			financialProduct.update(tx.getConnection());
			
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
				//全删除
				FinancialCategory financialCategory=new FinancialCategory();
				financialCategory.setFinancialId(id);
				financialCategory.delete(tx.getConnection());
				
				
				FinancialProduct financialProduct = new FinancialProduct();
				financialProduct.setId(id);
				financialProduct.delete(tx.getConnection());
				
			}
			
			tx.commit();
			
			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
			
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "list";
	}
}
