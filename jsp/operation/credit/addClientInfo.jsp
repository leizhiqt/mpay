<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="ClientInfo"/></title>
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
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="processBatchAdd"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="listClientInfo"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Add"/> <fmt:message key="ClientInfo"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="ContractNumber"/></td>
<td><input type="text" name="startJarNumber" size="4" maxlength="4"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="ClientName"/></td>
<td><input type="text" name="startJarNumber" size="4" maxlength="4"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Sex"/></td>
<td><input type="text" name="endJarNumber" size="4" maxlength="4"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="Marry"/></td>
<td><input type="checkbox" name="endJarNumber"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Mobile"/></td>
<td><input type="text" name="suffixJarNumber"  size="11" maxlength="11"/></td>

<td class="tl"><fmt:message key="Childs"/></td>
<td><input type="text" name="suffixJarNumber"  size="2" maxlength="2"/><font class="fm">*</font>
</tr>

<tr>
<td class="tl"><fmt:message key="Childs"/></td>
<td><input type="text" name="suffixJarNumber"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="Housing"/></td>
<td><input type="text" name="suffixJarNumber"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="HomePhoneName"/></td>
<td><input type="text" name="suffixJarNumber"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="HomePhone"/></td>
<td><input type="text" name="suffixJarNumber"/><font class="fm">*</font></td>
</tr>


<tr>
<td class="tl"><fmt:message key="CreateDate"/></td>
<td>

</td>

<td class="tl"><fmt:message key="Email"/></td>
<td><input type="text" name="suffixJarNumber"/><font class="fm">*</font></td>
</tr>

</tbody>

</table>
</td>
</tr>


<tr>
<td>

<table class="modify">
<caption><fmt:message key="Relatives"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="RelativesType"/></td>
<td><input type="text" name="startJarNumber" size="4" maxlength="4"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="RelativesName"/></td>
<td><input type="text" name="startJarNumber" size="4" maxlength="4"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="EmployerName"/></td>
<td><input type="text" name="endJarNumber" size="4" maxlength="4"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="officePhone"/></td>
<td><input type="text" name="endJarNumber" size="4" maxlength="4"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="ExtencePhone"/></td>
<td><input type="text" name="suffixJarNumber"  size="11" maxlength="11"/></td>

<td class="tl"><fmt:message key="ZipCode"/></td>
<td><input type="text" name="suffixJarNumber"  size="2" maxlength="2"/><font class="fm">*</font>
</tr>

<tr>
<td class="tl"><fmt:message key="Census"/></td>
<td><input type="text" name="suffixJarNumber"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="Housing"/></td>
<td><input type="text" name="suffixJarNumber"/><font class="fm">*</font></td>
</tr>

</tbody>

</table>
</td>
</tr>

<tr>
<td>

<table class="modify">
<caption><fmt:message key="Bank"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="DebitCard"/></td>
<td><input type="text" name="startJarNumber" size="19" maxlength="19"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="BankName"/></td>
<td><input type="text" name="startJarNumber"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="AutoPay"/></td>
<td><input type="checkbox" name="endJarNumber"/><font class="fm">*</font></td>

<td class="tl"></td>
<td></td>
</tr>

</tbody>

</table>
</td>
</tr>


<tr>
<td>

<table class="lt">
<caption><fmt:message key="Sale"/></caption>

<thead>
<tr>
<th><fmt:message key="Product"/></th>
<th><fmt:message key="Quantity"/></th>
<th><fmt:message key="Price"/></th>
<th><fmt:message key="Totail"/></th>
</tr>
</thead>

<tbody>
<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><c:out value="${item.user.name }"/></td>
<td><c:out value="${item.cardType.cardTypeName }"/></td>
<td><c:out value="${item.card.rfidcode }"/></td>
<td><c:out value="${item.card.position }"/></td>
</tr>
</c:forEach>
</tbody>

</tbody>

</table>
</td>
</tr>

<tr>
<td>

<table class="modify">
<caption><fmt:message key="Credit"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="CreditAmount"/></td>
<td><input type="text" name="startJarNumber" size="19" maxlength="19"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="DownAmount"/></td>
<td><input type="text" name="startJarNumber"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="CreditType"/></td>
<td><input type="text" name="startJarNumber" size="19" maxlength="19"/><font class="fm">*</font></td>

<td class="tl"><fmt:message key="ByUse"/></td>
<td><input type="text" name="startJarNumber"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="FirstpayDate"/></td>
<td><input type="text" name="wineJar.createDate" value="<fmt:formatDate value="${wineJar.createDate }" type="date"/>" size="10" maxlength="10" onclick="displayCalendar(this,'yyyy-MM-dd');"/>
<font class="fm">*</font></td>

<td class="tl"><fmt:message key="RepaymentDate"/></td>
<td><input type="text" name="wineJar.createDate" value="<fmt:formatDate value="${wineJar.createDate }" type="date"/>" size="10" maxlength="10" onclick="displayCalendar(this,'yyyy-MM-dd');"/>
<font class="fm">*</font></td>
</tr>

</tbody>

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
