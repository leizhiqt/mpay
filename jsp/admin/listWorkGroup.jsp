<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="GroupMember"/></title>
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
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="listWorkGroup"/>
	</jsp:include>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="AssignUser"/>
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="promptAssignUser"/>
	</jsp:include>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="AssignRole"/>
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="promptAssignRole"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="WorkGroup"/></caption>
<tbody>
<tr>
	<td  class="textr"><fmt:message key="Definition"/></td>
	<td><input name="definition" value="${param.definition }"/></td>
	<td  class="textr"><fmt:message key="Description"/></td>
	<td><input name="description" value="${param.description }"/></td>
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
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'id');" /><fmt:message key="ID"/></th>
<th><fmt:message key="Definition"/></th>
<th><fmt:message key="Description"/></th>
<th><fmt:message key="Branch"/></th>
<th><fmt:message key="BranchCategory"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.workGroup.id }">
<c:url value="/WorkGroup.do" var="assignUserLink">
	<c:param name="method">promptAssignUser</c:param>
	<c:param name="id">${item.workGroup.id }</c:param>
	<c:param name="branchId">${item.workGroup.branchId }</c:param>
</c:url>
<c:url value="/WorkGroup.do" var="assignRoleLink">
	<c:param name="method">promptAssignRole</c:param>
	<c:param name="id">${item.workGroup.id }</c:param>
	<c:param name="branchId">${item.workGroup.branchId }</c:param>
</c:url>

<a href="#" onclick="window.open('${assignUserLink }','<fmt:message key="AssignUser"/>', 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=800,height=500');return false;"><fmt:message key="AssignUser"/></a>
<a href="#" onclick="window.open('${assignRoleLink }','<fmt:message key="AssignRole"/>', 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=800,height=500');return false;"><fmt:message key="AssignRole"/></a>
</td>

<td><c:out value="${item.workGroup.definition }"/></td>
<td><c:out value="${item.workGroup.description }"/></td>
<td><c:out value="${item.branch.definition }"/></td>
<td><c:out value="${item.branchCategory.definition }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="5" >
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