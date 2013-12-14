<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="gbar" style="width: 100%;height: 20px;text-align: right;background-color: #c0c0c0;">
	
	<c:if test="${!empty bar}">
		<c:forEach var="ibar" items="${bar}" varStatus="sbar">
			<c:if test="${ibar.enable==true}">
				<c:url value="${ibar.action}" var="url">
					<c:if test="${!empty ibar.method}">
						<c:param name="method">${ibar.method}</c:param>
					</c:if>
					<c:param name="gbar">${param.gbar}</c:param>
					<c:param name="ibar">${sbar.index}</c:param>
					<c:param name="isubbar">0</c:param>
				</c:url>
				
				<c:if test="${param.ibar!=sbar.index}">
					<a href="${url}"><fmt:message key="${ibar.key}" /></a>|
				</c:if>
				
				<c:if test="${param.ibar==sbar.index}">
					<a href="${url}" style="height:100%; line-height:20px; display:inline-block;background:#ffffff;"><fmt:message key="${ibar.key}" /></a>|
				</c:if>
			</c:if>
		</c:forEach>
	</c:if>


</div>