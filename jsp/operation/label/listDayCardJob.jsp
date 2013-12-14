<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">

<html>
<head>
<title><fmt:message key="Card"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>

<body>

<form method="post">

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">

<tr>
<td>

<table class="lt">

<thead>
<!-- 分页 -->
<tr class="lp">
<td colspan="12" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="Winery"/></th>
<th><fmt:message key="WineJarId"/></th>
<th><fmt:message key="Rfidcode"/></th>
<th><fmt:message key="Position"/></th>
<th><fmt:message key="JobType"/></th>
<th><fmt:message key="OperatorId"/></th>
<th><fmt:message key="JobTime"/></th>
<th><fmt:message key="SpotNormal"/></th>
<th><fmt:message key="CardNormal"/></th>
<th><fmt:message key="Remark"/></th>
<th><fmt:message key="Picture"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${cards}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.id }"></td>
<td><c:out value="${item.winery.enterpriseName }"/></td>
<td><c:out value="${item.wineJar.jarNumber }"/></td>
<td><c:out value="${item.card.rfidcode }"/></td>
<td><c:out value="${item.card.position }"/></td>
<td><c:out value="${item.jobType.definition }"/></td>
<td><c:out value="${item.user.name }"/></td>
<td><fmt:formatDate value="${item.cardJob.jobDate }" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<td><c:out value="${item.cardJob.spotNormal }"/> </td>
<td><c:out value="${item.cardJob.cardNormal }"/></td>

<td><c:out value="${item.cardJob.remark }"/></td>
<td>
<c:forEach var="image" items="${item.cardJob.images }">
<a href="${image.filePath }"><img src="${image.filePath }" width="40" height="30"></a>
</c:forEach>
</td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="12" >
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