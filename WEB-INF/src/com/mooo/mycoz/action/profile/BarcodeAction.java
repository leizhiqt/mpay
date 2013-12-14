package com.mooo.mycoz.action.profile;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.Barcode;
import com.mooo.mycoz.dbobj.wineBranch.Product;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class BarcodeAction extends BaseSupport {

	private static Log log = LogFactory.getLog(BarcodeAction.class);

	public String listBarcode(HttpServletRequest request,
			HttpServletResponse response) {
		String value = null;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Product.class, "product");
			dbobject.addTable(Barcode.class, "barcode");

			dbobject.setForeignKey("product", "id", "barcode", "productId");

			value = request.getParameter("productId");
			if (!StringUtils.isNull(value)) {
				dbobject.setField("product", "id", new Integer(value));
			}

			value = request.getParameter("point");
			if (!StringUtils.isNull(value)) {
				dbobject.setLike("barcode", "point", value);
			}

			dbobject.setRetrieveField("product", "styleName");
			dbobject.setRetrieveField("barcode", "id");
			dbobject.setRetrieveField("barcode", "pointDate");
			dbobject.setRetrieveField("barcode", "point");
			dbobject.setRetrieveField("barcode", "codeNumber");
			
			dbobject.setOrderBy("barcode", "id", "DESC");

			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(), page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();
			Product product = new Product();

			request.setAttribute("results", results);
			request.setAttribute("products", product.searchAndRetrieveList());
			request.setAttribute("points", IDGenerator.getBarcodePoints());
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
		Product product = new Product();
		List<Object> list = null;
		try {
			list = product.searchAndRetrieveList();
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
			return "listBarcode";
		}
		request.setAttribute("products", list);
		request.setAttribute("points", IDGenerator.getBarcodePoints());
		return "success";
	}

	public String processAdd(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processAdd");
		Transaction tx = new Transaction();
		try {
			tx.start();

			Barcode barcode = new Barcode();
			ParamUtil.bindData(request, barcode, "barcode");

			int barcodeId = IDGenerator.getNextID(tx.getConnection(),
					Barcode.class);
			barcode.setId(barcodeId);
			barcode.setPointDate(new Date());
			barcode.setCodeNumber(IDGenerator
					.getBarcode("690", "12859", "9121"));
			barcode.add(tx.getConnection());

			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptAdd";
		} finally {
			tx.end();
		}
		return "listBarcode";
	}

	public String promptEdit(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("promptEdit");

		String barcodeId = null;
		try {
			barcodeId = request.getParameter("id");
			if (barcodeId == null)
				throw new Exception("Please chose object");

			Barcode barcode = new Barcode();
			barcode.setId(new Integer(barcodeId));
			barcode.retrieve();

			Product product = new Product();
			request.setAttribute("barcode", barcode);
			request.setAttribute("products", product.searchAndRetrieveList());
			request.setAttribute("points", IDGenerator.getBarcodePoints());
		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}

	public String processEdit(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processEdit");
		Transaction tx = new Transaction();
		try {
			tx.start();

			Barcode barcode = new Barcode();
			ParamUtil.bindData(request, barcode, "barcode");
			barcode.setCodeNumber(IDGenerator
					.getBarcode("690", "12859", "9121"));
			barcode.update(tx.getConnection());
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		} finally {
			tx.end();
		}
		return "listBarcode";
	}

	public String processDelete(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("processDelete");

		Transaction tx = new Transaction();
		try {
			tx.start();

			String[] ids = request.getParameterValues("id");

			if (ids == null)
				throw new Exception("Please select delete object");

			for (int i = 0; i < ids.length; i++) {
				Integer id = new Integer(ids[i]);

				Barcode barcode = new Barcode();
				barcode.setId(id);
				barcode.delete(tx.getConnection());
			}

			tx.commit();

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			tx.rollback();

			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "listBarcode";
	}

	public String preview(HttpServletRequest request,
			HttpServletResponse response) {
		if (log.isDebugEnabled())
			log.debug("preview");

		String barcodeId = null;
		try {
			barcodeId = request.getParameter("id");
			if (barcodeId == null)
				throw new Exception("Please chose object");

			Barcode barcode = new Barcode();
			barcode.setId(new Integer(barcodeId));
			barcode.retrieve();

			Product product = new Product();
			product.setId(barcode.getProductId());
			product.retrieve();

			String physicalPath = request.getSession().getServletContext()
					.getRealPath("/");
			String jpegURL = "tmp/" + barcode.getCodeNumber() + ".jpg";
			IDGenerator.generateBarcodeImage(barcode.getCodeNumber(), 105, 50,
					physicalPath + jpegURL);

			request.setAttribute("barcode", barcode);
			request.setAttribute("product", product);
			request.setAttribute("jpegURL", jpegURL);

		} catch (Exception e) {
			if (log.isDebugEnabled())
				log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}

}
