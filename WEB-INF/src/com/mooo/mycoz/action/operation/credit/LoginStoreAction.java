package com.mooo.mycoz.action.operation.credit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.StoreUser;
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.util.ParamUtil;

public class LoginStoreAction extends BaseSupport {

	private static Log log = LogFactory.getLog(LoginStoreAction.class);

	public String promptLogin(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled()) log.debug("promptLogin");
		Integer sessionId = ActionSession.getInteger(request,ActionSession.USER_SESSION_KEY);
		try {
			StoreUser storeUser = new StoreUser();
			storeUser.setUserId(sessionId);
			storeUser.setActive("Y");
			int ecount = storeUser.count();
			
			if(ecount>0){
				storeUser.retrieve();
				request.setAttribute("storeUser", storeUser);
				
				Store store = new Store();
				store.setId(storeUser.getStoreId());
				store.retrieve();
				request.setAttribute("store", store);
			}
			
			MultiDBObject dbobject = new MultiDBObject();

			dbobject.addTable(Store.class, "store");
			dbobject.addTable(StoreUser.class, "storeUser");
			
			dbobject.setForeignKey("store", "id", "storeUser", "storeId");
			dbobject.setField("storeUser", "userId", sessionId);
			
			dbobject.setRetrieveField("storeUser", "id");
			dbobject.setRetrieveField("store", "storeName");
			
			request.setAttribute("stores", dbobject.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}

	public String processLogin(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled()) log.debug("processLogin");

		Integer sessionId = ActionSession.getInteger(request,ActionSession.USER_SESSION_KEY);

		Transaction tx = null;
		try {
			tx = new Transaction();
			tx.start();

			StoreUser storeUser = new StoreUser();
			storeUser.setUserId(sessionId);
			storeUser.setActive("Y");

			int ecount = storeUser.count();
			
			if(ecount>0){
				storeUser.retrieve(tx.getConnection());
				storeUser.setActive("N");
				storeUser.update(tx.getConnection());
			}
			
			storeUser = new StoreUser();
			ParamUtil.bindData(request, storeUser,"storeUser");
			storeUser.setActive("Y");
			
			storeUser.update(tx.getConnection());
			
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "promptLogin";
	}
}
