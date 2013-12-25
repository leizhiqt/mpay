package com.mooo.mycoz.action.operation.credit;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.CalendarUtils;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.AddressBook;
import com.mooo.mycoz.dbobj.wineBranch.Bank;
import com.mooo.mycoz.dbobj.wineBranch.Client;
import com.mooo.mycoz.dbobj.wineBranch.ClientDoc;
import com.mooo.mycoz.dbobj.wineBranch.ClientJob;
import com.mooo.mycoz.dbobj.wineBranch.ClientJobSale;
import com.mooo.mycoz.dbobj.wineBranch.ClientJobTrack;
import com.mooo.mycoz.dbobj.wineBranch.FinancialCategory;
import com.mooo.mycoz.dbobj.wineBranch.StoreProduct;
import com.mooo.mycoz.dbobj.wineBranch.StoreUser;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.dbobj.wineShared.Product;
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.dbobj.wineShared.StoreType;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.component.UploadFile;
import com.mooo.mycoz.framework.component.XSLTUtil;
import com.mooo.mycoz.framework.util.IDGenerator;

public class SaleAction extends BaseSupport {

	private static Log log = LogFactory.getLog(SaleAction.class);

	public String promptSale(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptDeclare");
		Integer sessionId = ActionSession.getInteger(request,
				ActionSession.USER_SESSION_KEY);

		// String value = null;

		try {
			StoreUser storeUser = new StoreUser();
			storeUser.setUserId(sessionId);
			storeUser.setActive("Y");

			int acount = storeUser.count();

			if (acount < 1)
				throw new Exception("请先登录店铺");

			storeUser.retrieve();

			MultiDBObject dbobject = new MultiDBObject();

			dbobject.addTable(Product.class, "product");
			dbobject.addTable(StoreProduct.class, "storeProduct");

			dbobject.setForeignKey("product", "id", "storeProduct", "productId");

			dbobject.setField("storeProduct", "storeId", storeUser.getStoreId());

			dbobject.setRetrieveField("product", "id");
			dbobject.setRetrieveField("product", "productName");

			request.setAttribute("products", dbobject.searchAndRetrieveList());

			String stPrice = request.getParameter("totalPrice");
			String ssAmount = request.getParameter("selfAmount");

			double totalPrice = 0d;
			double selfAmount = 0d;
			double creditAmount = 0d;

			double selfPercent = 0d;

			if (!StringUtils.isNull(stPrice)) {
				totalPrice = new Double(stPrice);
			}
			request.setAttribute("totalPrice", stPrice);

			if (!StringUtils.isNull(ssAmount))
				selfAmount = new Double(ssAmount);

			request.setAttribute("selfAmount", ssAmount);

			if (selfAmount >= totalPrice && totalPrice > 0)
				throw new Exception("首付过多");

			selfPercent = selfAmount / totalPrice;
			request.setAttribute("selfPercent", selfPercent);

			// if (selfPercent < 0.2)
			// throw new Exception("首付不足");

			creditAmount = totalPrice - selfAmount;

			String[] products = request.getParameterValues("product");

			if (products != null) {
				request.setAttribute("cproducts", products);

				List fProucts = new ArrayList();

				FinancialProduct financialProduct = new FinancialProduct();
				financialProduct.setGreaterEqual("financialMax", creditAmount);
				financialProduct.setLessEqual("financialMin", creditAmount);

				List<?> financials = financialProduct.searchAndRetrieveList();

				for (Object obj : financials) {
					financialProduct = (FinancialProduct) obj;

					Map<String, Object> rowm = new LinkedHashMap();

					double monthPay1 = 0;
					// 乘以税率后的总钱数
					double afterCalculetedTotals = creditAmount
							* (financialProduct.getChargeRate()
									+ financialProduct.getVouchRate()
									+ financialProduct.getNaturalRate() + 1);
					// 每月支付钱数
					monthPay1 = (afterCalculetedTotals / financialProduct
							.getCycleTotal());

					// 取整加1
					int monthPay1Int = (int) monthPay1;

					if (monthPay1 - monthPay1Int > 0) {
						monthPay1Int++;
					}

					rowm.put("finName", financialProduct.getFinancialName());
					rowm.put("cycleTotal", financialProduct.getCycleTotal());
					rowm.put("monthPay", monthPay1Int);
					rowm.put("creditAmount", creditAmount);
					rowm.put("selfAmount", selfAmount);
					rowm.put("pId", financialProduct.getId());

					fProucts.add(rowm);
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
		Integer sessionId = ActionSession.getInteger(request,
				ActionSession.USER_SESSION_KEY);

		String value = null;
		try {
			Calendar now = Calendar.getInstance();

			String startDate = request.getParameter("StartDate");
			if (startDate == null) {
				now.add(Calendar.YEAR, -1);
				startDate = CalendarUtils.dtformat(now.getTime());
			}
			request.setAttribute("StartDate", startDate);

			String endDate = request.getParameter("EndDate");
			if (endDate == null) {
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
			//
			// dbobject.setLessEqual(arg0, arg1, arg2);
			// dbobject.setGreaterEqual(arg0, arg1, arg2);(arg0, arg1, arg2);

			value = request.getParameter("jobNo");
			if (!StringUtils.isNull(value))
				dbobject.setLike("clientJob", "jobNo", value);

			value = request.getParameter("idNo");
			if (!StringUtils.isNull(value))
				dbobject.setLike("client", "idNo", value);

			value = request.getParameter("telephone");
			if (!StringUtils.isNull(value))
				dbobject.setLike("client", "telephone", value);

			value = request.getParameter("jobTypeId");
			if (!StringUtils.isNull(value))
				dbobject.setField("jobType", "id", new Integer(value));

			value = request.getParameter("storeId");
			if (!StringUtils.isNull(value))
				dbobject.setField("clientJob", "storeId", new Integer(value));

			if (!StringUtils.isNull(startDate))
				dbobject.setGreaterEqual("clientJob", "jobDate", startDate);

			if (!StringUtils.isNull(endDate))
				dbobject.setLessEqual("clientJob", "jobDate", endDate);

			dbobject.setField("clientJobTrack", "processId", 0);

			dbobject.setRetrieveField("client", "id");
			dbobject.setRetrieveField("client", "idNo");
			dbobject.setRetrieveField("client", "clientName");

			dbobject.setRetrieveField("clientJob", "id");
			dbobject.setRetrieveField("clientJob", "totalPrice");
			dbobject.setRetrieveField("clientJob", "selfAmount");
			dbobject.setRetrieveField("clientJob", "monthOfPay");
			dbobject.setRetrieveField("clientJob", "jobNo");
			dbobject.setRetrieveField("clientJob", "jobDate");
			dbobject.setRetrieveField("clientJobTrack", "jobDate");
			dbobject.setRetrieveField("clientJobTrack", "jobRemark");
			dbobject.setRetrieveField("user", "name");
			dbobject.setRetrieveField("jobType", "jobKey");
			dbobject.setRetrieveField("jobType", "nextState");
			dbobject.setRetrieveField("financialProduct", "cycleTotal");

			dbobject.setRetrieveField("store", "storeName");
			dbobject.setOrderBy("clientJob", "jobDate", "DESC");

			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List clients = dbobject.searchAndRetrieveList();
			for(Object orow:clients){
				Map rowm = (Map)orow;
				
				ClientJob clientJob = (ClientJob) rowm.get("clientJob");
				
				ClientJobTrack clientJobTrack = new ClientJobTrack();
				clientJobTrack.setClientJobId(clientJob.getId());
				clientJobTrack.setJobTypeId(1);
				clientJobTrack.retrieve();
				
				User user = new User();
				user.setId(clientJobTrack.getUserId());
				user.retrieve();
				
				rowm.put("seller", user.getName());
				
				
				clientJobTrack = new ClientJobTrack();
				clientJobTrack.setClientJobId(clientJob.getId());
				clientJobTrack.setProcessId(0);
				clientJobTrack.retrieve();
				
				rowm.put("nowJobTime", CalendarUtils.dtformat(clientJobTrack.getJobDate()));
			}
			
			request.setAttribute("clients", clients);
			

			dbobject.setRecord(page.getOffset(), page.getPageSize());

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
		try {

			String pId = request.getParameter("pId");
			String stPrice = request.getParameter("totalPrice");
			String ssAmount = request.getParameter("selfAmount");

			if (pId == null) {
				pId = (String) request.getAttribute("pId");
				stPrice = (String) request.getAttribute("totalPrice");
				ssAmount = (String) request.getAttribute("selfAmount");
			}

			request.setAttribute("pId", pId);
			request.setAttribute("totalPrice", stPrice);
			request.setAttribute("selfAmount", ssAmount);

			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(new Integer(pId));
			financialProduct.retrieve();

			request.setAttribute("financialProduct", financialProduct);

			double totalPrice = 0d;
			double selfAmount = 0d;
			double creditAmount = 0d;

			if (!StringUtils.isNull(stPrice))
				totalPrice = new Double(stPrice);

			if (!StringUtils.isNull(ssAmount))
				selfAmount = new Double(ssAmount);

			creditAmount = totalPrice - selfAmount;

			double monthPay = creditAmount
					* (1 + financialProduct.getChargeRate()
							+ financialProduct.getVouchRate() + financialProduct
								.getNaturalRate())
					/ financialProduct.getCycleTotal();

			// 取整加1
			int monthPay1Int = (int) monthPay;
			if (monthPay - monthPay1Int > 0) {
				monthPay1Int++;
			}
			request.setAttribute("creditAmount", creditAmount);
			// 每月支付
			request.setAttribute("monthPay1", monthPay1Int);

			Calendar now = Calendar.getInstance();
			// now.DAY_OF_MONTH;
			// int now.getActualMaximum(Calendar.DAY_OF_MONTH);

			// now.getActualMinimum(Calendar.DAY_OF_MONTH);

			Date monthOfDay = null;
			// int day = now.get(Calendar.DAY_OF_MONTH);

			now.add(Calendar.MONTH, +1);

			// int nextMonthDay = now.get(Calendar.DAY_OF_MONTH);

			//
			// if(day<=nextMonthDay){
			monthOfDay = now.getTime();
			// }else{
			// now.add(Calendar.DATE, -1);
			//
			// monthOfDay = now.getTime();
			// }
			// request.setAttribute("monthOfDay",
			// CalendarUtils.dformat(monthOfDay));
			request.setAttribute("monthOfDay", monthOfDay);

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
		String value = null;
		Transaction tx = null;
		try {
			tx = new Transaction();
			tx.start();

			StoreUser storeUser = new StoreUser();
			storeUser.setUserId(sessionId);
			storeUser.setActive("Y");

			int acount = storeUser.count();

			if (acount < 1)
				throw new Exception("请先登录店铺");

			storeUser.retrieve(tx.getConnection());

			Store store = new Store();
			store.setId(storeUser.getStoreId());
			store.retrieve(tx.getConnection());

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
			request.setAttribute("censusAddressBook", censusAddressBook);

			Client client = new Client();
			uf.bindData(client, "client");
			request.setAttribute("client", client);

			AddressBook livingAddressBook = new AddressBook();
			uf.bindData(livingAddressBook, "livingAddressBook");
			request.setAttribute("livingAddressBook", livingAddressBook);

			AddressBook homeAddressBook = new AddressBook();
			uf.bindData(homeAddressBook, "homeAddressBook");
			request.setAttribute("homeAddressBook", homeAddressBook);

			AddressBook officeAddressBook = new AddressBook();
			uf.bindData(officeAddressBook, "officeAddressBook");
			request.setAttribute("officeAddressBook", officeAddressBook);

			ClientJob clientJob = new ClientJob();
			uf.bindData(clientJob, "clientJob");
			request.setAttribute("clientJob", clientJob);

			request.setAttribute("pId", clientJob.getFinancialProductId() + "");
			request.setAttribute("totalPrice", clientJob.getTotalPrice() + "");
			request.setAttribute("selfAmount", clientJob.getSelfAmount() + "");

			Bank oBank = new Bank();
			uf.bindData(oBank, "oBank");
			request.setAttribute("oBank", oBank);

			Bank tBank = new Bank();
			tBank.setClientId(client.getId());
			uf.bindData(tBank, "tBank");
			request.setAttribute("tBank", tBank);

			ClientJobSale oSale = new ClientJobSale();
			uf.bindData(oSale, "oSale");
			request.setAttribute("oSale", oSale);

			ClientJobSale tSale = new ClientJobSale();
			uf.bindData(tSale, "tSale");
			request.setAttribute("tSale", tSale);

			// check
			if (pictureName == null || pictureName.length < 2) {
				throw new Exception("请上传头像或图片");
			}

			if (client.getAge() == null || client.getAge() == 0) {
				throw new Exception("请填写客户年龄");
			}
			if (StringUtils.isNull(client.getIdAuthority())) {
				throw new Exception("请填写发证机关");
			}
			if (StringUtils.isNull(client.getMobilePhone())) {
				throw new Exception("请填写本人手机号或格式错误");
			}
			if (StringUtils.isNull(client.getMobileAddress())) {
				throw new Exception("请填写手机号码归属地");
			}
			if (client.getHousing().equals("已婚")) {
				if (StringUtils.isNull(client.getSpuseName())) {
					throw new Exception("请填写配偶姓名和电话");
				}
			}
			if (censusAddressBook.getProvince().equals("请选择")) {
				throw new Exception("请输入户籍地址的省");
			}
			if (StringUtils.isNull(censusAddressBook.getCity())) {
				throw new Exception("请输入户籍地址的市");
			}
			if (StringUtils.isNull(censusAddressBook.getCounty())) {
				throw new Exception("请输入户籍地址的区");
			}
			if (StringUtils.isNull(censusAddressBook.getStreet())) {
				throw new Exception("请输入户籍地址的街道");
			}
			if (StringUtils.isNull(censusAddressBook.getCommunity())) {
				throw new Exception("请输入户籍地址的小区");
			}

			if (livingAddressBook.getProvince().equals("请选择")) {
				throw new Exception("请输入现居地址的省");
			}
			if (StringUtils.isNull(livingAddressBook.getCity())) {
				throw new Exception("请输入现居地址的市");
			}
			if (StringUtils.isNull(livingAddressBook.getCounty())) {
				throw new Exception("请输入现居地址的区");
			}
			if (StringUtils.isNull(livingAddressBook.getStreet())) {
				throw new Exception("请输入现居地址的街道");
			}

			if (StringUtils.isNull(livingAddressBook.getCommunity())) {
				throw new Exception("请输入现居地址的小区");
			}

			if (homeAddressBook.getProvince().equals("请选择")) {
				throw new Exception("请输入家庭信息的省");
			}
			if (StringUtils.isNull(homeAddressBook.getCity())) {
				throw new Exception("请输入家庭信息的市");
			}
			if (StringUtils.isNull(homeAddressBook.getCounty())) {
				throw new Exception("请输入家庭信息的区");
			}
			if (StringUtils.isNull(homeAddressBook.getStreet())) {
				throw new Exception("请输入家庭信息的街道");
			}

			if (StringUtils.isNull(homeAddressBook.getCommunity())) {
				throw new Exception("请输入家庭信息的小区");
			}

			if (officeAddressBook.getProvince().equals("请选择")) {
				throw new Exception("请输入所在单位信息的省");
			}
			if (StringUtils.isNull(officeAddressBook.getCity())) {
				throw new Exception("请输入所在单位信息的市");
			}
			if (StringUtils.isNull(officeAddressBook.getCounty())) {
				throw new Exception("请输入所在单位信息的区");
			}
			if (StringUtils.isNull(officeAddressBook.getStreet())) {
				throw new Exception("请输入所在单位信息的街道");
			}
			if (StringUtils.isNull(officeAddressBook.getCommunity())) {
				throw new Exception("请输入所在单位信息的小区");
			}

			if (StringUtils.isNull(client.getHomeName())) {
				throw new Exception("请输入家庭成员名称");
			}
			if (client.getHomeType().equals("请选择")) {
				throw new Exception("请输入家庭成员类型");
			}

			if (StringUtils.isNull(client.getClientName())) {
				throw new Exception("请输入申请人名字");
			}
			if (StringUtils.isNull(client.getOtherContacts())) {
				throw new Exception("请输入其他联系名字");
			}
			if (StringUtils.isNull(client.getOtherPhone())) {
				throw new Exception("请输入其他联系电话");
			}
			if (client.getHomeInMonth() == null) {
				throw new Exception("请输入家庭月收入");
			}
			if (client.getOnFullName() == null) {
				throw new Exception("请输入单位/学校/个体全称");
			}
			if (client.getOnDivision() == null) {
				throw new Exception("请输入任职部门或班级");
			}
			if (client.getOnDivision() == null) {
				throw new Exception("请输入任职部门或班级");
			}

			if (oBank.getBankName() == null) {
				throw new Exception("请输入银行开户名");
			}

			if (oBank.getDebitCard() == null) {
				throw new Exception("请输入银行卡号");
			}

			if (oSale.getSaleName() == null) {
				throw new Exception("请输入商品名称");
			}

			if (client.getIdNo() == null
					|| (client.getIdNo().length() != 15 && client.getIdNo()
							.length() != 18)) {
				throw new Exception("身份证非法输入");
			}

			if(clientJob.getByUse().equals("请选择")){
				throw new Exception("请选择贷款用途");
			}

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
			if (pictureName != null && pictureName.length > 0)
				client.setPhotoPath(sPath + pictureName[0]);

			client.update(tx.getConnection());

			Client existClient = new Client();
			existClient.setIdNo(client.getIdNo());
			
			int count = existClient.count(tx.getConnection());
			clientId = 0;
			if(count>0){
				clientId = existClient.getId();
				client.setId(clientId);
				if(livingAddressBook.getStreet()!=null)
				client.setLivingAddressBookId(livingAddressBookId);
				if(officeAddressBook.getStreet()!=null)
				client.setOfficeAddressBookId(officeAddressBookId);
				if(homeAddressBook.getStreet()!=null)
				client.setHomeAddressBookId(homeAddressBookId);
				if(censusAddressBook.getStreet()!=null)
				client.setCensusAddressBookId(censusAddressBookId);
				client.setBranchId(branchId);
				if(pictureName!=null && pictureName.length>0 )
					client.setPhotoPath(sPath + pictureName[0]);

				client.update(tx.getConnection());
			}else {
				clientId = IDGenerator.getNextID(tx.getConnection(),
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
			}
			String docType[] = uf.getParameters("docType");
			// 处理文件图片
			for (int i = 1; i < pictureName.length; i++) {

				ClientDoc clientDoc = new ClientDoc();
				int clientDocId = IDGenerator.getNextID(tx.getConnection(),
						ClientDoc.class);
				clientDoc.setClientId(clientId);
				
				value = "";
				if(docType!=null && docType.length>0){
					for(int j=0;j<docType.length;j++){
						value += docType[j]+",";
					}
				}
				
				if(value.lastIndexOf(",")>0)
					value = value.substring(0,value.lastIndexOf(","));
				
				clientDoc.setDocType(value);

				clientDoc.setFilepath(sPath + pictureName[i]);
				clientDoc.setId(clientDocId);
				clientDoc.add(tx.getConnection());
			}

			int clientJobId = IDGenerator.getNextID(tx.getConnection(),
					ClientJob.class);
			clientJob.setId(clientJobId);
			clientJob.setClientId(clientId);
			clientJob.setJobNo(IDGenerator.getSN(tx.getConnection(),
					ClientJob.class, "jobNo",
					IDGenerator.getBatchSN(store.getStoreKey(), 6)));
			clientJob.setStoreId(store.getId());
			clientJob.setBranchId(branchId);
			clientJob.setJobDate(new Date());
			clientJob.update(tx.getConnection());

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

			int nextId = IDGenerator.getNextID(tx.getConnection(),
					ClientJobSale.class);
			oSale.setId(nextId);
			oSale.setClientJobId(clientJob.getId());
			oSale.add(tx.getConnection());

			if (tSale.getSaleName() != null) {
				nextId = IDGenerator.getNextID(tx.getConnection(),
						ClientJobSale.class);
				tSale.setId(nextId);
				tSale.setClientJobId(clientJob.getId());
				tSale.add(tx.getConnection());
			}

			nextId = IDGenerator.getNextID(tx.getConnection(), Bank.class);
			oBank.setClientId(client.getId());
			oBank.setId(nextId);
			oBank.add(tx.getConnection());

			if (tBank.getDebitCard() != null) {
				nextId = IDGenerator.getNextID(tx.getConnection(), Bank.class);
				uf.bindData(tBank, "tBank");
				tBank.setId(nextId);
				tBank.setClientId(client.getId());
				tBank.add(tx.getConnection());
			}
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

	/**
	 * 查询金融产品
	 * 
	 * @param request
	 * @param response
	 */
	public String test(HttpServletRequest request, HttpServletResponse response) {
		JSONObject jsonObject = null;
		try {
			jsonObject = new JSONObject();
			String productId = request.getParameter("productId");
			String totalMoney = request.getParameter("totalMoney");
			String firstPay = request.getParameter("firstPay");

			Double firstPay1 = new Double(firstPay);
			Double totalMoney1 = new Double(totalMoney);

			if (StringUtils.isNull(totalMoney)
					|| StringUtils.isNull(totalMoney)
					|| StringUtils.isNull(firstPay)) {
				throw new Exception("有参数为空！请检查后填写！");
			}
			MultiDBObject dbobject = new MultiDBObject();

			dbobject.addTable(Product.class, "product");
			dbobject.addTable(FinancialProduct.class, "financialProduct");
			dbobject.addTable(FinancialCategory.class, "financialCategory");

			dbobject.setForeignKey("product", "id", "financialCategory",
					"productId");
			dbobject.setForeignKey("financialProduct", "id",
					"financialCategory", "financialId");
			dbobject.setField("product", "id", new Integer(productId));
			dbobject.addCustomWhereClause(" financialMax>= "
					+ (totalMoney1 - firstPay1) + " and financialMin " + "<= "
					+ (totalMoney1 - firstPay1) + "" + " and minPayPercent<= "
					+ (totalMoney1 - firstPay1) / totalMoney1);

			dbobject.setRetrieveField("financialProduct", "id");
			dbobject.setRetrieveField("financialProduct", "financialName");
			List<Object> financials=dbobject.searchAndRetrieveList();
			List<FinancialProduct> financialProducts=new ArrayList<FinancialProduct>();
			for(Object orow:financials){
				Map rowm = (Map)orow;
				FinancialProduct financialProduct = (FinancialProduct) rowm.get("financialProduct");
				financialProducts.add(financialProduct);
			}
			
			
			
			jsonObject
					.put("financialProducts", financialProducts);
			jsonObject.put("size", financialProducts.size());
			response.getWriter().write(jsonObject.toString());

		} catch (Exception e) {
			// TODO Auto-generated catch block
			jsonObject.put("message", e.getMessage());
			try {
				response.getWriter().write(jsonObject.toString());
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return "success";

	}

	/**
	 * 根据金融产品id和贷款数，返回每月支付钱数
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public String queryFinancialProductByID(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		JSONObject jb = null;
		try {

			String financialId = request.getParameter("financialId");
			String loadMoney = request.getParameter("loadMoney");
			if (StringUtils.isNull(financialId)
					|| StringUtils.isNull(loadMoney)) {
				throw new Exception("参数合法，请重新输入！");
			}
			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(new Integer(financialId));
			financialProduct.retrieve();
			// 处理每月支付钱数
			double monthPay = (financialProduct.getChargeRate()
					+ financialProduct.getNaturalRate()
					+ financialProduct.getVouchRate() + 1)
					* new Double(loadMoney) / financialProduct.getCycleTotal();
			int monthpay1 = (int) monthPay;
			if (monthPay - monthpay1 > 0) {
				monthpay1++;
			}
			jb = new JSONObject();
			jb.put("totlaTime", financialProduct.getCycleTotal());
			jb.put("financialProductId", financialProduct.getId());
			jb.put("monthPay", monthpay1);

			response.getWriter().write(jb.toString());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			jb = new JSONObject();
			jb.put("message", e.getMessage());
			response.getWriter().write(jb.toString());
			e.printStackTrace();
			;
		}

		return "success";
	}

	public String promptEdit(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptView");
		String id = request.getParameter("id");
		try {

			// check
			if (StringUtils.isNull(id)) {
				throw new Exception("无效的合同号");
			}

			ClientJob clientJob = new ClientJob();
			clientJob.setId(new Integer(id));
			clientJob.retrieve();
			request.setAttribute("clientJob", clientJob);

			ClientJobSale clientJobSale = new ClientJobSale();
			clientJobSale.setClientJobId(clientJob.getId());
			List <?>sales = clientJobSale.searchAndRetrieveList();
			if (sales.size() > 0)
				request.setAttribute("oSale", sales.get(0));
			if (sales.size() > 1){
				request.setAttribute("tSale", sales.get(1));
				request.setAttribute("oSale", sales.get(0));
			}

			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(clientJob.getFinancialProductId());
			financialProduct.retrieve();
			request.setAttribute("financialProduct", financialProduct);

			Store store = new Store();
			store.setId(clientJob.getStoreId());
			store.retrieve();
			request.setAttribute("store", store);

			Client client = new Client();
			client.setId(clientJob.getClientId());
			client.retrieve();
			request.setAttribute("client", client);

			// 处理户籍地址
			AddressBook censusAddressBook = new AddressBook();
			censusAddressBook.setId(client.getCensusAddressBookId());
			censusAddressBook.retrieve();
			request.setAttribute("censusAddressBook", censusAddressBook);

			AddressBook livingAddressBook = new AddressBook();
			livingAddressBook.setId(client.getLivingAddressBookId());
			livingAddressBook.retrieve();
			request.setAttribute("livingAddressBook", livingAddressBook);

			AddressBook homeAddressBook = new AddressBook();
			homeAddressBook.setId(client.getHomeAddressBookId());
			homeAddressBook.retrieve();
			request.setAttribute("homeAddressBook", homeAddressBook);

			AddressBook officeAddressBook = new AddressBook();
			officeAddressBook.setId(client.getHomeAddressBookId());
			officeAddressBook.retrieve();
			request.setAttribute("officeAddressBook", officeAddressBook);

			ClientDoc clientDoc = new ClientDoc();
			clientDoc.setClientId(client.getId());
			request.setAttribute("clientDoc", clientDoc.searchAndRetrieveList());

			// 封装审批端的备注信息和自己的备注信息
			ClientJobTrack clientJobTrack = new ClientJobTrack();
			clientJobTrack.setClientJobId(clientJob.getId());

			request.setAttribute("clientJobTrack",
					clientJobTrack.searchAndRetrieveList());

			JobType jobType = new JobType();
			jobType.setId(clientJobTrack.getJobTypeId());
			jobType.retrieve();
			request.setAttribute("jobType", jobType);
			// 处理产品
			Product product = new Product();
			request.setAttribute("products", product.searchAndRetrieveList());
			
			//处理银行卡
			Bank bank = new Bank();
			bank.setClientId(client.getId());
			List <?> list=bank.searchAndRetrieveList();
			if(list.size()==2){
				System.out.println(">>>>>>>>>>>bank>>>>>>>>>>"+list.size());
				Bank oBank=(Bank)list.get(0);
				request.setAttribute("oBank", oBank);
				Bank tBank = (Bank)list.get(1);
				request.setAttribute("tBank", tBank);
			}else if(list.size()==1){
				Bank oBank=(Bank)list.get(0);
				request.setAttribute("oBank", oBank);
			}

			request.setAttribute("jobType", jobType);
		} catch (Exception e) {
			e.printStackTrace();
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "list";
		}
		return "success";
	}

	public String processEdit(HttpServletRequest request,
			HttpServletResponse response) {
		
		if (log.isDebugEnabled())
			log.debug("processAdd");
		Integer branchId = ActionSession.getInteger(request,
				ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request,
				ActionSession.USER_SESSION_KEY);
		String sPath = "upload/images/";
		// physical path
		String pPath = request.getSession().getServletContext()
				.getRealPath("/");
		// upload path
		String uPath = pPath + sPath;
		if (log.isDebugEnabled())
			log.debug("uploadPath=" + uPath);
		UploadFile uf = new UploadFile();
		uf.setRequest(request);
		uf.setUploadPath(uPath);
		uf.process();
		String value = uf.getParameter("clieddddssntJobId");
		Transaction tx = null;
		try {
			//获取页面传过来的ID
			Integer clientJobId = null;
			if (StringUtils.isNull(value)) {
				throw new Exception("无效的合同号");

			}

			// 先查询出原来合同信息
			clientJobId = new Integer(value);
			ClientJob clientJob = new ClientJob();
			clientJob.setId(clientJobId);
			clientJob.retrieve();
			

			tx = new Transaction();
			tx.start();

			StoreUser storeUser = new StoreUser();
			storeUser.setUserId(sessionId);
			storeUser.setActive("Y");

			int acount = storeUser.count();

			if (acount < 1)
				throw new Exception("请先登录店铺");

			storeUser.retrieve(tx.getConnection());

			Store store = new Store();
			store.setId(storeUser.getStoreId());
			store.retrieve(tx.getConnection());

			// sub path
			
			if (log.isDebugEnabled())
				log.debug("uploadPath=" + uPath);

			File upFile = new File(uPath);
			if (!upFile.exists())
				upFile.mkdirs();

			System.out.println(">>>>>>>>>>>>>>>>>>>" + clientJobId);

			String[] pictureName = uf.getUpdFileNames();
			
			Client client = new Client();
			client.setId(clientJob.getClientId());
			client.retrieve();

			// 处理户籍地址
			AddressBook censusAddressBook = new AddressBook();
			censusAddressBook.setId(client.getCensusAddressBookId());
			uf.bindData(censusAddressBook, "censusAddressBook");
			censusAddressBook.update(tx.getConnection());
			request.setAttribute("censusAddressBook", censusAddressBook);

			
			AddressBook livingAddressBook = new AddressBook();
			livingAddressBook.setId(client.getLivingAddressBookId());		
			uf.bindData(livingAddressBook, "livingAddressBook");
			livingAddressBook.update(tx.getConnection());
			request.setAttribute("livingAddressBook", livingAddressBook);

			AddressBook homeAddressBook = new AddressBook();
			homeAddressBook.setId(client.getHomeAddressBookId());
			uf.bindData(homeAddressBook, "homeAddressBook");
			homeAddressBook.update(tx.getConnection());
			request.setAttribute("homeAddressBook", homeAddressBook);

			AddressBook officeAddressBook = new AddressBook();
			officeAddressBook.setId(client.getOfficeAddressBookId());
			uf.bindData(officeAddressBook, "officeAddressBook");
			officeAddressBook.update(tx.getConnection());
			request.setAttribute("officeAddressBook", officeAddressBook);

			// 处理银行卡
			Bank bank = new Bank();
			bank.setClientId(clientJob.getClientId());
			List<?> list = bank.searchAndRetrieveList();
			if (list.size() > 1) {
				Bank tBank = (Bank) list.get(1);
				uf.bindData(tBank, "oBank");
				tBank.update(tx.getConnection());
				request.setAttribute("tBank", tBank);
			}
			Bank oBank = (Bank) list.get(0);
			uf.bindData(oBank, "oBank");
			oBank.update(tx.getConnection());
			request.setAttribute("oBank", oBank);

			// check
			// if(pictureName==null || pictureName.length<2){
			// throw new Exception("请上传头像或图片");
			// }
			//
			// if(client.getAge()==null || client.getAge()==0){
			// throw new Exception("请填写客户年龄");
			// }
			// if(StringUtils.isNull(client.getIdAuthority())){
			// throw new Exception("请填写发证机关");
			// }
			// if(StringUtils.isNull(client.getMobilePhone())){
			// throw new Exception("请填写本人手机号或格式错误");
			// }
			// if(StringUtils.isNull(client.getMobileAddress())){
			// throw new Exception("请填写手机号码归属地");
			// }
			// if(client.getHousing().equals("已婚")){
			// if(StringUtils.isNull(client.getSpuseName())){
			// throw new Exception("请填写配偶姓名和电话");
			// }
			// }
			// if(censusAddressBook.getProvince().equals("请选择")){
			// throw new Exception("请输入户籍地址的省");
			// }
			// if(StringUtils.isNull(censusAddressBook.getCity())){
			// throw new Exception("请输入户籍地址的市");
			// }
			// if(StringUtils.isNull(censusAddressBook.getCounty())){
			// throw new Exception("请输入户籍地址的区");
			// }
			// if(StringUtils.isNull(censusAddressBook.getStreet())){
			// throw new Exception("请输入户籍地址的街道");
			// }
			// if(StringUtils.isNull(censusAddressBook.getCommunity())){
			// throw new Exception("请输入户籍地址的小区");
			// }
			//
			// if(livingAddressBook.getProvince().equals("请选择")){
			// throw new Exception("请输入现居地址的省");
			// }
			// if(StringUtils.isNull(livingAddressBook.getCity())){
			// throw new Exception("请输入现居地址的市");
			// }
			// if(StringUtils.isNull(livingAddressBook.getCounty())){
			// throw new Exception("请输入现居地址的区");
			// }
			// if(StringUtils.isNull(livingAddressBook.getStreet())){
			// throw new Exception("请输入现居地址的街道");
			// }
			//
			// if(StringUtils.isNull(livingAddressBook.getCommunity())){
			// throw new Exception("请输入现居地址的小区");
			// }
			//
			// if(homeAddressBook.getProvince().equals("请选择")){
			// throw new Exception("请输入家庭信息的省");
			// }
			// if(StringUtils.isNull(homeAddressBook.getCity())){
			// throw new Exception("请输入家庭信息的市");
			// }
			// if(StringUtils.isNull(homeAddressBook.getCounty())){
			// throw new Exception("请输入家庭信息的区");
			// }
			// if(StringUtils.isNull(homeAddressBook.getStreet())){
			// throw new Exception("请输入家庭信息的街道");
			// }
			//
			// if(StringUtils.isNull(homeAddressBook.getCommunity())){
			// throw new Exception("请输入家庭信息的小区");
			// }
			//
			//
			// if(officeAddressBook.getProvince().equals("请选择")){
			// throw new Exception("请输入所在单位信息的省");
			// }
			// if(StringUtils.isNull(officeAddressBook.getCity())){
			// throw new Exception("请输入所在单位信息的市");
			// }
			// if(StringUtils.isNull(officeAddressBook.getCounty())){
			// throw new Exception("请输入所在单位信息的区");
			// }
			// if(StringUtils.isNull(officeAddressBook.getStreet())){
			// throw new Exception("请输入所在单位信息的街道");
			// }
			// if(StringUtils.isNull(officeAddressBook.getCommunity())){
			// throw new Exception("请输入所在单位信息的小区");
			// }
			//
			// if(StringUtils.isNull(client.getHomeName())){
			// throw new Exception("请输入家庭成员名称");
			// }
			// if(client.getHomeType().equals("请选择")){
			// throw new Exception("请输入家庭成员类型");
			// }
			//
			// if(StringUtils.isNull(client.getClientName())){
			// throw new Exception("请输入申请人名字");
			// }
			// if(StringUtils.isNull(client.getOtherContacts())){
			// throw new Exception("请输入其他联系名字");
			// }
			// if(StringUtils.isNull(client.getOtherPhone())){
			// throw new Exception("请输入其他联系电话");
			// }
			// if(client.getHomeInMonth() == null){
			// throw new Exception("请输入家庭月收入");
			// }
			// if(client.getOnFullName() == null){
			// throw new Exception("请输入单位/学校/个体全称");
			// }
			// if(client.getOnDivision() == null){
			// throw new Exception("请输入任职部门或班级");
			// }
			// if(client.getOnDivision() == null){
			// throw new Exception("请输入任职部门或班级");
			// }
			//
			// if(oBank.getBankName() == null){
			// throw new Exception("请输入银行开户名");
			// }
			//
			// if(oBank.getDebitCard()== null){
			// throw new Exception("请输入银行卡号");
			// }
			//
			// if(oSale.getSaleName() == null){
			// throw new Exception("请输入商品名称");
			// }
			//
			// if(client.getIdNo()==null || (client.getIdNo().length()!=15 &&
			// client.getIdNo().length()!=18)){
			// throw new Exception("身份证非法输入");
			// }
			//
			int censusAddressBookId = client.getCensusAddressBookId();
			censusAddressBook.setId(censusAddressBookId);
			censusAddressBook.setBranchId(branchId);
			censusAddressBook.update(tx.getConnection());
			// 处理现居地址
			int livingAddressBookId = client.getLivingAddressBookId();
			livingAddressBook.setId(livingAddressBookId);
			livingAddressBook.setBranchId(branchId);
			livingAddressBook.update(tx.getConnection());
			// 处理家庭成員地址
			int homeAddressBookId = client.getHomeAddressBookId();
			homeAddressBook.setId(homeAddressBookId);
			homeAddressBook.setBranchId(branchId);
			homeAddressBook.update(tx.getConnection());
			// 处理单位地址
			int officeAddressBookId = client.getOfficeAddressBookId();
			officeAddressBook.setId(officeAddressBookId);
			officeAddressBook.setBranchId(branchId);
			officeAddressBook.update(tx.getConnection());
			// 处理基本信息
			uf.bindData(client, "client");
			request.setAttribute("client", client);
			client.setId(clientJob.getClientId());
			client.setBranchId(branchId);
			uf.bindData(clientJob, "clientJob");
			if (pictureName != null && pictureName.length > 0)
				client.setPhotoPath(sPath + pictureName[0]);

			client.update(tx.getConnection());

			String docType[] = uf.getParameters("docType");
			// 处理文件图片
			for (int i = 1; i < pictureName.length; i++) {

				ClientDoc clientDoc = new ClientDoc();
				int clientDocId = IDGenerator.getNextID(tx.getConnection(),
						ClientDoc.class);
				clientDoc.setClientId(client.getId());
				
				value = "";
				if(docType!=null && docType.length>0){
					for(int j=0;j<docType.length;j++){
						value += docType[j]+",";
					}
				}
				
				if(value.lastIndexOf(",")>0)
					value = value.substring(0,value.lastIndexOf(","));
				
				clientDoc.setDocType(value);

				clientDoc.setFilepath(sPath + pictureName[i]);
				clientDoc.setId(clientDocId);
				clientDoc.add(tx.getConnection());
			}

			clientJob.setStoreId(store.getId());
			clientJob.setJobDate(new Date());
			clientJob.update(tx.getConnection());

			int clientJobTrackId = IDGenerator.getNextID(tx.getConnection(),
					ClientJobTrack.class);
			
			
			//处理日志
			ClientJobTrack orgTrack = new ClientJobTrack();
			orgTrack.setClientJobId(new Integer(clientJobId));
			int jobCount = orgTrack.count(tx.getConnection());
			
			orgTrack.setProcessId(0);
			orgTrack.retrieve();
			
			orgTrack.setProcessId(jobCount);
			orgTrack.update(tx.getConnection());
			
			
			ClientJobTrack clientJobTrack = new ClientJobTrack();
			clientJobTrack.setId(clientJobTrackId);
			clientJobTrack.setClientJobId(clientJob.getId());
			clientJobTrack.setJobDate(new Date());
			clientJobTrack.setJobTypeId(1);
			clientJobTrack.setProcessId(0);
			clientJobTrack.setUserId(sessionId);
			clientJobTrack.setBranchId(branchId);
			clientJobTrack.add(tx.getConnection());
			ClientJobSale clientJobSale = new ClientJobSale();
			clientJobSale.setClientJobId(clientJob.getId());
			List<?> list2 = clientJobSale.searchAndRetrieveList();
			if (list2.size() > 1) {
				//商品一
				ClientJobSale tSale1 =(ClientJobSale) list2.get(1);
				uf.bindData(tSale1, "tSale");
				request.setAttribute("tSale", tSale1);
				tSale1.update(tx.getConnection());
				//商品二
				ClientJobSale oSale1 = (ClientJobSale) list2.get(0);
				uf.bindData(oSale1, "oSale");
				oSale1.update(tx.getConnection());
				request.setAttribute("tSale", oSale1);
			}else if(list2.size()==1){
				//商品一
				System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>"+list.size());
				ClientJobSale oSale1 = (ClientJobSale) list2.get(0);
				uf.bindData(oSale1, "oSale");
				oSale1.update(tx.getConnection());
				request.setAttribute("tSale", oSale1);
			}
						
			
			
			//处理金融产品
			

			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "success";
		} finally {
			tx.end();
		}
		return "list";
	}

	public String promptView(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptView");
		String id = request.getParameter("id");
		try {

			// check
			if (StringUtils.isNull(id)) {
				throw new Exception("无效的合同号");
			}

			ClientJob clientJob = new ClientJob();
			clientJob.setId(new Integer(id));
			clientJob.retrieve();
			request.setAttribute("clientJob", clientJob);

			ClientJobSale clientJobSale = new ClientJobSale();
			clientJobSale.setClientJobId(clientJob.getId());
			request.setAttribute("sales", clientJobSale.searchAndRetrieveList());

			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(clientJob.getFinancialProductId());
			financialProduct.retrieve();
			request.setAttribute("financialProduct", financialProduct);

			Store store = new Store();
			store.setId(clientJob.getStoreId());
			store.retrieve();
			request.setAttribute("store", store);

			Client client = new Client();
			client.setId(clientJob.getClientId());
			client.retrieve();
			request.setAttribute("client", client);

			Bank bank = new Bank();
			bank.setClientId(client.getId());
			request.setAttribute("banks", bank.searchAndRetrieveList());

			// 处理户籍地址
			AddressBook censusAddressBook = new AddressBook();
			censusAddressBook.setId(client.getCensusAddressBookId());
			censusAddressBook.retrieve();
			request.setAttribute("censusAddressBook", censusAddressBook);

			AddressBook livingAddressBook = new AddressBook();
			livingAddressBook.setId(client.getLivingAddressBookId());
			livingAddressBook.retrieve();
			request.setAttribute("livingAddressBook", livingAddressBook);

			AddressBook homeAddressBook = new AddressBook();
			homeAddressBook.setId(client.getHomeAddressBookId());
			homeAddressBook.retrieve();
			request.setAttribute("homeAddressBook", homeAddressBook);

			AddressBook officeAddressBook = new AddressBook();
			officeAddressBook.setId(client.getOfficeAddressBookId());
			officeAddressBook.retrieve();
			request.setAttribute("officeAddressBook", officeAddressBook);

			ClientDoc clientDoc = new ClientDoc();
			clientDoc.setClientId(client.getId());
			request.setAttribute("docs", clientDoc.searchAndRetrieveList());

			ClientJobTrack clientJobTrack = new ClientJobTrack();
			clientJobTrack.setClientJobId(clientJob.getId());
			clientJobTrack.setProcessId(0);
			clientJobTrack.retrieve();

			request.setAttribute("clientJobTrack", clientJobTrack);

			JobType jobType = new JobType();
			jobType.setId(clientJobTrack.getJobTypeId());
			jobType.retrieve();
			request.setAttribute("jobType", jobType);

		} catch (Exception e) {
			e.printStackTrace();
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "list";
		}
		return "success";
	}

	public String export(HttpServletRequest request,
			HttpServletResponse response) {
		return XSLTUtil.buildPDF(request, response);
	}

	public String print(HttpServletRequest request, HttpServletResponse response) {

		String noteType = request.getParameter("noteType");
		String physicalPath = request.getSession().getServletContext()
				.getRealPath("/");

		String xml = null;
		String xslt = null;
		String noteName = null;

		try {
			String xmlStr = null;
			if (noteType.equals("FQHT")) {
				// xmlStr=xmlFQHT(request,response);
				xslt = "hts.xsl";
				noteName = "FQHT";
			} else if (noteType.equals("HTZY")) {
				// xmlStr=xmlHTZY(request,response);
				xslt = "hkzys.xsl";
				noteName = "HTZY";
			} else if (noteType.equals("SPJF")) {
				// xmlStr=xmlSPJF(request,response);
				xslt = "spjhs.xsl";
				noteName = "SPJF";
			} else if (noteType.equals("HKS")) {
				// xmlStr=xmlSPJF(request,response);
				xslt = "hks.xsl";
				noteName = "HKS";
			}

			xmlStr = xmlFQHT(request, response);

			xml = physicalPath + "tmp/" + System.currentTimeMillis() + ".xml";
			xslt = physicalPath + "jsp/xslt/" + xslt;

			FileOutputStream writerStream = new FileOutputStream(xml);
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
					writerStream, "UTF-8"));
			writer.write(xmlStr);
			writer.flush();
			writer.close();
			writerStream.close();

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
		}

		request.setAttribute("xml", xml);
		request.setAttribute("xslt", xslt);
		request.setAttribute("noteName", noteName);

		return XSLTUtil.buildPDF(request, response);
	}

	public String xmlFQHT(HttpServletRequest request,
			HttpServletResponse response) {
		StringBuilder buffer = new StringBuilder();
		buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
		buffer.append("<SN>\n");

		try {
			String id = request.getParameter("id");

			ClientJob clientJob = new ClientJob();
			clientJob.setId(new Integer(id));
			clientJob.retrieve();

			Client client = new Client();
			client.setId(clientJob.getClientId());
			client.retrieve();

			AddressBook addressBook = new AddressBook();
			addressBook.setId(client.getLivingAddressBookId());
			addressBook.retrieve();

			Store store = new Store();
			store.setId(clientJob.getStoreId());
			store.retrieve();

			StoreType storeType = new StoreType();
			store.setId(store.getStoreTypeId());
			store.retrieve();
			request.setAttribute("storeType", storeType);

			buffer.append("<ClientName>" + client.getClientName()
					+ "</ClientName>\n");
			buffer.append("<ClientID>" + client.getIdNo() + "</ClientID>\n");
			buffer.append("<Address>" + addressBook.getProvince()
					+ addressBook.getCity() + addressBook.getCounty()
					+ addressBook.getTown() + addressBook.getStreet()
					+ "</Address>\n");
			buffer.append("<FromIn>" + client.getOnFullName() + "</FromIn>\n");
			buffer.append("<TelePhone>" + client.getOnOfficePhone()
					+ "</TelePhone>\n");
			buffer.append("<Email>" + client.getEmail() + "</Email>\n");
			buffer.append("<StoreName>" + store.getStoreName()
					+ "</StoreName>\n");
			buffer.append("<StoreKey>" + store.getStoreKey() + "</StoreKey>\n");

			buffer.append("<TotalPrice>" + clientJob.getTotalPrice()
					+ "</TotalPrice>\n");
			buffer.append("<SelfAmount>" + clientJob.getSelfAmount()
					+ "</SelfAmount>\n");
			buffer.append("<MonthOfPay>" + clientJob.getMonthOfPay()
					+ "</MonthOfPay>\n");

			buffer.append("<ImgURL>" + client.getPhotoPath() + "</ImgURL>\n");

			SimpleDateFormat dformat = new SimpleDateFormat("yyyy年MM月dd日");
			Date vDate = clientJob.getMonthOfDate();
			
			buffer.append("<MonthOfDate>"+dformat.format(vDate)+"</MonthOfDate>\n");
			buffer.append("<PayFirst>"+dformat.format(vDate)+"</PayFirst>\n");
			
			vDate = clientJob.getJobDate();
			buffer.append("<JobDate>"+dformat.format(vDate)+"</JobDate>\n");
			
			dformat = new SimpleDateFormat("dd日");
			vDate = clientJob.getMonthOfDate();
			buffer.append("<PayOfMonth>" + dformat.format(vDate)
					+ "</PayOfMonth>\n");

			buffer.append("<IdNo>" + client.getIdNo() + "</IdNo>\n");

			buffer.append("<StoreTypeKey>" + storeType.getTypeKey()
					+ "</StoreTypeKey>\n");
			buffer.append("<StoreTypeName>" + storeType.getTypeName()
					+ "</StoreTypeName>\n");

			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(clientJob.getFinancialProductId());
			financialProduct.retrieve();

			buffer.append("<TotalPay>"
					+ (clientJob.getMonthOfPay() * financialProduct
							.getCycleTotal()) + "</TotalPay>\n");

			buffer.append("<CycleTotal>" + financialProduct.getCycleTotal()
					+ "</CycleTotal>\n");

			ClientJobSale clientJobSale = new ClientJobSale();
			clientJobSale.setClientJobId(clientJob.getId());

			Bank bank = new Bank();
			bank.setClientId(client.getId());
			bank.retrieve();

			buffer.append("<BankName>" + bank.getBankName() + "</BankName>\n");
			buffer.append("<DebitCard>" + bank.getDebitCard()
					+ "</DebitCard>\n");

			List sales = clientJobSale.searchAndRetrieveList();

			for (Object obj : sales) {
				clientJobSale = (ClientJobSale) obj;

				buffer.append("<Lookup>\n");
				buffer.append("<ProductName>" + clientJobSale.getSaleName()
						+ "</ProductName>\n");
				buffer.append("<ProductPrice>" + clientJobSale.getSalePrice()
						+ "</ProductPrice>\n");
				buffer.append("<ProductQuantity>" + "1"
						+ "</ProductQuantity>\n");
				buffer.append("<ProductModelNo>" + clientJobSale.getModelNo()
						+ "</ProductModelNo>\n");
				buffer.append("<ProductBrand>" + clientJobSale.getBrand()
						+ "</ProductBrand>\n");
				buffer.append("</Lookup>\n");
			}
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
		}

		buffer.append("</SN>\n");

		return buffer.toString();
	}
}
