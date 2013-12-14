<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Barcode"/></title>
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
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="Barcode.do"/>
		<jsp:param name="method" value="listBarcode"/>
	</jsp:include>
		
	<applet code="com.mooo.mycoz.applet.ZPLApplet" archive="applet/ZPLApplet.jar" width="80" height="20">
		<param name="ZPL" value="${ZPL }">
	</applet>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Preview"/> <fmt:message key="Barcode"/></caption>

<tbody>

<tr>
<th class="tl"><fmt:message key="WineStyle"/>: </th>
<td><c:out value="${wineStyle.styleName }"/></td>
</tr>

<tr>
<th class="tl"><fmt:message key="CodeNumber"/>: </th>
<td><c:out value="${barcode.codeNumber }"/></td>
</tr>


<tr>
<th class="tl"><fmt:message key="Point"/>: </th>
<td><fmt:message key="${barcode.point }"/></td>
</tr>


<tr>
<th class="tl"><fmt:message key="PointDate"/>: </th>
<td><fmt:formatDate value="${barcode.pointDate }" type="both" /></td>
</tr>


<tr>
<td class="tl"><fmt:message key="Image"/>: </td>
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

<jsp:include page="../incl/g_footer.jsp" />
</div>
</form>
</body>
</html>
</fmt:bundle>