package com.mooo.mycoz.action.operation.security;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Hashtable;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.dbobj.wineBranch.Product;
import com.mooo.mycoz.dbobj.wineBranch.Sale;
import com.mooo.mycoz.dbobj.wineBranch.SaleItem;
import com.mooo.mycoz.dbobj.wineBranch.SaleJob;
import com.mooo.mycoz.dbobj.wineBranch.SampleItem;
import com.mooo.mycoz.dbobj.wineBranch.SampleProduct;
import com.mooo.mycoz.dbobj.wineBranch.SampleTasting;
import com.mooo.mycoz.dbobj.wineBranch.SampleTest;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineShared.WineTaster;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;

public class SaleAction extends BaseSupport {

private static Log log = LogFactory.getLog(SaleAction.class);

	public String list(HttpServletRequest request,HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("list");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

		String value = null;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(SampleProduct.class, "sampleProduct");
			dbobject.addTable(Sale.class, "sale");
			dbobject.addTable(SaleItem.class, "saleItem");
			dbobject.addTable(Product.class, "product");
			dbobject.addTable(SaleJob.class, "saleJob");
			
			dbobject.setForeignKey("winery", "id","product", "enterpriseId");
			dbobject.setForeignKey("sampleProduct", "productId","product", "id");
			dbobject.setForeignKey("sampleProduct", "id","saleItem", "sampleId");
			dbobject.setForeignKey("sale", "id","saleItem", "saleId");
			dbobject.setForeignKey("saleJob", "itemId","saleItem", "id");
			
			value = request.getParameter("wineryId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("winery", "id", new Integer(value));
			}
			
			value = request.getParameter("BatchNo");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("sale", "batchNo", value);
				request.setAttribute("BatchNo", value);
			}
			
