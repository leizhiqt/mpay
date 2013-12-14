package com.mooo.mycoz.action.report;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
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
import com.mooo.mycoz.dbobj.ReportUtil;
import com.mooo.mycoz.dbobj.wineBranch.Card;
import com.mooo.mycoz.dbobj.wineBranch.CardJob;
import com.mooo.mycoz.dbobj.wineBranch.WineJar;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.JRUtil;
import com.mooo.mycoz.framework.component.JRExport;
import com.mooo.mycoz.framework.component.Page;

public class ReportAction extends BaseSupport {
	private static Log log = LogFactory.getLog(ReportAction.class);

	public String patrolReport(HttpServletRequest request,HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("listWineJar");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		
		//报表参数
		String reportName="JobReport";

		Vector<String> colName = new Vector<String>();
		Vector<String> colSum = new Vector<String>();
		Vector<Integer> colWidth = new Vector<Integer>();
		String value = null;
		
		try {
			Calendar now = Calendar.getInstance();
			
			String startDate = request.getParameter("StartDate");
			if(StringUtils.isNull(startDate)){
				now.add(Calendar.YEAR, -1);
				now.add(Calendar.DAY_OF_MONTH, 1);
				startDate = CalendarUtils.dformat(now.getTime());
			}
			request.setAttribute("StartDate", startDate);
			
			String endDate = request.getParameter("EndDate");
			if(StringUtils.isNull(endDate)){
				now.add(Calendar.YEAR, 1);
				endDate = CalendarUtils.dformat(now.getTime());
			}
			request.setAttribute("EndDate", endDate);
			
			request.setAttribute("reportName", reportName);

			value="编号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒厂";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒罐总量";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="标签总量";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="巡检记录总数";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="无巡检标签数";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="无巡检酒罐数";
			colName.add(value);colWidth.add(StringUtils.length(value));
			
			StringBuilder buffer = new StringBuilder();
			buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			buffer.append("<Reports>\n");
			
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(WineJar.class, "wineJar");
			dbobject.addTable(Card.class, "card");
			dbobject.addTable(CardJob.class, "cardJob");
			
			dbobject.setForeignKey("winery", "id", "card", "wineryId");
			dbobject.setForeignKey("wineJar", "id", "card", "wineJarId");
			dbobject.setForeignKey("cardJob", "cardId", "card", "id");
			dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");

			dbobject.setGreaterEqual("cardJob", "jobDate", startDate);
			dbobject.setLessEqual("cardJob", "jobDate", endDate);
			
			
			String branchCategory=ActionSession.getBranchCategory(request);
			String wineryValues = ActionSession.getWineryValues(request);
			if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Bank")){
				dbobject.addCustomWhereClause(" wineJar.bankId=" + sessionId);
			}else if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Regulators")){
				if(!StringUtils.isNull(wineryValues))
					dbobject.addCustomWhereClause(" winery.id IN (" + wineryValues+")");
				
				Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
				if(branchId!=null){
					dbobject.setField("winery","branchId", branchId);
				}
			}
			
			dbobject.setRetrieveField("winery", "id");
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("winery", "branchId");

			dbobject.setGroupBy("winery","id");
			dbobject.setGroupBy("winery","enterpriseName");
			
			dbobject.setOrderBy("winery", "id","DESC");

			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<Object> result = dbobject.searchAndRetrieveList();
			List<Map<String,String>> report = new ArrayList<Map<String,String>>();

			for(Object orow:result){
				buffer.append("<Rows>\n");
				Map rowm = (Map)orow;
				Winery winery = (Winery)rowm.get("winery");
				
				Map<String,String> row = new HashMap<String,String>();
				
				value=winery.getId()+"";
				row.put("id", value);
				if(value.length()>colWidth.get(0)){
					colWidth.set(0, StringUtils.length(value));
				}
				buffer.append("<Key0>"+winery.getId()+"</Key0>\n");

				value=winery.getEnterpriseName();
				if(value.length()>colWidth.get(1)){
					colWidth.set(1, StringUtils.length(value));
				}
				
				row.put("wineryName", value);
				buffer.append("<Key1>"+value+"</Key1>\n");
				
				int wineryId = winery.getId();
				Integer branchId = winery.getBranchId();
				
				row.put("branchId", branchId+"");

				int totalWineJar=ReportUtil.getTotalWineJar(wineryId,branchId);

				value=totalWineJar+"";
				if(value.length()>colWidth.get(2)){
					colWidth.set(2, StringUtils.length(value));
				}
				
				row.put("totalWineJar", value);
				buffer.append("<Key2>"+value+"</Key2>\n");

				int totalCard=ReportUtil.getTotalCard(wineryId,branchId);
				value=totalCard+"";
				if(value.length()>colWidth.get(3)){
					colWidth.set(3, StringUtils.length(value));
				}
				
				row.put("totalCard", totalCard+"");
				buffer.append("<Key3>"+value+"</Key3>\n");

				value=ReportUtil.getTotalPatrol(wineryId,branchId,startDate,endDate)+"";
				if(value.length()>colWidth.get(4)){
					colWidth.set(4, StringUtils.length(value));
				}
				
				row.put("totalPatrol", value);
				buffer.append("<Key4>"+value+"</Key4>\n");

				value=ReportUtil.getDisableCard(wineryId,branchId,startDate,endDate)+"";
				if(value.length()>colWidth.get(5)){
					colWidth.set(5, StringUtils.length(value));
				}
				
				row.put("totalDisableCard", value);
				buffer.append("<Key5>"+value+"</Key5>\n");

				value=ReportUtil.getDisableWineJar(wineryId,branchId,startDate,endDate)+"";
				if(value.length()>colWidth.get(6)){
					colWidth.set(6, StringUtils.length(value));
				}
				
				row.put("totalDisableWineJar", value);
				buffer.append("<Key6>"+value+"</Key6>\n");

				report.add(row);
				buffer.append("</Rows>\n");
			}
			request.setAttribute("report", report);
			
			buffer.append("</Reports>\n");
			
			String filePrefix=physicalPath+"tmp/"+reportName;
			
			FileOutputStream writerStream = new FileOutputStream(filePrefix+".xml");
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8"));      
			writer.write(buffer.toString());
			writer.flush();
			writer.close();
			writerStream.close();
			
			String jrxml = JRUtil.createJRXML(reportName, "源酒产业联盟", "业务报表", colName, colSum, colWidth, "/Reports/Rows");
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
	
	public String export(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String print(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
}