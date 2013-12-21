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
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Declare"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="promptDeclare"/>
	</jsp:include>

	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Approval"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="promptApproval"/>
	</jsp:include>

</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption>合同</caption>
<tbody>
<tr>
	<td  class="textr"><fmt:message key="JobNo" /></td>
	<td><input type="text" name="JobNo" value="${param.jobNo }"/></td>
	
	<td  class="textr"><fmt:message key="IdNo" /></td>
	<td><input type="text" name="idNo" value="${param.idNo }"/> </td>
	
	<td  class="textr"><fmt:message key="Telephone" /></td>
	<td><input type="text" name="telephone" value="${param.telephone }"/></td>
	
	<td  class="textr"><fmt:message key="Status" /></td>
	<td><input type="text" name="status" value="${param.status }"/></td>
</tr>

<tr>
	<td class="textr"><fmt:message key="StartDate"/></td>
	<td><input type="text" name="StartDate" value="${StartDate }" onclick="displayCalendar(this,'yyyy-MM-dd');" size="10" maxlength="10"/></td>

	<td class="textr"><fmt:message key="EndDate"/></td>
	<td><input type="text" name="EndDate" value="${EndDate }" onclick="displayCalendar(this,'yyyy-MM-dd');" size="10" maxlength="10"/></td>
	
	<td>

	</td>
</tr>


</tbody>

<tfoot>
<tr style="text-align:center;">
<td colspan="6">
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Search"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
</td>
</tr>
</tfoot>

</table>
</td>
</tr>

<tr>
<td>

<table class="lt">

<thead>
<!-- 分页 -->
<tr class="lp">
<td colspan="11" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th></th>
<th>合同号</th>
<th>合同日期</th>
<th>状态</th>
<th>身份证号</th>
<th>客户名称</th>
<th>贷款本金</th>
<th>分期数</th>
<th>月付</th>
<th>销售代表</th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${clients}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.clientJob.id }"></td>
<td><c:out value="${item.clientJob.jobNo }"/></td>
<td><fmt:formatDate value="${item.clientJobTrack.jobDate }" type="both" /></td>
<td><c:out value="${item.jobType.nextState }"/></td>
<td><c:out value="${item.client.idNo }"/></td>
<td><c:out value="${item.client.clientName }"/></td>
<td><c:out value="${item.clientJob.totalPrice-item.clientJob.selfAmount }"/></td>
<td><c:out value="${item.financialProduct.cycleTotal }"/></td>
<td><c:out value="${item.clientJob.monthOfPay }"/></td>
<td><c:out value="${item.user.name }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="11" >
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