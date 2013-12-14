<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="User"/></title>
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
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="Winery"/>
		<jsp:param name="action" value="WineryProperty.do"/>
		<jsp:param name="method" value="promptWinery"/>
	</jsp:include>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="User"/>
		<jsp:param name="action" value="WineryProperty.do"/>
		<jsp:param name="method" value="promptUser"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="User"/></caption>
<tbody>
<tr>
	<td><fmt:message key="User"/></td>
	<td>
		<select name="userId">
			<c:forEach var="item" items="${users}" varStatus="s">
				<option value="${item.key}"
		
				<c:if test="${item.key==param.userId}">
					selected="selected"
				</c:if>
					>
				${item.value}
				</option>
			--</c:forEach>
		</select>

		<jsp:include page="../incl/actionb.jsp">
			<jsp:param name="key" value="List"/>
			<jsp:param name="action" value="WineryProperty.do"/>
			<jsp:param name="method" value="promptUser"/>
		</jsp:include>
	</td>
</tr>

</tbody>
</table>
</td>
</tr>

<c:if test="${not empty param.userId}">

<tr>
<td>

<table class="lt">

<thead>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'wineryId');"/></th>
<th><fmt:message key="Winery"/></th>
</tr>
</thead>

<tbody>

<c:forEach var="item" items="${winerys}" varStatus="sw">
<tr <c:if test="${sw.index%2==0 }">bgcolor="#ffffff"</c:if> >
<td>
	<input type="checkbox" name="wineryId" value="${item.id }"
	
	<c:forEach var="wineryMap" items="${wineryMaps}" varStatus="sm">
		<c:if test="${item.id==wineryMap.wineryId }">checked="checked"</c:if>
	</c:forEach>
	>
</td>
<td><c:out value="${item.enterpriseName}"/></td>
</tr>
</c:forEach>

</tbody>

</table>
</td>
</tr>

<tr>
<td>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="Update"/>
		<jsp:param name="action" value="WineryProperty.do"/>
		<jsp:param name="method" value="processUser"/>
	</jsp:include>
</td>
</tr>
</c:if>

</table>
</div>

<jsp:include page="../incl/g_footer.jsp" />
</div>

</form>
</body>
</html>
</fmt:bundle>