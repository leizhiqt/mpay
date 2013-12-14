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
		
		<input type="submit" value="<fmt:message key="${transfer.key}"/>" onclick="docommit('${transferURL}');return false;">
	</c:if>
</fmt:bundle>