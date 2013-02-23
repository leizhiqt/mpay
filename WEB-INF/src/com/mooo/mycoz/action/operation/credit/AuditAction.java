package com.mooo.mycoz.action.operation.credit;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.CalendarUtils;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.dbobj.wineBranch.Client;
import com.mooo.mycoz.dbobj.wineBranch.ClientJob;
import com.mooo.mycoz.dbobj.wineBranch.ClientJobTrack;
import com.mooo.mycoz.dbobj.wineBranch.StoreUser;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;

public class AuditAction extends BaseSupport {

	private static Log log = LogFactory.getLog(AuditAction.class);

	public String list(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("list");
		Integer sessionId = ActionSession.getInteger(request,ActionSession.USER_SESSION_KEY);

		String value=null;
		try {
			Calendar now = Calendar.getInstance();
			
			String startDate = request.getParameter("StartDate");
			if(startDate==null){
				now.add(Calendar.YEAR, -1);
				startDate = CalendarUtils.dtformat(now.getTime());
			}
			request.setAttribute("StartDate", startDate);
			
			String endDate = request.getParameter("EndDate");
			if(endDate==null){
				now.add(Calendar.YEAR, 1);
				now.add(Calendar.DAY_OF_MONTH, 1);
				endDate = CalendarUtils.dtformat(now.getTime());
			}
			request.setAttribute("EndDate", endDate);
			
			MultiDBObject dbobject = new MultiDBObject();

			dbobject.addTable(Store.class, "store");
			dbobject.addTable(StoreUser.class, "storeUser");
			
			dbobject.setForeignKey("store", "id", "storeUser", "storeId");
			dbobject.setField("storeUser", "userId", sessionId);
			
			dbobject.setRetrieveField("store", "id");
			dbobject.setRetrieveField("store", "storeName");
			
			request.setAttribute("stores", dbobject.searchAndRetrieveList());
			
//			JobType jobType = new JobType();
//			jobType.setGreater("id", 0);
//			request.setAttribute("jobTypes", jobType.searchAndRetrieveList());

			dbobject = new MultiDBObject();

			dbobject.addTable(Client.class, "client");
			dbobject.addTable(ClientJob.class, "clientJob");
			dbobject.addTable(Store.class, "store");
			dbobject.addTable(ClientJobTrack.class, "clientJobTrack");
			dbobject.addTable(FinancialProduct.class, "financialProduct");
			dbobject.addTable(JobType.class, "jobType");
			dbobject.addTable(User.class, "user");

			dbobject.setForeignKey("clientJob", "clientId", "client", "id");
			dbobject.setForeignKey("clientJob", "financialProductId",
					"financialProduct", "id");
			dbobject.setForeignKey("clientJobTrack", "clientJobId",
					"clientJob", "id");
			dbobject.setForeignKey("clientJobTrack", "jobTypeId", "jobType",
					"id");
			dbobject.setForeignKey("clientJobTrack", "userId", "user", "id");
			dbobject.setForeignKey("clientJob", "storeId", "store", "id");

//			dbobject.setLessEqual(arg0, arg1, arg2);
//			dbobject.setGreaterEqual(arg0, arg1, arg2);(arg0, arg1, arg2);
			
			value = request.getParameter("jobNo");
			if(!StringUtils.isNull(value))
				dbobject.setLike("clientJob", "jobNo", value);
			
			value = request.getParameter("idNo");
			if(!StringUtils.isNull(value))
				dbobject.setLike("client", "idNo", value);
			
			value = request.getParameter("telephone");
			if(!StringUtils.isNull(value))
				dbobject.setLike("client", "telephone", value);
			
//			value = request.getParameter("jobTypeId");
//			if(!StringUtils.isNull(value))
//				dbobject.setField("jobType", "id", new Integer(value));
			
			value = request.getParameter("storeId");
			if(!StringUtils.isNull(value))
				dbobject.setField("clientJob", "storeId", new Integer(value));
			
			value = request.getParameter("storeId");
			if(!StringUtils.isNull(value))
				dbobject.setField("clientJob", "storeId", new Integer(value));
			
			if(!StringUtils.isNull(startDate))
				dbobject.setGreaterEqual("clientJobTrack", "jobDate", startDate);
			
			if(!StringUtils.isNull(endDate))
				dbobject.setLessEqual("clientJobTrack", "jobDate", endDate);
			
			dbobject.setField("clientJobTrack", "processId", 0);
			dbobject.setField("jobType", "id", 1);
			
			dbobject.setRetrieveField("client", "id");
			dbobject.setRetrieveField("client", "idNo");
			dbobject.setRetrieveField("client", "clientName");
			
			dbobject.setRetrieveField("clientJob", "id");
			dbobject.setRetrieveField("clientJob", "totalPrice");
			dbobject.setRetrieveField("clientJob", "selfAmount");
			dbobject.setRetrieveField("clientJob", "monthOfPay");
			dbobject.setRetrieveField("clientJob", "jobNo");
			dbobject.setRetrieveField("clientJobTrack", "jobDate");
			dbobject.setRetrieveField("clientJobTrack", "jobRemark");
			dbobject.setRetrieveField("user", "name");
			dbobject.setRetrieveField("jobType", "jobKey");
			dbobject.setRetrieveField("jobType", "nextState");
			dbobject.setRetrieveField("financialProduct", "cycleTotal");
			dbobject.setRetrieveField("store", "storeName");
			
			dbobject.setOrderBy("clientJobTrack", "jobDate","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			request.setAttribute("clients", dbobject.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		return "success";
	}
}
