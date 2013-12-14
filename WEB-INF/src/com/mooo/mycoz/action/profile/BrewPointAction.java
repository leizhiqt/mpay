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
import com.mooo.mycoz.dbobj.wineShared.BrewCrafts;
import com.mooo.mycoz.dbobj.wineShared.BrewPoint;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.I18n;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class BrewPointAction extends BaseSupport {

	private static Log log = LogFactory.getLog(BrewPointAction.class);
	
	public String listBrewPoint(HttpServletRequest request,HttpServletResponse response) {
		String value = null;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(BrewPoint.class, "brewPoint");
			dbobject.addTable(BrewCrafts.class, "brewCrafts");

			dbobject.setForeignKey("brewPoint", "brewCraftsId","brewCrafts", "id");
			
			value = request.getParameter("brewCraftsId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("brewCrafts", "id", new Integer(value));
			}
			
			value = request.getParameter("pointName");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("brewPoint", "pointName", value);
			}
			
			value = request.getParameter("pointDesc");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("brewPoint", "pointDesc", value);
			}
			
			dbobject.setRetrieveField("brewCrafts", "craftsName");
			dbobject.setRetrieveField("brewPoint", "id");
			dbobject.setRetrieveField("brewPoint", "pointName");
			dbobject.setRetrieveField("brewPoint", "pointDesc");
			dbobject.setRetrieveField("brewPoint", "pointOrder");

			dbobject.setOrderBy("brewPoint", "id","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			List<?> results = dbobject.searchAndRetrieveList();
			BrewCrafts brewCrafts = new BrewCrafts();
			
			request.setAttribute("results", results);
			request.setAttribute("brewCrafts", brewCrafts.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		BrewCrafts brewCrafts = new BrewCrafts();
		List<Object> list = null;
		try {
			list = brewCrafts.searchAndRetrieveList();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
			return "listBrewPoint";
		}
		request.setAttribute("brewCrafts", list);
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		
		String pString = request.getParameter("brewPoint.pointOrder");
		try{
			Long.valueOf(pString);
		}catch(NumberFormatException e){
			request.setAttribute("error",  I18n.getValue("PointOrderMustBeNumber"));
			return "promptAdd";
		}
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			BrewPoint brewPoint = new BrewPoint();
			ParamUtil.bindData(request, brewPoint,"brewPoint");
			
			int brewPointId = IDGenerator.getNextID(tx.getConnection(),BrewPoint.class);
			brewPoint.setId(brewPointId);
			brewPoint.add(tx.getConnection());
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "listBrewPoint";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String brewPointId = null;
		try{
			brewPointId = request.getParameter("id");
			if(brewPointId==null)
				throw new Exception("Please chose object");
			
			BrewPoint brewPoint = new BrewPoint();
			brewPoint.setId(new Integer(brewPointId));
			brewPoint.retrieve();

			BrewCrafts brewCrafts = new BrewCrafts();
			request.setAttribute("brewPoint", brewPoint);
			request.setAttribute("brewCrafts", brewCrafts.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		String pString = request.getParameter("brewPoint.pointOrder");
		try{
			Long.valueOf(pString);
		}catch(NumberFormatException e){
			request.setAttribute("error",  I18n.getValue("PointOrderMustBeNumber"));
			return "promptEdit";
		}
		
		Transaction tx=new Transaction();
		try{
			tx.start();
			
			BrewPoint brewPoint = new BrewPoint();
			ParamUtil.bindData(request, brewPoint, "brewPoint");
			
			brewPoint.update(tx.getConnection());
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}finally {
			tx.end();
		}
		return "listBrewPoint";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				Integer id = new Integer(ids[i]);
				
				BrewPoint brewPoint = new BrewPoint();
				brewPoint.setId(id);
				brewPoint.delete(tx.getConnection());
			}
			
			tx.commit();
			
			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			tx.rollback();
			
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "listBrewPoint";
	}
	
}
