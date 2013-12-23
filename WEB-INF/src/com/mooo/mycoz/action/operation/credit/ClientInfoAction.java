package com.mooo.mycoz.action.operation.credit;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.CalendarUtils;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.AddressBook;
import com.mooo.mycoz.dbobj.wineBranch.Client;
import com.mooo.mycoz.dbobj.wineBranch.ClientDoc;
import com.mooo.mycoz.dbobj.wineBranch.ClientJob;
import com.mooo.mycoz.dbobj.wineBranch.ClientJobCheck;
import com.mooo.mycoz.dbobj.wineBranch.ClientJobTrack;
import com.mooo.mycoz.dbobj.wineBranch.StoreUser;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.dbobj.wineShared.JobCheck;
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class ClientInfoAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ClientInfoAction.class);

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
			
			JobType jobType = new JobType();
			jobType.setGreater("id", 0);
			request.setAttribute("jobTypes", jobType.searchAndRetrieveList());

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
			
			value = request.getParameter("jobTypeId");
			if(!StringUtils.isNull(value))
				dbobject.setField("jobType", "id", new Integer(value));
			
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

	public String promptApproval(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptApproval");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

		String clientJobId=request.getParameter("id");
		String value = null;

		Transaction tx = null;
		try {
			tx = new Transaction();
			tx.start();
			
			if (log.isDebugEnabled())
				log.debug("clientJobId:"+clientJobId);
			
			if(clientJobId==null || clientJobId.equals("")){
				request.setAttribute("error", "请选择合同");
				return "list";
			}
			
			ClientJob clientJob = new ClientJob();
			clientJob.setId(new Integer(clientJobId));
			clientJob.retrieve();
			request.setAttribute("clientJob", clientJob);
			
			Client client = new Client();
			client.setId(clientJob.getClientId());
			client.retrieve();
			request.setAttribute("client", client);
			
			ClientDoc clientDoc = new ClientDoc();
			clientDoc.setClientId(client.getId());
			request.setAttribute("clientDocs", clientDoc.searchAndRetrieveList());
		
			//处理座机号在其他合同中出现
			MultiDBObject dbobject6 = new MultiDBObject();
			dbobject6.addTable(ClientJob.class,"clientJob" );
			dbobject6.addTable(Client.class,"client" );
			dbobject6.addCustomWhereClause("  client.id=clientJob.clientId and "
					+ "(client.homePhone='"+client.getHomePhone()+"' or"
					+ " client.onOfficePhone='"+client.getHomePhone()+"' or "
					+ " client.onExtPhone='"+client.getOnOfficePhone()+"' or "
					+ " client.onExtPhone='"+client.getHomePhone()+"')");
			dbobject6.setRetrieveField("clientJob","jobNo");
			dbobject6.setRetrieveField("clientJob","id");
			request.setAttribute("homePhoneNoList", dbobject6.searchAndRetrieveList());
			
			//带出身份证出现在其他合同(自己和配偶)
			MultiDBObject dbobject1 = new MultiDBObject();
			
			dbobject1.addTable(ClientJob.class,"clientJob" );
			dbobject1.addTable(Client.class,"client" );
		
			dbobject1.addCustomWhereClause("  client.id=clientJob.clientId and  client.id !="+client.getId()+"  and (client.idNo='"+client.getIdNo()+"' or"
					+ " client.idSpuse='"+client.getIdNo()+"')");
			dbobject1.setRetrieveField("clientJob","jobNo");
			dbobject1.setRetrieveField("clientJob","id");
			request.setAttribute("selfIdNoList", dbobject1.searchAndRetrieveList());
			
			MultiDBObject dbobject2 = new MultiDBObject();
			dbobject2.addTable(ClientJob.class,"clientJob" );
			dbobject2.addTable(Client.class,"client" );
			dbobject2.setForeignKey("clientJob", "clientId", "client", "id");
			dbobject2.addCustomWhereClause("  client.id=clientJob.clientId and (client.idNo='"+client.getIdSpuse()+"' or"
					+ " client.idSpuse='"+client.getIdSpuse()+"')");
			dbobject2.setRetrieveField("clientJob","jobNo");
			dbobject2.setRetrieveField("clientJob","id");
			request.setAttribute("spuseIdNoList", dbobject2.searchAndRetrieveList());
			//处理手机号
			MultiDBObject dbobject3 = new MultiDBObject();
			
			dbobject3.addTable(ClientJob.class,"clientJob" );
			dbobject3.addTable(Client.class,"client" );
			dbobject3.addCustomWhereClause("  client.id=clientJob.clientId and (client.telePhone='"+client.getMobilePhone()+"' or"
					+ " client.spuseMobile='"+client.getMobilePhone()+"')");
			dbobject3.setRetrieveField("clientJob","jobNo");
			dbobject3.setRetrieveField("clientJob","id");
			request.setAttribute("selfPhoneList", dbobject3.searchAndRetrieveList());
			
			MultiDBObject dbobject4 = new MultiDBObject();
			dbobject4.addTable(ClientJob.class,"clientJob" );
			dbobject4.addTable(Client.class,"client" );
			dbobject4.setForeignKey("clientJob", "clientId", "client", "id");
			dbobject4.addCustomWhereClause("   (client.telePhone='"+client.getSpuseMobile()+"' or"
					+ " client.spuseMobile='"+client.getSpuseMobile()+"')");
			dbobject4.setRetrieveField("clientJob","jobNo");
			dbobject4.setRetrieveField("clientJob","id");
			request.setAttribute("spusePhoneNoList", dbobject4.searchAndRetrieveList());
			
			ClientJobTrack clientJobTrack = new ClientJobTrack();
			clientJobTrack.setClientJobId(clientJob.getId());
			clientJobTrack.setProcessId(0);
			clientJobTrack.setJobTypeId(2);
			
			if(clientJobTrack.count()>0){
				clientJobTrack.retrieve();

				MultiDBObject dbobject = new MultiDBObject();
	
				dbobject.addTable(ClientJobCheck.class, "clientJobCheck");
				dbobject.addTable(JobCheck.class, "jobCheck");
				dbobject.setForeignKey("clientJobCheck", "jobCheckId", "jobCheck", "id");
				dbobject.setField("clientJobCheck", "jobTrackId",clientJobTrack.getId());
				
				dbobject.setRetrieveField("jobCheck", "checkType");
				dbobject.setRetrieveField("jobCheck", "checkName");
				dbobject.setRetrieveField("clientJobCheck", "checkRemark");
	
				request.setAttribute("jobChecks", dbobject.searchAndRetrieveList());
			}
			
			AddressBook censusAddressBook =new AddressBook();
			censusAddressBook.setId(client.getCensusAddressBookId());
			censusAddressBook.retrieve();
			request.setAttribute("censusAddressBook", censusAddressBook);
			
			AddressBook homeAddressBook =new AddressBook();
			homeAddressBook.setId(client.getHomeAddressBookId());
			homeAddressBook.retrieve();
			request.setAttribute("homeAddressBook", homeAddressBook);
			
			AddressBook officeAddressBook =new AddressBook();
			officeAddressBook.setId(client.getOfficeAddressBookId());
			officeAddressBook.retrieve();
			request.setAttribute("officeAddressBook", officeAddressBook);

			AddressBook livingAddressBook =new AddressBook();
			livingAddressBook.setId(client.getLivingAddressBookId());
			livingAddressBook.retrieve();
			request.setAttribute("livingAddressBook", livingAddressBook);

			//金融产品
			FinancialProduct financialProduct=new FinancialProduct();
			financialProduct.setId(clientJob.getFinancialProductId());
			financialProduct.retrieve();
			request.setAttribute("financialProduct", financialProduct);
			
			JobType jobType = new JobType();
			jobType.setJobCategory("A");
			jobType.setNotEqual("jobKey", "W");
			
			request.setAttribute("jobTypes",jobType.searchAndRetrieveList());
			
			JobCheck jobCheck = new JobCheck();
			jobCheck.setJobCategory("A");
			jobCheck.addGroupBy("checkType");
			request.setAttribute("checkTypes", jobCheck.searchAndRetrieveList());
			
			JobCheck checkName = new JobCheck();
			checkName.setJobCategory("A");
			value = request.getParameter("checkType");
			if( !StringUtils.isNull(value) ){
				checkName.setCheckType(value);
			}
			request.setAttribute("checkNames",checkName.searchAndRetrieveList());
			
			if (log.isDebugEnabled())
				log.debug("clientJobId:"+clientJobId);
			
			//审核中状态处理
			
			clientJobTrack = new ClientJobTrack();
			clientJobTrack.setClientJobId(clientJob.getId());
			clientJobTrack.setProcessId(0);
			clientJobTrack.setJobTypeId(2);
			
			int checkCount = clientJobTrack.count(tx.getConnection());
			
			if(checkCount < 1 ){
				ClientJobTrack orgTrack = new ClientJobTrack();
				orgTrack.setClientJobId(clientJob.getId());
				int jobCount = orgTrack.count(tx.getConnection());
				
				orgTrack.setProcessId(0);
				orgTrack.retrieve(tx.getConnection());
				
				orgTrack.setProcessId(jobCount);
				orgTrack.update(tx.getConnection());
				
				clientJobTrack = new ClientJobTrack();
				clientJobTrack.setId(IDGenerator.getNextID(tx.getConnection(), ClientJobTrack.class));
				clientJobTrack.setUserId(sessionId);
				clientJobTrack.setJobDate(new Date());
				clientJobTrack.setJobRemark(orgTrack.getJobRemark());
				clientJobTrack.setProcessId(0);
				clientJobTrack.setClientJobId(clientJob.getId());
				clientJobTrack.setJobTypeId(2);
				clientJobTrack.add(tx.getConnection());
			}
			
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
	
			return "promptApproval";
		} finally {
			tx.end();
		}
		return "success";
	}

	public String processAddCheck(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processAddCheck");

		String clientJobId=request.getParameter("id");
		try {
			
			if (log.isDebugEnabled())
				log.debug("clientJobId:"+clientJobId);
			
			if(clientJobId==null || clientJobId.equals("")){
				throw new Exception("请选择合同");
			}
			
			ClientJob clientJob = new ClientJob();
			clientJob.setId(new Integer(clientJobId));
			clientJob.retrieve();
			request.setAttribute("clientJob", clientJob);
			
			ClientJobTrack clientJobTrack = new ClientJobTrack();
			clientJobTrack.setClientJobId(new Integer(clientJobId));
			clientJobTrack.setProcessId(0);
			clientJobTrack.setJobTypeId(2);
			
			int checkCount = clientJobTrack.count();
			int nextId=0;
			
			if(checkCount>0){
				clientJobTrack.retrieve();
				
				nextId = IDGenerator.getNextInt(ClientJobCheck.class);
				ClientJobCheck clientJobCheck = new ClientJobCheck();
				ParamUtil.bindData(request, clientJobCheck, "clientJobCheck");
				
				clientJobCheck.setId(nextId);
				clientJobCheck.setJobTrackId(clientJobTrack.getId());
				clientJobCheck.add();
			}
			
			if (log.isDebugEnabled())
				log.debug("clientJobId:"+clientJobId);
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		return "promptApproval";
	}
	
	public String processApproval(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processApproval");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

		String clientJobId=request.getParameter("id");
		Transaction tx = null;
		try {
				tx = new Transaction();
				tx.start();
				
				if (log.isDebugEnabled())
					log.debug("clientJobId:"+clientJobId);
				
				if(clientJobId==null || clientJobId.equals("")){
					throw new Exception("请选择合同");
				}
				
				ClientJob clientJob = new ClientJob();
				clientJob.setId(new Integer(clientJobId));
				clientJob.retrieve(tx.getConnection());
				request.setAttribute("clientJob", clientJob);
				
				ClientJobTrack clientJobTrack = new ClientJobTrack();
				clientJobTrack.setClientJobId(new Integer(clientJobId));
				clientJobTrack.setProcessId(0);
				clientJobTrack.setJobTypeId(2);
				
				int checkCount = clientJobTrack.count(tx.getConnection());
				if(checkCount > 0 ){
					ClientJobTrack orgTrack = new ClientJobTrack();
					orgTrack.setClientJobId(new Integer(clientJobId));
					int jobCount = orgTrack.count(tx.getConnection());
					
					orgTrack.setProcessId(0);
					orgTrack.retrieve();
					
					orgTrack.setProcessId(jobCount);
					orgTrack.update(tx.getConnection());
					
					clientJobTrack.retrieve();
					ParamUtil.bindData(request, clientJobTrack, "clientJobTrack");
					
					clientJobTrack.setId(IDGenerator.getNextID(tx.getConnection(), ClientJobTrack.class));
					clientJobTrack.setUserId(sessionId);
					clientJobTrack.setJobDate(new Date());
					clientJobTrack.setProcessId(0);
					clientJobTrack.add(tx.getConnection());
				}
				tx.commit();
			} catch (Exception e) {
				e.printStackTrace();
				tx.rollback();
				if (log.isDebugEnabled())
					log.debug("Exception Load error of: " + e.getMessage());
				request.setAttribute("error", e.getMessage());
		
				return "promptApproval";
			} finally {
				tx.end();
			}
		return "list";
	}
	
}
