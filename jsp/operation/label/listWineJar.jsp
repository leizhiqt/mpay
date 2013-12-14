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
<c:url value="/WineJar.do" var="defURL">
	<c:param name="method">listWineJar</c:param>
</c:url>

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="method" value="listWineJar"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="print"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=pdf"/>
		<jsp:param name="method" value="print"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="export"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=xls"/>
		<jsp:param name="method" value="export"/>
	</jsp:include>
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Close"/>
		<jsp:param name="action" value="WineJar.do"/>
		<jsp:param name="method" value="disableWineJar"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="WineJar"/></caption>
<tbody>
<tr>
	<td class="textr"><fmt:message key="Abbreviation"/></td>
	<td><input name="query_abbreviation" value="${param.query_abbreviation }"/></td>
	
	<td  class="textr"><fmt:message key="Winery"/></td>
	<td><select name="wineryId" onchange="document.forms[0].submit();">
			<option selected="selected" value="">All</option>
			<c:forEach var="items" items="${winerys}" varStatus="s">
				<option value="${items.winery.id}"
		
				<c:if test="${items.winery.id==wineryId}">
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
	<td class="textr"><fmt:message key="StartDate"/></td>
	<td>
		<input type="text" name="StartDate" value="${StartDate }" onclick="displayCalendar(this,'yyyy-MM-dd');"/>
	</td>
	<td class="textr"><fmt:message key="EndDate"/></td>
	<td>
		<input type="text" name="EndDate" value="${EndDate }" onclick="displayCalendar(this,'yyyy-MM-dd');"/>
	</td>
</tr>

<tr>
	<tr>
	<td class="textr"><fmt:message key="State"/></td>
	<td>
	<select name="stateId" onchange="document.forms[0].submit();">
		<option selected="selected" value="">All</option>
		     <c:forEach var="items" items="${status}" varStatus="s">
		        <option value="${items.key}"
		
		        <c:if test="${items.key==param.stateId}">
		                selected="selected"
		        </c:if>
		                >
		        ${items.value}
		        </option>
		 	--</c:forEach>
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
<td colspan="16" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="JarNumber"/></th>
<th><fmt:message key="Winery"/></th>
<th><fmt:message key="Perimeter"/>(m)</th>
<th><fmt:message key="OutsideHeight"/>(m)</th>
<th><fmt:message key="TotalHeight"/>(m)</th>
<th><fmt:message key="ClearHeight"/>(m)</th>
<th><fmt:message key="Density"/>(T/m³)</th>
<th><fmt:message key="Tonnage"/>(T)</th>
<%-- 
<th><fmt:message key="Weight"/>(T)</th>
<th><fmt:message key="Price"/>(RMB/T)</th>
--%>
<th><fmt:message key="WineTypeId"/></th>
<th><fmt:message key="WineLevelId"/></th>
<th><fmt:message key="Alcohol"/></th>
<th><fmt:message key="CreateDate"/></th>
<th><fmt:message key="Material"/></th>
<th><fmt:message key="BankSupervision"/></th>
<th><fmt:message key="State"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.wineJar.id }"></td>
<td><c:out value="${item.wineJar.jarNumber }"/></td>
<td><c:out value="${item.winery.enterpriseName }"/></td>
<td><c:out value="${item.wineJar.perimeter }"/></td>
<td><c:out value="${item.wineJar.outsideHeight }"/></td>
<td><c:out value="${item.wineJar.totalHeight }"/></td>
<td><c:out value="${item.wineJar.clearHeight }"/></td>
<td><c:out value="${item.wineJar.density }"/></td>
<td><c:out value="${item.wineJar.volume }"/></td>
<%-- 
<td><c:out value="${item.wineJar.weight }"/></td>
<td><c:out value="${item.wineJar.price }"/></td>
--%>
<td><c:out value="${item.wineType.definition }"/></td>
<td><c:out value="${item.wineLevel.definition }"/></td>
<td><c:out value="${item.wineJar.alcohol }"/></td>
<td><fmt:formatDate value="${item.wineJar.createDate }" type="date"/></td>
<td><c:out value="${item.wineJar.material }"/></td>
<td><c:out value="${item.user.name }"/></td>
<td><c:out value="${item.jobState.fullName }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="16" >
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
