<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Package"/></title>
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
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="Package.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="Package.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
		
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="Package.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="Package.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
	
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Print"/>
		<jsp:param name="action" value="Package.do"/>
		<jsp:param name="method" value="print"/>
	</jsp:include>
	
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Export"/>
		<jsp:param name="action" value="Package.do"/>
		<jsp:param name="method" value="export"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="Sale"/></caption>
<tbody>
<tr>
	<td class="textr"><fmt:message key="BatchNo"/></td>
	<td><input name="BatchNo" value="${BatchNo }"/></td>
	
	<td class="textr"></td>
	<td></td>
</tr>

<tr>
	<td class="textr"><fmt:message key="StartDate"/></td>
	<td><input type="text" name="StartDate" value="${StartDate }" onclick="displayCalendar(this,'yyyy-MM-dd');"/></td>

	<td class="textr"><fmt:message key="EndDate"/></td>
	<td><input type="text" name="EndDate" value="${EndDate }" onclick="displayCalendar(this,'yyyy-MM-dd');"/></td>
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
<td colspan="5" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="BatchNo"/></th>
<th><fmt:message key="VintageDate"/></th>
<th><fmt:message key="IsConfirm"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.id }"></td>
<td><c:out value="${item.batchNo }"/></td>
<td><fmt:formatDate value="${item.saleDate }" type="date" /></td>
<td><c:out value="${item.isSale }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="5" >
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