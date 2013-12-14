package com.mooo.mycoz.action.operation.label;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.CalendarUtils;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.Card;
import com.mooo.mycoz.dbobj.wineBranch.CardJob;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineBranch.WineJar;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineShared.CardType;
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.dbobj.wineShared.WineLevel;
import com.mooo.mycoz.dbobj.wineShared.WineType;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.JRUtil;
import com.mooo.mycoz.framework.component.JRExport;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class CardAction extends BaseSupport {

private static Log log = LogFactory.getLog(CardAction.class);

	public String listCard(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		
		//报表参数
		String reportName="Cards";

		Vector<String> colName = new Vector<String>();
		Vector<String> colSum = new Vector<String>();
		Vector<Integer> colWidth = new Vector<Integer>();
		
		String value = null;
		try {
			Calendar now = Calendar.getInstance();
			
			String startDate = request.getParameter("StartDate");
			if(startDate==null){
				now.add(Calendar.YEAR, -1);
				now.add(Calendar.DAY_OF_MONTH, 1);
				startDate = CalendarUtils.dformat(now.getTime());
			}
			request.setAttribute("StartDate", startDate);
			
			String endDate = request.getParameter("EndDate");
			if(endDate==null){
				now.add(Calendar.YEAR, 1);
				endDate = CalendarUtils.dformat(now.getTime());
			}
			request.setAttribute("EndDate", endDate);
			
			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));

			request.setAttribute("jobTypes", IDGenerator.getValues(JobType.class));

			request.setAttribute("reportName", reportName);

			value="酒厂";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒罐号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="状态";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="操作员";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="操作时间";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="标识号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="序列号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="位置";
			colName.add(value);colWidth.add(StringUtils.length(value));
			
			StringBuilder buffer = new StringBuilder();
			buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			buffer.append("<Reports>\n");
			
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(CardJob.class, "cardJob");
			dbobject.addTable(Card.class, "card");
			dbobject.addTable(Winery.class, "winery");
			
			dbobject.addTable(User.class, "user");
			dbobject.addTable(CardType.class, "cardType");
			dbobject.addTable(JobType.class, "jobType");
			
			dbobject.setForeignKey("card", "cardTypeId", "cardType", "id");
			
			dbobject.setForeignKey("card", "wineryId", "winery", "id");
			dbobject.setForeignKey("card", "branchId", "winery", "branchId");

			dbobject.setForeignKey("cardJob", "cardId", "card", "id");
			dbobject.setForeignKey("cardJob", "branchId", "card", "branchId");

			dbobject.setForeignKey("cardJob", "userId","user", "id");
			dbobject.setForeignKey("cardJob", "branchId","user", "branchId");

			dbobject.setForeignKey("jobType", "id", "cardJob", "jobTypeId");
			
			dbobject.setField("cardJob", "processId",0);
			
			if(!StringUtils.isNull(startDate))
				dbobject.setGreaterEqual("cardJob", "jobDate", startDate);
			
			if(!StringUtils.isNull(endDate))
				dbobject.setLessEqual("cardJob", "jobDate", endDate);
			
			value = request.getParameter("wineryId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("winery", "id", new Integer(value));
			}else{
				if(request.getAttribute("wineryId")!=null)
					dbobject.setField("winery", "id", (Integer)request.getAttribute("wineryId"));
			}
			
			value = request.getParameter("rfidcode");
			if(!StringUtils.isNull(value))
				dbobject.setLike("card", "rfidcode", value);
			
			value = request.getParameter("jobTypeId");
			if(!StringUtils.isNull(value))
				dbobject.setField("jobType", "id", value);
			
			String branchCategory = ActionSession.getBranchCategory(request);
			String wineryValues = ActionSession.getWineryValues(request);
			if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Regulators")){
				if(!StringUtils.isNull(wineryValues))
					dbobject.addCustomWhereClause(" winery.id IN (" + wineryValues+")");
				
				if(branchId!=null){
					dbobject.setField("winery","branchId", branchId);
				}
			}
			
			dbobject.setRetrieveField("card", "id");
			dbobject.setRetrieveField("card", "rfidcode");
			dbobject.setRetrieveField("card", "uuid");
			dbobject.setRetrieveField("card", "position");
			dbobject.setRetrieveField("card", "wineJarId");
			dbobject.setRetrieveField("card", "remark");
			
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("jobType", "definition");
			
			dbobject.setRetrieveField("cardJob", "jobDate");

			dbobject.setRetrieveField("user", "name");
			dbobject.setRetrieveField("cardType", "cardTypeName");

			dbobject.setOrderBy("card", "rfidcode");

			Page page = new Page();
			page.buildComponent(request, dbobject.count());

			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> results = dbobject.searchAndRetrieveList();
			
			for(Object orow:results){
				buffer.append("<Rows>\n");
				Map rowm = (Map)orow;
				
				Winery winery = (Winery)rowm.get("winery");
				Card card = (Card)rowm.get("card");
				User user = (User)rowm.get("user");

				//column start
				value=winery.getEnterpriseName();
				if(value.length()>colWidth.get(0)){
					colWidth.set(0, StringUtils.length(value));
				}
				buffer.append("<Key0>"+value+"</Key0>\n");

				//column start
				if(value.length()>colWidth.get(1)){
					colWidth.set(1, StringUtils.length(value));
				}
				buffer.append("<Key1>"+value+"</Key1>\n");
				
				//column start
				if(value.length()>colWidth.get(2)){
					colWidth.set(2, StringUtils.length(value));
				}
				buffer.append("<Key2>"+value+"</Key2>\n");
				
				//column start
				value=user.getName();
				if(value.length()>colWidth.get(3)){
					colWidth.set(3, StringUtils.length(value));
				}
				buffer.append("<Key3>"+value+"</Key3>\n");
				
				//column start
				if(value.length()>colWidth.get(4)){
					colWidth.set(4, StringUtils.length(value));
				}
				buffer.append("<Key4>"+value+"</Key4>\n");
				
				//column start
				value=card.getRfidcode();
				if(value.length()>colWidth.get(5)){
					colWidth.set(5, StringUtils.length(value));
				}
				
				buffer.append("<Key5>"+value+"</Key5>\n");
				
				//column start
				value=card.getUuid();
				if(value.length()>colWidth.get(6)){
					colWidth.set(6, StringUtils.length(value));
				}
				buffer.append("<Key6>"+value+"</Key6>\n");
				
				//column start
				value=card.getPosition()+"";
				if(card.getPosition()==null){
					value="";
				}
				
				if(value.length()>colWidth.get(7)){
					colWidth.set(7, StringUtils.length(value));
				}
				buffer.append("<Key7>"+value+"</Key7>\n");
				
				//put data
				buffer.append("</Rows>\n");
			}
			request.setAttribute("results", results);
			
			buffer.append("</Reports>\n");
			
			String filePrefix=physicalPath+"tmp/"+reportName;
			
			FileOutputStream writerStream = new FileOutputStream(filePrefix+".xml");
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8"));      
			writer.write(buffer.toString());
			writer.flush();
			writer.close();
			writerStream.close();
			
			String jrxml = JRUtil.createJRXML(reportName, "源酒产业联盟", "标签", colName, colSum, colWidth, "/Reports/Rows");
			writerStream = new FileOutputStream(filePrefix+".jrxml");
			writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8")); 
			writer.write(jrxml.toString());
			writer.flush();
			writer.close();
			writerStream.close();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.printStackTrace();
		}
		return "success";
	}
	
	public String exportCard(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String printCard(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

		request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			Card card = new Card();
			ParamUtil.bindData(request, card,"card");
			
			int cardId = IDGenerator.getNextID(tx.getConnection(),Card.class);
			card.setId(cardId);
			card.setBranchId(branchId);
			card.add(tx.getConnection());
			
			CardJob cardJob = new CardJob();
			ParamUtil.bindData(request, cardJob,"cardJob");
			cardJob.setCardId(cardId);
			
			cardJob.setId(IDGenerator.getNextID(tx.getConnection(),CardJob.class));
			cardJob.setBranchId(branchId);
			cardJob.setUserId(sessionId);
			cardJob.setProcessId(0);
			cardJob.add(tx.getConnection());

			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptAdd";
		} finally {
			tx.end();
		}
		return "listCard";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);

		Transaction tx=new Transaction();
		try {
			tx.start();
			
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null || ids.length==0)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				CardJob cardJob = new CardJob();
				cardJob.setCardId(new Integer(ids[i]));
				cardJob.setBranchId(branchId);
				
				if(cardJob.count(tx.getConnection()) ==1){
					cardJob.delete(tx.getConnection());
				}
				
				Card card = new Card();
				card.setId( new Integer(ids[i]));
				card.setBranchId(branchId);
				card.delete(tx.getConnection());
			}
			tx.commit();
			
			if (log.isDebugEnabled()) log.debug("Delete Card finsh");
		} catch (Exception e) {
			tx.rollback();

			request.setAttribute("error", e.getMessage());
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		} finally {
			tx.end();
		}
		return "listCard";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
