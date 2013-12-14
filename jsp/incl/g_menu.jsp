<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div style="height: 100%;width: 100%;margin-top: 5%;">
	<div style="width: 60%;height: 16%;border: 1px solid green;margin: 0 auto;text-align: left;">
	    <p><fmt:message key="Location"/>.......</p>
	    <ul>
	    	<c:if test="${!empty gbar}">
				<c:forEach var="igbar" items="${gbar}" varStatus="sgbar">
					<c:if test="${param.bar==sgbar.index}">
							<c:forEach var="isgbar" items="${igbar}" varStatus="ssgbar">
								<c:url value="${isgbar.action}" var="url">
									<c:if test="${!empty isgbar.method}">
										<c:param name="method">${isgbar.method}</c:param>
									</c:if>
								
									<c:param name="bar">${param.bar}</c:param>
									<c:param name="subbar">${param.subbar}</c:param>
								</c:url>
								<li><a href="${url}"><fmt:message key="${isgbar.key}" /></a></li>
							</c:forEach>
					</c:if>
				</c:forEach>
			</c:if>
	    </ul>
	</div>
</div>