<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="CreditType" /></title>
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
				<jsp:param name="action" value="CreditType.do" />
				<jsp:param name="method" value="processEdit" />
			</jsp:include>
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="cancel" />
				<jsp:param name="key" value="Cancel" />
				<jsp:param name="action" value="CreditType.do" />
				<jsp:param name="method" value="list" />
			</jsp:include>
		</div>

		<div id="container">
			<%@ include file="../incl/b_message.jsp"%>
			<input type="hidden" name="creditType.id" value="${creditType.id }" />

			<div>
				<table class="twrap">
					<tr>
						<td>

							<table class="modify">
								<caption>
									<fmt:message key="Update" />
									<fmt:message key="CreditType" />
								</caption>

								<tbody>
									<tr>

										<td></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="creditName" /></td>
										<td><input type="text" name="creditType.creditName"
											value="${creditType.creditName }" size="5" maxlength="5" /><font
											class="fm">*</font></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="cycleTotal" /></td>
										<td><input type="text" name="creditType.cycleTotal"
											value="${creditType.cycleTotal }" size="16" maxlength="16" /><font
											class="fm">*</font></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="cycleUnit" /></td>
										<td><input type="text" name="creditType.cycleUnit"
											value="${creditType.cycleUnit }" size="5" maxlength="5" /></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="creditRate" /></td>
									<td>	<input type="text" name="creditType.creditRate"
											value='<fmt:formatNumber value="${creditType.creditRate }" type="percent" />'/>
											</td>
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