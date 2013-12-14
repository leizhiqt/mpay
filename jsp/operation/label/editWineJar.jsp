<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="WineJar"/></title>
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
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="method" value="listWineJar"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../../incl/b_message.jsp" %>
<input type="hidden" name="wineJar.id" value="${wineJar.id }"/>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="WineJar"/></caption>

<tbody>
<tr>
<td class="tl"><fmt:message key="JarNumber"/>:</td>
<td><input type="text" name="wineJar.jarNumber" value="${wineJar.jarNumber}"  size="4" maxlength="4"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Winery"/></td>
<td>
<select name="wineJar.wineryId">
	<c:forEach var="items" items="${winerys}" varStatus="s">
		<option value="${items.winery.id}"

		<c:if test="${items.winery.id==wineJar.wineryId}">
			selected="selected"
		</c:if>
			>
		${items.winery.enterpriseName}
		</option>
	--</c:forEach>
</select>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Perimeter"/></td>
<td><input type="text" name="wineJar.perimeter" value="${wineJar.perimeter}"  size="6" maxlength="6"/><font>[00.000](m)</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="OutsideHeight"/></td>
<td><input type="text" name="wineJar.outsideHeight" value="${wineJar.outsideHeight}"  size="6" maxlength="6"/><font>[00.000](m)</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="TotalHeight"/></td>
<td><input type="text" name="wineJar.totalHeight" value="${wineJar.totalHeight}"  size="6" maxlength="6"/><font>[00.000](m)</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="ClearHeight"/></td>
<td><input type="text" name="wineJar.clearHeight" value="${wineJar.clearHeight}"  size="6" maxlength="6"/><font>[00.000](m)</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Density"/></td>
<td><input type="text" name="wineJar.density" value="${wineJar.density}"  size="6" maxlength="6"/><font>[00.000](T/m³)</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Volume"/></td>
<td><input type="text" name="wineJar.volume" value="${wineJar.volume}" size="10" maxlength="10"/>

<select name="wineJar.unitId">
	<c:forEach var="items" items="${volumeUnits}" varStatus="s">
		<option value="${items.key}"

		<c:if test="${items.key==4}">
			selected="selected"
		</c:if>
			>
		${items.value}
		</option>
	</c:forEach>
</select>

<font>[000000.000](T)</font>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Weight"/></td>
<td><input type="text" name="wineJar.weight" value="${wineJar.weight}" size="10" maxlength="10"/><font>[000000.000](T)</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Price"/></td>
<td><input type="text" name="wineJar.price" value="${wineJar.price }" size="10" maxlength="10"/>

<select name="wineJar.orgCurrencyId">
	<c:forEach var="items" items="${currencys}" varStatus="s">
		<option value="${items.key}"

		<c:if test="${items.key==wineJar.orgCurrencyId}">
			selected="selected"
		</c:if>
			>
		${items.value}
		</option>
	--</c:forEach>
</select>
<font>[0000000.00](元)</font>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="WineTypeId"/></td>
<td>
<select name="wineJar.wineTypeId">
	<c:forEach var="items" items="${wineTypes}" varStatus="s">
		<option value="${items.key}"

		<c:if test="${items.key==wineJar.wineTypeId}">
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
<td class="tl"><fmt:message key="WineLevelId"/></td>
<td>
<select name="wineJar.wineLevelId">
	<c:forEach var="items" items="${wineLevels}" varStatus="s">
		<option value="${items.key}"

		<c:if test="${items.key==wineJar.wineLevelId}">
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
<td class="tl"><fmt:message key="BankSupervision"/></td>
<td>
<select name="wineJar.bankId">
	<c:forEach var="items" items="${banks}" varStatus="s">
		<option value="${items.user.id}"

		<c:if test="${items.user.id==wineJar.bankId}">
			selected="selected"
		</c:if>
			>
		${items.user.name}
		</option>
	--</c:forEach>
</select>
<font class="fm">*</font>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Alcohol"/></td>
<td><input type="text" name="wineJar.alcohol" value="${wineJar.alcohol }"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="CreateDate"/></td>
<td>
<input type="text" name="wineJar.createDate" value="<fmt:formatDate value="${wineJar.createDate }" type="both"/>" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');"/>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Material"/></td>
<td><input type="text" name="wineJar.material" value="${wineJar.material }"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="State"/></td>
<td>
<select name="wineJar.stateId">
       <c:forEach var="items" items="${status}" varStatus="s">
               <option value="${items.key}"

               <c:if test="${items.key==wineJar.stateId}">
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
