<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<tr>
<td>
<input type="hidden" name="gbar" value="${param.gbar}">
<input type="hidden" name="ibar" value="${param.ibar}">
<input type="hidden" name="isubbar" value="0">

<table style="width:100%;background:#999999;text-align: center;">
   <tr>
   	<c:if test="${!empty subbar}">
   		<c:forEach var="isubbar" items="${subbar}" varStatus="ssubbar">
			<c:if test="${isubbar.enable==true}">
				<c:url value="${isubbar.action}" var="url">
					<c:if test="${!empty isubbar.method}">
						<c:param name="method">${isubbar.method}</c:param>
					</c:if>
					
					<c:param name="gbar">${param.gbar}</c:param>
					<c:param name="ibar">${param.ibar}</c:param>
					<c:param name="isubbar">${ssubbar.index}</c:param>
				</c:url>
				
				<c:if test="${param.isubbar!=ssubbar.index}">
					<td style="background:#ffffcc;text-align: center;"> 
				      	<a href="${url}" target="main"><fmt:message key="${isubbar.key}" /></a>
				    </td>
				</c:if>
				
				<c:if test="${param.isubbar==ssubbar.index}">
					<td style="background:orange;text-align: center;"> 
				      	<a href="${url}" target="main"><fmt:message key="${isubbar.key}" /></a>
				    </td>
				</c:if>
			</c:if>
		</c:forEach>
   	</c:if>
   </tr>
</table>
</td>
</tr>