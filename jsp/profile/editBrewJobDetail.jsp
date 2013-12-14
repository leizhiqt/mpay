<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="BrewJobDetail"/></title>
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
		<jsp:param name="action" value="BrewJobDetail.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="BrewJobDetail.do"/>
		<jsp:param name="method" value="listBrewJobDetail"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>
<input type="hidden" name="brewJobDetail.id" value="${brewJobDetail.id }"/>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="BrewJobDetail"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="BrewJob"/></td>
<td>
<select name="brewJobDetail.brewJobId">
	<c:forEach var="items" items="${brewJobs}" varStatus="s">
		<option value="${items.id}"

		<c:if test="${items.id==brewJobDetail.brewJobId}">
			selected="selected"
		</c:if>
			>
		${items.brewNumber}
		</option>
	--</c:forEach>
</select>
<font class="fm">*</font>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="BrewPoint"/></td>
<td>
<select name="brewJobDetail.jobPointId">
	<c:forEach var="items" items="${brewPoints}" varStatus="s">
		<option value="${items.id}"

		<c:if test="${items.id==brewJobDetail.jobPointId}">
			selected="selected"
		</c:if>
			>
		${items.pointName}
		</option>
	--</c:forEach>
</select>
<font class="fm">*</font>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="JobPeople"/></td>
<td><input type="text" name="brewJobDetail.jobPeople" value="${brewJobDetail.jobPeople }" maxlength="32" style="width:120px;" /><font class="fm">*</font></td>
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