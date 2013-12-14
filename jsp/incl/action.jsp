<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.mooo.mycoz.framework.Action" %>
<%@ page import="com.mooo.mycoz.framework.ActionSession" %>
<%
Integer sessionId= (Integer)session.getAttribute(ActionSession.USER_SESSION_KEY);

Action transfer = null;

String key = request.getParameter("key");
String action = request.getParameter("action");
String method = request.getParameter("method");

if(key!=null){
	if(action!=null){
		if(method!=null){
			transfer = new Action(sessionId,key,action,method);
		}else{
			transfer = new Action(sessionId,key,action);
		}
		request.setAttribute("transfer", transfer);
	}
}

%>
<fmt:bundle basename="MessageBundle">
	<c:if test="${!empty transfer and transfer.enable==true}">
		
		<c:url value="/${transfer.action}" var="transferURL">
			<c:if test="${!empty transfer.method}">
				<c:param name="method">${transfer.method}</c:param>
			</c:if>
		</c:url>
		<!-- add -->
		<c:if test="${param.type=='add' }">
			<a href="#" onclick="docommit('${transferURL}');"><img onmouseover="this.src='jsp/images/tools/addb.gif'"  onmouseout="this.src ='jsp/images/tools/addn.gif'" src="jsp/images/tools/addn.gif"></a>
		</c:if>
		<!-- delete -->
		<c:if test="${param.type=='delete' }">
			<a href="#" onclick="confirmSubmit('${transferURL}');"><img onmouseover="this.src='jsp/images/tools/delb.gif'"  onmouseout="this.src ='jsp/images/tools/deln.gif'" src="jsp/images/tools/deln.gif"></a>
		</c:if>
		<!-- edit -->
		<c:if test="${param.type=='edit' }">
			<a href="#" onclick="docommit('${transferURL}');"><img onmouseover="this.src='jsp/images/tools/modifyb.gif'"  onmouseout="this.src ='jsp/images/tools/modifyn.gif'" src="jsp/images/tools/modifyn.gif"></a>
		</c:if>
		<!-- find -->
		<c:if test="${param.type=='find' }">
			<a href="#" onclick="docommit('${transferURL}');"><img onmouseover="this.src='jsp/images/tools/findb.gif'"  onmouseout="this.src ='jsp/images/tools/findn.gif'" src="jsp/images/tools/findn.gif"></a>
		</c:if>
		<!-- save -->
		<c:if test="${param.type=='save' }">
			<a href="#" onclick="confirmSubmit('${transferURL}');"><img onmouseover="this.src='jsp/images/tools/saveb.gif'"  onmouseout="this.src ='jsp/images/tools/saven.gif'" src="jsp/images/tools/saven.gif"></a>
		</c:if>
		<!-- cancel -->
		<c:if test="${param.type=='cancel' }">
			<a href="#" onclick="docommit('${transferURL}');"><img onmouseover="this.src='jsp/images/tools/cancelb.gif'"  onmouseout="this.src ='jsp/images/tools/canceln.gif'" src="jsp/images/tools/canceln.gif"></a>
		</c:if>
		<!-- print -->
		<c:if test="${param.type=='print' }">
			<a href="#" onclick="docommit('${transferURL}&${param.aparams}');"><img onmouseover="this.src='jsp/images/tools/printb.png'"  onmouseout="this.src ='jsp/images/tools/printn.png'" src="jsp/images/tools/printn.png"></a>
		</c:if>
		<!-- export -->
		<c:if test="${param.type=='export' }">
			<a href="#" onclick="docommit('${transferURL}&${param.aparams}');"><img onmouseover="this.src='jsp/images/tools/exportb.gif'"  onmouseout="this.src ='jsp/images/tools/exportn.gif'" src="jsp/images/tools/exportn.gif"></a>
		</c:if>
		<!--back -->
		<c:if test="${param.type=='back' }">
			<a href="#" onclick="docommit('${transferURL}');"><img onmouseover="this.src='jsp/images/tools/backb.gif'"  onmouseout="this.src ='jsp/images/tools/backn.gif'" src="jsp/images/tools/backn.gif"></a>
		</c:if>
		<!--report -->
		<c:if test="${param.type=='report' }">
			<a href="#" onclick="docommit('${transferURL}');"><img onmouseover="this.src='jsp/images/tools/reportb.gif'"  onmouseout="this.src ='jsp/images/tools/reportn.gif'" src="jsp/images/tools/reportn.gif"></a>
		</c:if>
	</c:if>
</fmt:bundle>