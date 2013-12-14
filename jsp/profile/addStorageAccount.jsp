<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="storageAccount"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
<link type="text/css" rel="stylesheet" href="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<form method="post">
<div id="gtop">
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="StorageAccount.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="Print"/>
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

<table class="modify">
<caption><fmt:message key="Add"/> <fmt:message key="StorageAccount"/></caption>

<tbody>

<tr>
<td  class="tl"><fmt:message key="BatchNumber"/></td>
<td><c:out value="${storageAccount.batchNumber }"/></td>

<td class="tl"></td>
<td>
<input type="hidden" name="storageAccount.id" value="${storageAccount.id }"/>
</td>
</tr>

<tr>
<td  class="tl"><fmt:message key="Product"/></td>
<td>
	<input type="text" id="product" name="product" value="${product }"/>
	<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/productLookup.jsp','forms[0].product');return false;">
</td>

<td class="tl"><fmt:message key="Date"/></td>
<td><input type="text" id="storageDate" name="storageAccount.storageDate" value="<fmt:formatDate value="${storageAccount.storageDate }" type="date"/>" size="10" maxlength="10"/>
		<img src="jsp/images/miniDate.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="displayCalendar(document.forms[0].storageDate,'yyyy-mm-dd',this,false)">

<font class="fm">*</font></td>
</tr>

<tr>
<td  class="tl"><fmt:message key="Warehouse"/></td>
<td>
	<input type="text" id="warehouse" name="warehouse" value="${warehouse }"/>
	<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/warehouseLookup.jsp','forms[0].warehouse');return false;">
</td>

<td class="tl"><fmt:message key="Operator"/></td>
<td><input type="text" name="storageAccount.storagePeople" value="${storageAccount.storagePeople }"/></td>
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
<th></th>
<th><fmt:message key="Name"/></th>
<th><fmt:message key="Debit"/></th>
<th><fmt:message key="WarehouseItem"/></th>
<th><fmt:message key="Quantity"/></th>
<th><fmt:message key="Volume"/></th>
<th><fmt:message key="Unit"/></th>
</tr>
</thead>

<tbody>
<tr>
<td></td>
<td><input type="text" name="storageDetail.storageName"/></td>

<td>
<select name="storageDetail.storageType">
	<c:forEach var="items" items="${dcTypes}" varStatus="s">
	<option value="${items.key}"
	
	<c:if test="${items.key==storageDetail.storageType}">
	        selected="selected"
	</c:if>
	        >
	${items.value}
	</option>
	</c:forEach>
</select>
</td>

<td>
<select name="storageDetail.itemId">
	<c:forEach var="items" items="${warehouseItems}" varStatus="s">
	<option value="${items.key}"
	
	<c:if test="${items.key==storageDetail.itemId}">
	        selected="selected"
	</c:if>
	        >
	${items.value}
	</option>
	</c:forEach>
</select>
</td>

<td><input type="text" name="storageDetail.quanItem"/></td>
<td><input type="text" name="storageDetail.itemVol"/></td>
<td><input type="text" name="storageDetail.volUnit" size="4" maxlength="4"/></td>
</tr>

<tr>
<td colspan="7" align="right">
<jsp:include page="../incl/actionb.jsp">
	<jsp:param name="key" value="Add"/>
	<jsp:param name="action" value="StorageAccount.do"/>
	<jsp:param name="method" value="processItemAdd"/>
</jsp:include>
<jsp:include page="../incl/actionb.jsp">
	<jsp:param name="key" value="Edit"/>
	<jsp:param name="action" value="StorageAccount.do"/>
	<jsp:param name="method" value="processItemUpdate"/>
</jsp:include>
<jsp:include page="../incl/actionb.jsp">
	<jsp:param name="key" value="Delete"/>
	<jsp:param name="action" value="StorageAccount.do"/>
	<jsp:param name="method" value="processItemDelete"/>
</jsp:include>	
</td>
</tr>

<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.id }"> </td>
<td><c:out value="${item.storageDetail.storageName }"/></td>
<td><c:out value="${item.storageDetail.storageType }"/></td>
<td><c:out value="${item.warehouseItem.itemName }"/></td>
<td><c:out value="${item.storageDetail.quanItem }"/></td>
<td><c:out value="${item.storageDetail.itemVol }"/></td>
<td><c:out value="${item.storageDetail.volUnit }"/></td>
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