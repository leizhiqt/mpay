<!DOCTYPE form PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc" %>

<c:if test="${!empty param.locale}">
	<fmt:setLocale value="${param.locale}" scope="session" />
	<fmt:setTimeZone value="${param.locale}" scope="session" />
</c:if>

<c:if test="${empty param.locale}">
	<fmt:setLocale value="zh_CN" scope="session" />
	<fmt:setTimeZone value="Asia/Chongqing" scope="session"/>
</c:if>

<fmt:bundle basename="MessageBundle">
<html>
<head>
	<title>汉易联信</title>
	<meta name="keywords" content="汉易资本,门户,资讯" />
	<meta name="description" content="汉易资本,多方位立体服务用户体验" />
	<meta name="application-name" content="汉易资本首页"/>
	<script type="text/javascript" src="jsp/js/util.js"></script>

	<style type="text/css">
	.msg,.err {
		text-align:center;
	}

	.err {
		color: red;
	}

	.msg {
		color: green;
	}
	</style>

	<script>
		if (top.location !== self.location){
			top.location=self.location;
		}
	</script>
</head>

<body bgcolor="#ffffff">
<c:url value="/Login.do" var="processLogin">
	<c:param name="method">processLogin</c:param>
</c:url>

<c:url value="/Login.do" var="promptLogin">
	<c:param name="method">promptLogin</c:param>
</c:url>

<c:url value="/Login.do" var="promptRegister">
	<c:param name="method">promptRegister</c:param>
</c:url>

<c:url value="skins/office/default/images/logo.png" var="logURL"/>

<c:url value="/Index.do" var="homeURL"/>

<!-- login.jsp -->

<form  method="post" action="${processLogin}">
<%@ include file="incl/b_message.jsp" %>

<center>

<p><br>
<a href="${homeURL }"><img src="${logURL }" width="420" height="100"/></a>

<table border="0" cellspacing="0" cellpadding="1" width="420" bgcolor="#999999">
<tr><td bgcolor="#009900" align="right" height="25">&nbsp;
<c:forEach var="locItem" items="${locales}" varStatus="s">

<c:url value="/Login.do" var="changeLocale">
	<c:param name="method">promptLogin</c:param>
	<c:param name="locale">${locItem }</c:param>
</c:url>
<a href="${changeLocale }">${locItem.displayLanguage}</a>

</c:forEach>
</td></tr>

<tr><td width=100%>
	<table border="0" cellspacing="0" cellpadding="4" width="100%" bgcolor="#eeeeee">
	    <tr><td>
			<!----Content----------->
			<table border=0 bgcolor="#eeeeee" align="center" cellspacing=0 cellpadding=5 id=small>
			 <tr valign=top align=left>
			  <td><b><fmt:message key="UserName"/>:</b></td>
			  <td><input type="text" name="user.name" maxlength="30"></td>
			 </tr>
			 <tr valign=top align=left>
			  <td><b><fmt:message key="Password"/>:</b></td>
			  <td><input type="password" name="user.password" maxlength="30"></td>
			 </tr>
			<tr valign=top align=left>
			  <td><b><fmt:message key="ValidateCode"/>:</b></td>
			  <td><img alt="" src="${validateCode}"></td>
			 </tr>
			 
			 <tr valign=top align=left>
			  <td></td>
			  <td><input type="text" name="validateCode" maxlength="4" size="4"></td>
			 </tr>
			 
			 <tr>
			  <td align=right colspan=2><input type="submit" value="<fmt:message key="Login"/>"/></td>
			 </tr>
			</table>
			<!---------------------->
	    </td></tr>
	</table>
</td></tr>
</table>

<p><font size=-2 color=#999999>Copyright&copy;2012 86999.org </font>
</center>
</form>
</body>
</fmt:bundle>
