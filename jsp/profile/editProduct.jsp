<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Product"/></title>
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
		<jsp:param name="action" value="Product.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="Product.do"/>
		<jsp:param name="method" value="listProduct"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>
<input type="hidden" name="product.id" value="${product.id }"/>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="Product"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="Winery"/></td>
<td>
<select name="product.enterpriseId">
	<c:forEach var="items" items="${winerys}" varStatus="s">
		<option value="${items.winery.id}"

		<c:if test="${items.winery.id==product.enterpriseId}">
			selected="selected"
		</c:if>
			>
		${items.winery.enterpriseName}
		</option>
	--</c:forEach>
</select>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="ProductCode"/></td>
<td><input type="text" name="product.productCode" value="${product.productCode }" size="5" maxlength="5"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="ProductName"/></td>
<td><input type="text" name="product.productName" value="${product.productName }" size="16" maxlength="16"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Alcohol"/></td>
<td><input type="text" name="product.alcohol" value="${product.alcohol }" size="5" maxlength="5"/><font>度</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="NetContent"/></td>
<td><input type="text" name="product.netContent" value="${product.netContent }" size="4" maxlength="4"/><font>ML</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Material"/></td>
<td><input type="text" name="product.material" value="${product.material }" size="32" maxlength="32"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Production"/></td>
<td><input type="text" name="product.production" value="${product.production }" size="64"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Flavor"/></td>
<td><input type="text" name="product.flavor" value="${product.flavor }" size="6" maxlength="6"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="FermentDays"/></td>
<td><input type="text" name="product.fermentDays" value="${product.fermentDays }" size="4" maxlength="4"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Description" /></td>
<td><input type="text" name="product.description" value="${product.description }" size="96"/></td>
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