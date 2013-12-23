package com.mooo.mycoz.action.operation.credit;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
import com.mooo.mycoz.dbobj.wineBranch.ClientJobTrack;
import com.mooo.mycoz.dbobj.wineBranch.StoreProduct;
import com.mooo.mycoz.dbobj.wineBranch.StoreUser;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.dbobj.wineShared.Product;
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.UploadFile;
import com.mooo.mycoz.framework.component.XSLTUtil;
import com.mooo.mycoz.framework.util.IDGenerator;

public class SaleAction extends BaseSupport {

	private static Log log = LogFactory.getLog(SaleAction.class);

	public String promptSale(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptDeclare");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

		String value = null;

		try {
			StoreUser storeUser = new StoreUser();
			storeUser.setUserId(sessionId);
			storeUser.setActive("Y");
			
			int acount=storeUser.count();
			
			if(acount<1)
				throw new Exception("请先登录店铺");
			
			storeUser.retrieve();
			
			MultiDBObject dbobject = new MultiDBObject();

			dbobject.addTable(Product.class, "product");
			dbobject.addTable(StoreProduct.class, "storeProduct");

			dbobject.setForeignKey("product", "id", "storeProduct", "productId");
			
			dbobject.setField("storeProduct", "storeId",storeUser.getStoreId());
			
			dbobject.setRetrieveField("product", "id");
			dbobject.setRetrieveField("product", "productName");

			request.setAttribute("products", dbobject.searchAndRetrieveList());

			double salePrice = 0d;
			double onePay = 0d;
			double creditAmount = 0d;

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
//
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

			if(pId==null){
				pId = (String) request.getAttribute("pId");
				stPrice = (String) request.getAttribute("totalPrice");
				ssAmount = (String) request.getAttribute("selfAmount");
			}
			
			if (log.isDebugEnabled()) log.debug("pId:"+pId);
			if (log.isDebugEnabled()) log.debug("totalPrice:"+stPrice);
			if (log.isDebugEnabled()) log.debug("selfAmount:"+ssAmount);
			
			request.setAttribute("pId", pId);
			request.setAttribute("totalPrice", stPrice);
			request.setAttribute("selfAmount", ssAmount);

			FinancialProduct financialProduct = new FinancialProduct();
			financialProduct.setId(new Integer(pId));
			financialProduct.retrieve();

			request.setAttribute("financialProduct", financialProduct);

			double totailPrice = 0d;
			double selfAmount = 0d;
			double creditAmount = 0d;

			totailPrice = new Double(stPrice);
			selfAmount = new Double(ssAmount);

			creditAmount = totailPrice - selfAmount;
			
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

			StoreUser storeUser = new StoreUser();
			storeUser.setUserId(sessionId);
			storeUser.setActive("Y");
			
			int acount=storeUser.count();
			
			if(acount<1)
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
			
			request.setAttribute("pId",clientJob.getFinancialProductId() );
			request.setAttribute("totalPrice",clientJob.getTotalPrice() );
			request.setAttribute("selfAmount",clientJob.getSelfAmount() );

			StringUtils.noNull(client.getIdNo());
			StringUtils.noNull(client.getClientName());

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

			int clientJobId = IDGenerator.getNextID(tx.getConnection(),ClientJob.class);
			clientJob.setId(clientJobId);
			clientJob.setClientId(clientId);
			clientJob.setJobNo(IDGenerator.getSN(tx.getConnection(),ClientJob.class, "jobNo", IDGenerator.getBatchSN(store.getStoreKey(), 6)));
			clientJob.setStoreId(store.getId());
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

	
	
	public String processConfirm(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processConfirm");
		Integer sessionId = ActionSession.getInteger(request,ActionSession.USER_SESSION_KEY);
		
		Transaction tx =new Transaction();
		try {
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			if(ids!=null)
				for(int i=0;i<ids.length;i++){
					
					ClientJobTrack clientJobTrack = new ClientJobTrack();
					clientJobTrack.setClientJobId(new Integer(ids[i]));
					clientJobTrack.setProcessId(0);
					clientJobTrack.setJobTypeId(2);
					
					int checkCount = clientJobTrack.count(tx.getConnection());
					
					if(checkCount > 0 ){
						throw new Exception("已经提交 请耐心等待审核!");
					}
					
					ClientJobTrack orgTrack = new ClientJobTrack();
					orgTrack.setClientJobId(new Integer(ids[i]));
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
					clientJobTrack.setClientJobId(new Integer(ids[i]));
					clientJobTrack.setJobTypeId(2);
					clientJobTrack.add(tx.getConnection());
				}
			tx.commit();
		} catch (Exception e) {
			tx.rollback();

			request.setAttribute("error", e.getMessage());
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
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
	
	public String export(HttpServletRequest request,HttpServletResponse response) {
		
		
		return XSLTUtil.buildPDF(request, response);
	}

	public String print(HttpServletRequest request,HttpServletResponse response) {
		
		String noteType = request.getParameter("noteType");
		String physicalPath = request.getSession().getServletContext().getRealPath("/");

		String xml = null;
		String xslt = null;
		String noteName = null;

		try{
			String xmlStr = null;
			if(noteType.equals("FQHT")){
				xmlStr=xmlFQHT(request,response);
				xslt="ht.xsl";
				noteName="FQHT";
			}else if(noteType.equals("HTZY")){
				xmlStr=xmlHTZY(request,response);
				xslt="hkzy.xsl";
				noteName="HTZY";
			}else if(noteType.equals("SPJF")){
				xmlStr=xmlSPJF(request,response);
				xslt="ht.xsl";
				noteName="SPJF";
			}
			
			xml=physicalPath+"tmp/"+System.currentTimeMillis()+".xml";
			xslt=physicalPath+"jsp/xslt/"+xslt;
			
			FileOutputStream writerStream = new FileOutputStream(xml);
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8"));      
			writer.write(xmlStr);
			writer.flush();
			writer.close();
			writerStream.close();
			
		}catch(Exception e){
			request.setAttribute("error", e.getMessage());
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		
		request.setAttribute("xml", xml);
		request.setAttribute("xslt", xslt);
		request.setAttribute("noteName", noteName);

		return XSLTUtil.buildPDF(request, response);
	}
	
	public String xmlFQHT(HttpServletRequest request,HttpServletResponse response) {
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
			
			buffer.append("<ClientName>"+client.getClientName()+"</ClientName>\n");
			buffer.append("<ClientID>"+client.getIdNo()+"</ClientID>\n");
			buffer.append("<Address>"+addressBook.getProvince()+addressBook.getCity()+addressBook.getCounty()+addressBook.getTown()+addressBook.getStreet()+"</Address>\n");
			buffer.append("<FromIn>"+client.getOnCompanyName()+"</FromIn>\n");
			buffer.append("<TelePhone>"+client.getTelePhone()+"</TelePhone>\n");
			buffer.append("<Email>"+client.getEmail()+"</Email>\n");
			buffer.append("<StoreName>"+store.getStoreName()+"</StoreName>\n");
			buffer.append("<StoreKey>"+store.getStoreKey()+"</StoreKey>\n");
			
			buffer.append("<Lookup>\n");
			buffer.append("<ProductName>"+""+"</ProductName>\n");
			buffer.append("<ProductPrice>"+""+"</ProductPrice>\n");
			buffer.append("<ProductQuantity>"+""+"</ProductQuantity>\n");
			buffer.append("<ProductModelNo>"+""+"</ProductModelNo>\n");
			buffer.append("<ProductBrand>"+""+"</ProductBrand>\n");
			buffer.append("</Lookup>\n");
	
			buffer.append("<Lookup>\n");
			buffer.append("<ProductName>"+""+"</ProductName>\n");
			buffer.append("<ProductPrice>"+""+"</ProductPrice>\n");
			buffer.append("<ProductQuantity>"+""+"</ProductQuantity>\n");
			buffer.append("<ProductModelNo>"+""+"</ProductModelNo>\n");
			buffer.append("<ProductBrand>"+""+"</ProductBrand>\n");
			buffer.append("</Lookup>\n");
		
		}catch(Exception e){
			request.setAttribute("error", e.getMessage());
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		buffer.append("</SN>\n");

		return buffer.toString();
	}
	
	public String xmlHTZY(HttpServletRequest request,HttpServletResponse response) {
		
		StringBuilder buffer = new StringBuilder();
		buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
		buffer.append("<SN>\n");
		buffer.append("</SN>\n");
		
		return buffer.toString();
	}
	
	public String xmlSPJF(HttpServletRequest request,HttpServletResponse response) {
		
		StringBuilder buffer = new StringBuilder();
		buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
		buffer.append("<SN>\n");
		buffer.append("</SN>\n");		
		return buffer.toString();
	}
}
