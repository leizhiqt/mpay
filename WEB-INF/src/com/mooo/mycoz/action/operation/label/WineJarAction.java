package com.mooo.mycoz.action.operation.label;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
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
import com.mooo.mycoz.dbobj.wineBranch.GroupMember;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineBranch.WineJar;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineFrameWork.WorkGroup;
import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.dbobj.wineShared.Currency;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;
import com.mooo.mycoz.dbobj.wineShared.Unit;
import com.mooo.mycoz.dbobj.wineShared.WineLevel;
import com.mooo.mycoz.dbobj.wineShared.WineType;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.JRUtil;
import com.mooo.mycoz.framework.component.JRExport;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class WineJarAction extends BaseSupport {

private static Log log = LogFactory.getLog(WineJarAction.class);

	public String listWineJar(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("listWineJar");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		String physicalPath = request.getSession().getServletContext().getRealPath("/");

		//报表参数
		String reportName="WineJars";

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
				endDate = CalendarUtils.dformat(now.getTime());
			}
			request.setAttribute("EndDate", endDate);
			
			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));
//			request.setAttribute("status", IDGenerator.getValues(JobState.class,"id","fullName"));
			
			request.setAttribute("reportName", reportName);

			value="编号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒罐号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒厂";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="容积";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="单位";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒类型";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒品质";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="酒精度";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="创建日期";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="原料";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="监管银行";
			colName.add(value);colWidth.add(StringUtils.length(value));
			
			StringBuilder buffer = new StringBuilder();
			buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			buffer.append("<Reports>\n");
			
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(WineLevel.class, "wineLevel");
			dbobject.addTable(WineType.class, "wineType");
