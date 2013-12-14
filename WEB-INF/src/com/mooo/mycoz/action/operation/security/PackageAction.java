package com.mooo.mycoz.action.operation.security;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.Product;
import com.mooo.mycoz.dbobj.wineBranch.Sale;
import com.mooo.mycoz.dbobj.wineBranch.SaleItem;
import com.mooo.mycoz.dbobj.wineBranch.SaleJob;
import com.mooo.mycoz.dbobj.wineBranch.SampleProduct;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class PackageAction extends BaseSupport {

private static Log log = LogFactory.getLog(PackageAction.class);

	public String list(HttpServletRequest request,HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("list");

		String value = null;
		try {
			Sale sale = new Sale();
			
			value = request.getParameter("BatchNo");
			if(!StringUtils.isNull(value)){
				sale.setLike("batchNo", value);
				request.setAttribute("BatchNo", value);
			}
			
			value = request.getParameter("StartDate");
			if(!StringUtils.isNull(value)){
				sale.setGreaterEqual("saleDate", value);
			}
			
			value = request.getParameter("EndDate");
			if(!StringUtils.isNull(value)){
				sale.setLessEqual("saleDate", value);
			}
			
			sale.addOrderBy("id DESC");
			
			Page page = new Page();
			page.buildComponent(request, sale.count());
			sale.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = sale.searchAndRetrieveList();
			
			request.setAttribute("results", results);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		
		return "success";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		String value = null;
		
		try{
			value = request.getParameter("id");
			
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(SampleProduct.class, "sampleProduct");
			dbobject.addTable(Product.class, "product");
			
			dbobject.setForeignKey("product", "enterpriseId","winery", "id");
			dbobject.setForeignKey("sampleProduct", "productId","product", "id");
			
			dbobject.setRetrieveField("sampleProduct", "id");
			dbobject.setRetrieveField("sampleProduct", "sampleName");
			dbobject.setRetrieveField("product", "productName");
			dbobject.setRetrieveField("winery", "enterpriseName");

			request.setAttribute("samples", dbobject.searchAndRetrieveList());
			
			Sale sale = null;
			
			if(request.getAttribute("isLoad")!=null){
				sale = (Sale) request.getAttribute("sale");
			}else if(!StringUtils.isNull(value)){
				sale = new Sale();
				sale.setId(new Integer(value));
				sale.retrieve();
			}
			
			if(sale !=null){
				request.setAttribute("sale", sale);

				dbobject = new MultiDBObject();
				
				dbobject.addTable(SampleProduct.class, "sampleProduct");
				dbobject.addTable(Sale.class, "sale");
				dbobject.addTable(SaleItem.class, "saleItem");
	
				dbobject.setForeignKey("saleItem", "sampleId","sampleProduct", "id");
				dbobject.setForeignKey("saleItem", "saleId", "sale", "id");
				dbobject.setField("sale", "id",sale.getId());
				
				dbobject.setRetrieveField("sampleProduct", "sampleName");
				dbobject.setRetrieveField("saleItem", "id");
				dbobject.setRetrieveField("saleItem", "salePrice");
				dbobject.setRetrieveField("saleItem", "saleCurr");
				dbobject.setRetrieveField("saleItem", "saleVol");
				dbobject.setRetrieveField("saleItem", "volUnit");
				
				List<?> results = dbobject.searchAndRetrieveList();
				
				List<Map<Object,Object>> saleItems = new ArrayList<Map<Object,Object>>();
	
				for(Object orow:results){
					Map rowm = (Map)orow;
					
					SaleItem saleItem = (SaleItem)rowm.get("saleItem");
					SampleProduct sampleProduct = (SampleProduct)rowm.get("sampleProduct");
					
					Map<Object,Object> ms = new HashMap<Object,Object>();
					ms.put("id", saleItem.getId());
					ms.put("salePrice", saleItem.getSalePrice());
					ms.put("saleCurr", saleItem.getSaleCurr());
					ms.put("saleVol", saleItem.getSaleVol());
					ms.put("volUnit", saleItem.getVolUnit());
					ms.put("sampleName", sampleProduct.getSampleName());
					
					SaleJob saleJob = new SaleJob();
					saleJob.setItemId(saleItem.getId());
					saleJob.addGroupBy("saleCode");
					
					ms.put("saleQuantity", saleJob.count());
					
					saleItems.add(ms);
				}
				request.setAttribute("saleItems", saleItems);
			}
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processItemAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processSale");
		String value=null;
		
		Transaction tx=new Transaction();
		try {
			tx.start();

			Sale sale = new Sale();
			ParamUtil.bindData(request, sale, "sale");
			
			Integer newId  = sale.getId();
			if(newId == null){
				sale.setId(IDGenerator.getNextID(tx.getConnection(), Sale.class));
				sale.setBatchNo(IDGenerator.getSN(tx.getConnection(),Sale.class, "batchNo", IDGenerator.getNowSN(),10,4));
				sale.setIsSale("N");

				sale.add(tx.getConnection());
			}else{
				sale.update(tx.getConnection());
			}
			
			sale.retrieve(tx.getConnection());
			request.setAttribute("sale", sale);

			SaleItem saleItem = new SaleItem();
			ParamUtil.bindData(request, saleItem, "saleItem");
			saleItem.setId(IDGenerator.getNextID(tx.getConnection(), SaleItem.class));
			saleItem.setSaleId(sale.getId());
			saleItem.add(tx.getConnection());
			
			SampleProduct sampleProduct = new SampleProduct();
			sampleProduct.setId(saleItem.getSampleId());
			sampleProduct.setIsPost("Y");
			sampleProduct.update(tx.getConnection());
			
			value = request.getParameter("bottles");
			
			Integer bottles = new Integer(value);
			
			SaleJob saleJob = null;

			for(int i=0;i<bottles;i++){
				saleJob = new SaleJob();
				saleJob.setId(IDGenerator.getNextID(tx.getConnection(), SaleJob.class));
				saleJob.setSaleCode(IDGenerator.getSN(tx.getConnection(),SaleJob.class, "saleCode", sale.getBatchNo(),16,6));
				saleJob.setItemId(saleItem.getId());
				saleJob.setJobDate(new Date());
				saleJob.setJobBy("U");
				saleJob.add(tx.getConnection());
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
	
	public String processItemDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processSale");
		String value=null;
		Transaction tx=new Transaction();
		try {
			tx.start();

			String id  = request.getParameter("id");
			
			Sale sale = new Sale();
			ParamUtil.bindData(request, sale,"sale");
			
			sale.retrieve(tx.getConnection());
			request.setAttribute("sale", sale);

			value = sale.getIsSale();
			if(value.equals("Y")){
				throw new Exception("二维码已经打印");
			}
			
			SaleItem saleItem = new SaleItem();
			saleItem.setId(new Integer(id));
			saleItem.retrieve(tx.getConnection());
			
			SaleJob saleJob = new SaleJob();
			saleJob.setItemId(saleItem.getId());
			
			List<Object> saleJobs = saleJob.searchAndRetrieveList();
			SaleJob sj=null;
			for(Object obj:saleJobs){
				sj = (SaleJob) obj;
				sj.delete(tx.getConnection());
			}
			saleItem.delete(tx.getConnection());
			
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
			Sale sale = new Sale();
			ParamUtil.bindData(request, sale,"sale");
			request.setAttribute("sale", sale);

			request.setAttribute("message", "Operating successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		request.setAttribute("isLoad", "Yes");
		return "promptEdit";
	}
	
	public String print(HttpServletRequest request,HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("check");
		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		String value=null;
		try {
			String saleId = request.getParameter("id");
			StringUtils.noNull(saleId);

			Sale sale = new Sale();
			sale.setId(new Integer(saleId));
			sale.retrieve();
			
			String fName = sale.getBatchNo();
			String filePrefix=physicalPath+"tmp/"+fName;
			
			// 打开文件
			WritableWorkbook book = Workbook.createWorkbook(new File(filePrefix+".xls"));
			
			SaleItem saleItem = new SaleItem();
			saleItem.setSaleId(sale.getId());
			
			List<Object> saleItems = saleItem.searchAndRetrieveList();
			int pages=0,rows=0/*,cols=0*/;
			
			for(Object siBean:saleItems){

				SaleItem siObj = (SaleItem)siBean;
				
				SampleProduct sampleProduct = new SampleProduct();
				sampleProduct.setId(siObj.getSampleId());
				sampleProduct.retrieve();
				
				Product product = new Product();
				product.setId(sampleProduct.getProductId());
				product.retrieve();
				
				Winery winery = new Winery();
				winery.setId(product.getEnterpriseId());
				winery.retrieve();
				
				// 生成名为“第一页”的工作表，参数0表示这是第一页
				WritableSheet sheet = book.createSheet(winery.getEnterpriseName()+":"+product.getProductName() , pages );
				
				SaleJob saleJob = new SaleJob();
				saleJob.setItemId(siObj.getId());
				
				List<Object> saleJobs = saleJob.searchAndRetrieveList();
				rows=0;
				for(Object sjBean:saleJobs){
					SaleJob sjObj = (SaleJob) sjBean;

					value = winery.getEnterpriseName1()+"."+product.getProductName()+"\n";
					value += "专家酒体评分:"+sampleProduct.getExpertScore()+"分"+"\n";
					value += "售价:"+siObj.getSalePrice()+"元/瓶 (2013)"+"\n";
					value += "http://86999.org/Sale.do?method=check&FC="+sjObj.getSaleCode();

					// 在Label对象的构造子中指名单元格位置是第一列第一行(0,0)
					// 以及单元格内容为test
					Label label = new Label( 0 , rows , value );
					rows++;
					// 将定义好的单元格添加到工作表中
					sheet.addCell(label);
				}
				pages++;
			}
			
			book.write();
			book.close();
			
			sale.setIsSale("Y");
			sale.update();
			
			request.setAttribute("fileName", fName+".xls");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String export(HttpServletRequest request,HttpServletResponse response) {

		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		try {
			String saleId = request.getParameter("id");
			StringUtils.noNull(saleId);

			Sale sale = new Sale();
			sale.setId(new Integer(saleId));
			sale.retrieve();
			
			String fName = sale.getBatchNo();
			String filePrefix=physicalPath+"tmp/"+fName;
			
			StringBuilder buffer = new StringBuilder();
			buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			buffer.append("<root xmlns=\"http://www.cdi.cn/handle\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n");
			buffer.append("<ListRecords metedataStandard=\"chanpinleibie\">\n");
			
			SaleItem saleItem = new SaleItem();
			saleItem.setSaleId(sale.getId());
			
			List<Object> saleItems = saleItem.searchAndRetrieveList();
			
			for(Object siBean:saleItems){

				SaleItem siObj = (SaleItem)siBean;
				
				SampleProduct sampleProduct = new SampleProduct();
				sampleProduct.setId(siObj.getSampleId());
				sampleProduct.retrieve();
				
				Product product = new Product();
				product.setId(sampleProduct.getProductId());
				product.retrieve();
				
				Winery winery = new Winery();
				winery.setId(product.getEnterpriseId());
				winery.retrieve();
				
				SaleJob saleJob = new SaleJob();
				saleJob.setItemId(siObj.getId());
				
				List<Object> saleJobs = saleJob.searchAndRetrieveList();
				for(Object sjBean:saleJobs){
					SaleJob sjObj = (SaleJob) sjBean;

//					value = winery.getEnterpriseName1()+"."+product.getProductName()+"\n";
//					value += "专家酒体评分:"+sampleProduct.getExpertScore()+"分"+"\n";
//					value += "售价:"+siObj.getSalePrice()+"元/瓶 (2013)"+"\n";
//					value += "http://86999.org/Sale.do?method=check&FC="+sjObj.getSaleCode();

					buffer.append("<record>\n");
					buffer.append("	<header>\n");
					buffer.append("		<identifier>86.1001.19/"+sjObj.getSaleCode()+"</identifier>\n");
					buffer.append("	</header>\n");
					
					buffer.append("	<metadata>\n");
					
					buffer.append("		<name>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+product.getProductName()+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</name>\n");
					
					buffer.append("		<netWeight>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+siObj.getSaleVol()+siObj.getVolUnit()+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</netWeight>\n");
					
					buffer.append("		<producersName>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+winery.getEnterpriseName()+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</producersName>\n");
					
					buffer.append("		<productStandardCode>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</productStandardCode>\n");
					
					buffer.append("		<productionLicenseNumber>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</productionLicenseNumber>\n");
					
					buffer.append("		<provenance>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+winery.getAddress()+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</provenance>\n");
					
					buffer.append("		<suitableAge>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</suitableAge>\n");
					
					buffer.append("		<warning>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</warning>\n");
					
					buffer.append("		<addressAndContact>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+winery.getAddress()+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</addressAndContact>\n");
					
					buffer.append("		<certificateNumber>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</certificateNumber>\n");
					
					buffer.append("		<ingredients>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+product.getMaterial()+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</ingredients>\n");
					
					buffer.append("		<storageCondition>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</storageCondition>\n");
					
					buffer.append("		<mainNutritionalCompositionAndContent>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</mainNutritionalCompositionAndContent>\n");
					
					buffer.append("		<productCategoryAndAttribute>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</productCategoryAndAttribute>\n");
					
					buffer.append("		<instructions>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</instructions>\n");
					
					buffer.append("		<otherInstructions>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</otherInstructions>\n");
					
					buffer.append("		<otherQualityCommitment>\n");
					buffer.append("		 	<value>\n");
					buffer.append("		 		<![CDATA[ "+""+"]]>\n");
					buffer.append("			</value>\n");
					buffer.append("		</otherQualityCommitment>\n");
					
					buffer.append("	</metadata>\n");
					buffer.append("</record>\n");
				}
			}
			
			buffer.append("</ListRecords>\n");
			buffer.append("</root>\n");
			
			FileOutputStream writerStream = new FileOutputStream(filePrefix+".xml");
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8"));      
			writer.write(buffer.toString());
			writer.flush();
			writer.close();
			writerStream.close();
			
			sale.setIsSale("Y");
			sale.update();
			
			request.setAttribute("fileName", fName+".xml");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
}