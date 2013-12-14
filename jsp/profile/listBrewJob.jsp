<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="BrewJob"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
<script type="text/javascript" src="jsp/js/util.js"></script>
<link type="text/css" rel="stylesheet" href="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<c:url value="/BrewJob.do" var="defURL" />

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="BrewJob.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="BrewJob.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="BrewJob.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="BrewJob.do"/>
		<jsp:param name="method" value="listBrewJob"/>
	</jsp:include>
	
</div>

<div id="container">

<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="BrewJob"/></caption>
<tbody>
<tr>
	<td  class="textr"><fmt:message key="WineStyle"/></td>
	<td><select name="wineStyleId" onchange="document.forms[0].submit();">
			<option selected="selected" value="">All</option>
			<c:forEach var="items" items="${wineStyles}" varStatus="s">
				<option value="${items.id}"
		
				<c:if test="${items.id==param.wineStyleId}">
					selected="selected"
				</c:if>
					>
				${items.styleName}
				</option>
			--</c:forEach>
		</select>
	</td>
	
	<td  class="textr"><fmt:message key="BrewNumber"/></td>
	<td><input name="brewNumber" value="${param.brewNumber }"/></td>
	
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
<td colspan="7" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'id');"/><fmt:message key="ID"/></th>
<th><fmt:message key="WineStyle"/></th>
<th><fmt:message key="BrewNumber"/></th>
<th><fmt:message key="Quantity"/></th>
<th><fmt:message key="Unit"/></th>
<th><fmt:message key="JobState"/></th>
<th><fmt:message key="JobDate"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.brewJob.id }"> </td>
<td><c:out value="${item.wineStyle.styleName }"/></td>
<td><c:out value="${item.brewJob.brewNumber }"/></td>
<td><c:out value="${item.brewJob.quantity }"/></td>
<td><c:out value="${item.brewJob.unit }"/></td>
<td><fmt:message key="${item.brewJob.jobState }"/></td>
<td><fmt:formatDate value="${item.brewJob.jobDate }" type="both" /></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="7" >
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