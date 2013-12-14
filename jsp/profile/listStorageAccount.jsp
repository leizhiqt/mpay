<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="StorageAccount"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
<link type="text/css" rel="stylesheet" href="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<c:url value="/StorageAccount.do" var="defURL" />

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="StorageAccount.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>

	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="StorageAccount.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="StorageAccount.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
		
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="StorageAccount.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="StorageAccount"/></caption>
<tbody>
<tr>
	<td  class="textr"><fmt:message key="BatchNumber"/></td>
	<td><input name="itemName" value="${param.itemName }"/></td>
	
	<td  class="textr"><fmt:message key="Product"/></td>
	<td><input name="storageMode" value="${param.storageMode }"/>
	<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/productLookup.jsp','forms[0].productId');return false;">
	</td>
	
	<td  class="textr"><fmt:message key="Warehouse"/></td>
	<td><input name="storageMode" value="${param.storageMode }"/>
	<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/productLookup.jsp','forms[0].productId');return false;">
	</td>
</tr>

</tbody>
</table>
</td>
</tr>

<tr>
<td>

<table class="lt">

<thead>
<!-- 分页 -->
<tr class="lp">
<td colspan="7" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'id');"/></th>
<th><fmt:message key="Winery"/></th>
<th><fmt:message key="WarehouseName"/></th>
<th><fmt:message key="Product"/></th>
<th><fmt:message key="BatchNumber"/></th>
<th><fmt:message key="Date"/></th>
<th><fmt:message key="Operator"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.storageAccount.id }"> </td>
<td><c:out value="${item.winery.enterpriseName }"/></td>
<td><c:out value="${item.warehouse.warehouseName }"/></td>
<td><c:out value="${item.product.productName }"/></td>
<td><c:out value="${item.storageAccount.batchNumber }"/></td>
<td><fmt:formatDate value="${item.storageAccount.storageDate }" type="date"/></td>
<td><c:out value="${item.storageAccount.storagePeople }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="7" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>
</tfoot>
</table>
</td>
</tr>

</table>
</div>

<jsp:include page="../incl/g_footer.jsp" />
</div>

</form>
</body>
</html>
</fmt:bundle>