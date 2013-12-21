<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="FinancialProduct" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css"
	type="text/css" rel="stylesheet">
<script type="text/javascript" src="jsp/js/util.js"></script>
<link type="text/css" rel="stylesheet"
	href="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.css?random=20051112"
	media="screen" />
<script type="text/javascript"
	src="skins/dhtmlgoodies_calendar/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="jsp/public/skin.js"></script>
</head>

<body>
	<form method="post">
		<div id="gtop">
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="save" />
				<jsp:param name="key" value="Edit" />
				<jsp:param name="action" value="FinancialProduct.do" />
				<jsp:param name="method" value="processEdit" />
			</jsp:include>
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="cancel" />
				<jsp:param name="key" value="Cancel" />
				<jsp:param name="action" value="FinancialProduct.do" />
				<jsp:param name="method" value="list" />
			</jsp:include>
		</div>

		<div id="container" align="center">
			<%@ include file="../incl/b_message.jsp"%>
			<input type="hidden" name="financialProduct.id" value="${financialProduct.id }" />

			<div>
				<table class="twrap">
					<tr>
						<td>

							<table class="modify" >
								<caption>
									<fmt:message key="Update" />
									<fmt:message key="FinancialProduct" />
								</caption>

								<tbody>
									<tr>
										<td class="tl" width='330px'></td>
										<td></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="FinancialName" /></td>
										<td><input type="text" name="financialProduct.financialName"
											value="${financialProduct.financialName }" size="10" maxlength="10" /><font
											class="fm">*</font></td>
									</tr>


									<tr>
										<td class="tl"><fmt:message key="CycleTotal" /></td>
										<td><input type="text" name="financialProduct.cycleTotal"
											value="${financialProduct.cycleTotal }" size="10" maxlength="10" /></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="CycleUnit" /></td>
										<td><input type="text" name="financialProduct.cycleUnit"
											value="${financialProduct.cycleUnit }" size="6" maxlength="6" /></td>
									</tr>
									<tr>
										<td class="tl"><fmt:message key="CreditRate" /></td>
										<td><input type="text" name="financialProduct.creditRate "
											value="${financialProduct.creditRate }" size="10" maxlength="10" /></td>
									</tr>
									<tr>
										<td class="tl"><fmt:message key="FinancialMax" /></td>
										<td><input type="text" name="financialProduct.financialMax"
											value="${financialProduct.financialMax }" size="10" maxlength="10" /></td>
									</tr>
									
									<tr>
										<td class="tl"><fmt:message key="MinPayPercent" /></td>
										<td><input type="text" name="financialProduct.minPayPercent "
											value="${financialProduct.minPayPercent }" size="4" maxlength="4" /></td>
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