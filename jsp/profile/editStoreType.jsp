<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="StoreType"/></title>
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
				<jsp:param name="action" value="StoreType.do" />
				<jsp:param name="method" value="processEdit" />
			</jsp:include>
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="cancel" />
				<jsp:param name="key" value="Cancel" />
				<jsp:param name="action" value="StoreType.do" />
				<jsp:param name="method" value="list" />
			</jsp:include>
		</div>

		<div id="container">
			<%@ include file="../incl/b_message.jsp"%>
			<input type="hidden" name="storeType.id" value="${storeType.id }" />

			<div>
				<table class="twrap">
					<tr>
						<td>

							<table class="modify">
								<caption>
									<fmt:message key="Update" />
									<fmt:message key="StoreType" />
								</caption>

								<tbody>
									<tr>

										<td></td>
									</tr>
									
									
									<tr>
										<td class="tl"><fmt:message key="TypeKey" /></td>
										<td><input type="text" name="storeType.typeKey"
											value="${storeType.typeKey }" size="30" maxlength="30" /><font
											class="fm">*</font></td>
									</tr>
									<tr>
										<td class="tl"><fmt:message key="TypeName" /></td>
										<td><input type="text" name="storeType.typeName"
											value="${storeType.typeName }" size="30" maxlength="30" /><font
											class="fm">*</font></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="TypeBankNo" /></td>
										<td><input type="text" name="storeType.TypeBankNo"
											value="${storeType.typeBankNo }" size="40" maxlength="40" /><font
											class="fm">*</font></td>
									</tr>
									<tr>
										<td class="tl"><fmt:message key="TypeBankName" /></td>
										<td><input type="text" name="storeType.typeBankName"
											value="${storeType.typeBankName }" size="40" maxlength="40" /><font
											class="fm">*</font></td>
									</tr>
									
							</table>
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