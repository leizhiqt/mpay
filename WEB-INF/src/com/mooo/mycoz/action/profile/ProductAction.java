package com.mooo.mycoz.action.profile;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.Product;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;


public class ProductAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ProductAction.class);
	
	public String list(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Product.class, "product");

			
			
			value = request.getParameter("ProductName");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("product", "productName", value);
			}
			value = request.getParameter("Brand");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("product", "brand", value);
			}
			
			
			
			
			dbobject.setRetrieveField("product", "id");
			dbobject.setRetrieveField("product", "productName");
			dbobject.setRetrieveField("product", "brand");
			dbobject.setRetrieveField("product", "modelNo");

			dbobject.setOrderBy("product", "id","DESC");
			dbobject.setGreater("product", "id", 0);
			
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
			//new Product().retrieve();
		//request.setAttribute("product", new Product().retrieve(););
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			Product product = new Product();
			ParamUtil.bindData(request, product,"product");
			
			int productId = IDGenerator.getNextID(tx.getConnection(),Product.class);
			product.setId(productId);
			
			product.add(tx.getConnection());
			
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
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String productId = null;
		try{
			productId = request.getParameter("id");
			if(productId==null){
				request.setAttribute("error", "请选择产品！");
				return "list";
			}
			
			Product product = new Product();
			product.setId(new Integer(productId));
			product.retrieve();

			request.setAttribute("product", product);
			
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
			
			Product product = new Product();
			ParamUtil.bindData(request, product, "product");
			
			product.update(tx.getConnection());
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
				
				Product product = new Product();
				product.setId(id);
				product.delete(tx.getConnection());
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