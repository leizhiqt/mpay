<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Account"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
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
		<jsp:param name="action" value="storageAccount.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="storageAccount.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>
<input type="hidden" name="storageAccount.id" value="${storageAccount.id }"/>

<div>
<table  class="twrap">

<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="storageAccount"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="storageAccount"/></td>
<td><input type="text" name="storageAccount.itemName" value="${storageAccount.itemName}" size="32" maxlength="32"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="UsefulLife"/></td>
<td><input type="text" name="storageAccount.usefulLife" value="${storageAccount.usefulLife }"  size="3" maxlength="3"/><font>???</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="StorageMode"/></td>
<td><input type="text" name="storageAccount.storageMode" value="${storageAccount.storageMode }" size="16"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Volume"/></td>
<td><input type="text" name="storageAccount.itemVolume" value="${storageAccount.itemVolume}" size="5" maxlength="5"/><input type="text" name="storageAccount.volUtil"  value="${storageAccount.volUtil }" size="4" maxlength="4"/><font class="fm">*</font></td>
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