<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="JobCheck" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css"
	type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>


<body>
	<c:url value="/JobCheck.do" var="defURL" />

	<form method="post" action="${defURL }">
		<div id="gtop">
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="add" />
				<jsp:param name="key" value="Add" />
				<jsp:param name="action" value="JobCheck.do" />
				<jsp:param name="method" value="promptAdd" />
			</jsp:include>
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="delete" />
				<jsp:param name="key" value="Delete" />
				<jsp:param name="action" value="JobCheck.do" />
				<jsp:param name="method" value="processDelete" />
			</jsp:include>
			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="edit" />
				<jsp:param name="key" value="Edit" />
				<jsp:param name="action" value="JobCheck.do" />
				<jsp:param name="method" value="promptEdit" />
			</jsp:include>

			<jsp:include page="../incl/action.jsp">
				<jsp:param name="type" value="find" />
				<jsp:param name="key" value="List" />
				<jsp:param name="action" value="JobCheck.do" />
				<jsp:param name="method" value="list" />
			</jsp:include>

		</div>

		<div id="container">

			<%@ include file="../incl/b_message.jsp"%>

			<div>
				<table class="twrap">
					<tr>
						<td>

							<table class="st">
								<caption>
									<fmt:message key="JobCheck" />
								</caption>
								<tbody>
									<tr>
										<td class="textr"><fmt:message key="JobCheck" /></td>
										<td><input name="styleName" value="${param.styleName }" /></td>

										<td class="textr"><fmt:message key="JobType" /></td>
										<td><input name="styleName" value="${param.styleName }" /></td>

									</tr>

								</tbody>
							</table>
						</td>
					</tr>

					<tr>
						<td>

							<table class="lt">

								<thead>
									<!-- 分页 -->
									<tr class="lp">
										<td colspan="9"><%@ include
												file="../incl/pageNavigation.jsp"%>
										</td>
									</tr>

									<tr>
										<th><input name="choose" type="checkbox"
											onclick="checkedAll(this.name,'id');" /> <fmt:message
												key="ID" /></th>
										<th><fmt:message key="CheckType" /></th>
										<th><fmt:message key="CheckName" /></th>
										<th><fmt:message key="JobType" /></th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="jobCheck" items="${jobChecks}" varStatus="status">
										<tr
											<c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>
											onMouseOver="trMouseOver(this);"
											onMouseOut="trMouseOut(this);">
											<td><input type="checkbox" name="id"
												value="${jobCheck.id }"></td>
											<td><c:out value="${jobCheck.jobCategory }" /></td>
											<td><c:out value="${jobCheck.checkType }" /></td>
											<td><c:out value="${jobCheck.checkName }" /></td>
										</tr>
									</c:forEach>
								</tbody>

								<tfoot>
									<!-- 分页 -->
									<tr class="lp">
										<td colspan="9"><%@ include
												file="../incl/pageNavigation.jsp"%>
										</td>
									</tr>
								</tfoot>
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