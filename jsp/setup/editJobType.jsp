<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="JobType"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
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
		<jsp:param name="action" value="JobType.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="JobType.do"/>
		<jsp:param name="method" value="listJobType"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>
<input type="hidden" name="jobType.id" value="${jobType.id }"/>

<div>
<table  class="twrap">

<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="JobType"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="Abbreviation"/></td>
<td><input type="text" name="jobType.abbreviation" value="${jobType.abbreviation }" size="5" maxlength="5"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Definition"/></td>
<td><input type="text" name="jobType.definition" value="${jobType.definition }"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Category"/></td>
<td>
<select name="jobType.category">
<option value="D" <c:if test="${jobType.category=='D'}">selected="selected"</c:if> >D</option>
<option value="R" <c:if test="${jobType.category=='R'}">selected="selected"</c:if>>R</option>
<option value="Y" <c:if test="${jobType.category=='Y'}">selected="selected"</c:if>>Y</option>
<option value="N" <c:if test="${jobType.category=='N'}">selected="selected"</c:if>>N</option>
<option value="C" <c:if test="${jobType.category=='C'}">selected="selected"</c:if>>C</option>
</select>
<font class="fm">*</font>
</td>
</tr>
</tbody>

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