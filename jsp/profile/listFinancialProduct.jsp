<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="FinancialProduct"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>

<body>
<c:url value="/FinancialProduct.do" var="defURL" />

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="FinancialProduct.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="FinancialProduct.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="FinancialProduct.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="FinancialProduct.do"/>
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
<caption><fmt:message key="FinancialProduct"/></caption>
<tbody>
<tr>
	<td  class="textr"><fmt:message key="Name"/></td>
	<td><input name="creditName" value="${param.creditName }"/></td>
	
	<td  class="textr"><fmt:message key="CreditRate"/></td>
	<td><input name="rate" value="${param.rate }"/></td>
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
<td colspan="9" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'id');"/><fmt:message key="ID"/></th>
<th><fmt:message key="Name"/></th>
<th><fmt:message key="CycleTotal"/></th>
<th><fmt:message key="CycleUnit"/></th>
<th><fmt:message key="NaturalRate"/></th>
<th><fmt:message key="ChargeRate"/></th>
<th><fmt:message key="VouchRate"/></th>
<th><fmt:message key="MinPayPercent"/></th>
<th><fmt:message key="FinancialMax"/></th>

</tr>
</thead>

<tbody>
<c:forEach var="financial" items="${financials}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${financial.id }"> </td>
<td><c:out value="${financial.financialName }"/></td>
<td><c:out value="${financial.cycleTotal }"/></td>
<td><c:out value="${financial.cycleUnit }"/></td>
<td><fmt:formatNumber value="${financial.naturalRate }" type="percent" maxFractionDigits="5"/></td>
<td><fmt:formatNumber value="${financial.chargeRate }" type="percent" maxFractionDigits="5"/></td>
<td><fmt:formatNumber value="${financial.vouchRate }" type="percent" maxFractionDigits="5"/></td>
<td><c:out value="${financial.minPayPercent }"/></td>
<td><c:out value="${financial.financialMax }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="9" >
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