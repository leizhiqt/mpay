<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="AuthRole"/></title>
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
		<jsp:param name="method" value="processAuthRole"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="Role.do"/>
		<jsp:param name="method" value="promptAuthRole"/>
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
<!-- 分页 -->
<tr class="lp">
<td colspan="4" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'methodId');"/></th>
<th><fmt:message key="Name"/></th>
<th><fmt:message key="Action"/></th>
<th><fmt:message key="Method"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="imethod" items="${methods}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if> onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td>
<input type="checkbox" name="methodId" value="${imethod.method.id }"
	
<c:forEach var="iauthRole" items="${authRoles}" varStatus="sauthRole">
	<c:if test="${imethod.method.id==iauthRole.methodId }">checked="checked"</c:if>
</c:forEach>
>

</td>
<td><c:out value="${imethod.action.definition }"/></td>
<td><c:out value="${imethod.action.cls }"/></td>
<td><c:out value="${imethod.method.methodName }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="4" >
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