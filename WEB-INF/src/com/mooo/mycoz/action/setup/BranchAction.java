package com.mooo.mycoz.action.setup;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;
import com.mooo.mycoz.framework.component.JRUtil;
import com.mooo.mycoz.framework.component.JRExport;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;

public class BranchAction extends BaseSupport {

private static Log log = LogFactory.getLog(BranchAction.class);

	public String listBranch(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		
		//报表参数
		String reportName="Branchs";

		Vector<String> colName = new Vector<String>();
		Vector<String> colSum = new Vector<String>();
		Vector<Integer> colWidth = new Vector<Integer>();
		
		String value = null;
		try {
			request.setAttribute("reportName", reportName);

			value="编号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="简称";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="定义";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="地址";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="电话";
			colName.add(value);colWidth.add(StringUtils.length(value));

			StringBuilder buffer = new StringBuilder();
			buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			buffer.append("<Reports>\n");
			
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Branch.class, "branch");
			dbobject.addTable(BranchCategory.class, "branchCategory");
			
			dbobject.setForeignKey("branch", "categoryId", "branchCategory", "id");
			
			dbobject.setLike("branch","abbreviation",request.getParameter("query_abbreviation"));
			dbobject.setLike("branch","definition",request.getParameter("query_definition"));
			dbobject.setLike("branch","address",request.getParameter("query_address"));
			dbobject.setLike("branch","phone",request.getParameter("query_phone"));

			dbobject.setRetrieveField("branch","id");
			dbobject.setRetrieveField("branch","abbreviation");
			dbobject.setRetrieveField("branch","definition");
			dbobject.setRetrieveField("branch","address");
			dbobject.setRetrieveField("branch","phone");
			dbobject.setRetrieveField("branchCategory","definition");
			
			dbobject.setOrderBy("branchCategory","id");
			dbobject.setOrderBy("branch","id");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			List<?> results = dbobject.searchAndRetrieveList();
			
			for(Object orow:results){
				buffer.append("<Rows>\n");
				Map row = (Map)orow;
				Branch branch = (Branch) row.get("branch");
				
				//column start
				value=branch.getId()+"";
				if(value.length()>colWidth.get(0)){
					colWidth.set(0, StringUtils.length(value));
				}
				buffer.append("<Key0>"+value+"</Key0>\n");

				//column start
				value=branch.getAbbreviation();
				if(value==null) value="";
				if(value.length()>colWidth.get(1)){
					colWidth.set(1, StringUtils.length(value));
				}
				
				buffer.append("<Key1>"+value+"</Key1>\n");
				
				//column start
				value=branch.getDefinition();
				if(value==null) value="";
				if(value.length()>colWidth.get(2)){
					colWidth.set(2, StringUtils.length(value));
				}
				
				buffer.append("<Key2>"+value+"</Key2>\n");
				
				//column start
				value=branch.getAddress();
				if(value==null) value="";
				if(value.length()>colWidth.get(3)){
					colWidth.set(3, StringUtils.length(value));
				}
				
				buffer.append("<Key3>"+value+"</Key3>\n");
				
				//column start
				value=branch.getPhone();
				if(value==null) value="";
				if(value.length()>colWidth.get(4)){
					colWidth.set(4, StringUtils.length(value));
				}
				
				buffer.append("<Key4>"+value+"</Key4>\n");
				
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
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		request.setAttribute("categorys", IDGenerator.getValues(BranchCategory.class));
		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		try {
			Branch branch = new Branch();
			branch.setId(IDGenerator.getNextInt(Branch.class));
			
			ParamUtil.bindData(request, branch,"branch");
			
			branch.add();
			
			request.setAttribute("message", "processAdd successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			return "promptAdd";
		}
		return "listBranch";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processDelete");

		try {
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			if(ids!=null)
				for(int i=0;i<ids.length;i++){
					Branch bean = new Branch();
					bean.setId( new Integer(ids[i]));
					bean.retrieve();
					
					bean.delete();
				}

			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "listBranch";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String id =  request.getParameter("id");

		try {
			if(StringUtils.isNull(id))
				throw new Exception("Please select modify object");
			
			Branch branch = new Branch();
			branch.setId( new Integer(id));
			branch.retrieve();
			
			request.setAttribute("branch", branch);
			
			request.setAttribute("categorys", IDGenerator.getValues(BranchCategory.class));
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			return "listBranch";
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		try {
			Branch branch = new Branch();
			ParamUtil.bindData(request, branch,"branch");
			
			branch.update();
			
			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			request.setAttribute("id", request.getParameter("branch.id"));
			return "promptEdit";
		}
		return "listBranch";
	}
	
	public String export(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String print(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
}