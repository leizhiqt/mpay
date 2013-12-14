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
		<jsp:param name="method" value="processAdd"/>
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

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Add"/> <fmt:message key="Card"/></caption>

<tbody>

<tr>
<td class="tl"><fmt:message key="Winery"/></td>
<td>
<select name="card.wineryId">
	<c:forEach var="items" items="${winerys}" varStatus="s">
		<option value="${items.winery.id}"

		<c:if test="${items.winery.id==card.wineryId}">
			selected="selected"
		</c:if>
			>
		${items.winery.enterpriseName}
		</option>
	--</c:forEach>
</select>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="Rfidcode"/></td>
<td><input type="text" name="card.rfidcode"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Uuid"/></td>
<td><input type="text" name="card.uuid"/></td>
</tr>

<tr>
<td class="tl"><fmt:message key="Position"/></td>
<td>
	<select name="card.position">
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		<option value="6">6</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
		<option value="10">10</option>
	</select>
</td>
</tr>

<tr>
<td class="tl"><fmt:message key="CardDate"/></td>
<td>
<input type="text" name="cardTrack.trackDate" value="<fmt:formatDate value="${cardTrack.trackDate }" pattern="both"/>" onclick="displayCalendar(this,'yyyy-MM-dd hh:mm:ss');"/>
</td>
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
