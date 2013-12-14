<%@page language="java" contentType="text/html;charset=UTF-8"%>
<%@ include file="./shared-head.jsp" %>
<%@page import="com.mooo.mycoz.db.MultiDBObject" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.Winery" %>
<%@page import="com.mooo.mycoz.dbobj.wineBranch.Product" %>
<%@page import="com.mooo.mycoz.framework.ActionSession" %>
<%@page import="com.mooo.mycoz.common.StringUtils" %>
<%@page import="com.mooo.mycoz.common.CalendarUtils" %>

function loadSourceList() {
 
<%! int listLength; %>
<%! String listItem; %>
<%! String infoItem; %>
<!-- fill the titles for this lookup here -->
<%! String textboxTitle = "Product"; %>
<%! String availableTitle = "Product"; %>
<%! String selectedTitle = "Product"; %> <!-- only used by multiple lookup -->
<%! String detailTitle = "Product"; %>
                                               
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
	dbobject.addTable(Product.class, "product");
	
	dbobject.setForeignKey("winery", "id","product", "enterpriseId");

	if (wChar0 != null && !wChar0.equals("ALL")){
		dbobject.addCustomWhereClause("(product.productName LIKE '" + wChar0.toUpperCase() + "%'" +
                   "  OR product.productName LIKE '" + wChar0.toLowerCase() + "%')");
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
		dbobject.setGreaterEqual("ProductJob", "jobDate", startDate);
	if (endDate.length() > 0) 
  		dbobject.setLessEqual("ProductJob", "jobDate", endDate);
	*/
	dbobject.setRetrieveField("winery", "enterpriseName");
	dbobject.setRetrieveField("product", "productName");
	dbobject.setRetrieveField("product", "productCode");
	dbobject.setRetrieveField("product", "alcohol");
	dbobject.setRetrieveField("product", "material");
	dbobject.setRetrieveField("product", "flavor");
	dbobject.setRetrieveField("product", "fermentDays");
	
	dbobject.setOrderBy("product", "id","DESC");
	
	List<?> results = dbobject.searchAndRetrieveList();
	int i = 0;
	System.out.println(Locale.getDefault());

	ResourceBundle resBundle= ResourceBundle.getBundle("MessageBundle",Locale.getDefault());
	for(Object orow:results){
		Map<String,Object> rowm = (Map)orow;
		Product product = (Product)rowm.get("product");
		Winery winery = (Winery)rowm.get("winery");

           listItem = product.getProductName();
           infoItem = winery.getEnterpriseName()
        		   +"\\n" +resBundle.getString("ProductName")+":"+ product.getProductName()
                   +"\\n" +resBundle.getString("ProductCode")+":"+ product.getProductCode()
                   +"\\n" +resBundle.getString("Alcohol") +":"+ product.getAlcohol()
                   +"\\n" +resBundle.getString("Material")+":"+ product.getMaterial()
                   +"\\n" +resBundle.getString("Flavor")+":"+ product.getFlavor()
                   +"\\n" +resBundle.getString("FermentDays")+":"+ product.getFermentDays();
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