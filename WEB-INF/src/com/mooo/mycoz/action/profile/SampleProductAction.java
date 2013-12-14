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
import com.mooo.mycoz.dbobj.wineBranch.Product;
import com.mooo.mycoz.dbobj.wineBranch.SampleItem;
import com.mooo.mycoz.dbobj.wineBranch.SampleProduct;
import com.mooo.mycoz.dbobj.wineBranch.SampleTasting;
import com.mooo.mycoz.dbobj.wineBranch.SampleTest;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineShared.WarehouseItem;
import com.mooo.mycoz.dbobj.wineShared.WineTaster;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class SampleProductAction  extends BaseSupport {

	private static Log log = LogFactory.getLog(SampleProductAction.class);
	
	public String list(HttpServletRequest request,HttpServletResponse response) {
//		String value = null;

		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(Product.class, "product");
			dbobject.addTable(SampleProduct.class, "sampleProduct");

			dbobject.setForeignKey("winery", "id","product", "enterpriseId");
			dbobject.setForeignKey("product", "id","sampleProduct", "productId");
			
//			value = request.getParameter("product");
//			if(!StringUtils.isNull(value)){
//				dbobject.setLike("product", "productName", value);
//			}

			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("product", "productName");
			dbobject.setRetrieveField("sampleProduct", "id");
			dbobject.setRetrieveField("sampleProduct", "sampleName");
			dbobject.setRetrieveField("sampleProduct", "buildDate");
			dbobject.setRetrieveField("sampleProduct", "buildPeople");

			dbobject.setOrderBy("sampleProduct", "id","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();
			
			request.setAttribute("results", results);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String id=null;
		try{
			request.setAttribute("dcTypes", IDGenerator.getDcType());

			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));

			request.setAttribute("warehouseItems", IDGenerator.getValues(WarehouseItem.class,"id","itemName"));
			
			id = request.getParameter("id");
			
			SampleProduct sampleProduct = null;
			
			if(request.getAttribute("isLoad")!=null){
				sampleProduct = (SampleProduct) request.getAttribute("sampleProduct");
			}else if(!StringUtils.isNull(id)){
				sampleProduct = new SampleProduct();
				sampleProduct.setId(new Integer(id));
				sampleProduct.retrieve();
			}
			
			if(sampleProduct!=null){
				request.setAttribute("sampleProduct", sampleProduct);
	
				Product product = new Product();
				product.setId(sampleProduct.getProductId());
				product.retrieve();
				
				request.setAttribute("product", product);
	
				SampleTest sampleTest = new SampleTest();
				sampleTest.setSampleId(sampleProduct.getId());
				sampleTest.retrieve();
				request.setAttribute("sampleTest", sampleTest);

				MultiDBObject dbobject = new MultiDBObject();
				dbobject.addTable(SampleProduct.class, "sampleProduct");
				dbobject.addTable(SampleItem.class, "sampleItem");
	
				dbobject.setForeignKey("sampleProduct", "id","sampleItem", "sampleId");
				dbobject.setField("sampleItem", "sampleId",sampleProduct.getId());
	
				dbobject.setRetrieveField("sampleItem", "id");
				dbobject.setRetrieveField("sampleItem", "itemName");
				dbobject.setRetrieveField("sampleItem", "itemAge");
				dbobject.setRetrieveField("sampleItem", "itemVol");
				dbobject.setRetrieveField("sampleItem", "itemVolUnit");
				
				request.setAttribute("sampleItems", dbobject.searchAndRetrieveList());
				
				WineTaster wineTaster = new WineTaster();
				request.setAttribute("wineTasters", wineTaster.searchAndRetrieveList());

				dbobject = new MultiDBObject();
				dbobject.addTable(SampleTasting.class, "sampleTasting");
				dbobject.addTable(WineTaster.class, "wineTaster");
				
				dbobject.setForeignKey("wineTaster", "id","sampleTasting", "tasterId");
				dbobject.setField("sampleTasting", "sampleId",sampleProduct.getId());
	
				dbobject.setRetrieveField("sampleTasting", "id");
				dbobject.setRetrieveField("wineTaster", "tasterName");
				dbobject.setRetrieveField("wineTaster", "tasterLicense");
				dbobject.setRetrieveField("wineTaster", "tasterCategory");
				
				request.setAttribute("sampleTastings", dbobject.searchAndRetrieveList());
				}
			} catch (Exception e) {
				if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processItemAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processItemAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			SampleProduct sampleProduct = new SampleProduct();
			ParamUtil.bindData(request, sampleProduct,"sampleProduct");
			
			Product product = new Product();
			ParamUtil.bindData(request, product,"product");

			StringUtils.noNull(product.getProductName());

			product.retrieve();

			request.setAttribute("product", product);

			sampleProduct.setProductId(product.getId());
			
			Integer newId  = sampleProduct.getId();
			
			if(newId == null){
				newId = IDGenerator.getNextID(tx.getConnection(),SampleProduct.class);
				sampleProduct.setId(newId);
				sampleProduct.setSampleName(IDGenerator.getSN(tx.getConnection(),SampleProduct.class, "sampleName", IDGenerator.getBatchSN("S",1),11,4));
				sampleProduct.setIsPost("N");
				sampleProduct.add(tx.getConnection());
			}else{
				sampleProduct.update(tx.getConnection());
			}

			sampleProduct.retrieve(tx.getConnection());
			request.setAttribute("sampleProduct", sampleProduct);

			SampleItem sampleItem = new SampleItem();
			ParamUtil.bindData(request, sampleItem,"sampleItem");
			
			StringUtils.noNull(sampleItem.getItemName());
			
			sampleItem.setSampleId(sampleProduct.getId());

			newId = IDGenerator.getNextID(tx.getConnection(),SampleItem.class);
			sampleItem.setId(newId);
			sampleItem.add(tx.getConnection());
			
			tx.commit();
			
			request.setAttribute("message", "Operating successfully");
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		request.setAttribute("isLoad", "Yes");

		return "promptEdit";
	}

	public String processItemDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		
		Transaction tx=new Transaction();
		try {
			tx.start();

			String id  = request.getParameter("id");
			StringUtils.noNull(id);
			
			SampleProduct sampleProduct = new SampleProduct();
			ParamUtil.bindData(request, sampleProduct,"sampleProduct");
			
			sampleProduct.retrieve(tx.getConnection());
			request.setAttribute("sampleProduct", sampleProduct);

			SampleItem sampleItem = new SampleItem();
			sampleItem.setSampleId(sampleProduct.getId());
			
			int icount = sampleItem.count(tx.getConnection());
			if(icount == 1){
				throw new Exception("配方不能为空.");
			}
			
			sampleItem = new SampleItem();
			sampleItem.setId(new Integer(id));
			sampleItem.delete(tx.getConnection());
			
			tx.commit();
			
			request.setAttribute("message", "Operating successfully");
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}

		request.setAttribute("isLoad", "Yes");
		return "promptEdit";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		try {
			
			Product product = new Product();
			ParamUtil.bindData(request, product,"product");
			product.retrieve();
			request.setAttribute("product", product);

			SampleProduct sampleProduct = new SampleProduct();
			ParamUtil.bindData(request, sampleProduct,"sampleProduct");
			
			StringUtils.noNull(sampleProduct.getSampleName());
			
			sampleProduct.setProductId(product.getId());
			sampleProduct.update();
			
			request.setAttribute("sampleProduct", sampleProduct);

			SampleTest sampleTest = new SampleTest();
			sampleTest.setSampleId(sampleProduct.getId());

			if(sampleTest.count()<1){
				sampleTest.setId(IDGenerator.getNextInt(SampleTest.class));
				ParamUtil.bindData(request, sampleTest,"sampleTest");

				sampleTest.add();
			}else{
				ParamUtil.bindData(request, sampleTest,"sampleTest");

				sampleTest.update();
			}
			request.setAttribute("sampleTest", sampleTest);

			request.setAttribute("message", "Operating successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		request.setAttribute("isLoad", "Yes");
		return "promptEdit";
	}
	
	public String processTastingAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processItemAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			Product product = new Product();
			ParamUtil.bindData(request, product,"product");

			StringUtils.noNull(product.getProductName());

			product.retrieve();
			request.setAttribute("product", product);
			
			SampleProduct sampleProduct = new SampleProduct();
			ParamUtil.bindData(request, sampleProduct,"sampleProduct");
			
			sampleProduct.setProductId(product.getId());

			sampleProduct.retrieve(tx.getConnection());
			request.setAttribute("sampleProduct", sampleProduct);
			
			Integer newId  = sampleProduct.getId();
			if(newId == null){
				throw new Exception("操作不正确.");
			}

			String tasterId[] = request.getParameterValues("tasterId");
			
			if(tasterId == null || tasterId.length<1){
				throw new Exception("无可操作的数据");
			}
			
			SampleTasting sampleTasting = null;
			
			for(int i=0;i<tasterId.length;i++){
				sampleTasting = new SampleTasting();
				newId = IDGenerator.getNextID(tx.getConnection(),SampleTasting.class);
				sampleTasting.setId(newId);
				
				sampleTasting.setSampleId(sampleProduct.getId());
				sampleTasting.setTasterId(new Integer(tasterId[i]));
				
				sampleTasting.add(tx.getConnection());
			}
			
			tx.commit();
			
			request.setAttribute("message", "Operating successfully");
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		request.setAttribute("isLoad", "Yes");

		return "promptEdit";
	}

	public String processTastingDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		
		Transaction tx=new Transaction();
		try {
			tx.start();

			Product product = new Product();
			ParamUtil.bindData(request, product,"product");

			StringUtils.noNull(product.getProductName());

			product.retrieve();
			request.setAttribute("product", product);
			
			SampleProduct sampleProduct = new SampleProduct();
			ParamUtil.bindData(request, sampleProduct,"sampleProduct");
			
			sampleProduct.retrieve(tx.getConnection());
			request.setAttribute("sampleProduct", sampleProduct);

			SampleTasting sampleTasting = new SampleTasting();
			sampleTasting.setSampleId(sampleProduct.getId());
			
			int icount = sampleTasting.count(tx.getConnection());
			if(icount < 1){
				throw new Exception("没有可删除的评酒人");
			}
			
			String tastingId[]  = request.getParameterValues("tastingId");
			if(tastingId == null || tastingId.length<1){
				throw new Exception("无可操作的数据");
			}
			
			for(int i=0;i<tastingId.length;i++){
				sampleTasting = new SampleTasting();
				sampleTasting.setId(new Integer(tastingId[i]));
				sampleTasting.delete(tx.getConnection());
			}
			
			tx.commit();
			
			request.setAttribute("message", "Operating successfully");
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}

		request.setAttribute("isLoad", "Yes");
		return "promptEdit";
	}
}
