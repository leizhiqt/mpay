<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Card"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
<link type="text/css" rel="stylesheet" href="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<form method="post">
<div id="gtop">
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Confirm"/>
		<jsp:param name="action" value="CardJob.do"/>
		<jsp:param name="method" value="processChange"/>
	</jsp:include>

	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Close"/>
		<jsp:param name="action" value="CardJob.do"/>
		<jsp:param name="method" value="listCardJob"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<input type="hidden" name="alength" value="${fun:length(cards)}"/>
<input type="hidden" name="winery.id" value="${winery.id}"/>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Activate"/>: ${winery.enterpriseName}</caption>

<thead>
<tr>
<th><fmt:message key="Rfidcode"/></th>
<th><fmt:message key="WineJarId"/></th>
<th><fmt:message key="Position"/></th>
<th><fmt:message key="ChangeCard"/></th>
</tr>
</thead>

<tbody>

<c:forEach var="item" items="${cards}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if> >

<td><c:out value="${item.card.rfidcode }"/>
<input type="hidden" name="cardId${status.index}" value="${item.card.id }"/>
</td>

<td><c:out value="${item.wineJar.jarNumber }"/></td>

<td><c:out value="${item.card.position }"/></td>

<td>
	<input type="text" name="rfidcode${status.index}"/>
	<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/cardLookup.jsp?wineryId=${winery.id}','forms[0].rfidcode${status.index}');return false;">
</td>

</tr>
</c:forEach>

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
