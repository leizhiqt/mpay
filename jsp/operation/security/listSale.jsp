<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Sale"/></title>
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
		<jsp:param name="type" value="find"/>
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="Sale.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
	
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="Preview"/>
		<jsp:param name="action" value="Sale.do"/>
		<jsp:param name="method" value="preview"/>
	</jsp:include>
</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="st">
<caption><fmt:message key="Sale"/></caption>
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
	
	<td class="textr"></td>
	<td></td>
</tr>

<tr>
	<td class="textr"><fmt:message key="ForgeryCode"/></td>
	<td><input name="SaleCode" value="${SaleCode }"/></td>
	
	<td class="textr"><fmt:message key="BatchNo"/></td>
	<td><input name="BatchNo" value="${BatchNo }"/></td>
</tr>

<tr>
	<td class="textr"><fmt:message key="StartDate"/></td>
	<td>
		<input type="text" name="StartDate" id="StartDate" value="${StartDate }"/>
		<img src="jsp/images/miniDate.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="displayCalendar(document.forms[0].StartDate,'yyyy-mm-dd',this,false)">
	</td>
	<td class="textr"><fmt:message key="EndDate"/></td>
	<td>
		<input type="text" name="EndDate" id="EndDate" value="${EndDate }"/>
		<img src="jsp/images/miniDate.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="displayCalendar(document.forms[0].EndDate,'yyyy-mm-dd',this,false)">
	</td>
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
<td colspan="14" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="ID"/></th>
<th><fmt:message key="Winery"/></th>
<th><fmt:message key="ProductName"/></th>
<th><fmt:message key="ForgeryCode"/></th>
<th><fmt:message key="VintageDate"/></th>
<th><fmt:message key="Alcohol"/></th>
<th><fmt:message key="Volume"/></th>
<th><fmt:message key="Unit"/></th>
<th><fmt:message key="Price"/></th>
<th><fmt:message key="Currency"/></th>
<th><fmt:message key="ExpertScore"/></th>
<th><fmt:message key="IsConfirm"/></th>
</tr>
</thead>

<tbody>
<c:forEach var="item" items="${results}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.saleJob.id }"></td>
<td><c:out value="${item.winery.enterpriseName }"/></td>
<td><c:out value="${item.product.productName }"/></td>
<td><c:out value="${item.saleJob.saleCode }"/></td>
<td><fmt:formatDate value="${item.sale.saleDate }" type="date" /></td>
<td><c:out value="${item.product.alcohol }"/></td>
<td><c:out value="${item.saleItem.saleVol }"/></td>
<td><c:out value="${item.saleItem.volUnit }"/></td>
<td><c:out value="${item.saleItem.salePrice }"/></td>
<td><c:out value="${item.saleItem.saleCurr }"/></td>
<td><c:out value="${item.sampleProduct.expertScore }"/></td>
<td><c:out value="${item.sale.isSale }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="14" >
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