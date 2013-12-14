<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="./shared-head.jsp" %>
<%@page import="com.mooo.mycoz.db.MultiDBObject" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.Winery" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.WineJar" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.User" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.WineryMap" %>

<%@page import="com.mooo.mycoz.dbobj.wineShared.Branch" %>
<%@page import="com.mooo.mycoz.dbobj.wineShared.BranchCategory" %>
<%@page import="com.mooo.mycoz.framework.ActionSession" %>
<%@page import="com.mooo.mycoz.common.StringUtils" %>
<%@page import="com.mooo.mycoz.common.CalendarUtils" %>

function loadSourceList() {
 
<%! int listLength; %>
<%! String listItem; %>
<%! String infoItem; %>
<!-- fill the titles for this lookup here -->
<%! String textboxTitle = "Winery"; %>
<%! String availableTitle = "Winery"; %>
<%! String selectedTitle = "Winery"; %> <!-- only used by multiple lookup -->
<%! String detailTitle = "Winery"; %>
                                               
orgList = new Array(); 
infoList = new Array(); //global

<%
listBy = "alphabet";
listBy = "date";

String value = null;
String wChar0 = request.getParameter("char0");
String addSql = "";

Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);

try {
	
	MultiDBObject dbobject = new MultiDBObject();
	dbobject.addTable(Winery.class, "winery");

	//dbobject.setField("winery", "stateId",2);
	dbobject.setNotEqual("winery", "stateId", 3);
	
	String category = ActionSession.getBranchCategory(request);

	if(!StringUtils.isNull(category) && category.equals("Regulators")){
		dbobject.addTable(WineryMap.class, "wineryMap");
		dbobject.setForeignKey("winery", "id", "wineryMap", "wineryId");
		
		dbobject.setField("wineryMap", "userId",sessionId);
	}else if(!StringUtils.isNull(category) && category.equals("Bank")){
		dbobject.addTable(WineJar.class, "wineJar");
		dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
		dbobject.setForeignKey("wineJar", "branchId", "winery", "branchId");

		dbobject.setField("wineJar", "bankId",sessionId);
		dbobject.setGroupBy("winery", "id");
	}
	
	if (wChar0 != null && !wChar0.equals("ALL")){
		dbobject.addCustomWhereClause("(winery.definition LIKE '" + wChar0.toUpperCase() + "%'" +
                   "  OR winery.definition LIKE '" + wChar0.toLowerCase() + "%')");
       }
     
	dbobject.setRetrieveField("winery", "id");
	dbobject.setRetrieveField("winery", "shortName");
	dbobject.setRetrieveField("winery", "enterpriseName");
	
	dbobject.setOrderBy("winery", "id","DESC");
	
	List<?> results = dbobject.searchAndRetrieveList();
	int i = 0;
	for(Object orow:results){
		Map<String,Object> rowm = (Map)orow;
		Winery winery = (Winery)rowm.get("winery");

           listItem = winery.getEnterpriseName();
           infoItem = winery.getShortName() +
                      "\\n" + winery.getEnterpriseName();
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