//			dbobject.addTable(JobState.class, "jobState");
			dbobject.addTable(Unit.class, "unit");
			dbobject.addTable(Currency.class, "currency");

			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(User.class, "user");

			dbobject.addTable(WineJar.class, "wineJar");

			dbobject.setForeignKey("wineJar", "wineTypeId", "wineType", "id");
			dbobject.setForeignKey("wineJar", "wineLevelId", "wineLevel", "id");
			dbobject.setForeignKey("wineJar", "stateId", "jobState", "id");
			dbobject.setForeignKey("wineJar", "unitId", "unit", "id");
			dbobject.setForeignKey("wineJar", "orgCurrencyId", "currency", "id");
			dbobject.setForeignKey("wineJar", "bankId", "user", "id");
			
			dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
			dbobject.setForeignKey("wineJar", "branchId", "winery", "branchId");
			
			dbobject.setRetrieveField("wineJar", "id");
			dbobject.setRetrieveField("wineJar", "jarNumber");
			dbobject.setRetrieveField("wineJar", "volume");
			dbobject.setRetrieveField("wineJar", "district");
			dbobject.setRetrieveField("wineJar", "alcohol");
			dbobject.setRetrieveField("wineJar", "createDate");
			dbobject.setRetrieveField("wineJar", "material");
			dbobject.setRetrieveField("wineJar", "remark");
			dbobject.setRetrieveField("wineJar", "price");
			dbobject.setRetrieveField("wineJar", "perimeter");
			dbobject.setRetrieveField("wineJar", "outsideHeight");
			dbobject.setRetrieveField("wineJar", "totalHeight");
			dbobject.setRetrieveField("wineJar", "clearHeight");
			dbobject.setRetrieveField("wineJar", "density");
			dbobject.setRetrieveField("wineJar", "weight");
			
			dbobject.setRetrieveField("wineType", "definition");
			dbobject.setRetrieveField("wineLevel", "definition");
			dbobject.setRetrieveField("jobState", "fullName");
			dbobject.setRetrieveField("unit", "definition");
			dbobject.setRetrieveField("currency", "codeISO");

			dbobject.setRetrieveField("user", "name");
			dbobject.setRetrieveField("winery", "enterpriseName");
			dbobject.setRetrieveField("jobState", "fullName");

			dbobject.setLike("winery","abbreviation",request.getParameter("query_abbreviation"));

			if(!StringUtils.isNull(startDate))
				dbobject.setGreaterEqual("wineJar","createDate",startDate);
			
			if(!StringUtils.isNull(endDate))
				dbobject.setLessEqual("wineJar","createDate",endDate);

			value = request.getParameter("wineryId");
			if(!StringUtils.isNull(value)){
				dbobject.setField("winery", "id", new Integer(value));
				request.setAttribute("wineryId",value);
			}else{
				if(request.getAttribute("wineryId")!=null)
					dbobject.setField("winery", "id", (Integer)request.getAttribute("wineryId"));
			}

			value = request.getParameter("stateId");
			if(!StringUtils.isNull(value))
				dbobject.setField("wineJar", "stateId", new Integer(value));
			
			String branchCategory = ActionSession.getBranchCategory(request);
			String wineryValues = ActionSession.getWineryValues(request);
			if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Regulators")){
				if(!StringUtils.isNull(wineryValues))
					dbobject.addCustomWhereClause(" winery.id IN (" + wineryValues+")");

				if(branchId!=null){
					dbobject.setField("winery", "branchId", new Integer(branchId));
				}
			}
			
			dbobject.setOrderBy("wineJar", "id","DESC");

			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> results = dbobject.searchAndRetrieveList();
			request.setAttribute("results", results);

			for(Object orow:results){
				buffer.append("<Rows>\n");
				Map rowm = (Map)orow;

				Winery winery = (Winery) rowm.get("winery");
				WineLevel wineLevel = (WineLevel) rowm.get("wineLevel");
				WineType wineType = (WineType) rowm.get("wineType");
				
				WineJar wineJar = (WineJar) rowm.get("wineJar");

				Unit unit = (Unit) rowm.get("unit");
				User bank = (User) rowm.get("user");

				int wineJarId = wineJar.getId();
				
				//column start
				value=wineJarId+"";
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
				value=winery.getEnterpriseName();
				if(value!=null && value.length()>colWidth.get(2)){
					colWidth.set(2, StringUtils.length(value));
				}
				
				buffer.append("<Key2>"+value+"</Key2>\n");
				
				//column start
				value=""+wineJar.getVolume();
				if(value!=null && value.length()>colWidth.get(3)){
					colWidth.set(3, StringUtils.length(value));
				}
				
				buffer.append("<Key3>"+value+"</Key3>\n");
				
				//column start
				value=unit.getDefinition();
				if(value!=null && value.length()>colWidth.get(4)){
					colWidth.set(4, StringUtils.length(value));
				}
				
				buffer.append("<Key4>"+value+"</Key4>\n");
				
				//column start
				value=wineLevel.getDefinition();
				if(value!=null && value.length()>colWidth.get(5)){
					colWidth.set(5, StringUtils.length(value));
				}
				
				buffer.append("<Key5>"+value+"</Key5>\n");
				
				//column start
				value=wineType.getDefinition();
				if(value!=null && value.length()>colWidth.get(6)){
					colWidth.set(6, StringUtils.length(value));
				}
				
				buffer.append("<Key6>"+value+"</Key6>\n");
				
				//column start
				value=wineJar.getAlcohol()+"";
				if(value!=null && value.length()>colWidth.get(7)){
					colWidth.set(7, StringUtils.length(value));
				}
				
				buffer.append("<Key7>"+value+"</Key7>\n");
				
				//column start
				value=CalendarUtils.dformat(wineJar.getCreateDate());
				if(value!=null && value.length()>colWidth.get(8)){
					colWidth.set(8, StringUtils.length(value));
				}
				
				buffer.append("<Key8>"+value+"</Key8>\n");
				
				//column start
				value=wineJar.getMaterial();
				if(value!=null && value.length()>colWidth.get(9)){
					colWidth.set(9, StringUtils.length(value));
				}
				
				buffer.append("<Key9>"+value+"</Key9>\n");
				
				//column start
				value=bank.getName();
				if(value!=null && value.length()>colWidth.get(10)){
					colWidth.set(10, StringUtils.length(value));
				}
				
				buffer.append("<Key10>"+value+"</Key10>\n");
				
				//put data
				buffer.append("</Rows>\n");
			}
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

	public String listLowWineJar(HttpServletRequest request, HttpServletResponse response) {
		listWineJar(request,response);
		return "success";
	}
	
	public String export(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String print(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		
		try {
			request.setAttribute("wineTypes", IDGenerator.getValues(WineType.class));
			request.setAttribute("wineLevels", IDGenerator.getValues(WineLevel.class));
			request.setAttribute("currencys", IDGenerator.getValues(Currency.class,"id","codeISO"));
			
	        Map<Integer,String> volumeUnits = new LinkedHashMap<Integer,String>();
	        Unit unit  = new Unit();
	        unit.setCategory("Weight");
	        List units = unit.searchAndRetrieveList();
	        for(Object bean:units){
	        	unit = (Unit)bean;
	        	volumeUnits.put(unit.getId(), unit.getDefinition());
	        }
			request.setAttribute("volumeUnits", volumeUnits);
	        
			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));
			
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(User.class, "user");
			dbobject.addTable(BranchCategory.class, "branchCategory");
			dbobject.addTable(Branch.class, "branch");

			dbobject.addTable(WorkGroup.class, "workGroup");
			dbobject.addTable(GroupMember.class, "groupMember");
			
			dbobject.setForeignKey("groupMember", "groupId", "workGroup", "id");
			dbobject.setForeignKey("groupMember", "userId", "user", "id");
			dbobject.setForeignKey("workGroup", "branchId", "branch", "id");
			dbobject.setForeignKey("branch", "categoryId", "branchCategory", "id");

			dbobject.setField("branchCategory", "id",2);
			
			dbobject.setRetrieveField("user", "id");
			dbobject.setRetrieveField("user", "name");
			
			request.setAttribute("banks", dbobject.searchAndRetrieveList());
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		WineJar wineJar = new WineJar();

		try {
			wineJar.setId(IDGenerator.getNextInt(WineJar.class));
			wineJar.setBranchId(branchId);
			
			ParamUtil.bindData(request, wineJar,"wineJar");
			
			if(wineJar.getJarNumber()==null)
				throw new Exception("please input JarNumber");
			
			if(wineJar.getWineryId()==null)
				throw new Exception("please select Winery");
			
			if(wineJar.getCreateDate()==null)
				throw new Exception("please input Date");
			
			wineJar.setStateId(2);
			
			wineJar.add();

			request.setAttribute("message", "add success");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			request.setAttribute("wineJar", wineJar);
		}
		return "promptAdd";
	}

	public String promptBatchAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		
		try {
			request.setAttribute("wineTypes", IDGenerator.getValues(WineType.class));
			request.setAttribute("wineLevels", IDGenerator.getValues(WineLevel.class));
			request.setAttribute("currencys", IDGenerator.getValues(Currency.class,"id","codeISO"));
			
	        Map<Integer,String> volumeUnits = new LinkedHashMap<Integer,String>();
	        Unit unit  = new Unit();
	        unit.setCategory("Weight");
	        List units = unit.searchAndRetrieveList();
	        for(Object bean:units){
	        	unit = (Unit)bean;
	        	volumeUnits.put(unit.getId(), unit.getDefinition());
	        }
			request.setAttribute("volumeUnits", volumeUnits);
	        
			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));
			
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(User.class, "user");
			dbobject.addTable(BranchCategory.class, "branchCategory");
			dbobject.addTable(Branch.class, "branch");

			dbobject.addTable(WorkGroup.class, "workGroup");
			dbobject.addTable(GroupMember.class, "groupMember");
			
			dbobject.setForeignKey("groupMember", "groupId", "workGroup", "id");
			dbobject.setForeignKey("groupMember", "userId", "user", "id");
			dbobject.setForeignKey("workGroup", "branchId", "branch", "id");
			dbobject.setForeignKey("branch", "categoryId", "branchCategory", "id");

			dbobject.setField("branchCategory", "id",2);
			
			dbobject.setRetrieveField("user", "id");
			dbobject.setRetrieveField("user", "name");
			
			request.setAttribute("banks", dbobject.searchAndRetrieveList());
		} catch (SQLException e) {
			e.printStackTrace();
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processBatchAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		
		try {
			
			if(request.getParameter("startJarNumber")==null || request.getParameter("startJarNumber").equals("")
					|| request.getParameter("endJarNumber")==null || request.getParameter("endJarNumber").equals(""))
				
				throw new Exception("please input JarNumber");
			
			WineJar wineJar = new WineJar();
			ParamUtil.bindData(request, wineJar,"wineJar");
			
			if(wineJar.getWineryId()==null)
				throw new Exception("please select Winery");
			
			if(wineJar.getCreateDate()==null)
				throw new Exception("please input Date");
			
			int start = new Integer(request.getParameter("startJarNumber"));
			int end = new Integer(request.getParameter("endJarNumber"));
			
			String suffixJarNumber = request.getParameter("suffixJarNumber");
			if(suffixJarNumber==null){
				suffixJarNumber = "";
			}
			
			for(int i=start;i<end+1;i++){
				wineJar.setId(IDGenerator.getNextInt(WineJar.class));
				wineJar.setBranchId(branchId);
				
				wineJar.setJarNumber(i+suffixJarNumber);
				wineJar.setStateId(2);
				wineJar.add();
			}
			request.setAttribute("message", "add success");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "listWineJar";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		
		try {
			String id =  request.getParameter("id");

			if(StringUtils.isNull(id)){
				throw new Exception("Please chose object");
			}
			
			WineJar wineJar = new WineJar();
			wineJar.setId( new Integer(id));
			wineJar.retrieve();
			request.setAttribute("wineJar", wineJar);

			request.setAttribute("wineTypes", IDGenerator.getValues(WineType.class));
			request.setAttribute("wineLevels", IDGenerator.getValues(WineLevel.class));
			request.setAttribute("currencys", IDGenerator.getValues(Currency.class,"id","codeISO"));
//			request.setAttribute("status", IDGenerator.getValues(JobState.class,"id","fullName"));
			
			Map<Integer,String> volumeUnits = new LinkedHashMap<Integer,String>();
			
			Unit unit  = new Unit();
			unit.setCategory("Weight");
			List units = unit.searchAndRetrieveList();
			for(Object obj:units){
				unit = (Unit)obj;
				volumeUnits.put(unit.getId(), unit.getDefinition());
			}
			request.setAttribute("volumeUnits", volumeUnits);
			
			request.setAttribute("winerys", IDGenerator.getWineryValues(sessionId));

			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(User.class, "user");
			dbobject.addTable(BranchCategory.class, "branchCategory");
			dbobject.addTable(Branch.class, "branch");

			dbobject.addTable(WorkGroup.class, "workGroup");
			dbobject.addTable(GroupMember.class, "groupMember");
			
			dbobject.setForeignKey("groupMember", "groupId", "workGroup", "id");
			dbobject.setForeignKey("groupMember", "userId", "user", "id");
			dbobject.setForeignKey("workGroup", "branchId", "branch", "id");
			dbobject.setForeignKey("branch", "categoryId", "branchCategory", "id");

			dbobject.setField("branchCategory", "id",2);
			
			dbobject.setRetrieveField("user", "id");
			dbobject.setRetrieveField("user", "name");
			
			request.setAttribute("banks", dbobject.searchAndRetrieveList());
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "listWineJar";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		WineJar wineJar = null;
		try {
			wineJar = new WineJar();
			ParamUtil.bindData(request, wineJar,"wineJar");
			wineJar.update();

			request.setAttribute("wineryId",wineJar.getWineryId());
			request.setAttribute("message", "update success");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("wineJar",wineJar);
			request.setAttribute("error", e.getMessage());

			return "promptEdit";
		}
		return "listWineJar";
	}

	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				WineJar bean = new WineJar();
				bean.setId(new Integer(ids[i]));
				bean.delete();
			}
			request.setAttribute("message", "delete success");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "listWineJar";
	}

	public String disableWineJar(HttpServletRequest request, HttpServletResponse response) {
		
		Transaction tx=new Transaction();
		
		try {
			tx.start();
			
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select disable object");
			
			for(int i=0;i<ids.length;i++){
				WineJar wineJar = new WineJar();
				wineJar.setId(new Integer(ids[i]));
				wineJar.retrieve(tx.getConnection());
				
				wineJar.setStateId(3);
				wineJar.update(tx.getConnection());
				
				WineJar allJar = new WineJar();
				allJar.setWineryId(wineJar.getWineryId());
				
				int cj = allJar.count(tx.getConnection());
				
				WineJar disJar = new WineJar();
				disJar.setWineryId(wineJar.getWineryId());
				disJar.setStateId(3);
				
				int dj = disJar.count(tx.getConnection());
				
				Winery winery = new Winery();
				winery.setId(wineJar.getWineryId());
				winery.setBranchId(wineJar.getBranchId());
				
				if(cj==dj){
					winery.setStateId(3);
				}else{
					winery.setStateId(4);
				}
				winery.update(tx.getConnection());

				Card card = new Card();
				card.setWineJarId(wineJar.getId());
				card.setProcessId(0);
				card.retrieve(tx.getConnection());
				
				CardJob existCardJob = new CardJob();
				existCardJob.setCardId(card.getId());
				existCardJob.setBranchId(card.getBranchId());
				existCardJob.setProcessId(0);
				existCardJob.setJobTypeId(11);

				if(existCardJob.count(tx.getConnection())>0)
					continue;
				
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
				cardJob.setSpotNormal("Y");
				cardJob.setCardNormal("Y");
		
				cardJob.add(tx.getConnection());
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
		return "listWineJar";
	}
}
