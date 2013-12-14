<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Winery"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
<script type="text/javascript" src="jsp/js/util.js"></script>
<link type="text/css" rel="stylesheet" href="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<c:url value="/Winery.do" var="defURL">
	<c:param name="method">list</c:param>
</c:url>

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="Winery.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="Winery.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="Winery.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="Winery.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
	
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Close"/>
		<jsp:param name="action" value="Winery.do"/>
		<jsp:param name="method" value="disableJob"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="Winery"/></caption>
<tbody>
	<tr>
		<td  class="textr"><fmt:message key="Abbreviation"/></td>
		<td><input name="query_abbreviation" value="${param.query_abbreviation }"/></td>
		<td  class="textr"><fmt:message key="Definition"/></td>
		<td><input name="query_definition" value="${param.query_definition }"/></td>
	</tr>
	
	<tr>
		<td  class="textr"><fmt:message key="Address"/></td>
		<td><input name="query_address" value="${param.query_address }"/></td>
		<td  class="textr"><fmt:message key="Telephone"/></td>
		<td><input name="query_telephone" value="${param.query_telephone }"/></td>
	</tr>

	<tr>
		<td  class="textr"><fmt:message key="State"/></td>
		<td><select name="query_stateId" onchange="document.forms[0].submit();">
				<option selected="selected" value="">All</option>
				<c:forEach var="items" items="${status}" varStatus="s">
					<option value="${items.key}"
			
					<c:if test="${items.key==param.query_stateId}">
						selected="selected"
					</c:if>
						>
					${items.value}
					</option>
				--</c:forEach>
			</select>
		</td>
		<td  class="textr"></td>
		<td></td>
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
<td colspan="8" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="ShortName"/></th>
<th><fmt:message key="EnterpriseName"/></th>
<th><fmt:message key="Address"/></th>
<th><fmt:message key="MobilePhone"/></th>
<th><fmt:message key="Telephone"/></th>
<th><fmt:message key="Telephone1"/></th>
<th><fmt:message key="State"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${winerys}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if> onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.winery.id }"></td>
<td><c:out value="${item.winery.shortName }"/></td>
<td><c:out value="${item.winery.enterpriseName }"/></td>
<td><c:out value="${item.winery.address }"/></td>
<td><c:out value="${item.winery.mobilePhone }"/></td>
<td><c:out value="${item.winery.telephone }"/></td>
<td><c:out value="${item.winery.telephone1 }"/></td>
<td><c:out value="${item.jobState.fullName }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="8" >
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