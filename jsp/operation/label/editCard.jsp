<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Card"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet">   
<script type="text/javascript" src="jsp/js/util.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
<form method="post">
<div id="gtop">
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="Card.do"/>
		<jsp:param name="method" value="processEdit"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="Card.do"/>
		<jsp:param name="method" value="listCard"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../../incl/b_message.jsp" %>
<input type="hidden" name="card.id" value="${card.id }"/>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Update"/> <fmt:message key="Card"/></caption>

<tbody>

<tr>
<td class="tl"><fmt:message key="Winery"/></td>
<td>:${winery.enterpriseName}</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Rfidcode"/></td>
<td>:${card.rfidcode }</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Uuid"/></td>
<td>:${card.uuid }</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Position"/></td>
<td>
<select name="card.position">
		<option value="D1"  <c:if test="${card.position=='D1'}">selected="selected"</c:if>>D1</option>
		<option value="D2" <c:if test="${card.position=='D2'}">selected="selected"</c:if>>D2</option>
		<option value="上" <c:if test="${card.position=='上'}">selected="selected"</c:if>>上</option>
		<option value="下" <c:if test="${card.position=='下'}">selected="selected"</c:if>>下</option>
		<option value="左" <c:if test="${card.position=='左'}">selected="selected"</c:if>>左</option>
		<option value="右" <c:if test="${card.position=='右'}">selected="selected"</c:if>>右</option>
		<option value="中" <c:if test="${card.position=='中'}">selected="selected"</c:if>>中</option>
		<option value="J1" <c:if test="${card.position=='J1'}">selected="selected"</c:if>>J1</option>
		<option value="J2" <c:if test="${card.position=='J2'}">selected="selected"</c:if>>J2</option>
		<option value="J3" <c:if test="${card.position=='J3'}">selected="selected"</c:if>>J3</option>
		<option value="J4" <c:if test="${card.position=='J4'}">selected="selected"</c:if>>J4</option>
		<option value="J5" <c:if test="${card.position=='J5'}">selected="selected"</c:if>>J5</option>
		<option value="J6" <c:if test="${card.position=='J6'}">selected="selected"</c:if>>J6</option>
		<option value="C1" <c:if test="${card.position=='C1'}">selected="selected"</c:if>>C1</option>
		<option value="C2" <c:if test="${card.position=='C2'}">selected="selected"</c:if>>C2</option>
		<option value="C3" <c:if test="${card.position=='C3'}">selected="selected"</c:if>>C3</option>
		<option value="C4" <c:if test="${card.position=='C4'}">selected="selected"</c:if>>C4</option>
		<option value="C5" <c:if test="${card.position=='C5'}">selected="selected"</c:if>>C5</option>
		<option value="C6" <c:if test="${card.position=='C6'}">selected="selected"</c:if>>C6</option>
	</select>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="WineJarId"/></td>
<td>
<select name="card.wineJarId">
	<c:forEach var="items" items="${wineJars}" varStatus="s">
		<option value="${items.wineJar.id}"

		<c:if test="${items.wineJar.id==card.wineJarId}">
			selected="selected"
		</c:if>
			>
		[${items.winery.enterpriseName}]/[${items.wineJar.jarNumber}]
		</option>
	--</c:forEach>
</select>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Remark"/></td>
<td><input type="text" name="card.remark" value="${card.remark}"/></td>
</tr>

</tbody>

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
