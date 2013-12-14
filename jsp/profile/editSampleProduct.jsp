<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="sampleProduct"/></title>
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
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="List"/>
		<jsp:param name="action" value="SampleProduct.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="Save"/>
		<jsp:param name="action" value="SampleProduct.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="Print"/>
		<jsp:param name="action" value="SampleProduct.do"/>
		<jsp:param name="method" value="print"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="SampleProduct"/></caption>

<tbody>

<tr>
<td  class="tl"><fmt:message key="Name"/></td>
<td>
<input type="text" name="sampleProduct.sampleName" value="${sampleProduct.sampleName }" readonly="readonly"/>
<input type="hidden" name="sampleProduct.id" value="${sampleProduct.id }"/>
</td>

<td  class="tl"><fmt:message key="Product"/></td>
<td>
	<input type="text" id="product" name="product.productName" value="${product.productName }"/>
	<img src="jsp/images/miniSearch.gif" border=0 alt="<fmt:message key="choosedate"/>" onclick="openLookup('jsp/lookup/productLookup.jsp','forms[0].product');return false;">
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Date"/></td>
<td>
<input type="text" name="sampleProduct.buildDate" value="<fmt:formatDate value="${sampleProduct.buildDate }" type="date"/>" size="10" maxlength="10" onclick="displayCalendar(this,'yyyy-MM-dd');"/>
<font class="fm">*</font></td>

<td class="tl"><fmt:message key="Operator"/></td>
<td><input type="text" name="sampleProduct.buildPeople" value="${sampleProduct.buildPeople }" size="10"/></td>
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
<td colspan="4" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th></th>
<th><fmt:message key="Formula"/></th>
<th><fmt:message key="Years"/></th>
<th><fmt:message key="Volume"/></th>
</tr>
</thead>

<tbody>
<tr>
<td></td>
<td><input type="text" name="sampleItem.itemName"/></td>

<td><input type="text" name="sampleItem.itemAge" size="3"/><font>年</font></td>

<td>
<input type="text" name="sampleItem.itemVol" size="7"/>
<input type="text" name="sampleItem.itemVolUnit" value="吨" size="2"/>
<font class="fm">*</font>
</td>
</tr>

<tr>
<td colspan="4" align="right">
<jsp:include page="../incl/actionb.jsp">
	<jsp:param name="key" value="Add"/>
	<jsp:param name="action" value="SampleProduct.do"/>
	<jsp:param name="method" value="processItemAdd"/>
</jsp:include>

<jsp:include page="../incl/actionb.jsp">
	<jsp:param name="key" value="Delete"/>
	<jsp:param name="action" value="SampleProduct.do"/>
	<jsp:param name="method" value="processItemDelete"/>
</jsp:include>
</td>
</tr>

<c:forEach var="item" items="${sampleItems}" varStatus="status">
<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
<td><input type="checkbox" name="id" value="${item.sampleItem.id }"> </td>
<td><c:out value="${item.sampleItem.itemName }"/></td>
<td><c:out value="${item.sampleItem.itemAge }"/></td>
<td><c:out value="${item.sampleItem.itemVol }"/></td>
</tr>
</c:forEach>
</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="4" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>
</tfoot>
</table>

</td>
</tr>

<tr>
<td>

<table class="modify">
<caption><fmt:message key="Tasting"/></caption>

<tbody>

<tr>
<td class="tl"><fmt:message key="Tasting"/><fmt:message key="StartTime"/></td>
<td>
<input type="text" name="sampleProduct.tastingStartTime" value="<fmt:formatDate value="${sampleProduct.tastingStartTime }" type="both"/>" size="19" maxlength="19" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');"/>
<font class="fm">*</font>
</td>

<td class="tl"><fmt:message key="Tasting"/><fmt:message key="EndTime"/></td>
<td>
<input type="text" name="sampleProduct.tastingEndTime" value="<fmt:formatDate value="${sampleProduct.tastingEndTime }" type="both"/>" size="19" maxlength="19" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');"/>
<font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="TastingSite"/></td>
<td>
<input type="text" name="sampleProduct.tastingSite" value="${sampleProduct.tastingSite }" />
<font class="fm">*</font></td>

<td class="tl"><fmt:message key="ExpertScore"/></td>
<td>
<input type="text" name="sampleProduct.expertScore" value="${sampleProduct.expertScore }" size="5"/>(分)
<font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="DrunkLevel"/></td>
<td  colspan="3">
<input type="text" name="sampleProduct.drunkLevel" value="${sampleProduct.drunkLevel }" size="5"/>(分)
<font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="TastingComment"/></td>
<td  colspan="3">
<textarea rows="3" cols="70" name="sampleProduct.tastingComment">${sampleProduct.tastingComment }</textarea>
<font class="fm">*</font></td>
</tr>

