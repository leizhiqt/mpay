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
<c:url value="/ClientInfo.do" var="defURL">
	<c:param name="method">list</c:param>
</c:url>

<form method="post" action="${defURL }">
<div id="gtop">
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="add"/>
		<jsp:param name="key" value="Add"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="promptAdd"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="delete"/>
		<jsp:param name="key" value="Delete"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="processDelete"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="edit"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="promptEdit"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="print"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=pdf"/>
		<jsp:param name="method" value="printClientInfo"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="export"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="aparams" value="reportName=${reportName }&reportType=xls"/>
		<jsp:param name="method" value="exportClientInfo"/>
	</jsp:include>
	
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Declare"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="promptDeclare"/>
	</jsp:include>

	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Approval"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>

</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="ClientInfo"/></caption>
<tbody>
<tr>
	<td  class="textr"><fmt:message key="Winery"/></td>
	<td></td>
	
	<td class="textr"></td>
	<td></td>
	
	<td  class="textr"><fmt:message key="Rfidcode"/></td>
	<td>
		<input type="text" name="rfidcode" value="${param.rfidcode }"/>
		<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/allClientInfoLookup.jsp?wineryId=${param.wineryId}','forms[0].rfidcode');return false;">
	</td>
	
	<td  class="textr"><fmt:message key="JobType"/></td>
	<td></td>
</tr>

<tr>
	<td class="textr"><fmt:message key="StartDate"/></td>
	<td><input type="text" name="StartDate" value="${StartDate }" onclick="displayCalendar(this,'yyyy-MM-dd');" size="10" maxlength="10"/></td>

	<td class="textr"><fmt:message key="EndDate"/></td>
	<td><input type="text" name="EndDate" value="${EndDate }" onclick="displayCalendar(this,'yyyy-MM-dd');" size="10" maxlength="10"/></td>
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
<td colspan="10" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="Winery"/></th>
<th><fmt:message key="StatusId"/></th>
<th><fmt:message key="OperatorId"/></th>
<th><fmt:message key="OperatingTime"/></th>
<th><fmt:message key="ClientInfoType"/></th>
<th><fmt:message key="Rfidcode"/></th>
<th><fmt:message key="Position"/></th>
<th><fmt:message key="Uuid"/></th>
<th><fmt:message key="Remark"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.card.id }"></td>
<td><c:out value="${item.winery.enterpriseName }"/></td>
<td>
	<c:url value="/ClientInfo.do" var="viewClientInfo">
		<c:param name="method">view</c:param>
		<c:param name="id">${item.card.id}</c:param>
	</c:url>
	<a href="#" onclick="window.open('${viewClientInfo }','ClientInfoJob', 'width=640,height=320,scrollbars');return false;"> <c:out value="${item.jobType.definition }"/></a>
</td>
<td><c:out value="${item.user.name }"/></td>
<td><fmt:formatDate value="${item.cardJob.jobDate }" type="both" /></td>
<td><c:out value="${item.cardType.cardTypeName }"/></td>
<td><c:out value="${item.card.rfidcode }"/></td>
<td><c:out value="${item.card.position }"/></td>
<td><c:out value="${item.card.uuid }"/></td>
<td><c:out value="${item.card.remark }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="10" >
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