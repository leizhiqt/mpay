<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Product"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>

<body>
<form method="post">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="FinancialProduct.do"/>
		<jsp:param name="method" value="processAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
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

<table class="modify">
<caption><fmt:message key="Add"/> <fmt:message key="FinancialProduct"/></caption>

<tbody>
<tr>

<td>

</td>
</tr>

<tr>
<td class="tl"><fmt:message key="creditName"/></td>
<td><input type="text" name="creditType.creditName" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="cycleTotal"/></td>
<td><input type="text" name="creditType.cycleTotal" size="16" maxlength="16"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="cycleUnit"/></td>
<td><input type="text" name="creditType.cycleUnit" size="30" maxlength="30"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="creditRate"/></td>
<td><input type="text" name="creditType.creditRate" size="8" maxlength="8"/><font class="fm">*</font></td>
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