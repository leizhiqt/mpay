<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Barcode"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
<script type="text/javascript" src="jsp/js/util.js"></script>
<link type="text/css" rel="stylesheet" href="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112" media="screen"/>
<script type="text/javascript" src="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<c:url value="/Barcode.do" var="defURL" />

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="Barcode.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="Barcode.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="Barcode.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="Barcode.do"/>
		<jsp:param name="method" value="listBarcode"/>
	</jsp:include>
	
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="Preview"/>
		<jsp:param name="action" value="Barcode.do"/>
		<jsp:param name="method" value="preview"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="Barcode"/></caption>
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
	
	<td  class="textr"><fmt:message key="Point"/></td>
	<td><select name="point" onchange="document.forms[0].submit();">
			<option selected="selected" value="">All</option>
			<c:forEach var="items" items="${points}" varStatus="s">
				<option value="${items.key}"
		
				<c:if test="${items.value==param.point}">
					selected="selected"
				</c:if>
					>
				<fmt:message key="${items.value}"/>
				</option>
			--</c:forEach>
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
<!-- 分页 -->
<tr class="lp">
<td colspan="5" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'id');"/><fmt:message key="ID"/></th>
<th><fmt:message key="WineStyle"/></th>
<th><fmt:message key="CodeNumber"/></th>
<th><fmt:message key="Point"/></th>
<th><fmt:message key="PointDate"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.barcode.id }"> </td>
<td><c:out value="${item.wineStyle.styleName }"/></td>
<td><c:out value="${item.barcode.codeNumber }"/></td>
<td><fmt:message key="${item.barcode.point }"/></td>
<td><fmt:formatDate value="${item.barcode.pointDate }" type="both" /></td>
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