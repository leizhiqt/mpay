package com.mooo.mycoz.action.operation.credit;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.AddressBook;
import com.mooo.mycoz.dbobj.wineBranch.Client;
import com.mooo.mycoz.dbobj.wineBranch.ClientDoc;
import com.mooo.mycoz.dbobj.wineBranch.ClientJob;
import com.mooo.mycoz.dbobj.wineBranch.ClientJobCheck;
import com.mooo.mycoz.dbobj.wineBranch.ClientJobTrack;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.dbobj.wineShared.JobCheck;
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.dbobj.wineShared.Product;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.UploadFile;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class ClientInfoAction extends BaseSupport {

	private static Log log = LogFactory.getLog(ClientInfoAction.class);

	public String promptDeclare(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptDeclare");

		String value = null;

		try {
			MultiDBObject dbobject = new MultiDBObject();

			dbobject.addTable(Product.class, "product");

			dbobject.setRetrieveField("product", "id");
			dbobject.setRetrieveField("product", "productName");

			request.setAttribute("products", dbobject.searchAndRetrieveList());

			double salePrice = 0d;
			double onePay = 0d;
			double monthPay = 0d, creditAmount = 0d;

			double onePayPercent = 0d;

			value = request.getParameter("salePrice");
			//处理首次进入
			if(StringUtils.isNull(value)){
				return "success";
			}
			if (!StringUtils.isNull(value)){
				salePrice = new Double(value);
			}
			request.setAttribute("salePrice", value);

			value = request.getParameter("onePay");

			if (!StringUtils.isNull(value))
				onePay = new Double(value);

			request.setAttribute("onePay", value);

			if (onePay >= salePrice && salePrice > 0)
				throw new Exception("首付过多");

			onePayPercent = onePay / salePrice;
			request.setAttribute("onePayPercent", onePayPercent);

			if (onePayPercent < 0.2)
				throw new Exception("首付不足");

			String[] products = request.getParameterValues("product");

			
				FinancialProduct FinancialProduct = null;
				List fProucts = new ArrayList();

				
					FinancialProduct financialProduct = new FinancialProduct();
					//financialProduct.getFinancialMax()
					//financialProduct.setProductId(new Integer(products[i]));
					financialProduct.setGreaterEqual("financialMax", salePrice-onePay);
					List<?> financials = financialProduct.searchAndRetrieveList();
					
					for(Object obj:financials){
						financialProduct = (FinancialProduct)obj;
						
						Map<String, Object> rowm = new LinkedHashMap();

						creditAmount = salePrice - onePay;
						double monthPay1 = 0;
						// 乘以税率后的总钱数
						double afterCalculetedTotals = creditAmount
								* (financialProduct.getCreditRate() + 1);
						// 每月支付钱数
						monthPay1 =  (afterCalculetedTotals / financialProduct
								.getCycleTotal());
						
						//取整加1
						int monthPay1Int=(int)monthPay1;
						if(monthPay1-monthPay1Int>0){
							monthPay1Int++;
						}
						rowm.put("finName", financialProduct.getFinancialName());
						rowm.put("cycleTotal", financialProduct.getCycleTotal());
						rowm.put("monthPay", monthPay1Int);
						
						
						double d = afterCalculetedTotals
								- (financialProduct.getCycleTotal() - 1)
								* monthPay1;
						//rowm.put("firstPay", df.format(d));
						rowm.put("creditAmount", creditAmount);
						rowm.put("onePay", onePay);
						rowm.put("pId", financialProduct.getId());
						fProucts.add(rowm);
					}
				
				request.setAttribute("fProucts", fProucts);
			

		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		return "success";
	}

	public String list(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("list");
		try {
			MultiDBObject dbobject = new MultiDBObject();

			dbobject.addTable(Client.class, "client");
			dbobject.addTable(ClientJob.class, "clientJob");
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
//
//			dbobject.setLessEqual(arg0, arg1, arg2);
//			dbobject.setGreaterEqual(arg0, arg1, arg2);(arg0, arg1, arg2);

			
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
			dbobject.setRetrieveField("jobType", "nextState");
			dbobject.setRetrieveField("financialProduct", "cycleTotal");

			request.setAttribute("clients", dbobject.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		return "success";
	}

	public String promptAdd(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptAdd");
		String value = null;
		try {
			value = request.getParameter("pId");
			request.setAttribute("pId", value);

			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(new Integer(value));
			financialProduct.retrieve();

			request.setAttribute("financialProduct", financialProduct);

			request.setAttribute("salePrice", request.getParameter("salePrice"));
			if (log.isDebugEnabled())
				log.debug("salePrice:" + request.getParameter("salePrice"));

			request.setAttribute("onePay", request.getParameter("onePay"));

			double totailPrice = 0d;
			double firstPayAmount = 0d;
			double creditAmount = 0d;

			value = request.getParameter("salePrice");
			totailPrice = new Double(value);

			value = request.getParameter("onePay");
			firstPayAmount = new Double(value);

			creditAmount = totailPrice - firstPayAmount;

			
			double monthPay = creditAmount
					* (1 + financialProduct.getCreditRate())
					/financialProduct.getCycleTotal() ;
			
			
			
			
			//取整加1
			int monthPay1Int=(int)monthPay;
			if(monthPay-monthPay1Int>0){
				monthPay1Int++;
			}
			request.setAttribute("creditAmount", creditAmount);
			// 每月支付
			request.setAttribute("monthPay1", monthPay1Int);
		
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}

	public String processAdd(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processAdd");
		Integer branchId = ActionSession.getInteger(request,
				ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request,
				ActionSession.USER_SESSION_KEY);

		Transaction tx = null;
		try {
			tx = new Transaction();
			tx.start();

			// sub path
			String sPath = "upload/images/";
			// physical path
			String pPath = request.getSession().getServletContext()
					.getRealPath("/");
			// upload path
			String uPath = pPath + sPath;
			if (log.isDebugEnabled())
				log.debug("uploadPath=" + uPath);

			File upFile = new File(uPath);
			if (!upFile.exists())
				upFile.mkdirs();

			UploadFile uf = new UploadFile();
			uf.setRequest(request);
			uf.setUploadPath(uPath);
			uf.process();

			String[] pictureName = uf.getUpdFileNames();

			// 处理户籍地址
			AddressBook censusAddressBook = new AddressBook();
			uf.bindData(censusAddressBook, "censusAddressBook");
			request.setAttribute("censusAddressBook",censusAddressBook );

			Client client = new Client();
			uf.bindData(client, "client");
			request.setAttribute("client",client );
			
			AddressBook livingAddressBook = new AddressBook();
			uf.bindData(livingAddressBook, "livingAddressBook");
			request.setAttribute("livingAddressBook",livingAddressBook );
			
			AddressBook homeAddressBook = new AddressBook();
			uf.bindData(homeAddressBook, "homeAddressBook");
			request.setAttribute("homeAddressBook",homeAddressBook );
			
			AddressBook officeAddressBook = new AddressBook();
			uf.bindData(officeAddressBook, "officeAddressBook");
			request.setAttribute("officeAddressBook",officeAddressBook );
			
			ClientJob clientJob = new ClientJob();
			uf.bindData(clientJob, "clientJob");
			request.setAttribute("clientJob",clientJob );
			
			StringUtils.notEmpty(client.getIdNo());
			StringUtils.notEmpty(client.getClientName());

			int censusAddressBookId = IDGenerator.getNextID(tx.getConnection(),
					AddressBook.class);
			censusAddressBook.setId(censusAddressBookId);
			censusAddressBook.setBranchId(branchId);
			censusAddressBook.add(tx.getConnection());
			// 处理现居地址
			int livingAddressBookId = IDGenerator.getNextID(tx.getConnection(),
					AddressBook.class);
			livingAddressBook.setId(livingAddressBookId);
			livingAddressBook.setBranchId(branchId);

			livingAddressBook.add(tx.getConnection());
			// 处理家庭成員地址
			int homeAddressBookId = IDGenerator.getNextID(tx.getConnection(),
					AddressBook.class);
			homeAddressBook.setId(homeAddressBookId);
			homeAddressBook.setBranchId(branchId);
			homeAddressBook.add(tx.getConnection());
			
			// 处理单位地址
			int officeAddressBookId = IDGenerator.getNextID(tx.getConnection(),
					AddressBook.class);
			officeAddressBook.setId(officeAddressBookId);
			officeAddressBook.setBranchId(branchId);
			officeAddressBook.add(tx.getConnection());
			
			// 处理基本信息
			int clientId = IDGenerator.getNextID(tx.getConnection(),
					Client.class);
			client.setId(clientId);
			client.setLivingAddressBookId(livingAddressBookId);
			client.setOfficeAddressBookId(officeAddressBookId);
			client.setHomeAddressBookId(homeAddressBookId);
			client.setCensusAddressBookId(censusAddressBookId);
			client.setBranchId(branchId);
			if(pictureName!=null && pictureName.length>0 )
				client.setPhotoPath(sPath + pictureName[0]);

			client.add(tx.getConnection());

			// 处理文件图片
			for (int i = 1; i < pictureName.length; i++) {
				System.out.println("pictureName" + pictureName[i]);
				
				ClientDoc clientDoc = new ClientDoc();
				int clientDocId = IDGenerator.getNextID(tx.getConnection(),
						ClientDoc.class);
				clientDoc.setClientId(clientId);
				clientDoc.setDocTypeId(1);
				clientDoc.setFilepath(sPath + pictureName[i]);
				clientDoc.setId(clientDocId);
				clientDoc.add(tx.getConnection());
			}

			int clientJobId = IDGenerator.getNextID(tx.getConnection(),
					ClientJob.class);
			clientJob.setId(clientJobId);
			clientJob.setClientId(clientId);
		//	clientJob.setOProductId(0);
		//	clientJob.setTProductId(0);
			clientJob.setJobNo(IDGenerator.getSN(tx.getConnection(),
				ClientJob.class, "jobNo", IDGenerator.getBatchSN("GM", 6)));

			//clientJob.setCreditAmount(clientJob.getTotalPrice()
		//			- clientJob.getSelfAmount());

			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(clientJob.getFinancialProductId());
			financialProduct.retrieve();

//			int monthPay1 = 0;

//			monthPay1 = (int) (clientJob.getCreditAmount() / financialProduct
//					.getCycleTotal());
//
//			clientJob.setFirstpayAmount(new Double(monthPay1));
//			clientJob.setMonthOfPay(clientJob.getCreditAmount()
//					- (financialProduct.getCycleTotal() - 1) * monthPay1);
			clientJob.setBranchId(branchId);
			clientJob.add(tx.getConnection());

			int clientJobTrackId = IDGenerator.getNextID(tx.getConnection(),
					ClientJobTrack.class);

			ClientJobTrack clientJobTrack = new ClientJobTrack();
			clientJobTrack.setId(clientJobTrackId);
			clientJobTrack.setClientJobId(clientJobId);
			clientJobTrack.setJobDate(new Date());
			clientJobTrack.setJobTypeId(1);
			clientJobTrack.setProcessId(0);
			clientJobTrack.setUserId(sessionId);
			clientJobTrack.setBranchId(branchId);
			clientJobTrack.add(tx.getConnection());
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptAdd";
		} finally {
			tx.end();
		}
		return "list";
	}

	public String processDelete(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processDelete");
		return "list";
	}

	public String promptEdit(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptEdit");
		return "success";
	}

	public String processEdit(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processEdit");
		//String clientJobId=request.getParameter(arg0);
		return "success";
	}

	public String promptApproval(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptApproval");
		String clientJobId=request.getParameter("id");
		
		String value = null;
		try {
			
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
		
			MultiDBObject dbobject5 = new MultiDBObject();
			
//			dbobject5.addTable(ClientJob.class,"clientJob" );
//			dbobject5.addTable(Client.class,"client" );
//		
//			dbobject5.addCustomWhereClause("  client.id=clientJob.clientId and (client.telePhone='"+client.get+"' or"
//					+ " client.spuseMobile='"+client.getTelePhone()+"')");
//			dbobject5.setRetrieveField("clientJob","jobNo");
//			request.setAttribute("selfPhoneList", dbobject5.searchAndRetrieveList());
			
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
			clientJobTrack.setProcessId(-1);
			
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
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		return "success";
	}

	public String processAddCheck(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processAddCheck");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

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
			clientJobTrack.setProcessId(-1);
			
			int checkCount = clientJobTrack.count();
			int nextId=0;
			
			if(checkCount<1){
				nextId = IDGenerator.getNextInt(ClientJobTrack.class);
				clientJobTrack.setId(nextId);
				clientJobTrack.setUserId(sessionId);
				clientJobTrack.add();
			}else{
				clientJobTrack.retrieve();
			}
			
			nextId = IDGenerator.getNextInt(ClientJobCheck.class);
			ClientJobCheck clientJobCheck = new ClientJobCheck();
			ParamUtil.bindData(request, clientJobCheck, "clientJobCheck");
			
			clientJobCheck.setId(nextId);
			clientJobCheck.setJobTrackId(clientJobTrack.getId());
			clientJobCheck.add();
			
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
			clientJobTrack.setProcessId(-1);
			
			int checkCount = clientJobTrack.count();
			
			if(checkCount > 0 ){
				ClientJobTrack orgTrack = new ClientJobTrack();
				orgTrack.setClientJobId(new Integer(clientJobId));
				int jobCount = orgTrack.count();
				
				orgTrack.setProcessId(0);
				orgTrack.retrieve();
				
				orgTrack.setProcessId(jobCount);
				orgTrack.update();
				
				clientJobTrack.retrieve();
				ParamUtil.bindData(request, clientJobTrack, "clientJobTrack");
				clientJobTrack.setUserId(sessionId);
				clientJobTrack.setJobDate(new Date());
				clientJobTrack.setProcessId(0);
				clientJobTrack.update();
			}
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		return "list";
	}
	
}
