<!-- ------------------handling of pagination----------------------- -->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:bundle basename="MessageBundle">
<c:if test="${page.totalRows >0 }">
	<fmt:message key="TotalRows"/>:
	<c:out value="${page.totalRows }"/>
	
	<fmt:message key="PageSize"/>:
	<input type="text" name="page.pageSize" value="${page.pageSize }" size="2"/>
	
	<c:if test="${page.currentPage >1 }">
		<input type="submit" name="page.forward" value="<<" />
		<input type="submit" name="page.forward" value="<" />
	</c:if>

	<c:if test="${page.currentPage < page.totalPages }">
		<input type="submit" name="page.forward" value=">" />
		<input type="submit" name="page.forward" value=">>" />
	</c:if>
	
	<fmt:message key="CurrentPage"/>:
	<input type="submit" name="page.forward" value="->" /><input type="text" name="page.currentPage" value="${page.currentPage }" size="2"/>/ <c:out value="${page.totalPages }"/>
</c:if>
</fmt:bundle>
<!-- ---------------------handling of pagination------------------------------------- -->