</tbody>

</table>
</td>
</tr>

<tr>
<td>

<table class="modify">
<caption><fmt:message key="QualityTesting"/></caption>

<tbody>

<tr>
<td class="tl"><fmt:message key="GeneralTesting"/></td>
<td>
<input type="hidden" name="sampleTest.id" value="${sampleTest.id }"/>

<select name="sampleTest.generalTesting">
	<option value="Y" <c:if test="${sampleTest.generalTesting=='Y' }">selected="selected"</c:if> >有</option>
	<option value="N" <c:if test="${sampleTest.generalTesting=='N' }">selected="selected"</c:if> >无</option>
</select>
<font class="fm">*</font>
</td>

<td class="tl"><fmt:message key="ChemistryTesting"/></td>
<td>
<select name="sampleTest.chemistryTesting">
	<option value="Y" <c:if test="${sampleTest.chemistryTesting=='Y' }">selected="selected"</c:if> >有</option>
	<option value="N" <c:if test="${sampleTest.chemistryTesting=='N' }">selected="selected"</c:if> >无</option>
</select>
<font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="PlasticTesting"/></td>
<td>
<select name="sampleTest.plasticTesting">
	<option value="Y" <c:if test="${sampleTest.plasticTesting=='Y' }">selected="selected"</c:if> >有</option>
	<option value="N" <c:if test="${sampleTest.plasticTesting=='N' }">selected="selected"</c:if> >无</option>
</select>
<font class="fm">*</font></td>

<td class="tl"><fmt:message key="TestingDate"/></td>
<td>
<input type="text" name="sampleTest.testingDate" value="<fmt:formatDate value="${sampleTest.testingDate }" type="date"/>" size="10" maxlength="10" onclick="displayCalendar(this,'yyyy-MM-dd');"/>
<font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="ReportNo"/></td>
<td>
<input type="text" name="sampleTest.reportNo" value="${sampleTest.reportNo }"/>
<font class="fm">*</font></td>

<td class="tl"><fmt:message key="TestingPerson"/></td>
<td>
<input type="text" name="sampleTest.testingPerson" value="${sampleTest.testingPerson }"/>
<font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="TestTools"/></td>
<td  colspan="3">
<textarea rows="3" cols="70" name="sampleTest.testTools">${sampleTest.testTools }</textarea>
<font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="TestNorm"/></td>
<td  colspan="3">
<input type="text" name="sampleTest.testNorm" value="${sampleTest.testNorm }"/>
<font class="fm">*</font></td>
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
<td colspan="4" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>

<tr>
<th><fmt:message key="WineTaster"/></th>
<th></th>
<th><fmt:message key="Tasting"/><fmt:message key="Member"/></th>
</tr>
</thead>

<tbody>
<tr>
<td>
<select name="tasterId" multiple="multiple" tabindex="1" size="10">
	<c:forEach var="item" items="${wineTasters}" varStatus="s">
		<option value="${item.id}">${item.tasterName}.${item.tasterLicense}</option>
	</c:forEach>
</select>
</td>
<td>
<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value=">>"/>
		<jsp:param name="action" value="SampleProduct.do"/>
		<jsp:param name="method" value="processTastingAdd"/>
</jsp:include>
<br/>
<jsp:include page="../incl/actionb.jsp">
		<jsp:param name="key" value="<<"/>
		<jsp:param name="action" value="SampleProduct.do"/>
		<jsp:param name="method" value="processTastingDelete"/>
</jsp:include>
</td>

<td>
<select name="tastingId" multiple="multiple" tabindex="2" size="10">
	<c:forEach var="item" items="${sampleTastings}" varStatus="s">
		<option value="${item.sampleTasting.id}">${item.wineTaster.tasterName}.${item.wineTaster.tasterLicense}</option>
	</c:forEach>
</select>
</td>
</tr>

</tbody>

<tfoot>
<!-- 分页 -->
<tr class="lp">
<td colspan="4" >
<%@ include file="../incl/pageNavigation.jsp"%>
</td>
</tr>
</tfoot>
</table>

</td>
</tr>

</table>
</div>

<jsp:include page="../incl/g_footer.jsp" />
</div>

</form>
</body>
</html>
</fmt:bundle>