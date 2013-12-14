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
import com.mooo.mycoz.dbobj.wineShared.JobType;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.JRExport;
import com.mooo.mycoz.framework.component.JRUtil;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class DayCardJobAction extends BaseSupport {

private static Log log = LogFactory.getLog(DayCardJobAction.class);

	public String listDayPatrol(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("patrol");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		
		//报表参数
		String reportName="DayPatrol";

		Vector<String> colName = new Vector<String>();
		Vector<String> colSum = new Vector<String>();
		Vector<Integer> colWidth = new Vector<Integer>();
		
		String value = null;
		try {
			Calendar now = Calendar.getInstance();
			Date nowDate = now.getTime();
			
//			now.add(Calendar.DAY_OF_MONTH, -1);

			String byDate = request.getParameter("ByDate");

			if(byDate==null){
				byDate = CalendarUtils.dformat(nowDate);
				request.setAttribute("ByDate", nowDate);
			}else{
				request.setAttribute("ByDate", CalendarUtils.dparse(byDate));
			}

			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId,true));

			request.setAttribute("reportName", reportName);

			value="酒厂";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒罐号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="标识号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="位置";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="操作员";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="巡检次数I";
			colName.add(value);colWidth.add(StringUtils.length(value));
			
			StringBuilder buffer = new StringBuilder();
			buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			buffer.append("<Reports>\n");
			
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(WineJar.class, "wineJar");
			dbobject.addTable(Card.class, "card");
			dbobject.addTable(CardJob.class, "cardJob");

//			dbobject.addTable(User.class, "user");
			dbobject.addTable(JobType.class, "jobType");

			dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
			dbobject.setForeignKey("wineJar", "branchId", "winery", "branchId");
			
			dbobject.setForeignKey("card", "wineJarId", "wineJar", "id");
			dbobject.setForeignKey("card", "branchId", "wineJar", "branchId");
			
			dbobject.setForeignKey("card", "wineryId", "winery", "id");
			dbobject.setForeignKey("card", "branchId", "winery", "branchId");
			
			dbobject.setForeignKey("cardJob", "cardId", "card", "id");
			dbobject.setForeignKey("cardJob", "branchId", "card", "branchId");
			
//			dbobject.setForeignKey("cardJob", "userId","user", "id");
//			dbobject.setForeignKey("cardJob", "branchId","user", "branchId");
			
			dbobject.setForeignKey("cardJob", "jobTypeId","jobType", "id");
			
			dbobject.setField("card", "processId",0);
			dbobject.setField("cardJob", "processId",0);

			dbobject.setGreater("jobType", "id",1);
			dbobject.setNotEqual("jobType", "id",11);

			dbobject.setNotEqual("wineJar", "stateId",3);
			
//			dbobject.addCustomWhereClause("wineJar.stateId<>3");
			
//			if(!StringUtils.isNull(byDate))
//				dbobject.setLike("cardJob", "jobDate", byDate);
			
			value = request.getParameter("WineJar");
			if(!StringUtils.isNull(value)){
				dbobject.setLike("wineJar", "jarNumber", value);
			}
			
			value = request.getParameter("wineryId");
			if(!StringUtils.isNull(value))
				dbobject.setField("winery", "id", value);
			
			String branchCategory = ActionSession.getBranchCategory(request);
			String wineryValues = ActionSession.getWineryValues(request);
			
			if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Bank")){
				dbobject.addCustomWhereClause(" wineJar.bankId=" + sessionId);
			}else if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Regulators")){
				if(!StringUtils.isNull(wineryValues))
					dbobject.addCustomWhereClause(" winery.id IN (" + wineryValues+")");
				dbobject.setField("winery", "branchId",branchId);
			}
			dbobject.setGroupBy("card", "id");
			
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("card", "rfidcode");
			dbobject.setRetrieveField("card", "position");
			dbobject.setRetrieveField("card", "remark");
			dbobject.setRetrieveField("wineJar", "jarNumber");
			dbobject.setRetrieveField("wineJar", "id");
			dbobject.setRetrieveField("card", "id");
			dbobject.setRetrieveField("card", "branchId");
			dbobject.setRetrieveField("jobType", "id");
			dbobject.setRetrieveField("jobType", "definition");
//			dbobject.setRetrieveField("cardJob", "jobDate");
//			dbobject.setRetrieveField("user", "name");

