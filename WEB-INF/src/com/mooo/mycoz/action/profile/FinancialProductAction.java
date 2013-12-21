package com.mooo.mycoz.action.profile;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

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

			request.setAttribute("financialProduct", financialProduct);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
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
				
				FinancialProduct financialProduct = new FinancialProduct();
				financialProduct.setId(id);
				financialProduct.delete(tx.getConnection());
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