			value = request.getParameter("SaleCode");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("saleJob", "saleCode", value);
				request.setAttribute("SaleCode", value);
			}
			
			value = request.getParameter("StartDate");
			if(!StringUtils.isNull(value)){
				dbobject.setGreaterEqual("sale", "saleDate", value);
			}
			
			value = request.getParameter("EndDate");
			if(!StringUtils.isNull(value)){
				dbobject.setLessEqual("sale", "saleDate", value);
			}
			
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("product", "productName");
			dbobject.setRetrieveField("product", "alcohol");

			dbobject.setRetrieveField("sampleProduct", "expertScore");
			
			dbobject.setRetrieveField("sale", "batchNo");
			dbobject.setRetrieveField("sale", "saleDate");
			dbobject.setRetrieveField("sale", "isSale");

			dbobject.setRetrieveField("saleItem", "salePrice");
			dbobject.setRetrieveField("saleItem", "saleCurr");
			dbobject.setRetrieveField("saleItem", "saleVol");
			dbobject.setRetrieveField("saleItem", "volUnit");
			dbobject.setRetrieveField("saleJob", "saleCode");
			dbobject.setRetrieveField("saleJob", "jobDate");
			dbobject.setRetrieveField("saleJob", "jobBy");//Sale:U Q D->Up Query Down
			dbobject.setRetrieveField("saleJob", "id");

			dbobject.setOrderBy("saleJob", "id","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();
			
			request.setAttribute("results", results);
			
			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));

		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		
		return "success";
	}
	
	public String preview(HttpServletRequest request,HttpServletResponse response) {
		try {
				String id =  request.getParameter("id");
				
				if(id==null) throw new Exception("Please select modify object");
				
				SaleJob saleJob = new SaleJob();
				saleJob.setId(new Integer(id));
				saleJob.retrieve();
				request.setAttribute("saleJob", saleJob);

				SaleItem saleItem = new SaleItem();
				saleItem.setId(saleJob.getItemId());
				saleItem.retrieve();

				Sale sale = new Sale();
				sale.setId(saleItem.getSaleId());
				sale.retrieve();
	
				SampleProduct sampleProduct = new SampleProduct();
				sampleProduct.setId(saleItem.getSampleId());
				sampleProduct.retrieve();
				
				Product product = new Product();
				product.setId(sampleProduct.getProductId());
				product.retrieve();
				
				Winery winery = new Winery();
				winery.setId(product.getEnterpriseId());
				winery.retrieve();
				
				int width=150, height=150;
				
				String contents ="";
				contents = winery.getEnterpriseName1()+"."+product.getProductName()+"\n";
				contents += "专家酒体评分:"+sampleProduct.getExpertScore()+"分"+"\n";
				contents += "售价:"+saleItem.getSalePrice()+"元/瓶 (2013)"+"\n";
				contents += "http://86999.org/Sale.do?method=check&FC="+saleJob.getSaleCode();
				
				System.out.println("http://localhost:8080/sfwine/Sale.do?method=check&FC="+saleJob.getSaleCode());
				
	            Hashtable<EncodeHintType, Object> hintMap = new Hashtable<EncodeHintType, Object>();
	            //指定纠错等级
	            hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
	            //指定编码格式
	            //hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
	            //hintMap.put(EncodeHintType.CHARACTER_SET, "GB18030");
	            
	            QRCodeWriter qrCodeWriter = new QRCodeWriter();
	            String buf = new String(contents.getBytes("UTF-8"),"ISO-8859-1");
	            BitMatrix byteMatrix = qrCodeWriter.encode(buf,BarcodeFormat.QR_CODE, width, height, hintMap);
	            
	            int CrunchifyWidth = byteMatrix.getWidth();
	            BufferedImage image = new BufferedImage(CrunchifyWidth, CrunchifyWidth,BufferedImage.TYPE_INT_RGB);
	 
	            Graphics2D graphics = (Graphics2D) image.getGraphics();
	            graphics.setColor(Color.WHITE);
	            graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
	            graphics.setColor(Color.BLACK);
	 
	            for (int i = 0; i < CrunchifyWidth; i++) {
	                for (int j = 0; j < CrunchifyWidth; j++) {
	                    if (byteMatrix.get(i, j)) {
	                        graphics.fillRect(i, j, 1, 1);
	                    }
	                }
	            }
	            //ImageIO.write(image, "png", new File(imgPath));
	            
				String physicalPath = request.getSession().getServletContext().getRealPath("/");
				
				String tmpFNPrefix="tmp/"+System.currentTimeMillis()+".png";
				
				ImageIO.write(image, "png", new File(physicalPath+tmpFNPrefix));
				
				request.setAttribute("jpegURL", tmpFNPrefix);

				String sp="\r\n";

				StringBuffer buffer = new StringBuffer();
				buffer.append("^XA"+sp);
				buffer.append("^FO50,100"+sp);
				buffer.append("^BQN,2,3"+sp);
				buffer.append("^FDMA,");
				buffer.append(contents+sp);
				buffer.append("^FS"+sp);
				buffer.append("^XZ"+sp);
				
				/*
				"^XA" +
				"^FO50,100^BQN,2,3" +
				"^FDMA," +
				"\n防伪码:SCYJPT13031900001" +
				"\n名称:源酒15年52度500ml(浓香型)" +
				"\n产地:四川宜宾市李庄下坝" +
				"\n生产日期:2010.10.01(瓶号:YF012005)" +
				"\n朔源地址:http://www.86999.org" +
				"^FS" +
				
				"^FO350,100^BQN,2,3" +
				"^FDMA," +
				"\n防伪码:SCYJPT13031900002" +
				"\n名称:源酒15年52度500ml(浓香型)" +
				"\n产地:四川宜宾市李庄下坝" +
				"\n生产日期:2010.10.01(瓶号:YF012006)" +
				"\n朔源地址:http://www.86999.org" +
				"^FS" +

				"^XZ";
				*/
	            String tmpS = buffer.toString();
	            
				request.setAttribute("ZPL", tmpS);

//			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "list";
		}
		return "success";
	}
	
	public String check(HttpServletRequest request,HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("check");
		try {
			String fc = request.getParameter("FC");
			
			if(StringUtils.isNull(fc))
				fc = request.getParameter("amp;FC");
			
			StringUtils.noNull(fc);
			
			SaleJob saleJob = new SaleJob();
			saleJob.setSaleCode(fc);
			saleJob.retrieve();
			
			SaleItem saleItem = new SaleItem();
			saleItem.setId(saleJob.getItemId());
			saleItem.retrieve();
			request.setAttribute("saleItem", saleItem);
			
			Sale sale = new Sale();
			sale.setId(saleItem.getSaleId());
			sale.retrieve();
			request.setAttribute("sale", sale);
			
			SampleProduct sampleProduct = new SampleProduct();
			sampleProduct.setId(saleItem.getSampleId());
			sampleProduct.retrieve();
			request.setAttribute("sampleProduct", sampleProduct);
			
			SampleTest sampleTest = new SampleTest();
			sampleTest.setSampleId(sampleProduct.getId());
			sampleTest.retrieve();
			request.setAttribute("sampleTest", sampleTest);

			SampleItem sampleItem = new SampleItem();
			sampleItem.setSampleId(sampleProduct.getId());
			
			List<?> sampleItems = sampleItem.searchAndRetrieveList();
			request.setAttribute("sampleItems", sampleItems);

			double totalVol = 0d;
			
			for(Object obj:sampleItems){
				sampleItem = (SampleItem)obj;
				totalVol+=sampleItem.getItemVol();
			}
			request.setAttribute("totalVol", totalVol);
			
			Product product = new Product();
			product.setId(sampleProduct.getProductId());
			product.retrieve();
			request.setAttribute("product", product);
			
			Winery winery = new Winery();
			winery.setId(product.getEnterpriseId());
			winery.retrieve();
			
			request.setAttribute("winery", winery);
			
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(SampleTasting.class, "sampleTasting");
			dbobject.addTable(WineTaster.class, "wineTaster");
			
			dbobject.setForeignKey("wineTaster", "id","sampleTasting", "tasterId");
			dbobject.setField("sampleTasting", "sampleId",sampleProduct.getId());

			dbobject.setRetrieveField("sampleTasting", "id");
			dbobject.setRetrieveField("wineTaster", "tasterName");
			dbobject.setRetrieveField("wineTaster", "tasterLicense");
			dbobject.setRetrieveField("wineTaster", "tasterCategory");
			
			request.setAttribute("sampleTastings", dbobject.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
}