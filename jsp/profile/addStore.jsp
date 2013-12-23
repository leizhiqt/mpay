<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Store"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>

<body>
	<form method="post">
		<div id="gtop">
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="save" />
				<jsp:param name="key" value="Edit" />
				<jsp:param name="action" value="Store.do" />
				<jsp:param name="method" value="processAdd" />
			</jsp:include>
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="cancel" />
				<jsp:param name="key" value="Cancel" />
				<jsp:param name="action" value="Store.do" />
				<jsp:param name="method" value="list" />
			</jsp:include>
		</div>

		<div id="container">
			<%@ include file="../incl/b_message.jsp"%>

			<div>
				<table class="twrap">
					<tr>
						<td>

							<table class="modify">
								<caption>
									<fmt:message key="Add" />
									<fmt:message key="Store" />
								</caption>

								<tbody>
									<tr>
										<td class="tl"><fmt:message key="StoreKey" /></td>
										<td><input type="text" name="store.storeKey" size="8" maxlength="8" /><font class="fm">*</font></td>
									</tr>
									
									<tr>
										<td class="tl"><fmt:message key="StoreName" /></td>
										<td><input type="text" name="store.storeName"
											size="30" maxlength="30" /><font class="fm">*</font></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="StoreAddress" /></td>
										<td><input type="text"
											name="store.storeAddress" size="40" maxlength="40" /><font
											class="fm">*</font></td>
									</tr>
									<tr>
										<td class="tl"><fmt:message key="StoreBankNo" /></td>
										<td><input type="text"
											name="store.storeBankNo" size="40" maxlength="40" /><font
											class="fm">*</font></td>
									</tr>
									<tr>
										<td class="tl"><fmt:message key="StoreBankName" /></td>
										<td><input type="text"
											name="store.storeBankName" size="40" maxlength="40" /><font
											class="fm">*</font></td>
									</tr>
									
									<tr>
										<td class="tl"><fmt:message key="StoreType" /></td>
										<td>
										
										<select name="store.storeTypeId" >
											<c:forEach var="storeType" items="${storeTypes}" varStatus="s">
													<option value="${storeType.id}"
						
													<c:if test="${storeType.id==param.store.storeTypeId}">
														selected="selected" 
													</c:if>
														>${storeType.typeName}
													
													</option>
											</c:forEach>
										</select>
									</tr>
									
									
									<tr>
										<td class="tl"><fmt:message key="Product" /></td>
										<td><c:forEach var="product" items="${products}"
												varStatus="s">
												<input type="checkbox" name="productId" value="${product.id }">${product.productName }
											</c:forEach>
									</tr></table>
						</td>
					</tr>

				</table>
			</div>

			<jsp:include page="../incl/g_footer.jsp" />
		</div>
	</form>
</body>
	</html>
</fmt:bundle>