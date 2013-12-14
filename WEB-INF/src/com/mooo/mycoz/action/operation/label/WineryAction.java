package com.mooo.mycoz.action.operation.label;

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
import com.mooo.mycoz.dbobj.wineBranch.Card;
import com.mooo.mycoz.dbobj.wineBranch.CardJob;
import com.mooo.mycoz.dbobj.wineBranch.WineJar;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineBranch.WineryMap;
import com.mooo.mycoz.dbobj.wineShared.JobState;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class WineryAction extends BaseSupport {

	private static Log log = LogFactory.getLog(WineryAction.class);
	
	public String list(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		String value = null;
		
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(JobState.class, "jobState");
			dbobject.addTable(Winery.class, "winery");

			dbobject.setForeignKey("winery", "stateId", "jobState", "id");

			value = request.getParameter("query_abbreviation");
			if(!StringUtils.isNull(value))
				dbobject.setLike("winery", "shortName", value);
			
			value = request.getParameter("query_definition");
			if(!StringUtils.isNull(value))
				dbobject.setLike("winery", "enterpriseName", value);
			
			value = request.getParameter("query_address");
			if(!StringUtils.isNull(value))
				dbobject.setLike("winery", "address", value);
			
			value = request.getParameter("query_telephone");
			if(!StringUtils.isNull(value))
				dbobject.setLike("winery", "telephone", value);
			
			value = request.getParameter("query_stateId");
			if(!StringUtils.isNull(value))
				dbobject.setField("winery","stateId", new Integer(value));

			dbobject.setOrderBy("winery", "id","DESC");
			
			dbobject.setRetrieveField("winery", "id");
			dbobject.setRetrieveField("winery", "shortName");
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("winery", "address");
			dbobject.setRetrieveField("winery", "mobilePhone");
			dbobject.setRetrieveField("winery", "telephone");
			dbobject.setRetrieveField("jobState", "fullName");

			String branchCategory = ActionSession.getBranchCategory(request);
			String wineryValues = ActionSession.getWineryValues(request,false);
			if(!StringUtils.isNull(branchCategory)){
				
				if(branchCategory.equals("Regulators")){
					if(!StringUtils.isNull(wineryValues))
						dbobject.addCustomWhereClause(" winery.id IN (" + wineryValues+")");
					
					if(branchId!=null){
						dbobject.setField("winery", "branchId",branchId);
					}
				}/*else if(branchCategory.equals("Tasting")){
					if(branchId!=null){
						dbobject.setField("winery", "branchId",branchId);
					}
				}*/
			}
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> winerys = dbobject.searchAndRetrieveList();
			
			request.setAttribute("winerys", winerys);
			
			request.setAttribute("status", IDGenerator.getValues(JobState.class,"id","fullName"));
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";//"list"
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			JobState jobState = new JobState();
			List<?> status = jobState.searchAndRetrieveList();
			request.setAttribute("status", status);

		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		String branchCategory = ActionSession.getBranchCategory(request);
		
		Transaction tx =new Transaction();
		try {
			tx.start();
			
			Winery winery = new Winery();
			ParamUtil.bindData(request, winery,"winery");
			
			winery.setId(IDGenerator.getNextInt(Winery.class));
			
			if(!StringUtils.isNull(branchCategory) && (branchCategory.equals("Regulators")||branchCategory.equals("Tasting")))
				winery.setBranchId(branchId);
			
			winery.add(tx.getConnection());
			
			tx.commit();
		}catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "list";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		Transaction tx =new Transaction();
		try {
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			if(ids!=null)
				for(int i=0;i<ids.length;i++){
					WineryMap wineryMap = new WineryMap();
					wineryMap.setWineryId( new Integer(ids[i]));
					wineryMap.delete(tx.getConnection());
					
					WineJar wineJar = new WineJar();
					wineJar.setWineryId(new Integer(ids[i]));
					wineJar.delete(tx.getConnection());

					Winery bean = new Winery();
					bean.setId( new Integer(ids[i]));
					bean.delete(tx.getConnection());
				}
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();

			request.setAttribute("error", e.getMessage());
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		
		return "list";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {

		try {
			String id =  request.getParameter("id");
			
			if(StringUtils.isNull(id))
				throw new Exception("Please chose object");
			
			Winery winery = new Winery();
			winery.setId( new Integer(id));
			winery.retrieve();
			
			request.setAttribute("winery", winery);
			
			JobState jobState = new JobState();
			List<?> status = jobState.searchAndRetrieveList();
			request.setAttribute("status", status);
		
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "list";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		try {
			Winery winery = new Winery();
			ParamUtil.bindData(request, winery,"winery");
			winery.update();
			
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			request.setAttribute("id", request.getParameter("winery.id"));
			
			return "promptEdit";
		}
		return "list";
	}
	
	public String disableJob(HttpServletRequest request, HttpServletResponse response) {

		Transaction tx=new Transaction();
		try {
			tx.start();
			
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				Winery winery = new Winery();
				winery.setId(new Integer(ids[i]));
				winery.setStateId(3);
				winery.update(tx.getConnection());
				
				WineJar wineJar = new WineJar();
				wineJar.setWineryId(new Integer(ids[i]));
				
				List<Object> wineJars = wineJar.searchAndRetrieveList();
				for(int j=0;j<wineJars.size();j++){
					wineJar = (WineJar) wineJars.get(j);
					
					if(wineJar.getStateId()==3)
						continue;
					
					wineJar.setStateId(3);
					wineJar.update(tx.getConnection());
					
					Card card = new Card();
					card.setWineJarId(wineJar.getId());
					card.setProcessId(0);
					card.retrieve(tx.getConnection());
					
					CardJob cardJob = new CardJob();
					cardJob.setCardId(card.getId());
					cardJob.setBranchId(card.getBranchId());
					
					int processId = cardJob.count(tx.getConnection());
					cardJob.setProcessId(0);
					cardJob.retrieve(tx.getConnection());

					cardJob.setProcessId(processId);
					cardJob.update(tx.getConnection());
					
					int cardJobId = IDGenerator.getNextID(tx.getConnection(),CardJob.class);
					cardJob.setId(cardJobId);
					cardJob.setUserId(ActionSession.getInteger(request,ActionSession.USER_SESSION_KEY));
					cardJob.setJobDate(new Date());
					cardJob.setJobTypeId(11);
					cardJob.setIsPost("A");
					cardJob.setProcessId(0);
					cardJob.setSpotNormal("N");
					cardJob.setCardNormal("N");
			
					cardJob.add(tx.getConnection());
				}
			}
			
			tx.commit();
			request.setAttribute("message", "disable success");
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}finally {
			tx.end();
		}
		return "list";
	}
}