//		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		try {
				String id =  request.getParameter("id");

				if(StringUtils.isNull(id))
					throw new Exception("Please select object");
			
				Card card = new Card();
				card.setId( new Integer(id));
				card.retrieve();
				
				request.setAttribute("card", card);
				
				Winery winery = new Winery();
				winery.setId(card.getWineryId());
				winery.setBranchId(card.getBranchId());
				winery.retrieve();
				
				request.setAttribute("winery", winery);

				MultiDBObject dbobject = new MultiDBObject();
				dbobject.addTable(WineJar.class, "wineJar");
				dbobject.addTable(Winery.class, "winery");

				dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
				dbobject.setForeignKey("wineJar", "branchId", "winery", "branchId");
				
				dbobject.setGreater("wineJar","id", 0);
				dbobject.setField("winery", "id", winery.getId());
				
				String value = ActionSession.getWineryValues(request);

				if(!StringUtils.isNull(value))
					dbobject.addCustomWhereClause(" winery.id IN (" + value+")");

				dbobject.setRetrieveField("winery", "id");
				dbobject.setRetrieveField("winery", "shortName");
				dbobject.setRetrieveField("winery", "enterpriseName");
				dbobject.setRetrieveField("wineJar", "id");
				dbobject.setRetrieveField("wineJar", "jarNumber");

				request.setAttribute("wineJars", dbobject.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "listCard";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);

		Transaction tx=new Transaction();
		try {
			tx.start();
			
			Card card = new Card();
			ParamUtil.bindData(request, card,"card");
			card.setBranchId(branchId);

			card.update(tx.getConnection());
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		} finally {
			tx.end();
		}
		return "listCard";
	}

