<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>

<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="JobType"/></title>
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
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="JobType.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="JobType.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="JobType.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="JobType.do"/>
		<jsp:param name="method" value="listJobType"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="JobType"/></caption>
<tbody>
<tr>
	<td><fmt:message key="ShortName"/></td>
	<td><input name="jobKey" value="${param.jobKey }"/></td>
	
	<td><fmt:message key="Name"/></td>
	<td><input name="jobName" value="${param.jobName }"/></td>
	
	<td><fmt:message key="State"/></td>
	<td><input name="nextState" value="${param.nextState }"/></td>
	
	<td><fmt:message key="Category"/></td>
	<td>
	<select name="jobCategory">
	<option value="" <c:if test="${empty param.jobCategory}">selected="selected"</c:if>>--All--</option>
	<option value="R" <c:if test="${param.jobCategory=='R'}">selected="selected"</c:if>>R</option>
	<option value="A" <c:if test="${param.jobCategory=='A'}">selected="selected"</c:if>>A</option>
	<option value="C" <c:if test="${param.jobCategory=='C'}">selected="selected"</c:if>>C</option>
	</select>
</td>
</tr>

</tbody>
</table>
</td>
</tr>

<tr>
<td>
<table class="lt">

<thead>
<tr class="lp">
<td colspan="6">
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="ShortName"/></th>
<th><fmt:message key="Name"/></th>
<th><fmt:message key="State"/></th>
<th><fmt:message key="Category"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${jobTypes}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.id }"><c:out value="${item.id }"/></td>
<td><c:out value="${item.jobKey }"/></td>
<td><c:out value="${item.jobName }"/></td>
<td><c:out value="${item.nextState }"/></td>
<td><c:out value="${item.jobCategory }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="6">
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>
</tfoot>
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