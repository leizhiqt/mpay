<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/jsp/incl/static.inc" %>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Document"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>

<body>
<form>
<div>

<ul>
<!-- 
<li><a href="jsp/help/20130109.doc">20130109.doc</a></li>

<li>
<video controls="controls" width="480" height="352" >
   <source src="01.ogg" type="video/ogg" />
   <source src="01.mp4" type="video/mp4" />
   <embed src="jsp/help/01.flv" type="application/x-shockwave-flash" width="480" height="320" allowscriptaccess="always" allowfullscreen="true"> </embed>
</video> 
</li> -->
 
<li>
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="240" height="240">
	<param name="movie" value="jsp/help/vcastr22.swf"><param name="quality" value="high">
	<param name="menu" value="false"><param name="allowFullScreen" value="true" />
	<param name="FlashVars" value="vcastr_file=01.flv&vcastr_title=00">
	<embed src="jsp/help/vcastr22.swf" allowFullScreen="true" FlashVars="vcastr_file=01.flv&vcastr_title=q" menu="false" quality="high" width="480" height="320" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" /> 
</object>
</li>

</ul>

</div>
</form>
</body>
</html>
</fmt:bundle>