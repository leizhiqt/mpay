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
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.JRUtil;
import com.mooo.mycoz.framework.component.JRExport;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;

public class CardJobAction extends BaseSupport {

private static Log log = LogFactory.getLog(CardJobAction.class);

public String listCardJob(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("patrol");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		
		//报表参数
		String reportName="PatrolCard";
	
		Vector<String> colName = new Vector<String>();
		Vector<String> colSum = new Vector<String>();
		Vector<Integer> colWidth = new Vector<Integer>();
		
		String value = null;
		try {
			Calendar now = Calendar.getInstance();
			
			String startDate = request.getParameter("StartDate");
			if(startDate==null){
				now.add(Calendar.YEAR, -1);
				startDate = CalendarUtils.dformat(now.getTime());
			}
			request.setAttribute("StartDate", startDate);
			
			String endDate = request.getParameter("EndDate");
			if(endDate==null){
				now.add(Calendar.YEAR, 1);
				now.add(Calendar.DAY_OF_MONTH, 1);
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
			value="标识号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="位置";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="业务类型";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="操作员";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="业务时间";
			colName.add(value);colWidth.add(StringUtils.length(value));
			
			StringBuilder buffer = new StringBuilder();
			buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			buffer.append("<Reports>\n");
			
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(CardJob.class, "cardJob");
			dbobject.addTable(Card.class, "card");
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(WineJar.class, "wineJar");

			dbobject.addTable(User.class, "user");
			dbobject.addTable(JobType.class, "jobType");
			dbobject.addTable(CardType.class, "cardType");

			dbobject.setForeignKey("card", "cardTypeId", "cardType", "id");

			dbobject.setForeignKey("card", "wineJarId", "wineJar", "id");
			dbobject.setForeignKey("card", "wineryId", "wineJar", "wineryId");
			dbobject.setForeignKey("card", "branchId", "wineJar", "branchId");
			
			dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
			dbobject.setForeignKey("wineJar", "branchId", "winery", "branchId");
			dbobject.setForeignKey("wineJar", "stateId", "jobState", "id");

			dbobject.setForeignKey("cardJob", "cardId", "card", "id");
			dbobject.setForeignKey("cardJob", "branchId", "card", "branchId");
	
			dbobject.setForeignKey("cardJob", "userId","user", "id");
			dbobject.setForeignKey("cardJob", "branchId","user", "branchId");
			
			dbobject.setForeignKey("jobType", "id", "cardJob", "jobTypeId");
			
			value = request.getParameter("wineryId");
			if(!StringUtils.isNull(value))
				dbobject.setField("winery", "id", new Integer(value));
			
			value = request.getParameter("wineJar");
			if(!StringUtils.isNull(value))
				dbobject.setLike("wineJar", "jarNumber", value);
			
			value = request.getParameter("rfidCode");
			if(!StringUtils.isNull(value))
				dbobject.setLike("card", "rfidcode", value);
			
			value = request.getParameter("jobTypeId");
			if(!StringUtils.isNull(value))
				dbobject.setField("jobType", "id", new Integer(value));
			
			value = request.getParameter("stateId");
			if(!StringUtils.isNull(value))
				dbobject.setField("wineJar", "stateId", new Integer(value));
			
			if(!StringUtils.isNull(startDate))
				dbobject.setGreaterEqual("cardJob", "jobDate", startDate);
			
			if(!StringUtils.isNull(endDate))
				dbobject.setLessEqual("cardJob", "jobDate", endDate);
			
			String branchCategory = ActionSession.getBranchCategory(request);
			String wineryValues = ActionSession.getWineryValues(request);
			
			if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Bank")){
				dbobject.addCustomWhereClause(" wineJar.bankId=" + sessionId);
			}else if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Regulators")){
				if(!StringUtils.isNull(wineryValues))
					dbobject.addCustomWhereClause(" winery.id IN (" + wineryValues+")");
				
				dbobject.setField("winery","branchId", branchId);
			}
			
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("card", "rfidcode");
			dbobject.setRetrieveField("card", "position");
			
			dbobject.setRetrieveField("cardJob", "remark");
			dbobject.setRetrieveField("cardJob", "id");
			dbobject.setRetrieveField("cardJob", "jobDate");
			dbobject.setRetrieveField("cardJob", "spotNormal");
			dbobject.setRetrieveField("cardJob", "cardNormal");
			dbobject.setRetrieveField("cardJob", "jobTypeId");
			dbobject.setRetrieveField("cardJob", "processId");
	
			dbobject.setRetrieveField("user", "name");
			dbobject.setRetrieveField("cardType", "cardTypeName");
			dbobject.setRetrieveField("jobType", "definition");
			dbobject.setRetrieveField("jobState", "fullName");
			dbobject.setRetrieveField("wineJar", "jarNumber");
			
			dbobject.setOrderBy("cardJob", "id","DESC");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> resuls = dbobject.searchAndRetrieveList();
			
			for(Object orow:resuls){
				buffer.append("<Rows>\n");
				Map rowm = (Map)orow;
				
				Winery winery = (Winery)rowm.get("winery");
				WineJar wineJar = (WineJar)rowm.get("wineJar");
				CardJob cardJob = (CardJob)rowm.get("cardJob");
				Card card = (Card)rowm.get("card");
				JobType jobType = (JobType)rowm.get("jobType");
				User user = (User)rowm.get("user");
	
				//column start
				value=winery.getEnterpriseName();
				if(value !=null && value.length()>colWidth.get(0)){
					colWidth.set(0, StringUtils.length(value));
				}
				buffer.append("<Key0>"+value+"</Key0>\n");
	
				//column start
				value=wineJar.getJarNumber();
				if(value !=null && value.length()>colWidth.get(1)){
					colWidth.set(1, StringUtils.length(value));
				}
				buffer.append("<Key1>"+value+"</Key1>\n");
				
				//column start
				value=card.getRfidcode();
				if(value !=null && value.length()>colWidth.get(2)){
					colWidth.set(2, StringUtils.length(value));
				}
				buffer.append("<Key2>"+value+"</Key2>\n");
				
				//column start
				value=card.getPosition()+"";
				if(value !=null && value.length()>colWidth.get(3)){
					colWidth.set(3, StringUtils.length(value));
				}
				buffer.append("<Key3>"+value+"</Key3>\n");
				
				//column start
//				value=jobType.getDefinition();
				if(value.length()>colWidth.get(4)){
					colWidth.set(4, StringUtils.length(value));
				}
				buffer.append("<Key4>"+value+"</Key4>\n");
				
				//column start
				value=user.getName();
				if(value !=null && value.length()>colWidth.get(5)){
					colWidth.set(5, StringUtils.length(value));
				}
				
				buffer.append("<Key5>"+value+"</Key5>\n");
				
				//column start
				value=CalendarUtils.dtformat(cardJob.getJobDate());
				if(value !=null && value.length()>colWidth.get(6)){
					colWidth.set(6, StringUtils.length(value));
				}
				buffer.append("<Key6>"+value+"</Key6>\n");
				
				//put data
				buffer.append("</Rows>\n");
			}
			request.setAttribute("cards", resuls);
			
			buffer.append("</Reports>\n");
			
			String filePrefix=physicalPath+"tmp/"+reportName;
			
			FileOutputStream writerStream = new FileOutputStream(filePrefix+".xml");
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8"));      
			writer.write(buffer.toString());
			writer.flush();
			writer.close();
			writerStream.close();
			
			String jrxml = JRUtil.createJRXML(reportName, "源酒产业联盟", "巡检明细", colName, colSum, colWidth, "/Reports/Rows");
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

public String exportCardJob(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}

public String printCardJob(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}

public String wineryCardJob(HttpServletRequest request, HttpServletResponse response) {
	return "success";
}

public String promptChange(HttpServletRequest request, HttpServletResponse response) {
	if (log.isDebugEnabled())log.debug("promptActivate");
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
		dbobject.addTable(WineJar.class, "wineJar");

		dbobject.setForeignKey("cardJob", "cardId", "card", "id");
		dbobject.setForeignKey("cardJob", "branchId", "card", "branchId");
		dbobject.setForeignKey("card", "wineJarId", "wineJar", "id");
		dbobject.setForeignKey("card", "branchId", "wineJar", "branchId");
		
		dbobject.setField("cardJob","jobTypeId", 3);
		dbobject.setField("cardJob","processId", 0);
		dbobject.setField("card","wineryId", winery.getId());
		dbobject.setNotEqual("wineJar", "stateId", 3);
		
		dbobject.setRetrieveField("card", "id");
		dbobject.setRetrieveField("card", "rfidcode");
		dbobject.setRetrieveField("card", "position");
		dbobject.setRetrieveField("wineJar", "jarNumber");
		
		dbobject.setOrderBy("wineJar", "id","DESC");
		
		request.setAttribute("cards", dbobject.searchAndRetrieveList());
	} catch (Exception e) {
		if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		request.setAttribute("error", e.getMessage());
		e.printStackTrace();
		
		return "listCardJob";
	}
	return "success";
}

public String processChange(HttpServletRequest request, HttpServletResponse response) {
	if (log.isDebugEnabled())log.debug("processChange");
	Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
	String value = null;
	
	String cardId = null;
	String changeCardId = null;
	
	Transaction tx=new Transaction();
	try {
		tx.start();
		
		value = request.getParameter("alength");
		
		Integer alength = new Integer(value);
		
		for(int i=0;i<alength;i++){
			cardId = request.getParameter("cardId"+i);
			
			changeCardId = request.getParameter("rfidcode"+i);
			
			if(StringUtils.isNull(changeCardId)){
				continue;
			}
			
			Card oldCard = new Card();
			oldCard.setId(new Integer(cardId));
			oldCard.retrieve(tx.getConnection());
			//update card
			Card changeCard = new Card();
			changeCard.setWineJarId(oldCard.getWineJarId());
			changeCard.setBranchId(oldCard.getBranchId());
			int processId = changeCard.count(tx.getConnection());
			changeCard.setProcessId(0);
			changeCard.retrieve(tx.getConnection());
			
			changeCard.setProcessId(processId);
			changeCard.update(tx.getConnection());
			
			CardJob oldCardJob = new CardJob();
			oldCardJob.setCardId(new Integer(cardId));
			oldCardJob.setBranchId(oldCard.getBranchId());
			
			processId = oldCardJob.count(tx.getConnection());
			oldCardJob.setProcessId(0);
			oldCardJob.retrieve(tx.getConnection());
			
			oldCardJob.setProcessId(processId);
			oldCardJob.update(tx.getConnection());
			
			oldCardJob.setId(IDGenerator.getNextID(tx.getConnection(),CardJob.class));
			oldCardJob.setProcessId(0);
			oldCardJob.setUserId(sessionId);
			oldCardJob.setJobDate(new Date());
			oldCardJob.setJobTypeId(11);
			
			value = request.getParameter("remark");
			if(!StringUtils.isNull(value)){
				oldCardJob.setRemark(value);
			}
			
			value = request.getParameter("spotNormal");
			if(!StringUtils.isNull(value))
				oldCardJob.setSpotNormal(value);
			else 
				oldCardJob.setSpotNormal("N");
			
			value = request.getParameter("cardNormal");
			if(!StringUtils.isNull(value))
				oldCardJob.setCardNormal(value);
			else
				oldCardJob.setCardNormal("N");
			
			oldCardJob.add(tx.getConnection());
			
			Card newCard = new Card();
			newCard.setRfidcode(changeCardId);
			newCard.setBranchId(oldCard.getBranchId());
			newCard.retrieve(tx.getConnection());
			
			if(newCard.getWineryId()!=oldCard.getWineryId()){
				throw new Exception("酒厂不匹配");
			}
			
			newCard.setWineJarId(oldCard.getWineJarId());
			newCard.setPosition(oldCard.getPosition());
			newCard.update(tx.getConnection());
	
			CardJob newCardJob = new CardJob();
			newCardJob.setCardId(newCard.getId());
			newCardJob.setBranchId(oldCard.getBranchId());
			
			processId = newCardJob.count(tx.getConnection());
			newCardJob.setProcessId(0);
			newCardJob.retrieve(tx.getConnection());
			
			newCardJob.setProcessId(processId);
			newCardJob.update(tx.getConnection());
			
			newCardJob.setId(IDGenerator.getNextID(tx.getConnection(),CardJob.class));
			newCardJob.setCardId(newCard.getId());
			newCardJob.setProcessId(0);
			newCardJob.setUserId(sessionId);
			newCardJob.setJobDate(new Date());
			newCardJob.setSpotNormal("Y");
			newCardJob.setCardNormal("Y");
			newCardJob.setJobTypeId(2);
			newCardJob.add(tx.getConnection());
		
		}
		tx.commit();
	} catch (Exception e) {
		tx.rollback();
		if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		request.setAttribute("error", e.getMessage());
	} finally {
		tx.end();
	}
	return "listCardJob";
}

}