public String view(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("view");
		try {
			String id =  request.getParameter("id");

			if(StringUtils.isNull(id))
				throw new Exception("Please select object");
			
			Card card = new Card();
			card.setId( new Integer(id));
			card.retrieve();
			request.setAttribute("card", card);
			
			Integer i = card.getWineJarId();
			
			WineJar wineJar = new WineJar();
			request.setAttribute("wineJar", wineJar);

			WineType wineType = new WineType();
			request.setAttribute("wineType", wineType);

			WineLevel wineLevel= new WineLevel();
			request.setAttribute("wineLevel", wineLevel);

			if(i!=null && i!=0){
				wineJar.setId(i);
				wineJar.retrieve();
				
				wineType.setId(wineJar.getWineTypeId());
				wineType.retrieve();

				wineLevel.setId(wineJar.getWineLevelId());
				wineLevel.retrieve();
			}
			
			CardJob cardJob = new CardJob();
			cardJob.setCardId(card.getId());
			request.setAttribute("cardJobs", cardJob.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "listCardJob";
		}
		return "success";
	}

public String chooseWinery(HttpServletRequest request, HttpServletResponse response) {
	return "success";
}

public String promptActivate(HttpServletRequest request, HttpServletResponse response) {
	if (log.isDebugEnabled())log.debug("promptActivate");
	Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
	String wineryName = request.getParameter("winery");
	try {
			Winery winery = new Winery();
			winery.setEnterpriseName(wineryName);
			winery.retrieve();
			
			request.setAttribute("winery", winery);

			MultiDBObject dbobject = null;

			dbobject = new MultiDBObject();
			dbobject.addTable(CardJob.class, "cardJob");
			dbobject.addTable(Card.class, "card");
			
			dbobject.setForeignKey("cardJob", "cardId", "card", "id");
			dbobject.setForeignKey("cardJob", "branchId", "card", "branchId");

			dbobject.setField("cardJob","jobTypeId", 1);
			dbobject.setField("cardJob","processId", 0);
			dbobject.setField("cardJob","branchId", branchId);
			dbobject.setField("card","wineryId", winery.getId());

			dbobject.setRetrieveField("card", "id");
			dbobject.setRetrieveField("card", "rfidcode");
			
			dbobject.setOrderBy("card", "id","DESC");
			
			request.setAttribute("cards", dbobject.searchAndRetrieveList());
	} catch (Exception e) {
		if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		request.setAttribute("error", e.getMessage());
		
		return "listCard";
	}
	return "success";
}

public String processActivate(HttpServletRequest request, HttpServletResponse response) {
	if (log.isDebugEnabled())log.debug("processActivate");
	Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
	Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

	Transaction tx=new Transaction();
	try {
		tx.start();
		
		Winery winery = new Winery();
		ParamUtil.bindData(request, winery,"winery");
		winery.retrieve();
		
		request.setAttribute("winery", winery);
		
		String value = request.getParameter("alength");
		
		Integer alength = new Integer(value);
		
		for(int i=0;i<alength;i++){
			value = request.getParameter("wineJarId"+i);
			
			if(StringUtils.isNull(value)){
				continue;
			}
			
			WineJar wineJar= new WineJar();
			wineJar.setJarNumber(value);
			wineJar.setWineryId(winery.getId());
			wineJar.retrieve(tx.getConnection());
			
			Card card = new Card();
			
			value = request.getParameter("cardId"+i);
			
			card.setId(new Integer(value));
			
			
			card.setWineJarId(wineJar.getId());
			
			value = request.getParameter("cardPosition"+i);
			
			card.setPosition(value);
			
			card.update(tx.getConnection());

			CardJob cardJob = new CardJob();
			cardJob.setCardId(card.getId());
			cardJob.setBranchId(branchId);

			int processId = cardJob.count(tx.getConnection());
			cardJob.setProcessId(0);
			cardJob.retrieve(tx.getConnection());

			cardJob.setProcessId(processId);
			cardJob.update(tx.getConnection());
			
			ParamUtil.bindData(request, cardJob,"cardJob");
			int cardJobId = IDGenerator.getNextID(tx.getConnection(),CardJob.class);
			cardJob.setId(cardJobId);
			cardJob.setUserId(sessionId);
			cardJob.setJobDate(new Date());
			cardJob.setSpotNormal("Y");
			cardJob.setCardNormal("Y");
			cardJob.setProcessId(0);
			cardJob.setJobTypeId(2);
			cardJob.add(tx.getConnection());
		}
		tx.commit();
	} catch (Exception e) {
		tx.rollback();
		if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		request.setAttribute("error", e.getMessage());
		
		return "promptActivate";
	} finally {
		tx.end();
	}
	return "listCard";
}

public String processCanceled(HttpServletRequest request, HttpServletResponse response) {
	if (log.isDebugEnabled())log.debug("processActivate");
	Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
	Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

	Transaction tx=new Transaction();
	try {
		tx.start();
		
		String[] ids =  request.getParameterValues("id");
		
		if(ids==null || ids.length==0)
			throw new Exception("Please select delete object");
		
		for(int i=0;i<ids.length;i++){
			
			Card card = new Card();
			card.setId(new Integer(ids[i]));
			card.retrieve(tx.getConnection());

			CardJob cardJob = new CardJob();
			cardJob.setCardId(card.getId());
			cardJob.setBranchId(branchId);

			int processId = cardJob.count(tx.getConnection());
			cardJob.setProcessId(0);
			cardJob.retrieve(tx.getConnection());

			cardJob.setProcessId(processId);
			cardJob.update(tx.getConnection());
			
			ParamUtil.bindData(request, cardJob,"cardJob");
			int cardJobId = IDGenerator.getNextID(tx.getConnection(),CardJob.class);
			cardJob.setId(cardJobId);
			cardJob.setUserId(sessionId);
			cardJob.setJobDate(new Date());
			cardJob.setSpotNormal("Y");
			cardJob.setCardNormal("Y");
			cardJob.setProcessId(0);
			cardJob.setJobTypeId(11);
			cardJob.add(tx.getConnection());
		}
		tx.commit();
	} catch (Exception e) {
		tx.rollback();
		if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		request.setAttribute("error", e.getMessage());
		
	} finally {
		tx.end();
	}
	return "listCard";
}
}
