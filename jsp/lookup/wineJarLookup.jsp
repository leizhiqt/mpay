<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="./shared-head.jsp" %>
<%@page import="com.mooo.mycoz.db.MultiDBObject" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.Winery" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.WineJar" %>
<%@page import="com.mooo.mycoz.framework.ActionSession" %>
<%@page import="com.mooo.mycoz.common.StringUtils" %>
<%@page import="com.mooo.mycoz.common.CalendarUtils" %>

function loadSourceList() {
 
<%! int listLength; %>
<%! String listItem; %>
<%! String infoItem; %>
<!-- fill the titles for this lookup here -->
<%! String textboxTitle = "WineJar"; %>
<%! String availableTitle = "WineJar"; %>
<%! String selectedTitle = "WineJar"; %> <!-- only used by multiple lookup -->
<%! String detailTitle = "WineJar"; %>
                                               
orgList = new Array(); 
infoList = new Array(); //global

<%
listBy = "alphabet";
listBy = "date";

String value = null;
String wChar0 = request.getParameter("char0");
String addSql = "";

Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

String wineryId = request.getParameter("wineryId");

try {
	MultiDBObject dbobject = new MultiDBObject();
	
	dbobject.addTable(Winery.class, "winery");
	dbobject.addTable(WineJar.class, "wineJar");
	
	dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
	dbobject.setForeignKey("wineJar", "branchId", "winery", "branchId");

	if (wChar0 != null && !wChar0.equals("ALL")){
		dbobject.addCustomWhereClause("(wineJar.jarNumber LIKE '" + wChar0.toUpperCase() + "%'" +
                   "  OR wineJar.jarNumber LIKE '" + wChar0.toLowerCase() + "%')");
       }
       
	Calendar now = Calendar.getInstance();
	
	startDate = request.getParameter("StartDate");
	if(StringUtils.isNull(startDate)){
		now.add(Calendar.YEAR, -1);
		now.add(Calendar.DAY_OF_MONTH, 1);
		startDate = CalendarUtils.dformat(now.getTime());
	}
	
	endDate = request.getParameter("EndDate");
	if(StringUtils.isNull(endDate)){
		now.add(Calendar.YEAR, 1);
		endDate = CalendarUtils.dformat(now.getTime());
	}
	
     if (startDate.length() > 0) 
		dbobject.setGreaterEqual("wineJar", "createDate", startDate);
     if (endDate.length() > 0) 
 		dbobject.setLessEqual("wineJar", "createDate", endDate);
       
	String branchCategory = ActionSession.getBranchCategory(request);
	String wineryValues = ActionSession.getWineryValues(request);
	
	
	if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Regulators")){
		
		if (wineryId!=null && !wineryId.equals("")) 
	  		dbobject.setField("winery", "id", new Integer(wineryId));
		else
			if(!StringUtils.isNull(wineryValues))
				dbobject.addCustomWhereClause(" winery.id IN (" + wineryValues+")");
		
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		if(branchId!=null){
			dbobject.setField("winery","branchId", branchId);
		}
	}else if(!StringUtils.isNull(branchCategory) && branchCategory.equals("Bank")){
		dbobject.setField("wineJar", "bankId",sessionId);
	}
	
	dbobject.setRetrieveField("wineJar", "id");
	dbobject.setRetrieveField("wineJar", "jarNumber");
	dbobject.setRetrieveField("winery", "enterpriseName");

	dbobject.setOrderBy("wineJar", "id","DESC");
	
	List<?> results = dbobject.searchAndRetrieveList();
	int i = 0;
	for(Object orow:results){
		Map<String,Object> rowm = (Map)orow;
		WineJar wineJar = (WineJar)rowm.get("wineJar");
		Winery winery = (Winery)rowm.get("winery");

           listItem = wineJar.getJarNumber();
           infoItem = winery.getEnterpriseName() +
                      "\\n" + wineJar.getJarNumber();
%>
           orgList[<%= i %>] = "<%= listItem %>";
           infoList[<%= i %>] = "<%= infoItem %>";
<%
			i++;
		}
	listLength = i;
} catch (Exception e) {
	e.printStackTrace();
}
%>
initSourceList(orgList);
}

<%@ include file="./shared-foot.jsp" %>