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
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class StoreAction extends BaseSupport {

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
				System.out.println("ids    >>>>>"+ids[i]);
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
