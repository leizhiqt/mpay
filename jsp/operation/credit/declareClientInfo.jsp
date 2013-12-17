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

</div>

<div id="container">
<%@ include file="../../incl/b_message.jsp" %>

<div>

<div style="float:left;width:29%;margin:4px;">
<table class="lt">
<caption style="text-align:left;">产品类别</caption>

<tbody>
<tr>
<td colspan="2">
<c:forEach var="item" items="${products}" varStatus="status">
<div style="width:20%;float:left;"><input type="checkbox" name="product" value="${item.product.id }"/>${item.product.productName }</div>
</c:forEach>
</td>
</tr>

<tr>
<td>销售价格</td>
<td></td>
</tr>

<tr>
<td><input type="text" name="salePirce" value="${salePirce }"/></td>
<td></td>
</tr>

<tr>
<td>首付金额(现金)</td>
<td>首付金额(%)</td>
</tr>

<tr>
<td><input type="text" name="onePay" value="${onePay }"/></td>
<td><c:out value="${onePayPercent }"/></td>
</tr>

<tr>
<td colspan="2">
<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Find"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="promptDeclare"/>
	</jsp:include>
</td>
</tr>

</tbody>

</table>
</div>


<div style="float:right;width:69%;margin:4px;">
<table class="lt">
<caption style="text-align:left;">免税产品</caption>

<thead>
<tr>
<td>金融策略</td>
<td>分期付款数</td>
<td>每月支付金额</td>
<td>第一次支付</td>
<td>贷款额</td>
</tr>
</thead>

<tbody>

<c:forEach var="item" items="${fProucts}" varStatus="status">
<tr>
<td>
	<c:url value="/ClientInfo.do" var="newURL">
		<c:param name="method">promptAdd</c:param>
		<c:param name="salePirce">${salePirce}</c:param>
		<c:param name="onePay">${onePay}</c:param>
		<c:param name="pId">${item.pId}</c:param>
	</c:url>
	<a href="${newURL}"> <c:out value="${item.finName }"/></a>
</td>

<td><c:out value="${item.cycleTotal }"/> </td>
<td><c:out value="${item.monthPay }"/> </td>
<td><c:out value="${item.firstPay }"/> </td>
<td><c:out value="${item.creditAmount }"/> </td>
</tr>

</c:forEach>


</tbody>

</table>
</div>
<div style="clear:both;"></div>
 
</div>

<jsp:include page="../../incl/g_footer.jsp" />
</div>
</form>
</body>
</html>
</fmt:bundle>
