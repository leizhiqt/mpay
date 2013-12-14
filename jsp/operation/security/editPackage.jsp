<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Package"/></title>
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
	<jsp:include page="../../incl/actionb.jsp">
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="Package.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Package"/></caption>

<tbody>

<tr>
<td  class="tl"><fmt:message key="BatchNo"/>:</td>
<td>
<input type="text" name="sale.batchNo" value="${sale.batchNo }" readonly="readonly"/>
<input type="hidden" name="sale.id" value="${sale.id }"/>
</td>

<td class="tl"><fmt:message key="Date"/>:</td>
<td><input type="text" id="buildDate" name="sale.saleDate" value="<fmt:formatDate value="${sale.saleDate }" type="both"/>" size="19" maxlength="19" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');"/>
<font class="fm">*</font>
</td>
</tr>

<tr>
<td colspan="4" align="right">
<jsp:include page="../../incl/actionb.jsp">
	<jsp:param name="key" value="Update"/>
	<jsp:param name="action" value="Package.do"/>
	<jsp:param name="method" value="processEdit"/>
</jsp:include>
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
<td colspan="6" >
<%@ include file="../../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th></th>
<th><fmt:message key="SampleProduct"/></th>
<th><fmt:message key="Quantity"/>(瓶)</th>
<th><fmt:message key="Volume"/></th>
<th><fmt:message key="Price"/></th>
</tr>
</thead>

<tbody>
<tr>
<td></td>
<td>
<select name="saleItem.sampleId">
	<c:forEach var="items" items="${samples}" varStatus="s">
	<option value="${items.sampleProduct.id}"
	
	<c:if test="${items.sampleProduct.id==saleItem.sampleId}">
	        selected="selected"
	</c:if>
	        >
	${items.sampleProduct.sampleName}/${items.winery.enterpriseName}.${items.product.productName}
	</option>
	</c:forEach>
</select>
</td>

<td>
<input type="text" name="bottles" value="${bottles }" size="10"/>
<font class="fm">*</font>
</td>

<td>
<input type="text" name="saleItem.saleVol" value="${saleItem.saleVol }" size="5"/>
<input type="text" name="saleItem.volUnit" value="ML" size="2"/>
<font class="fm">*</font>
</td>

<td>
<input type="text" name="saleItem.salePrice" size="5"/>
<input type="text" name="saleItem.saleCurr" value="RMB" size="3"/>
<font class="fm">*</font>
</td>

</tr>

<tr>
<td colspan="6" align="right">
<jsp:include page="../../incl/actionb.jsp">
	<jsp:param name="key" value="Add"/>
	<jsp:param name="action" value="Package.do"/>
	<jsp:param name="method" value="processItemAdd"/>
</jsp:include>

<jsp:include page="../../incl/actionb.jsp">
	<jsp:param name="key" value="Delete"/>
	<jsp:param name="action" value="Package.do"/>
	<jsp:param name="method" value="processItemDelete"/>
</jsp:include>	
</td>
</tr>

<c:forEach var="item" items="${saleItems}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.id }"> </td>
<td><c:out value="${item.sampleName }"/></td>
<td><c:out value="${item.saleQuantity }"/></td>
<td><c:out value="${item.saleVol }"/><c:out value="${item.volUnit }"/></td>
<td><c:out value="${item.salePrice }"/><c:out value="${item.saleCurr }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="6" >
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