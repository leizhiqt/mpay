package com.mooo.mycoz.action.operation.credit;

import java.io.File;
import java.sql.SQLException;
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
import com.mooo.mycoz.dbobj.wineBranch.ClientJobTrack;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.dbobj.wineShared.Product;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.UploadFile;
import com.mooo.mycoz.framework.util.IDGenerator;

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
			if (!StringUtils.isNull(value))
				salePrice = new Double(value);

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

			if (products != null) {
				request.setAttribute("cproducts", products);

				FinancialProduct FinancialProduct = null;
				List fProucts = new ArrayList();

				for (int i = 0; i < products.length; i++) {

					FinancialProduct financialProduct = new FinancialProduct();
					financialProduct.setProductId(new Integer(products[i]));

					List<?> financials = financialProduct.searchAndRetrieveList();
					
					for(Object obj:financials){
						financialProduct = (FinancialProduct)obj;
						
						Map<String, Object> rowm = new LinkedHashMap();

						creditAmount = salePrice - onePay;
						int monthPay1 = 0;
						// 乘以税率后的总钱数
						double afterCalculetedTotals = creditAmount
								* (financialProduct.getCreditRate() + 1);
						// 每月支付钱数
						monthPay1 = (int) (afterCalculetedTotals / financialProduct
								.getCycleTotal());

						rowm.put("finName", financialProduct.getFinancialName());
						rowm.put("cycleTotal", financialProduct.getCycleTotal());
						rowm.put("monthPay", monthPay1);
						// 首月支付钱数(小数后3位)
						java.text.DecimalFormat df = new java.text.DecimalFormat(
								"#.###");
						double d = afterCalculetedTotals
								- (financialProduct.getCycleTotal() - 1)
								* monthPay1;
						rowm.put("firstPay", df.format(d));
						rowm.put("creditAmount", creditAmount);
						rowm.put("pId", financialProduct.getId());
						fProucts.add(rowm);
					}
				}
				request.setAttribute("fProucts", fProucts);
			}

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

			dbobject.setField("clientJobTrack", "processId", 0);

			dbobject.setRetrieveField("client", "id");
			dbobject.setRetrieveField("client", "idNo");
			dbobject.setRetrieveField("client", "clientName");
			
			dbobject.setRetrieveField("clientJob", "id");
			dbobject.setRetrieveField("clientJob", "creditAmount");
			dbobject.setRetrieveField("clientJob", "totalPrice");
			dbobject.setRetrieveField("clientJob", "selfAmount");
			dbobject.setRetrieveField("clientJob", "firstpayAmount");
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

			int monthPay1 = (int) (creditAmount
					* (1 + financialProduct.getCreditRate()) / financialProduct
					.getCycleTotal());
			//处理小数位数
			java.text.DecimalFormat df = new java.text.DecimalFormat(
					"#.###");
			double monthPay = creditAmount
					* (1 + financialProduct.getCreditRate())
					- (financialProduct.getCycleTotal() - 1) * monthPay1;

			request.setAttribute("creditAmount", creditAmount);
			// 每月支付
			request.setAttribute("monthPay1", monthPay1);
			// 首次支付
			request.setAttribute("monthPay", df.format(monthPay));

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
			// ParamUtil.bindData(request, censusAddressBook,
			// "censusAddressBook");
			int censusAddressBookId = IDGenerator.getNextID(tx.getConnection(),
					AddressBook.class);
			censusAddressBook.setId(censusAddressBookId);
			censusAddressBook.setBranchId(branchId);
			censusAddressBook.add(tx.getConnection());
			// 处理现居地址
			AddressBook livingAddressBook = new AddressBook();
			// ParamUtil.bindData(request, livingAddressBook,
			// "livingAddressBook");
			uf.bindData(livingAddressBook, "livingAddressBook");
			int livingAddressBookId = IDGenerator.getNextID(tx.getConnection(),
					AddressBook.class);
			livingAddressBook.setId(livingAddressBookId);
			livingAddressBook.setBranchId(branchId);

			livingAddressBook.add(tx.getConnection());
			// 处理家庭成員地址
			AddressBook homeAddressBook = new AddressBook();
			// ParamUtil.bindData(request, homeAddressBook, "homeAddressBook");
			uf.bindData(homeAddressBook, "homeAddressBook");
			int homeAddressBookId = IDGenerator.getNextID(tx.getConnection(),
					AddressBook.class);
			homeAddressBook.setId(homeAddressBookId);
			homeAddressBook.setBranchId(branchId);
			homeAddressBook.add(tx.getConnection());
			// 处理单位地址
			AddressBook officeAddressBook = new AddressBook();
			// ParamUtil.bindData(request, homeAddressBook,
			// "officeAddressBook");
			uf.bindData(officeAddressBook, "officeAddressBook");

			int officeAddressBookId = IDGenerator.getNextID(tx.getConnection(),
					AddressBook.class);
			officeAddressBook.setId(officeAddressBookId);
			officeAddressBook.setBranchId(branchId);
			officeAddressBook.add(tx.getConnection());
			// 处理基本信息
			Client client = new Client();

			int clientId = IDGenerator.getNextID(tx.getConnection(),
					Client.class);

			// ParamUtil.bindData(request, client, "client");
			uf.bindData(client, "client");
			request.setAttribute("client",client );

			client.setId(clientId);
			client.setLivingAddressBookId(livingAddressBookId);
			client.setOfficeAddressBookId(officeAddressBookId);
			client.setHomeAddressBookId(homeAddressBookId);
			client.setCensusAddressBookId(censusAddressBookId);
			client.setBranchId(branchId);
			client.add(tx.getConnection());

			// 处理文件图片
			for (int i = 0; i < pictureName.length; i++) {
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

			ClientJob clientJob = new ClientJob();
			uf.bindData(clientJob, "clientJob");

			int clientJobId = IDGenerator.getNextID(tx.getConnection(),
					ClientJob.class);
			clientJob.setId(clientJobId);
			clientJob.setClientId(clientId);
			clientJob.setOProductId(0);
			clientJob.setTProductId(0);
			clientJob.setJobNo(IDGenerator.getSN(tx.getConnection(),
					ClientJob.class, "jobNo", IDGenerator.getBatchSN("GM", 6)));

			clientJob.setCreditAmount(clientJob.getTotalPrice()
					- clientJob.getSelfAmount());

			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(clientJob.getFinancialProductId());
			financialProduct.retrieve();

			int monthPay1 = 0;

			monthPay1 = (int) (clientJob.getCreditAmount() / financialProduct
					.getCycleTotal());

			clientJob.setFirstpayAmount(new Double(monthPay1));
			clientJob.setMonthOfPay(clientJob.getCreditAmount()
					- (financialProduct.getCycleTotal() - 1) * monthPay1);

			clientJob.setStoreId(1);
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
		} catch (SQLException e) {
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
			
			Client client = new Client();
			client.setId(clientJob.getClientId());
			client.retrieve();
			request.setAttribute("client", client);
			
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

			
			/*
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

			dbobject.setField("clientJobTrack", "processId", 0);
			dbobject.setField("clientJob", "id",  Integer.parseInt(clientJobId));
			
			if (log.isDebugEnabled())
				log.debug("clientJobId:"+clientJobId);
			
			dbobject.setRetrieveField("client", "id");
			dbobject.setRetrieveField("client", "idNo");
			dbobject.setRetrieveField("client", "clientName");
			dbobject.setRetrieveField("client", "photoPath");
			dbobject.setRetrieveField("client", "idEndDate");
			dbobject.setRetrieveField("client", "idValidDate");
			dbobject.setRetrieveField("client", "idAuthority");
			dbobject.setRetrieveField("client", "otherNo");
			dbobject.setRetrieveField("client", "age");
			dbobject.setRetrieveField("client", "mobilePhone");
			dbobject.setRetrieveField("client", "mobileAddress");
			dbobject.setRetrieveField("client", "sex");
			dbobject.setRetrieveField("client", "marry");
			dbobject.setRetrieveField("client", "childs");
			dbobject.setRetrieveField("client", "housing");
			dbobject.setRetrieveField("client", "educationId");
			dbobject.setRetrieveField("client", "homePhoneName");
			dbobject.setRetrieveField("client", "homePhone");
			dbobject.setRetrieveField("client", "email");
			dbobject.setRetrieveField("client", "spuseName");
			dbobject.setRetrieveField("client", "spuseMobile");
			dbobject.setRetrieveField("client", "idSpuse");
			dbobject.setRetrieveField("client", "spuseHirer");
			dbobject.setRetrieveField("client", "spuseOfficePhone");
			dbobject.setRetrieveField("client", "spuseExtPhone");
			dbobject.setRetrieveField("client", "censusAddressBookId");
			dbobject.setRetrieveField("client", "livingAddressBookId");
			dbobject.setRetrieveField("client", "homeName");
			dbobject.setRetrieveField("client", "homeType");
			dbobject.setRetrieveField("client", "homeTelephone");
			dbobject.setRetrieveField("client", "homeAddressBookId");
			dbobject.setRetrieveField("client", "otherContacts");
			dbobject.setRetrieveField("client", "otherNexus");
			dbobject.setRetrieveField("client", "otherPhone");
			dbobject.setRetrieveField("client", "masterInMonth");			
			dbobject.setRetrieveField("client", "otherInMonth");
			dbobject.setRetrieveField("client", "homeInMonth");
			dbobject.setRetrieveField("client", "otherIncome");
			dbobject.setRetrieveField("client", "onShortName");
			dbobject.setRetrieveField("client", "onFullName");
			dbobject.setRetrieveField("client", "onDivision");
			dbobject.setRetrieveField("client", "onCompanyName");
			dbobject.setRetrieveField("client", "onWorkTime");
			dbobject.setRetrieveField("client", "onSector");
			dbobject.setRetrieveField("client", "onOffice");
			dbobject.setRetrieveField("client", "onFeature");
			dbobject.setRetrieveField("client", "onOfficePhone");
			dbobject.setRetrieveField("client", "onExtPhone");
			dbobject.setRetrieveField("client", "officeAddressBookId");
			dbobject.setRetrieveField("client", "financeName");
			dbobject.setRetrieveField("client", "branchId");
			dbobject.setRetrieveField("client", "selfAmount");
			dbobject.setRetrieveField("client", "selfAmount");
			dbobject.setRetrieveField("client", "selfAmount");
			dbobject.setRetrieveField("client", "selfAmount");
			
			dbobject.setRetrieveField("clientJob", "id");
			dbobject.setRetrieveField("clientJob", "creditAmount");
			dbobject.setRetrieveField("clientJob", "totalPrice");
			dbobject.setRetrieveField("clientJob", "selfAmount");
			dbobject.setRetrieveField("clientJob", "firstpayAmount");
			dbobject.setRetrieveField("clientJob", "monthOfPay");

			dbobject.setRetrieveField("clientJob", "jobNo");
			dbobject.setRetrieveField("clientJobTrack", "jobDate");
			dbobject.setRetrieveField("clientJobTrack", "jobRemark");
			dbobject.setRetrieveField("user", "name");
			dbobject.setRetrieveField("jobType", "nextState");
			dbobject.setRetrieveField("financialProduct", "cycleTotal");
*/
			if (log.isDebugEnabled())
				log.debug("clientJobId:"+clientJobId);
			
//			request.setAttribute("clients", dbobject.searchAndRetrieveList());
			
			if (log.isDebugEnabled())
				log.debug("clientJobId:"+clientJobId);
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
//			return "list";
		}
		return "success";
	}

	public String test(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processApproval");
		return "success";
	}
	
	public String processApproval(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processApproval");
		return "success";
	}
}
