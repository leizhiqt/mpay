<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="BranchCategory"/></title>
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
		<jsp:param name="action" value="BranchCategory.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="BranchCategory.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>
<input type="hidden" name="branchCategory.id" value="${branchCategory.id }"/>

<div>
<table  class="twrap">

<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="BranchCategory"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="Abbreviation"/></td>
<td><input type="text" name="branchCategory.abbreviation" value="${branchCategory.abbreviation }" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Definition"/></td>
<td><input type="text" name="branchCategory.definition" value="${branchCategory.definition }"/><font class="fm">*</font></td>
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