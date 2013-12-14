<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Card"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<c:url value="/CardJob.do" var="defURL">
	<c:param name="method">listCardJob</c:param>
</c:url>
		
<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="CardJob.do"/>
		<jsp:param name="method" value="listCardJob"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="print"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="CardJob.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=pdf"/>
		<jsp:param name="method" value="printCardJob"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="export"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="CardJob.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=xls"/>
		<jsp:param name="method" value="exportCardJob"/>
	</jsp:include>
	
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="ChangeCard"/>
		<jsp:param name="action" value="CardJob.do"/>
		<jsp:param name="method" value="wineryCardJob"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="Card"/></caption>
<tbody>

<tr>
	<td  class="textr"><fmt:message key="Winery"/></td>
	<td><select name="wineryId" onchange="document.forms[0].submit();">
			<option selected="selected" value="">All</option>
			<c:forEach var="items" items="${winerys}" varStatus="s">
				<option value="${items.winery.id}"
		
				<c:if test="${items.winery.id==param.wineryId}">
					selected="selected"
				</c:if>
					>
				${items.winery.enterpriseName}
				</option>
			--</c:forEach>
		</select>
	</td>
	
	<td  class="textr"><fmt:message key="WineJar"/></td>
	<td>
		<input type="text" name="wineJar" value="${param.wineJar }"/>
		<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/wineJarLookup.jsp?wineryId=${param.wineryId}','forms[0].wineJar');return false;">
	</td>
</tr>

<tr>
	<td  class="textr"><fmt:message key="Rfidcode"/></td>
	<td>
		<input type="text" name="rfidCode" value="${param.rfidCode }"/>
		<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/allCardLookup.jsp?wineryId=${param.wineryId}','forms[0].rfidCode');return false;">
	</td>
	
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
</tr>

<tr>
	<td  class="textr"></td>
	<td></td>
	
	<td  class="textr"><fmt:message key="JobType"/></td>
	<td><select name="jobTypeId" onchange="document.forms[0].submit();">
			<option selected="selected" value="">All</option>
			<c:forEach var="items" items="${jobTypes}" varStatus="s">
				<option value="${items.key}"
		
				<c:if test="${items.key==param.jobTypeId}">
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
	<td class="textr"><fmt:message key="StartDate"/></td>
	<td><input type="text" name="StartDate" value="${StartDate }" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');"/></td>

	<td class="textr"><fmt:message key="EndDate"/></td>
	<td><input type="text" name="EndDate" value="${EndDate }" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');"/></td>
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
<td colspan="15" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="Winery"/></th>
<th><fmt:message key="WineJarId"/></th>
<th><fmt:message key="State"/></th>
<th><fmt:message key="CardType"/></th>
<th><fmt:message key="Rfidcode"/></th>
<th><fmt:message key="Position"/></th>
<th><fmt:message key="JobType"/></th>
<th><fmt:message key="OperatorId"/></th>
<th><fmt:message key="JobTime"/></th>
<th><fmt:message key="SpotNormal"/></th>
<th><fmt:message key="CardNormal"/></th>
<th><fmt:message key="Remark"/></th>
<th><fmt:message key="Audit"/></th>
<th><fmt:message key="Picture"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${cards}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.cardJob.id }"></td>
<td><c:out value="${item.winery.enterpriseName }"/></td>
<td><c:out value="${item.wineJar.jarNumber }"/></td>
<td><c:out value="${item.jobState.fullName }"/></td>
<td><c:out value="${item.cardType.cardTypeName }"/></td>
<td><c:out value="${item.card.rfidcode }"/></td>
<td><c:out value="${item.card.position }"/></td>
<td><c:out value="${item.jobType.definition }"/></td>
<td><c:out value="${item.user.name }"/></td>
<td><fmt:formatDate value="${item.cardJob.jobDate }" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></td>
<td><c:out value="${item.cardJob.spotNormal }"/> </td>
<td><c:out value="${item.cardJob.cardNormal }"/></td>
<td><c:out value="${item.cardJob.remark }"/></td>
<td><c:out value="${item.cardJob.isPost }"/></td>

<td>
<c:forEach var="image" items="${item.cardJob.images }">
<a href="${image.filePath }"><img src="${image.filePath }" width="40" height="30"></a>
</c:forEach>
</td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="15" >
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