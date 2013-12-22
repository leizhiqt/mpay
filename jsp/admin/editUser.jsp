<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="User"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>

<body>
<form method="post">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="listUser"/>
	</jsp:include>
</div>

<div id="container">
<input type="hidden" name="user.id" value="${user.id }"/>

<%@ include file="../incl/b_message.jsp" %>
<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Edit"/> <fmt:message key="User"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="Branch"/></td>
<td>
<select name="user.branchId">
	<c:forEach var="items" items="${branchs}" varStatus="s">
		<option value="${items.key}"

		<c:if test="${items.key==user.branchId}">
			selected="selected"
		</c:if>
			>
		${items.value}
		</option>
	--</c:forEach>
</select>
<font class="fm">*</font>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Name"/></td>
<td><input type="text" name="user.name" value="${user.name }" maxlength="8" style="width:120px;"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Password"/></td>
<td><input type="password" name="user.password" value="${user.password }" maxlength="8" style="width:120px;"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Alias"/></td>
<td><input type="text" name="user.alias" value="${user.alias }" maxlength="16" style="width:240px;"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Active"/></td>
	<td>
		<select name="user.active">
			<option value="Y"  <c:if test="${user.active=='Y'}">
				selected="selected"
			</c:if>>Y</option>
			
			<option value="N" 
			<c:if test="${user.active=='N'}">
				selected="selected"
			</c:if>>N</option>
		</select>
	</td>
</tr>

<tr>
<td class="tl"><fmt:message key="MobilePhone"/></td>
<td><input type="text" name="user.mobile" value="${user.mobile }" size="11" maxlength="11"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Store"/></td>
<td>
	<c:forEach var="store" items="${stores}" varStatus="s">
		<input type="checkbox" name="storeId" value="${store.id }" 
		
			<c:forEach var="nowStore" items="${nowStores}" varStatus="s">
				<c:if test="${store.id==nowStore.storeId }"> checked</c:if>
			</c:forEach>
		
		>${store.storeName }
	</c:forEach>
</tr>

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