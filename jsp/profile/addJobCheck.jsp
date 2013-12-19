<!DOCTYPE HTML>
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
				<jsp:param name="action" value="JobCheck.do" />
				<jsp:param name="method" value="processAdd" />
			</jsp:include>
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="cancel" />
				<jsp:param name="key" value="Cancel" />
				<jsp:param name="action" value="JobCheck.do" />
				<jsp:param name="method" value="list" />
			</jsp:include>
		</div>

		<div id="container" align="center">
			<%@ include file="../incl/b_message.jsp"%>

			<div>
				<table class="twrap">
					<tr>
						<td>

							<table class="modify" >
								<caption>
									<fmt:message key="Update" />
									<fmt:message key="JobCheck" />
								</caption>

								<tbody>
									<tr>
										<td class="tl"><fmt:message key="JobType" /></td>
										<td><select name="jobCheck.jobCategory">
												<c:forEach var="jobType" items="${jobTypes}" varStatus="s">
													<option value="${jobType}"
														<c:if test="${jobType==param.jobCheck.jobCategory}">
												selected="selected"
											</c:if>>
														${jobType}</option>
										--</c:forEach>
										</select> <font class="fm">*</font></td>
									</tr>
									
									<tr>
										<td class="tl"><fmt:message key="CheckType" /></td>
										<td><input type="text" name="jobCheck.checkType" value="${jobCheck.checkType }"/>
											<font class="fm">*</font>
											</td>
									</tr>


									<tr>
										<td class="tl"><fmt:message key="CheckName" /></td>
										<td><input type="text" name="jobCheck.checkName"
											value="${jobCheck.checkName }"/></td>
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