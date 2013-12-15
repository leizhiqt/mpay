<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="WineJar"/></title>
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
				<jsp:param name="action" value="Certificate.do" />
				<jsp:param name="method" value="processEdit" />
			</jsp:include>
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="cancel" />
				<jsp:param name="key" value="Cancel" />
				<jsp:param name="action" value="Certificate.do" />
				<jsp:param name="method" value="list" />
			</jsp:include>
		</div>

		<div id="container">
			<%@ include file="../incl/b_message.jsp"%>
			<input type="hidden" name="certificate.id" value="${certificate.id }" />

			<div>
				<table class="twrap">
					<tr>
						<td>

							<table class="modify">
								<caption>
									<fmt:message key="Update" />
									<fmt:message key="Certificate" />
								</caption>

								<tbody>
									<tr>

										<td></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="certificateCode" /></td>
										<td><input type="text" name="certificate.certificateCode"
											value="${certificate.certificateCode }" size="5"
											maxlength="5" /><font class="fm">*</font></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="issuingAuthority" /></td>
										<td><input type="text"
											name="certificate.issuingAuthority"
											value="${certificate.issuingAuthority }" size="16"
											maxlength="16" /><font class="fm">*</font></td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="issueDate" /></td>
										<td>	
										<input type="text" name="certificate.issueDate"
											value="<fmt:formatDate value="${certificate.issueDate }" type="date"/>"
											onclick="displayCalendar(this,'yyyy-MM-dd');" />
											</td>
									</tr>

									<tr>
										<td class="tl"><fmt:message key="valid" /></td>
										<td><input type="text" name="certificate.valid"
											value="${certificate.valid }" size="4" maxlength="4" /></td>
									</tr>
									<tr>
										<td class="tl"><fmt:message key="certificateType" /></td>
										<td><input type="text" name="certificate.certificateType"
											value="${certificate.certificateType }" size="4"
											maxlength="4" /></td>
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