//			dbobject.setGroupBy("DATE_FORMAT(cardJob", "jobDate, '%Y-%m-%d')");
//			dbobject.setGroupBy("winery", "id");
//			dbobject.setGroupBy("wineJar", "jarNumber");
//			dbobject.setGroupBy("card", "id");
//			
//			dbobject.setOrderBy("DATE_FORMAT(cardJob", "jobDate, '%Y-%m-%d')","DESC");
			dbobject.setOrderBy("winery", "id");
			dbobject.setOrderBy("wineJar", "jarNumber");
			dbobject.setOrderBy("card", "id");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> resuls = dbobject.searchAndRetrieveList();
			for(Object orow:resuls){
				buffer.append("<Rows>\n");
				Map<String,Object> rowm = (Map)orow;
				
				Winery winery = (Winery)rowm.get("winery");
				WineJar wineJar = (WineJar)rowm.get("wineJar");
				Card card = (Card)rowm.get("card");
//				CardJob gCardJob = (CardJob)rowm.get("cardJob");
//				User user = (User)rowm.get("user");

				//column start
				value=winery.getEnterpriseName();
				if(value!=null && value.length()>colWidth.get(0)){
					colWidth.set(0, StringUtils.length(value));
				}
				buffer.append("<Key0>"+value+"</Key0>\n");
				
				//column start
				value=wineJar.getJarNumber();
				if(value!=null && value.length()>colWidth.get(1)){
					colWidth.set(1, StringUtils.length(value));
				}
				buffer.append("<Key1>"+value+"</Key1>\n");

				//column start
				value=card.getRfidcode();
				if(value!=null && value.length()>colWidth.get(2)){
					colWidth.set(2, StringUtils.length(value));
				}
				buffer.append("<Key2>"+value+"</Key2>\n");
				
				//column start
				value=card.getPosition()+"";
				if(value!=null && value.length()>colWidth.get(3)){
					colWidth.set(3, StringUtils.length(value));
				}
				buffer.append("<Key3>"+value+"</Key3>\n");
				


				//column start		
				CardJob cardJob = new CardJob();
				cardJob.setCardId(card.getId());
				cardJob.setBranchId(card.getBranchId());
				cardJob.setJobTypeId(3);
				cardJob.retrieve();
				
				User user = new User();
				user.setId(cardJob.getUserId());
				user.setBranchId(cardJob.getBranchId());
				user.retrieve();
				
				rowm.put("patrolUser", user.getName());
				
				//column start
				value=user.getName();
				if(value!=null && value.length()>colWidth.get(4)){
					colWidth.set(4, StringUtils.length(value));
				}
				buffer.append("<Key4>"+value+"</Key4>\n");
				
				cardJob = new CardJob();
				cardJob.setCardId(card.getId());
				cardJob.setBranchId(card.getBranchId());
				cardJob.setJobTypeId(3);
				cardJob.setLike("jobDate", byDate);

				int count = cardJob.count();
				
				rowm.put("countPatrol", count);
				
				//column start
				value=count+"";
				if(value!=null && value.length()>colWidth.get(5)){
					colWidth.set(5, StringUtils.length(value));
				}
				buffer.append("<Key5>"+value+"</Key5>\n");
				
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
			
			String jrxml = JRUtil.createJRXML(reportName, "原酒产业联盟", byDate+"巡检日报", colName, colSum, colWidth, "/Reports/Rows");
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

	public String exportDayPatrol(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String printDayPatrol(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String listDayCardJob(HttpServletRequest request,HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("listCardJob");
		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		
		//报表参数
		String reportName="PatrolCard";

		Vector<String> colName = new Vector<String>();
		Vector<String> colSum = new Vector<String>();
		Vector<Integer> colWidth = new Vector<Integer>();
		
		String value = null;
		String cardId = null;

		try {
			cardId = request.getParameter("cardId");
			
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
			
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(WineJar.class, "wineJar");
			dbobject.addTable(Card.class, "card");
			dbobject.addTable(CardJob.class, "cardJob");

			dbobject.addTable(User.class, "user");
			dbobject.addTable(JobType.class, "jobType");

			dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
			dbobject.setForeignKey("wineJar", "branchId", "winery", "branchId");
			
			dbobject.setForeignKey("card", "wineJarId", "wineJar", "id");
			dbobject.setForeignKey("card", "branchId", "wineJar", "branchId");
			
			dbobject.setForeignKey("cardJob", "cardId", "card", "id");
			dbobject.setForeignKey("cardJob", "branchId", "card", "branchId");
			
			dbobject.setForeignKey("cardJob", "userId","user", "id");
			dbobject.setForeignKey("cardJob", "branchId","user", "branchId");
			
			dbobject.setForeignKey("cardJob", "jobTypeId","jobType", "id");

			dbobject.setField("card", "id", cardId);

			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("card", "rfidcode");
			dbobject.setRetrieveField("card", "position");
			
			dbobject.setRetrieveField("cardJob", "remark");
			dbobject.setRetrieveField("cardJob", "id");
			dbobject.setRetrieveField("cardJob", "jobDate");
			dbobject.setRetrieveField("cardJob", "spotNormal");
			dbobject.setRetrieveField("cardJob", "cardNormal");

			dbobject.setRetrieveField("user", "name");
			dbobject.setRetrieveField("jobType", "definition");
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
				if(value.length()>colWidth.get(0)){
					colWidth.set(0, StringUtils.length(value));
				}
				buffer.append("<Key0>"+value+"</Key0>\n");

				//column start
				value=wineJar.getJarNumber();
				if(value.length()>colWidth.get(1)){
					colWidth.set(1, StringUtils.length(value));
				}
				buffer.append("<Key1>"+value+"</Key1>\n");
				
				//column start
				value=card.getRfidcode();
				if(value.length()>colWidth.get(2)){
					colWidth.set(2, StringUtils.length(value));
				}
				buffer.append("<Key2>"+value+"</Key2>\n");
				
				//column start
				value=card.getPosition()+"";
				if(value.length()>colWidth.get(3)){
					colWidth.set(3, StringUtils.length(value));
				}
				buffer.append("<Key3>"+value+"</Key3>\n");
				
				//column start
				value=jobType.getDefinition();
				if(value.length()>colWidth.get(4)){
					colWidth.set(4, StringUtils.length(value));
				}
				buffer.append("<Key4>"+value+"</Key4>\n");
				
				//column start
				value=user.getName();
				if(value.length()>colWidth.get(5)){
					colWidth.set(5, StringUtils.length(value));
				}
				
				buffer.append("<Key5>"+value+"</Key5>\n");
				
				//column start
				value=CalendarUtils.dtformat(cardJob.getJobDate());
				if(value.length()>colWidth.get(6)){
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
		}
		return "success";
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
		return "listDayPatrol";
	}
}