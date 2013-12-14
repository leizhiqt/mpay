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
		<jsp:param name="action" value="Role.do"/>
		<jsp:param name="method" value="processAssignGroup"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="Role.do"/>
		<jsp:param name="method" value="promptAssignGroup"/>
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
<fmt:message key="AuthRole"/>:<c:out value="${roleName}"/>
<input type="hidden" name="id" value="${roleId}">
</caption>

</table>

</td>
</tr>

<tr>
<td>
<table class="lt">

<thead>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'groupId');"/></th>
<th><fmt:message key="WorkGroup"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="iuserGroup" items="${userGroups}" varStatus="suserGroup">
<tr <c:if test="${suserGroup.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td>
<input type="checkbox" name="groupId" value="${iuserGroup.key }"
	
<c:forEach var="igroupRoleMapping" items="${groupRoleMappings}" varStatus="sgroupRoleMapping">
	<c:if test="${igroupRoleMapping.groupId==iuserGroup.key }">checked="checked"</c:if>
</c:forEach>
>

</td>
<td><c:out value="${iuserGroup.value }"/></td>
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