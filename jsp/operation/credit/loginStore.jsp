<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Store"/></title>
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
<c:if test="${!empty store}">
当前登录店铺为:<c:out value="${store.storeName}"/> 店铺地址:<c:out value="${store.storeAddress}"/>
</c:if>
</div>

<div id="container">

<%@ include file="../../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Store"/></caption>

<tbody>
<tr>
	<td  class="tl"><fmt:message key="Store"/></td>
	<td>
		<select name="storeUser.id">
			<c:forEach var="item" items="${stores}" varStatus="s">
				<option value="${item.storeUser.id}"
		
				<c:if test="${item.storeUser.id==storeUser.id}">
					selected="selected"
				</c:if>
					>
				${item.store.storeName}
				</option>
			--</c:forEach>
		</select>
		
		<jsp:include page="../../incl/actionb.jsp">
			<jsp:param name="key" value="Confirm"/>
			<jsp:param name="action" value="LoginStore.do"/>
			<jsp:param name="method" value="processLogin"/>
		</jsp:include>
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
