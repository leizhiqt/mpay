<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="ggbar" style="width: 100%;height: 20px;text-align: right;background-color: #c0c0c0;">
	
	<c:if test="${!empty gbar}">
		<c:forEach var="igbar" items="${gbar}" varStatus="sgbar">
			<c:url value="${igbar.action}" var="url">
				<c:if test="${!empty igbar.method}">
					<c:param name="method">${igbar.method}</c:param>
				</c:if>
				<c:param name="gbar">${sgbar.index}</c:param>
				<c:param name="ibar">0</c:param>
			</c:url>
			
			<c:if test="${param.igbar!=sgbar.index}">
				<a href="${url}"><fmt:message key="${igbar.key}" /></a>|
			</c:if>
			
			<c:if test="${param.igbar==sgbar.index}">
				<a href="${url}" style="height:100%; line-height:20px; display:inline-block;background:#ffffff;"><fmt:message key="${igbar.key}" /></a>|
			</c:if>
			
		</c:forEach>
	</c:if>


</div>