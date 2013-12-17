package com.mooo.mycoz.action.operation.credit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.dbobj.wineShared.Product;

public class ClientInfoAction extends BaseSupport {

private static Log log = LogFactory.getLog(ClientInfoAction.class);


	public String promptDeclare(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptDeclare");
		String value=null;
		
		try {
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(Product.class, "product");
			dbobject.addTable(FinancialProduct.class, "financialProduct");
			
			dbobject.setForeignKey("financialProduct", "productId", "product", "id");
			
			dbobject.setRetrieveField("product", "id");
			dbobject.setRetrieveField("product", "productName");

			request.setAttribute("products",dbobject.searchAndRetrieveList());
			
			double salePirce=0d;
			double onePay=0d;
			
			value=request.getParameter("salePirce");
			if(!StringUtils.isNull(value))
				salePirce = new Double(value);
			
			request.setAttribute("salePirce",value);

			value=request.getParameter("onePay");
			
			if(!StringUtils.isNull(value))
				onePay = new Double(value);
			
			request.setAttribute("onePay",value);

			if(onePay>=salePirce && salePirce>0 )
				throw new Exception("首付过多");
			
			if(onePay/salePirce<0.10)
				throw new Exception("首付不足");
			
			String[] products =  request.getParameterValues("product");
			
			if(products!=null){
				FinancialProduct financialProduct=null;
				for(int i=0;i<products.length;i++){
					financialProduct = new FinancialProduct();
					financialProduct.setProductId(new Integer(products[i]));
					financialProduct.retrieve();
					
				}
			}

		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		return "success";
	}
	
	public String list(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("list");
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		return "listCard";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		return "list";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		return "success";
	}

}
