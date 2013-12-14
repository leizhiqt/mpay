<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="WorkGroup"/></title>
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
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="processAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="WorkGroup.do"/>
		<jsp:param name="method" value="listWorkGroup"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Add"/> <fmt:message key="WorkGroup"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="Branch"/></td>
<td>
<select name="workGroup.branchId">
	<c:forEach var="items" items="${branchs}" varStatus="s">
		<option value="${items.key}"

		<c:if test="${items.key==workGroup.branchId}">
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
<td class="tl"><fmt:message key="Definition"/></td>
<td><input type="text" name="workGroup.definition"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Description"/></td>
<td><textarea rows="3" cols="28" name="workGroup.description"></textarea></td>
</tr>

<%-- 
<tr>
<td>
<input type="text" value="模糊型号查询" onfocus="if(value=='模糊型号查询') {value=''}" onblur="if (value=='') {value='模糊型号查询'}" name="keyword" size="30" style="color:#e5e1e1;"/>
<input type="text" value="联系人" onFocus="this.select();this.style.color='#000000'" onClick="if (this.value=='联系人'){this.value=''}" onblur="if(this.value ==''||this.value=='联系人'){this.value='联系人';this.style.color='#CCCCCC'}" style="width: 200px;color:#CCCCCC;" />
<input type="text" style="width:190px; height:16px; color:#DFDFDF" value="请输入笔记本的系列或者型号" onfocus="if(this.value=='请输入笔记本的系列或者型号'){this.value=''};this.style.color='black';" onblur="if(this.value==''||this.value=='请输入笔记本的系列或者型号'){this.value='请输入笔记本的系列或者型号';this.style.color='#DFDFDF';}">
</td>
</tr>
--%>
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