<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta name="google-site-verification"	content="_TP8q1T6i81iSMGf29l2wIeBhUBR8bXzfBB3tc1H2e4" />

<meta name="description" content="中国原酒溯源系统">
<meta name="keywords" content="中国原酒溯源系统">

<meta name="Author" content="成都艾因特">
<meta name="Copyright" content="成都艾因特iinte.com 版权所有">
<link rel="Shortcut Icon" type="image/x-icon" href="../images/favicon.ico"> 
<link rel="Bookmark" href="../images/favicon.ico">
<title>中国原酒溯源系统</title>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>

<c:url value="/Main.do" var="menuTop">
	<c:param name="method">menuTop</c:param>
</c:url>

<c:url value="/Main.do" var="menu">
	<c:param name="method">menu</c:param>
</c:url>

<frameset rows="60,30,*" cols="*" frameborder="no" border="0" framespacing="0">
	<frame src="${menuTop }" name="topFrame" scrolling="NO" noresize >
	<frame src="jsp/main/crossLine.html" name="crossFrame" scrolling="NO" noresize  style="z-index:-1">
	<frameset rows="*" cols="148,6,*" framespacing="0" frameborder="NO" border="0" >
		<frame src="${menu }" name="leftFrame" scrolling="NO" noresize>
			<frame src="jsp/main/split.html" name="splitFrame" scrolling="NO" noresize>
			<frame src="jsp/main/defHome.jsp" name="mainFrame" scrolling="YES" noresize style="z-index:1">
		</frameset>
	</frameset>
<noframes>
<body oncontextmenu ='self.event.returnValue=false'>
</body>
</noframes>

</html>