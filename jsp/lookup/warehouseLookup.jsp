<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="./shared-head.jsp" %>
<%@page import="com.mooo.mycoz.db.MultiDBObject" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.Winery" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.Warehouse" %>
<%@page import="com.mooo.mycoz.framework.ActionSession" %>
<%@page import="com.mooo.mycoz.common.StringUtils" %>
<%@page import="com.mooo.mycoz.common.CalendarUtils" %>

function loadSourceList() {
 
<%! int listLength; %>
<%! String listItem; %>
<%! String infoItem; %>
<!-- fill the titles for this lookup here -->
<%! String textboxTitle = "Card"; %>
<%! String availableTitle = "Card"; %>
<%! String selectedTitle = "Card"; %> <!-- only used by multiple lookup -->
<%! String detailTitle = "Card"; %>
                                               
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
	dbobject.addTable(Warehouse.class, "warehouse");
	
	dbobject.setForeignKey("winery", "id","warehouse", "enterpriseId");

	if (wChar0 != null && !wChar0.equals("ALL")){
		dbobject.addCustomWhereClause("(warehouse.warehouseName LIKE '" + wChar0.toUpperCase() + "%'" +
                   "  OR warehouse.warehouseName LIKE '" + wChar0.toLowerCase() + "%')");
       }
      /* 
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
		dbobject.setGreaterEqual("cardJob", "jobDate", startDate);
	if (endDate.length() > 0) 
  		dbobject.setLessEqual("cardJob", "jobDate", endDate);
	*/
	dbobject.setRetrieveField("winery", "enterpriseName");
	dbobject.setRetrieveField("warehouse", "warehouseName");
	dbobject.setRetrieveField("warehouse", "warehouseName");
	dbobject.setRetrieveField("warehouse", "contact");
	dbobject.setRetrieveField("warehouse", "address");
	dbobject.setRetrieveField("warehouse", "zipcode");
	dbobject.setRetrieveField("warehouse", "telephone");
	
	dbobject.setOrderBy("warehouse", "id","DESC");
	
	List<?> results = dbobject.searchAndRetrieveList();
	int i = 0;
	System.out.println(Locale.getDefault());

	ResourceBundle resBundle= ResourceBundle.getBundle("MessageBundle",Locale.getDefault());
	for(Object orow:results){
		Map<String,Object> rowm = (Map)orow;
		Warehouse warehouse = (Warehouse)rowm.get("warehouse");
		Winery winery = (Winery)rowm.get("winery");

           listItem = warehouse.getWarehouseName();
           infoItem = winery.getEnterpriseName()
        		   +"\\n" +resBundle.getString("WarehouseName")+":"+ warehouse.getWarehouseName()
                   +"\\n" +resBundle.getString("Contact")+":"+ warehouse.getContact()
                   +"\\n" +resBundle.getString("Address") +":"+ warehouse.getAddress()
                   +"\\n" +resBundle.getString("Zipcode")+":"+ warehouse.getZipcode()
                   +"\\n" +resBundle.getString("Telephone")+":"+ warehouse.getTelephone();
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