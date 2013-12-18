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
<script type="text/javascript" src="jsp/js/jquery-1.9.0.js"></script>
	<script type="text/javascript">
	$(function(){
		onValue();
	});
			 function onValue(){
			 	if($('#onePay').val()!="" && $('#salePirce').val()!=""){
			 						var num=$('#onePay').val()/$('#salePirce').val()*100;  
			 					 	$('#vals').html(Math.round(num*1000)/1000+"%");
			 					 	
			 		
			 	}			
			  }
			 
	</script>
	<style>
<!--
body,td,th {
	font-size: 14px;
}
-->
</style>
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


<tbody>
<tr><th colspan="2" style="font-size:18px"><strong>产品类别</strong></th></tr>
<tr>
<td colspan="2">
<c:forEach var="item" items="${products}" varStatus="status">
<div style="width:20%;float:left;"><input type="checkbox" name="product" value="${item.product.id }"/>${item.product.productName }</div>
</c:forEach>
</td>
</tr>

<tr>
<td align="left"  colspan="2">销售价格</td>
</tr>

<tr>
<td align="left"  colspan="2"><input id="salePirce" type="text"  name="salePrice" value="${salePrice }" Onchange="onValue()" /></td>
</tr>

<tr>
<td align="left" width="150px">首付金额(现金)</td>
<td>首付金额(%)</td>
</tr>

<tr>
<td align="left" ><input id="onePay" type="text" name="onePay" value="${onePay }" Onchange="onValue()"/></td>
<td id="vals"></td>
</tr>

<tr>
<td colspan="2">
<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Search"/>
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

<thead>
<tr><th colspan="5" style="font-size:18px"><strong>免税产品</strong></th></tr>
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
		<c:param name="salePrice">${salePrice}</c:param>
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
