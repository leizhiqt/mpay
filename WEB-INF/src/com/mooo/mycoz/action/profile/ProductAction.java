package com.mooo.mycoz.action.profile;

import java.util.List;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.Product;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;


public class ProductAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ProductAction.class);
	
	public String listProduct(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(Product.class, "product");

			dbobject.setForeignKey("winery", "id","product", "enterpriseId");
			
			value = request.getParameter("wineryId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("winery", "id", new Integer(value));
			}
			
			value = request.getParameter("styleName");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("product", "styleName", value);
			}
			
			value = request.getParameter("styleNumber");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("product", "styleNumber", value);
			}
			
			value = request.getParameter("flavor");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("product", "flavor", value);
			}
			
			
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("product", "id");
			dbobject.setRetrieveField("product", "productCode");
			dbobject.setRetrieveField("product", "productName");
			dbobject.setRetrieveField("product", "alcohol");
			dbobject.setRetrieveField("product", "material");
			dbobject.setRetrieveField("product", "flavor");
			dbobject.setRetrieveField("product", "createDate");
			dbobject.setRetrieveField("product", "fermentDays");

			dbobject.setOrderBy("product", "id","DESC");
			
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
			
			Product product = new Product();
			ParamUtil.bindData(request, product,"product");
			
			int productId = IDGenerator.getNextID(tx.getConnection(),Product.class);
			product.setId(productId);
			product.setCreateDate(new Date());
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
		return "listProduct";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String productId = null;
		try{
			productId = request.getParameter("id");
			if(productId==null)
				throw new Exception("Please chose object");
			
			Product product = new Product();
			product.setId(new Integer(productId));
			product.retrieve();

			request.setAttribute("product", product);
			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));
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
		return "listProduct";
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
		return "listProduct";
	}
	
}