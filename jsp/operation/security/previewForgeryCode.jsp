<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Sale"/></title>
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
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="Sale.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
		
	<applet code="com.mooo.mycoz.applet.ZPLApplet" archive="applet/ZPLApplet.jar" width="80" height="20">
		<param name="ZPL" value="${ZPL }">
	</applet>
</div>

<div id="container">
<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Add"/> <fmt:message key="Sale"/></caption>

<tbody>

<tr>
<td class="tl"><fmt:message key="ForgeryName"/></td>
<td><c:out value="${saleJob.saleCode }"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Image"/></td>
<td>
<img alt="" src="${jpegURL}">
</td>
</tr>

</tbody>

</table>
</td>
</tr>
</table>
</div>

<jsp:include page="../../incl/g_footer.jsp" />
</div>
</form>
</body>
</html>
</fmt:bundle>