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
	<td  class="textr">合同号</td>
	<td><input type="text" name="jobNo" value="${param.jobNo }"/></td>
	
	<td  class="textr">身份证号</td>
	<td><input type="text" name="idNo" value="${param.idNo }"/> </td>
	
	<td  class="textr"><fmt:message key="Telephone" /></td>
	<td><input type="text" name="telephone" value="${param.telephone }"/></td>
	
	<td  class="textr">合同状态</td>
	<td>
	<select name="jobTypeId" onchange="document.forms[0].submit();">
			<option selected="selected" value="">All</option>
			<c:forEach var="jobType" items="${jobTypes}" varStatus="s">
				<option value="${jobType.id}"
		
				<c:if test="${jobType.id==param.jobTypeId}">
					selected="selected"
				</c:if>
					>
				${jobType.nextState}
				</option>
			--</c:forEach>
		</select>
	</td>
</tr>

<tr>


	<td  class="textr">店铺</td>
	<td>
	<select name="storeId">
				<option selected="selected" value="">All</option>
	
			<c:forEach var="item" items="${stores}" varStatus="s">
			
				<option value="${item.store.id}"
		
				<c:if test="${item.store.id==param.storeId}">
					selected="selected"
				</c:if>
					>
				${item.store.storeName}
				</option>
			--</c:forEach>
		</select>
	</td>
			
	<td class="textr"><fmt:message key="StartDate"/></td>
	<td><input type="text" name="StartDate" value="${StartDate }" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');" size="19" maxlength="19"/></td>

	<td class="textr"><fmt:message key="EndDate"/></td>
	<td><input type="text" name="EndDate" value="${EndDate }" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');" size="19" maxlength="19"/></td>
	
	<td>

	</td>
</tr>


</tbody>

</table>
</td>
</tr>

<tr>
<td style="text-align: center;">
<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Search"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
</td>
</tr>

<tr>
<td>

<table class="lt">

<thead>
<!-- 分页 -->
<tr class="lp">
<td colspan="12" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th>店铺</th>
<th>合同号</th>
<th>合同日期</th>
<th>状态</th>
<th>身份证号</th>
<th>客户名称</th>
<th>贷款本金</th>
<th>分期数</th>
<th>月付</th>
<th>销售代表</th>
<th>操作</th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${clients}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><c:out value="${item.store.storeName }"/></td>
<td><c:out value="${item.clientJob.jobNo }"/></td>
<td><fmt:formatDate value="${item.clientJob.jobDate }" type="both" /></td>
<td><c:out value="${item.jobType.nextState }"/></td>
<td><c:out value="${item.client.idNo }"/></td>
<td><c:out value="${item.client.clientName }"/></td>
<td><c:out value="${item.clientJob.totalPrice-item.clientJob.selfAmount }"/></td>
<td><c:out value="${item.financialProduct.cycleTotal }"/></td>
<td><c:out value="${item.clientJob.monthOfPay }"/></td>
<td><c:out value="${item.seller }"/></td>

<td>
	<c:url value="/ClientInfo.do" var="approvalURL">
		<c:param name="method">promptApproval</c:param>
		<c:param name="id">${item.clientJob.id }</c:param>
	</c:url>
	
	<c:url value="/ClientInfo.do" var="viewURL">
		<c:param name="method">promptView</c:param>
		<c:param name="id">${item.clientJob.id }</c:param>
	</c:url>
	
	<a href="${viewURL }"><fmt:message key="View"/></a>
	
	<c:if test="${item.jobType.jobKey=='R' ||item.jobType.jobKey=='W' }">
		<a href="${approvalURL }"><fmt:message key="Approval"/></a>
	</c:if>
</td>

</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="12" >
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