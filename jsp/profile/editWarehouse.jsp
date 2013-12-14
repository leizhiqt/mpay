<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Warehouse"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
<script type="text/javascript" src="jsp/js/util.js"></script>
<link type="text/css" rel="stylesheet" href="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<form method="post">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="Warehouse.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="Warehouse.do"/>
		<jsp:param name="method" value="listWarehouse"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>
<input type="hidden" name="warehouse.id" value="${warehouse.id }"/>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="Warehouse"/></caption>

<tbody>
<tr>
<td  class="tl"><fmt:message key="Winery"/></td>
<td>
<select name="warehouse.enterpriseId">
	<c:forEach var="items" items="${winerys}" varStatus="s">
		<option value="${items.winery.id}"

		<c:if test="${items.winery.id==warehouse.enterpriseId}">
			selected="selected"
		</c:if>
			>
		${items.winery.enterpriseName}
		</option>
	</c:forEach>
</select>
<font class="fm">*</font>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="WarehouseName"/></td>
<td><input type="text" name="warehouse.warehouseName" value="${warehouse.warehouseName }"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Contact"/></td>
<td><input type="text" name="warehouse.contact" value="${warehouse.contact }"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Address"/></td>
<td><input type="text" name="warehouse.address" value="${warehouse.address }" size="32" maxlength="32"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Zipcode"/></td>
<td><input type="text" name="warehouse.zipcode" value="${warehouse.zipcode }" size="6" maxlength="6"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Telephone"/></td>
<td><input type="text" name="warehouse.telephone" value="${warehouse.telephone }" size="15" maxlength="15"/><font class="fm">*</font></td>
</tr>

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