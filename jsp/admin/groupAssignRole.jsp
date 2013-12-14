<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title></title>
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
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="processAssignRole"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
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
<caption>
<fmt:message key="AssignGroup"/>:<c:out value="${groupName}"/>
<input type="hidden" name="id" value="${groupId}">
</caption>

</table>

</td>
</tr>

<tr>
<td>
<table class="lt">

<thead>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'roleId');"/></th>
<th><fmt:message key="Role"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="iuserRole" items="${userRoles}" varStatus="suserRole">
<tr <c:if test="${suserRole.index%2==0 }">bgcolor="#ffffff"</c:if> >
<td>
<input type="checkbox" name="roleId" value="${iuserRole.key }"
	
<c:forEach var="igroupRoleMapping" items="${groupRoleMappings}" varStatus="sgroupRoleMapping">
	<c:if test="${igroupRoleMapping.roleId==iuserRole.key }">checked="checked"</c:if>
</c:forEach>
>

</td>
<td><c:out value="${iuserRole.value }"/></td>
</tr>
</c:forEach>
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