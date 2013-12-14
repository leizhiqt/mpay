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
<form method="post">
<div id="gtop">
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="Winery.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="Winery.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../../incl/b_message.jsp" %>
<input type="hidden" name="winery.id" value="${winery.id }"/>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="Winery"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="ShortName"/></td>
<td><input type="text" name="winery.shortName" value="${winery.shortName }" size="5" maxlength="5"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="EnterpriseName"/></td>
<td><input type="text" name="winery.enterpriseName" value="${winery.enterpriseName }"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="EnterpriseName1"/></td>
<td><input type="text" name="winery.enterpriseName1" value="${winery.enterpriseName1 }"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="EnterpriseCode"/></td>
<td><input type="text" name="winery.enterpriseCode"  value="${winery.enterpriseCode }" size="20" maxlength="20"/></td>
</tr>

<tr>
<td class="tl">
<fmt:message key="State"/>
</td>
<td>
<select name="winery.stateId">
	<c:forEach var="items" items="${status}" varStatus="s">
		<option value="${items.id}"

		<c:if test="${items.id==winery.stateId}">
			selected="selected"
		</c:if>
			>
		${items.fullName}
		</option>
	--</c:forEach>
</select>
<font class="fm">*</font>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Contact"/></td>
<td><input type="text" name="winery.contact" value="${winery.contact }"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Address"/></td>
<td><input type="text" name="winery.address"  value="${winery.address }" size="40"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Zipcode"/></td>
<td><input type="text" name="winery.zipcode"  value="${winery.zipcode }" size="6" maxlength="6"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="MobilePhone"/></td>
<td><input type="text" name="winery.mobilePhone"  value="${winery.mobilePhone }" size="14" maxlength="14"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Telephone"/></td>
<td><input type="text" name="winery.telephone"  value="${winery.telephone }" size="16" maxlength="16"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Telephone1"/></td>
<td><input type="text" name="winery.telephone1"  value="${winery.telephone1 }" size="16" maxlength="16"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="HygieneLicense"/></td>
<td><input type="text" name="winery.hygieneLicense"  value="${winery.hygieneLicense }" size="20" maxlength="20"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="BusinessLicence"/></td>
<td><input type="text" name="winery.businessLicence"  value="${winery.businessLicence }" size="20" maxlength="20"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="TotalPits"/></td>
<td><input type="text" name="winery.totalPits"  value="${winery.totalPits }"  size="6" maxlength="6"/><font>口</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="AverageAgePits"/></td>
<td><input type="text" name="winery.averageAgePits"  value="${winery.averageAgePits }"  size="6" maxlength="6"/><font>年</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="HightAgePits"/></td>
<td><input type="text" name="winery.hightAgePits"  value="${winery.hightAgePits }"  size="6" maxlength="6"/><font>口</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Nissan"/></td>
<td><input type="text" name="winery.nissan"  value="${winery.nissan }"  size="6" maxlength="6"/><font>吨</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="NissanTop"/></td>
<td><input type="text" name="winery.nissanTop"  value="${winery.nissanTop }"  size="6" maxlength="6"/><font>吨</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Introduction"/></td>
<td><p><textarea name="winery.introduction" cols="70" rows="10">${winery.introduction }</textarea></p></td>
</tr>

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