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
<c:url value="/User.do" var="defURL"/>

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="listUser"/>
	</jsp:include>
	
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="print"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=pdf"/>
		<jsp:param name="method" value="print"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="export"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=xls"/>
		<jsp:param name="method" value="export"/>
	</jsp:include>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="AssignGroup"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="promptAssignGroup"/>
	</jsp:include>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="Close"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="processDisable"/>
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
	<td  class="textr"><fmt:message key="Name"/></td>
	<td><input name="userName" value="${param.userName }"/></td>
	<td  class="textr"><fmt:message key="Alias"/></td>
	<td><input name="userAlias" value="${param.userAlias }"/></td>
</tr>

<tr>
	<td class="textr"><fmt:message key="BranchCategory"/></td>
	<td>
	<select name="categoryId"  onchange="document.forms[0].submit();">
		<option selected="selected" value="">All</option>
		<c:forEach var="items" items="${categorys}" varStatus="s">
			<option value="${items.key}"
	
			<c:if test="${items.key==param.categoryId}">
				selected="selected"
			</c:if>
				>
			${items.value}
			</option>
		--</c:forEach>
	</select>
	</td>

	<td  class="textr"><fmt:message key="UserType"/></td>
	<td>
	<select name="typeId">
		<option selected="selected" value="">All</option>
		<c:forEach var="items" items="${userTypes}" varStatus="s">
			<option value="${items.key}"
	
			<c:if test="${items.key==param.typeId}">
				selected="selected"
			</c:if>
				>
			${items.value}
			</option>
		--</c:forEach>
	</select>
	</td>
</tr>

<tr>
	<td class="textr"><fmt:message key="Active"/></td>
	<td>
		<select name="active"  onchange="document.forms[0].submit();">
			
			<c:if test="${empty param.active }">
					<option selected="selected" value="">All</option>
			</c:if>
				
			<option value="Y"  <c:if test="${param.active=='Y'}">
				selected="selected"
			</c:if>>Y</option>
			
			<option value="N" 
			<c:if test="${param.active=='N'}">
				selected="selected"
			</c:if>>N</option>
		</select>
	</td>

	<td class="textr"></td>
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
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><input name="choose" type="checkbox" onclick="checkedAll(this.name,'id');"/><fmt:message key="ID"/></th>
<th><fmt:message key="BranchCategory"/></th>
<th><fmt:message key="UserType"/></th>
<th><fmt:message key="Name"/></th>
<th><fmt:message key="Alias"/></th>
<th><fmt:message key="MobileNumber"/></th>
<th><fmt:message key="Branch"/></th>
<th><fmt:message key="Active"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.user.id }"> </td>
<td><c:out value="${item.branchCategory.definition }"/></td>
<td><c:out value="${item.userType.definition }"/></td>
<td><c:out value="${item.user.name }"/></td>
<td><c:out value="${item.user.alias }"/></td>
<td><c:out value="${item.user.mobile }"/></td>
<td><c:out value="${item.branch.definition }"/></td>
<td><c:out value="${item.user.active }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="8" >
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