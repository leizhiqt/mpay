<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Card"/></title>
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

</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>
<!-- Card start -->

<table class="st">

<caption><fmt:message key="View"/> <fmt:message key="Card"/></caption>

<tbody>
<tr>
<td><fmt:message key="Rfidcode"/></td>
<td><c:out value="${card.rfidcode }"/></td>
<td><fmt:message key="Uuid"/></td>
<td><c:out value="${card.uuid }"/></td>
</tr>

<tr>
<td><fmt:message key="CardDate"/></td>
<td><fmt:formatDate value="${cardTrack.trackDate }" type="both"/></td>
<td><fmt:message key="Winery"/></td>
<td><c:out value="${card.winery.enterpriseName }"/></td>
</tr>

<tr>
<td><fmt:message key="Position"/></td>
<td><c:out value="${card.position }"/></td>
<td></td>
<td></td>
</tr>

</tbody>

<tfoot>
</tfoot>
</table>

</td>
</tr>

<!-- WineJar start -->

<tr>
<td>

<table class="st">
<caption><fmt:message key="View"/> <fmt:message key="WineJar"/></caption>

<tbody>
<tr>
<td><fmt:message key="JarNumber"/></td>
<td><c:out value="${wineJar.jarNumber }"/></td>
<td><fmt:message key="WineType"/></td>
<td><c:out value="${wineType.definition }"/></td>
</tr>

<tr>
<td><fmt:message key="CreateDate"/></td>
<td><fmt:formatDate value="${wineJar.createDate }" type="both"/></td>
<td><fmt:message key="WineLevel"/></td>
<td><c:out value="${wineLevel.definition }"/> </td>
</tr>

</tbody>

<tfoot>
</tfoot>
</table>

</td>
</tr>

<!-- CardJob track start -->

<tr>
<td>

<table class="lt">
<caption><fmt:message key="View"/> <fmt:message key="WineJar"/></caption>

<thead>
<tr>
<th><fmt:message key="JobType"/></th>
<th><fmt:message key="User"/></th>
<th><fmt:message key="JobDate"/></th>
</tr>
</thead>

<tbody>
<tbody>
<c:forEach var="item" items="${cardJobs}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if> >
<td><c:out value="${item.jobType.definition }"/></td>
<td><c:out value="${item.user.name }"/></td>
<td><fmt:formatDate value="${item.jobDate }"  type="both"/></td>
</tr>
</c:forEach>

</tbody>

<tfoot>
</tfoot>
</table>

</td>
</tr>

<!-- end -->
</table>
</div>

<jsp:include page="../../incl/g_footer.jsp" />
</div>

</form>
</body>
</html>
</fmt:bundle>
