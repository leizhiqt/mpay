<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${!empty message}">
<div class="msg">${message}</div>
</c:if>

<c:if test="${!empty error}">
<div class="err">${error}</div>
</c:if>
