<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
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
<c:url value="/User.do" var="promptAddURL">
		<c:param name="method">promptAdd</c:param>
</c:url>
<form method="post" action="${promptAddURL }">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="processAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="User.do"/>
		<jsp:param name="method" value="listUser"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Add"/> <fmt:message key="User"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="Branch"/></td>
<td>
<select name="user.branchId"  onchange="document.forms[0].submit();">
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
<td><input type="text" name="user.name" maxlength="8" style="width:120px;"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Password"/></td>
<td><input type="password" name="user.password" maxlength="8" style="width:120px;"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Alias"/></td>
<td><input type="text" name="user.alias" maxlength="16" style="width:240px;"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="MobilePhone"/></td>
<td><input type="text" name="user.mobile" size="11" maxlength="11"/><font class="fm">*</font></td>
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