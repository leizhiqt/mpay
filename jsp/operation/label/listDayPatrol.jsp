<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="DayPartrol"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>

<body>
<c:url value="/DayCardJob.do" var="defURL">
	<c:param name="method">listDayPatrol</c:param>
</c:url>

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="DayCardJob.do"/>
		<jsp:param name="method" value="listDayPatrol"/>
	</jsp:include>
	
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="print"/>
		<jsp:param name="key" value="Print"/>
		<jsp:param name="action" value="DayCardJob.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=pdf"/>
		<jsp:param name="method" value="printDayPatrol"/>
	</jsp:include>
	
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="export"/>
		<jsp:param name="key" value="Export"/>
		<jsp:param name="action" value="DayCardJob.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=xls"/>
		<jsp:param name="method" value="exportDayPatrol"/>
	</jsp:include>
	
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Canceled"/>
		<jsp:param name="action" value="DayCardJob.do"/>
		<jsp:param name="method" value="processCanceled"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="Card"/></caption>
<tbody>

<tr>
	<td  class="textr"><fmt:message key="Winery"/></td>
	<td><select name="wineryId" onchange="document.forms[0].submit();">
			<option selected="selected" value="">All</option>
			<c:forEach var="items" items="${winerys}" varStatus="s">
				<option value="${items.winery.id}"
		
				<c:if test="${items.winery.id==param.wineryId}">
					selected="selected"
				</c:if>
					>
				${items.winery.enterpriseName}
				</option>
			--</c:forEach>
		</select>
	</td>
	
	<td  class="textr"><fmt:message key="WineJar"/></td>
	<td>
		<input type="text" name="WineJar" value="${param.WineJar }"/>
		<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/wineJarLookup.jsp?wineryId=${param.wineryId}','forms[0].WineJar');return false;">
	</td>
</tr>

<tr>
	<td class="textr"><fmt:message key="Date"/></td>
	<td><input type="text" name="ByDate" value="<fmt:formatDate value="${ByDate }" pattern="yyyy-MM-dd" />" onclick="displayCalendar(this,'yyyy-MM-dd');" size="10"/></td>

	<td class="textr"></td>
	<td></td>
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
<td colspan="8" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="Winery"/></th>
<th><fmt:message key="WineJarId"/></th>
<th><fmt:message key="Rfidcode"/></th>
<th><fmt:message key="Position"/></th>
<th><fmt:message key="OperatorId"/></th>
<th><fmt:message key="Patrol"/></th>
<th><fmt:message key="Remark"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${cards}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.card.id }">
	<c:url value="/DayCardJob.do" var="listDayCardJob">
		<c:param name="method">listDayCardJob</c:param>
		<c:param name="cardId">${item.card.id }</c:param>
	</c:url>
	<a href="#" onclick="window.open('${listDayCardJob }'); "><fmt:message key="View"/></a>
</td>

<td><c:out value="${item.winery.enterpriseName }"/></td>
<td><c:out value="${item.wineJar.jarNumber }"/></td>
<td><c:out value="${item.card.rfidcode }"/></td>
<td><c:out value="${item.card.position }"/></td>
<td><c:out value="${item.patrolUser }"/></td>
<td><c:out value="${item.countPatrol }"/></td>
<td><c:out value="${item.card.remark }"/></td>
</tr>

</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp" >
<td colspan="8" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>
</tfoot>

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