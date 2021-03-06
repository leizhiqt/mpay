<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Product"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>

<body>
<c:url value="/Store.do" var="defURL" />

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="Store.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="Store.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="Store.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="Store.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
	
</div>

<div id="container">

<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="Store"/></caption>
<tbody>
<tr>
	<td  class="textr"><fmt:message key="StoreKey"/></td>
	<td><input name="StoreKey" value="${param.StoreKey }"/></td>
	
	<td  class="textr"><fmt:message key="Store"/></td>
	<td><input name="storeName" value="${param.storeName }"/></td>
</tr>

</tbody>
</table>
</td>
</tr>

<tr>
<td>

<table class="lt">

<thead>
<!-- ?????? -->
<tr class="lp">
<td colspan="9" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'id');"/><fmt:message key="ID"/></th>
<th><fmt:message key="StoreKey"/></th>
<th><fmt:message key="Store"/></th>
<th><fmt:message key="StoreAddress"/></th>
<th><fmt:message key="StoreBankNo"/></th>
<th><fmt:message key="StoreBankName"/></th>
<th><fmt:message key="StoreTypeName"/></th>

</tr>
</thead>

<tbody>
<c:forEach var="items" items="${items}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${items.store.id }"> </td>
<td><c:out value="${items.store.storeKey }"/></td>
<td><c:out value="${items.store.storeName }"/></td>
<td><c:out value="${items.store.storeAddress }"/></td>
<td><c:out value="${items.store.storeBankNo }"/></td>
<td><c:out value="${items.store.storeBankName }"/></td>
<td><c:out value="${items.storeType.typeName }"/></td>


</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- ?????? -->
<tr class="lp">
<td colspan="9" >
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