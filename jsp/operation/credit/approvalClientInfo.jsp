<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="ClientInfo" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="skins/office/default/loan.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/myhy.js"></script>
<script type="text/javascript" src="jsp/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>

<style>
	td{
		line-height:24px;
	}
	* {margin:0;padding:0;}
#imglist {list-style:none; width:500px; margin:50px auto;}
#imglist li {float:left; margin-top:10px;}

</style>
</head>

<body>
			<form method="post">
			
		<div id="gtop">
			<jsp:include page="../../incl/action.jsp">
			<jsp:param name="type" value="cancel" />
			<jsp:param name="key" value="Cancel" />
			<jsp:param name="action" value="ClientInfo.do" />
			<jsp:param name="method" value="list" />
			</jsp:include>
		</div>
		
		
		<table width="98%" border="0" cellpadding="0" cellspacing="0" id="tab2">
				<tbody>
					<tr height="10px">
		
						<td height="28" colspan="2" align="right">
							销售顾问代码:
						</td>
					  <td width="17%">&nbsp;<c:out value="${UserName}"/></td>
		
		<td>
			<input type="text" name="clientJob.privateKey" value="${clientJob.privateKey}"/>
			</td>
			<td width="8%">&nbsp;</td>
			<td width="14%" colspan="3">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="9" align="center"style="background-color: #0285c7; line-height: 28px; font-size: 1.5em; color: white; padding-top: 5px;">
		<center>
			<h2><c:out value="状态"/> </h2>
				</center>
		  </td>
		</tr>
		
		<tr>
			<td colspan="9" align="center" bgcolor="#D6D6D6" style="background-color:#eafef3; line-height: 28px">
						客户基本信息
					</td>
				</tr>
			</tbody>
		</table>
		
		
		 <table width="98%" border="1" cellpadding="0" cellspacing="0" class="lt"id="tab2">
			<tbody>
				<tr>
					<td rowspan="1" align="center" id="guest_info1"><strong>
					  客户资料
					</strong></td>
					<td>
		  <table width="100%" border="1" cellpadding="0" cellspacing="0"
							id="tab3">
							<tbody>
								<tr>
									<td colspan="6" align="right" style="background-color:#eafef3">
					客户照片:
				</td>
				<td align="left" colspan="2">
					<%-- <img src='${client.photoPath} ' width="120">--%>
				</td>
		      </tr>
			<tr>
				<td align="right" id="guest_infoA" style="height:24px">
					姓名:
				</td>
				<td align="left" id="guest_infoB" style="padding-left:4px;">
					<input type="text" name="client.clientName" value="${client.clientName}"
					maxlength="10" size="10"/></td>
				<td align="right" id="guest_infoC" style="padding-left:4px;">
					SSI号码/学生号码:
		                            </td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><input size="10" type="text" name="client.otherNo" value="${ client.otherNo}"/></td>
				<td align="right" id="guest_infoE">
					性别:
		                            </td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><input size="10" type="text" name="client.sex" value="${ client.sex}"/></td>
				<td align="right" id="guest_infoG">
					申请人年龄:
				</td>
				<td align="left" id="guest_infoK" style="padding-left:4px;"><input size="10" type="text" name="client.age" value="${ client.age}"/></td>
		
		  </tr>
			<tr>
				<td align="right" id="guest_infoA">
					身份证号码:
				</td>
				<td align="left" id="guest_infoB" style="padding-left:4px;"><input size="10" type="text" name="client.idNo" value="${ client.idNo}"
					onblur="calcIdCard()" value="${client.idNo}"/></td>
		
				<td align="right" id="guest_infoC">
					<input type="button" value="查询合同" id="userIdCode"
						style="height: 22px;font-size:12px;">
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;">6</td>
				<td align="right" id="guest_infoE">
					身份证截止日期:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><fmt:formatDate value="${client.idEndDate}" type="date" pattern="yyyy-MM-dd"/></td></td>
				<td align="right" id="guest_infoG">
					发证机关:
				</td>
				<td align="left" id="guest_infoK" style="padding-left:4px;"><input size="10" type="text" name="client.idAuthority" value="${ client.idAuthority}"
					maxlength="50" /></td> 
		  </tr>
			<tr>
		
				<td align="right" id="guest_infoA">
					住房:
				</td>
				<td align="left" id="guest_infoB" style="padding-left:4px;"><input size="10" type="text" name="client.housing" value="${ client.housing}"
					maxlength="50" /></td>
				<td align="right" id="guest_infoC">
					教育程度:
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><input size="10" type="text" name="client.educationId"
					maxlength="50" value="${client.educationId }"/></td>
				<td align="right" id="guest_infoE">
					婚姻状况:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><input type="text" name="client.marry" value="${client.marry }"
					maxlength="50" size="10" /></td>
				<td align="right" id="guest_infoG">
					子女数目:
				</td>
				<td align="left" id="guest_infoK" style="padding-left:4px;"><input size="10" type="text" name="client.childs" value="${client.childs }"/></td>
		
		  </tr>
			<tr>
		
				<td align="right" id="guest_infoA">
					配偶姓名:
				</td>
				<td align="left" id="guest_infoB" style="padding-left:4px;"><input size="10" type="text" name="client.spuseName" maxlength="20" size="10" value="${client.spuseName}"/></td>
				<td align="right" id="guest_infoC">
					身份证号码:
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><input size="15" type="text" name="client.idSpuse" value="${client.idSpuse}"/></td>
				<td align="right" id="guest_infoE">
					电子邮箱:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><input size="10" type="text" name="client.homePhone" value="${client.homePhone}"/></td>
		
		
							<td align="right" id="guest_infoG"></td>
							<td align="left" id="guest_infoK"></td>
					  </tr>
					</tbody>
				</table>
		  </td>
		</tr>
		
		
		<tr>
			<td align="center" id="guest_info1"><strong>
			  户籍地址
			</strong></td>
			<td>
		<table width="100%" border="1" cellpadding="0" cellspacing="0" id="tab3">
					<tbody>
						<tr>
							<td id="guest_info11">
								<table>
		
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="text" name="censusAddressBook.province" size="8"
													maxlength="20" size="10" value="${censusAddressBook.province }" readonly="readonly"
													id="verifyForm_contract_adProvince"
													class="inputStyle2">
											</td>
										</tr>
		
									</tbody>
								</table>
		          	 </td>
							<td id="guest_info12">
								<table>
		
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="text" name="censusAddressBook.city" size="10"
													maxlength="20" size="10" value="${censusAddressBook.city }" readonly="readonly"
													id="verifyForm_contract_adCity" class="inputStyle1">
											</td>
										</tr>
		
									</tbody>
								</table>
		           </td>
							<td id="guest_info13">
						  <table>
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="text" name="censusAddressBook.county" size="8"
													maxlength="20" size="10" value="${censusAddressBook.county }" readonly="readonly"
													id="verifyForm_contract_adCounty" class="inputStyle1">
											</td>
										</tr>
		
									</tbody>
								</table>
		           </td>
							<td id="guest_info14">
								<table>
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="text" name="censusAddressBook.town" size="5"
													maxlength="20" size="10" value="${client.otherPhone}" readonly="readonly"
										id="verifyForm_contract_adTown" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
		        </td>
				<td id="guest_info15">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="censusAddressBook.street" size="10"
										maxlength="20" size="10" value="${client.otherPhone}" readonly="readonly"
										id="verifyForm_contract_adStreet" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
		        </td>
				<td id="guest_info16">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text"
										name="censusAddressBook.community" size="10"
										maxlength="20" size="10" value="${censusAddressBook.community}" readonly="readonly"
										id="verifyForm_contract_adNeighborhoodPremises"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
		        </td>
				<td id="guest_info17">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="censusAddressBook.houseNo"
										size="10" maxlength="20" size="10" value="${censusAddressBook.houseNo}" readonly="readonly"
										id="verifyForm_contract_adUnitHomeNumber"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
		        </td>
		
				<td id="guest_info18">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="censusAddressBook.other" size="10"
										maxlength="50" value="${censusAddressBook.other}" readonly="readonly"
										id="verifyForm_contract_adOther" class="inputStyle1"
										isempty="true">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
		
				<td align="right" id="guest_info20">
					邮编:
				</td>
				<td id="guest_info21">
				  <table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="censusAddressBook.zipCode" size="6"
										maxlength="20" size="10" value="${censusAddressBook.zipCode}" readonly="readonly"
													id="verifyForm_contract_adPostCode"
													class="inputStyle1" dtype="number">
											</td>
										</tr>
		
									</tbody>
							  </table>
		           </td>
							<td id="guest_info19"></td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" id="guest_info1"><strong>
			  现居住地址
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td id="guest_info11">
								<table>
		
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="text" name="livingAddressBook.province" size="8"
													maxlength="20" size="10" value="${livingAddressBook.province}" readonly="readonly"
										id="verifyForm_contract_nowProvince"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info12">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name=livingAddressBook.city size="10"
										maxlength="20" size="10" value="${livingAddressBook.city}" readonly="readonly"
										id="verifyForm_contract_nowCity" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info13">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="livingAddressBook.county" size="8"
										maxlength="20" size="10" value="${livingAddressBook.county}" readonly="readonly"
										id="verifyForm_contract_nowCounty" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info14">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="livingAddressBook.town" size="5"
										maxlength="20" size="10" value="${livingAddressBook.town}" readonly="readonly"
										id="verifyForm_contract_nowTown" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info15">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="livingAddressBook.street" size="10"
										maxlength="20" size="10" value="${livingAddressBook.street}" readonly="readonly"
										id="verifyForm_contract_nowStreet" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info16">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text"
										name="livingAddressBook.community" size="10"
										maxlength="20" size="10" value="${livingAddressBook.community}" readonly="readonly"
										id="verifyForm_contract_nowNeighborhoodPremises"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info17">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="livingAddressBook.houseNo"
										size="10" maxlength="20" size="10" value="${livingAddressBook.houseNo}"
										readonly="readonly"
										id="verifyForm_contract_nowUnitHomeNumber"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
		
				<td id="guest_info18" align="center">
					居住(月):
				</td>
			  <td id="guest_info19">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="contract.nowMonth" size="3"
										value="${contract.nowMonth}" readonly="readonly"
										id="verifyForm_contract_nowMonth" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
			  </td>
				<td align="right" id="guest_info20">
					邮编:
				</td>
				<td id="guest_info21">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="livingAddressBook.zipCode" size="6"
										maxlength="10" value="${livingAddressBook.zipCode}" readonly="readonly"
													id="verifyForm_contract_nowPostCode"
													class="inputStyle1" dtype="number">
											</td>
										</tr>
		
									</tbody>
							  </table>
						  </td>
		
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" id="guest_info1"><strong>
			  公司地址</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td id="guest_info11">
								<table>
		
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="text" name="officeAddressBook.province" size="8"
													value="${officeAddressBook.province}" readonly="readonly"
										id="verifyForm_contract_xxProvince"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info12">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="officeAddressBook.city" size="10"
										value="${officeAddressBook.city}" readonly="readonly"
										id="verifyForm_contract_xxCity" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info13">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="officeAddressBook.county" size="8"
										value="${officeAddressBook.county}" readonly="readonly"
										id="verifyForm_contract_xxCounty" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info14">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="officeAddressBook.town" size="5"
										value="${officeAddressBook.town}" readonly="readonly"
										id="verifyForm_contract_xxTown" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info15">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="officeAddressBook.street" size="10"
										value="${officeAddressBook.street}" readonly="readonly"
										id="verifyForm_contract_xxStreet" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info16">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text"
										name="officeAddressBook.community" size="10"
										value="${officeAddressBook.community}" readonly="readonly"
										id="verifyForm_contract_xxNeighborhoodPremises"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info17">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="officeAddressBook.houseNo"
										size="10" value="${officeAddressBook.houseNo}" readonly="readonly"
										id="verifyForm_contract_xxUnitHomeNumber"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
		
			  <td id="guest_info18">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="officeAddressBook.other" size="10"
										value="${officeAddressBook.other}" readonly="readonly"
										id="verifyForm_contract_xxOther" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
			  </td>
		
				<td align="right" id="guest_info20">
					邮编:
				</td>
				<td id="guest_info21">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="officeAddressBook.zipCode" size="6"
										value="${officeAddressBook.zipCode}" readonly="readonly"
													id="verifyForm_contract_xxPostCode"
													class="inputStyle1">
											</td>
										</tr>
		
									</tbody>
							  </table>
						  </td>
							<td id="guest_info19"></td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>

		<tr>
			<td align="center" id="guest_info1"><strong>
			  家庭成员地址
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td id="guest_info11">
								<table>
		
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="text" name="homeAddressBook.province" size="8"
													maxlength="20" size="10" value="${homeAddressBook.province}" readonly="readonly"
										id="verifyForm_contract_faProvince"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info12">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="homeAddressBook.city" size="10"
										maxlength="20" size="10" value="${homeAddressBook.city}" readonly="readonly"
										id="verifyForm_contract_faCity">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info13">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="homeAddressBook.county" size="8"
										maxlength="20" size="10" value="${homeAddressBook.county}" readonly="readonly"
										id="verifyForm_contract_faCounty" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info14">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="homeAddressBook.town" size="5"
										maxlength="20" size="10" value="${homeAddressBook.town}" readonly="readonly"
										id="verifyForm_contract_faTown" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info15">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="homeAddressBook.street" size="10"
										maxlength="20" size="10" value="${homeAddressBook.street}" readonly="readonly"
										id="verifyForm_contract_faStreet" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info16">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text"
										name="homeAddressBook.community" size="10"
										maxlength="20" size="10" value="${homeAddressBook.community}" readonly="readonly"
										id="verifyForm_contract_faNeighborhoodPremises"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td id="guest_info17">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="homeAddressBook.houseNo"
										size="10" maxlength="20" size="10" value="${homeAddressBook.houseNo}" readonly="readonly"
										id="verifyForm_contract_faUnitHomeNumber"
										class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
		
			  <td id="guest_info18">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="homeAddressBook.other" size="10"
										value="${homeAddressBook.other}" readonly="readonly"
										id="verifyForm_contract_faOther" class="inputStyle1">
								</td>
							</tr>
		
						</tbody>
					</table>
			  </td>
		
				<td align="right" id="guest_info20">
					邮编:
				</td>
				<td id="guest_info21">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="homeAddressBook.zipCode" size="6"
										maxlength="10" value="${homeAddressBook.zipCode}" readonly="readonly"
													id="verifyForm_contract_faPostCode"
													class="inputStyle1" dtype="number">
											</td>
										</tr>
		
									</tbody>
							  </table>
						  </td>
							<td id="guest_info19">
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		
		<tr>
			<td rowspan="1" align="center" id="guest_info1"><strong>
			  联系人信息
			</strong></td>
			<td>
				<table width="100%" border="1" cellpadding="0" cellspacing="0" id="tab3">
					<tbody>
						<tr>
							<td width="12%" align="right" id="guest_info61">
								家庭成员名称:
							</td>
						  <td width="20%" id="guest_info62" style="padding-left:4px;">
				 <input type="text" name="client.homeName" maxlength="20" size="10" value="${client.homeName}"/>
			  </td>
				<td width="17%" align="right" id="guest_info63">
					家庭成员类型:
				</td>
			  <td width="17%" id="guest_info64" style="padding-left:4px;">
					<input type="text" name="client.homeType" value="${client.homeType}" size="10"/>
			  </td>
				<td width="17%" align="right" id="guest_info65">
					家庭成员电话号:
				</td>
				<td width="17%" id="guest_info66" style="padding-left:4px;">
					<input type="text" name="client.homeTelephone" value="${client.otherPhone}" size="10"/>
			  </td>
			</tr>
			<tr>
				<td align="right" id="guest_info61">
					联系人姓名:
					<input type="button" value="查询合同" id="contactPhone" value="${client.otherPhone}" name="client.otherPhone"
						style="height: 20px; font-size:12px;" >
				</td>
				<td id="guest_info62" style="padding-left:4px;">
				  <input type="text" name="client.otherContacts" value="${client.otherContacts}" size="10"/>
				</td>
				<td align="right" id="guest_info63">
					与申请人关系:
				</td>
			  <td id="guest_info64" style="padding-left:4px;">
				  <input type="text" name="client.otherNexus" value="${client.otherNexus}" size="10"/>
			  </td>
				<td align="right" id="guest_info65">
					联系电话:
				</td>
				<td id="guest_info66" style="padding-left:4px;">
					<input type="text" name="client.otherPhone" value="${client.otherPhone}" size="10"/>
						  </td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		
		<tr>
			<td rowspan="1" align="center" id="guest_info1"><strong>
			  电话
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
						  <td align="right" id="guest_infoA">
								手机&nbsp;:			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;">							
			  	<input type="text" name="client.mobilePhone" size="10" onblur="getphonearea(this.value)"  value="${client.mobilePhone }">
			</td>
				<td align="right" id="guest_infoC">
					手机号码归属地:
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><input size="10" type="text" name="client.mobileAddress" value="${client.mobileAddress }"/></td>
				<td align="right" id="guest_infoE">
					住宅电话登记人:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><input size="10" type="text" name="client.homePhoneName" value="${client.homePhoneName }"
		maxlength="20" size="10" /></td>
							<td align="right" id="guest_infoG">
								住宅/宿舍电话:
							</td>
							<td align="left" id="guest_infoK" style="padding-left:4px;"><input  size="10" type="text" name="client.homePhone" value="${client.homePhone }"/></td>
		
		
			</tr>
			<tr>
			  <td align="right" id="guest_infoA">
					办公电话&nbsp;:<input type="button" value="查询合同" id="officePhone" style="height: 20px; font-size:12px;">
			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;"><input size="10" type="text" name="client.onOfficePhone" value="${client.onOfficePhone }"
		maxlength="20"  /></td>
							<td align="right" id="guest_infoC">
								办公电话分机:
							</td>
							<td align="left" id="guest_infoD" style="padding-left:4px;"><input  size="10"type="text" name="client.onExtPhone" value="${client.onExtPhone }"/></td>
				<td align="right" id="guest_infoE"></td>
				<td align="left" id="guest_infoF"></td>
				<td align="right" id="guest_infoG"></td>
				<td align="left" id="guest_infoK"></td>
			</tr>
			<tr>
			  <td align="right" id="guest_infoA">
					配偶移动电话:
			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;"><input size="10" type="text" name="client.spuseMobile" value="${client.spuseMobile }"/></td>
				<td align="right" id="guest_infoC">
					配偶办公电话:
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><input size="10" type="text" name="client.spuseOfficePhone" value="${client.spuseOfficePhone }"/></td>
				<td align="right" id="guest_infoE">
					配偶办公电话分机:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><input type="text" size="10" name="client.spuseExtPhone" value="${client.spuseExtPhone }"/></td>
				<td align="right" id="guest_infoE">
					配偶雇主:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><input type="text" size="10" name="client.spuseHirer" value="${client.spuseHirer }"
		maxlength="20" size="10" /></td>
		
						</tr>
					</tbody>
				</table>
		  </td>
		</tr>
		
		
		<tr>
			<td rowspan="1" align="center" id="guest_info1"><strong>
			  所在单位信息
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td width="7%" align="right" id="guest_infoA">
								单位名称或大学名称:
							</td>
							<td width="34%" align="left" id="guest_infoB">
							  <table>
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="text" id="client.onShortName" value="${client.onShortName }"
										class="inputStyle1" maxlength="20" size="10" />
								</td>
							</tr>
		
						</tbody>
				  </table>
				</td>
				<td width="6%" align="right" id="guest_infoC">
					单位/学校/个体全称:
				</td>
				<td width="36%" align="left" id="guest_infoD">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="client.onFullName" value="${client.onFullName }"
										class="inputStyle1" maxlength="20" size="10"/>
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td width="7%" align="right" id="guest_infoE">
					单位性质:
				</td>
				<td width="2%" align="left" id="guest_infoF">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="client.onFeature" value="${client.onFeature }"
										class="inputStyle1" maxlength="20" size="10"/>
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td width="4%" align="right" id="guest_infoG">
					任职部门或班级:
				</td>
				<td width="4%" align="left" id="guest_infoK"><table>
				  <tbody>
				    <tr>
				      <td class="tdLabel"></td>
				      <td><input type="text" name="client.onDivision" value="${client.onDivision }"
										class="inputStyle1" maxlength="20" size="10"/></td>
			        </tr>
			      </tbody>
			    </table></td>
		
			</tr>
			<tr>
				<td align="right" id="guest_infoA">
					行业类别:
				</td>
				<td align="left" id="guest_infoB">
				  <table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
								<input type="text" name="client.onSector" value="${client.onSector }"
										class="inputStyle1" maxlength="20" size="10"/>
								</td>
							</tr>
		
						</tbody>
				  </table>
				</td>
		
				<td align="right" id="guest_infoC">
					职位:
				</td>
				<td align="left" id="guest_infoD">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									 <input type="text" name="client.onOffice" value="${client.onOffice }"
										class="inputStyle1" maxlength="20" size="10"/>
								</td>
							</tr>
		
						</tbody>
					</table>
				</td>
				<td align="right" id="guest_infoE" >
					<p>
						总共工作经脸/总共大学学习时间:
					</p>
				</td>
				<td align="left" id="guest_infoF">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="text" name="client.onWorkTime" value="${client.onWorkTime }"
													class="inputStyle1" maxlength="20" size="10"/>
											</td>
										</tr>
		
									</tbody>
								</table>
							</td>
							<td align="right" id="guest_infoG">
								现工作时间/大学开始时间(年):
							</td>
							<td align="left" id="guest_infoK">
								<table>
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<label id="verifyForm_contract_xxStartTime"
													class="inputStyle1"  >
													60
												</label>
											</td>
										</tr>
		
									</tbody>
								</table>
							</td>
		
						</tr>
					</tbody>
				</table>
		  </td>
		</tr>
		<tr>
			<td align="center" id="guest_info1"><strong>
			  收入资料
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td align="right" id="guest_infoA">
								月收入总额(元):
							</td>
							<td align="left" id="guest_infoB" style="padding-left:4px;">
					<input type="text" name="client.masterInMonth" maxlength="10" value="${client.masterInMonth }" size="10" />
			  </td>
				<td align="right" id="guest_infoC">
					其他收入(元/月):
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;">
					<input type="text" name="client.otherInMonth" value="${client.otherInMonth }"
		maxlength="10"  size="10"/>
						  </td>
							<td align="right" id="guest_infoE">
								其他收入来源:
							</td>
							<td align="left" id="guest_infoF" style="padding-left:4px;">
					<input type="text" name="client.otherIncome" value="${client.otherIncome }"
		maxlength="10"  size="10"/>
						  </td>
							<td align="right" id="guest_infoG">
								家庭月收入(元):
							</td>
							<td align="left" id="guest_infoK" style="padding-left:4px;">
					<input type="text" name="client.homeInMonth" value="${client.homeInMonth }"
		maxlength="10"  size="10"/>
						  </td>
					  </tr>
					</tbody>
				</table>
			</td>
		</tr>
		
		
		
		<tr>
			<td rowspan="1" align="center" id="guest_info1"><strong>
			  文件
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td id="guest_infoM">
								<table>
		
									<tbody>
										<tr>
											<td class="tdLabel"></td>
											<td>
												<input type="checkbox" name="contract.fIdCode"
													value="身份证" id="contract.fIdCode-1" checked="checked"
													disabled="disabled">
												<label for="contract.fIdCode-1" class="checkboxLabel">
													身份证
												</label>
												<input type="hidden"
													id="__multiselect_verifyForm_contract_fIdCode"
													name="__multiselect_contract.fIdCode" value="${client.otherPhone}"
										disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fSocialCard"
										value="社保卡" id="contract.fSocialCard-1"
										checked="checked" disabled="disabled">
									<label for="contract.fSocialCard-1"
										class="checkboxLabel">
										社保卡
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fSocialCard"
										name="__multiselect_contract.fSocialCard" value="${client.otherPhone}"
										disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fWorkCard"
										value="工卡" id="contract.fWorkCard-1" checked="checked"
										disabled="disabled">
									<label for="contract.fWorkCard-1" class="checkboxLabel">
										工卡
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fWorkCard"
										name="__multiselect_contract.fWorkCard" value="${client.otherPhone}"
										disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fBankCard"
										value="银行卡" id="contract.fBankCard-1"
										checked="checked" disabled="disabled">
									<label for="contract.fBankCard-1" class="checkboxLabel">
										银行卡
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fBankCard"
										name="__multiselect_contract.fBankCard" value="${client.otherPhone}"
										disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
		
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fBankStatement"
										value="银行对账单" id="contract.fBankStatement-1"
										disabled="disabled">
									<label for="contract.fBankStatement-1"
										class="checkboxLabel">
										银行对账单
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fBankStatement"
										name="__multiselect_contract.fBankStatement" value="${client.otherPhone}"
										disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fBankDeposit"
										value="银行存折" id="contract.fBankDeposit-1"
										disabled="disabled">
									<label for="contract.fBankDeposit-1"
										class="checkboxLabel">
										银行存折
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fBankDeposit"
										name="__multiselect_contract.fBankDeposit" value="${client.otherPhone}"
										disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox"
										name="contract.fResidenceBooklet" value="户口本"
										id="contract.fResidenceBooklet-1" checked="checked"
										disabled="disabled">
									<label for="contract.fResidenceBooklet-1"
										class="checkboxLabel">
										户口本
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fResidenceBooklet"
										name="__multiselect_contract.fResidenceBooklet"
										value="${client.otherPhone}" disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
		
			</tr>
			<tr>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fSid"
										value="大学学生证" id="contract.fSid-1" disabled="disabled">
									<label for="contract.fSid-1" class="checkboxLabel">
										大学学生证
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fSid"
										name="__multiselect_contract.fSid" value="${client.otherPhone}"
										disabled="disabled">
								</td>
							</tr>
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fUid"
										value="大学学生证明" id="contract.fUid-1"
										disabled="disabled">
									<label for="contract.fUid-1" class="checkboxLabel">
										大学学生证明（仅适用全日制大学学生）
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fUid"
										name="__multiselect_contract.fUid" 
										disabled="disabled">
								</td>
							</tr>
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fHouseCard"
										value="${bank2.bankName }" id="contract.fHouseCard-1"
										disabled="disabled">
									<label for="contract.fHouseCard-1"
										class="checkboxLabel">
										房产证
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fHouseCard"
										name="__multiselect_contract.fHouseCard" value="${bank2.bankName }"
										disabled="disabled">
								</td>
							</tr>
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fDirvingCard"
										value="${bank2.bankName }" id="contract.fDirvingCard-1"
										checked="checked" disabled="disabled">
									<label for="contract.fDirvingCard-1"
										class="checkboxLabel">
										行驶证
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fDirvingCard"
										name="__multiselect_contract.fDirvingCard" value="${bank2.bankName }"
										disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fDirverCard" value="${bank2.bankName }"
										 id="contract.fDirverCard-1"
										checked="checked" disabled="disabled">
									<label for="contract.fDirverCard-1"
										class="checkboxLabel">
										驾驶证
									</label>
									<input type="hidden" value="${bank2.bankName }"
										id="__multiselect_verifyForm_contract_fDirverCard"
										name="__multiselect_contract.fDirverCard" 															disabled="disabled">
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td id="guest_infoM">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<input type="checkbox" name="contract.fOther" value="${bank2.bankName }"
										value="其它" id="contract.fOther-1" disabled="disabled">
									<label for="contract.fOther-1" class="checkboxLabel">
										其它
									</label>
									<input type="hidden"
										id="__multiselect_verifyForm_contract_fOther"
										name="__multiselect_contract.fOther" value="${bank2.bankName }"
													disabled="disabled">
											</td>
										</tr>
		
		
									</tbody>
								</table>
							</td>
							<td id="guest_infoM"></td>
		
		
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" id="guest_info1"><strong>
			  上传的图片
			</strong></td>
			<td colspan="7">
			  <table id="uploadfile">
		
					<tbody>
						<tr>
							<td>
		                                         <div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;"><div id="innerdiv" style="position:absolute;"><img id="bigimg" style="border:5px solid #fff;" src="" /></div></div>
								<img src="./_files/4_1_1386858164024_0.036046124514748756.jpeg" class="pimg" width="120" height="120">
							</td>
							<td>
								<img src="./_files/4_1_1386858164028_0.5705359558075703.jpeg"  class="pimg" width="120" height="120">
							</td>
		
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" id="guest_info1"><strong>
			  商品1
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td align="right" id="guest_info51">
								商品:
							</td>
							<td align="left" id="guest_info52" style="padding-left:4px;">1</td>
				<td align="right" id="guest_info53">
					商品类型:
				</td>
			  <td align="left" id="guest_info54" style="padding-left:4px;">2</td>
				<td align="right" id="guest_info55">
					价格(元):
				</td>
			  <td align="left" id="guest_info56" style="padding-left:4px;">3</td>
				<td align="right" id="guest_info57">
					品牌:
				</td>
			  <td align="left" id="guest_info58" style="padding-left:4px;">4</td>
				<td align="right" id="guest_info59">
					型号:
				</td>
			  <td align="left" id="guest_info60" style="padding-left:4px;">5</td>
					  </tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" id="guest_info1"><strong>
			  商品2
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td align="right" id="guest_info51">
								商品:
							</td>
							<td align="left" id="guest_info52" style="padding-left:4px;">1</td>
				<td align="right" id="guest_info53">
					商品类型:
				</td>
			  <td align="left" id="guest_info54" style="padding-left:4px;">2</td>
				<td align="right" id="guest_info55">
					价格(元):
				</td>
			  <td align="left" id="guest_info56" style="padding-left:4px;">3</td>
				<td align="right" id="guest_info57">
					品牌:
				</td>
			  <td align="left" id="guest_info58" style="padding-left:4px;">4</td>
				<td align="right" id="guest_info59">
					型号:
				</td>
			  <td align="left" id="guest_info60" style="padding-left:4px;">5</td>
					  </tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
		
			<td align="center" id="guest_info1"><strong>
			  销售顾问备注:
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
						  <td align="left" colspan="11">&nbsp;</td>
		
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		
		<tr>
			<td rowspan="1" align="center" id="guest_info1"><strong>
			  信用信息
			</strong></td>
			<td>
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"
					id="tab3">
					<tbody>
						<tr>
							<td align="right" id="guest_info51">
								产品:
							</td>
							<td align="left" id="guest_info52" style="padding-left:4px;"><c:out value="${financialProduct.financialName }"/></td>
				<td align="right" id="guest_info53">
					商品总价:
				</td>
			  <td align="left" id="guest_info54" style="padding-left:4px;"><input size="10" type="text" name="clientJob.totalPrice"  value="${salePrice }" readonly /></td>
				<td align="right" id="guest_info55">
					贷款用途:
				</td>
			  <td align="left" id="guest_info56" style="padding-left:4px;"><input size="10" type="text" name="clientJob.byUse" value="${bank2.bankName }"/></td>
				<td align="right" id="guest_info57">
					自付金额(元):
				</td>
			  <td align="left" id="guest_info58" style="padding-left:4px;"><input size="10" type="text" name="clientJob.selfAmount" value="${onePay }"/></td>
				<td align="right" id="guest_info59">
					分期期数:
				</td>
			  <td align="left" id="guest_info60" style="padding-left:4px;"><c:out value="${financialProduct.cycleTotal }"/> </td>
		  </tr>
		
			<tr>
				<td align="right" id="guest_info51">
					每月还款额(元):
				</td>
			  <td align="left" id="guest_info52" style="padding-left:4px;"><c:out value="${monthPay1 }"/></td>
				<td align="right" id="guest_info53">
					贷款本金(元):
				</td>
			  <td align="left" id="guest_info54" style="padding-left:4px;"><input size="10"  type="text" name="clientJob.creditAmount" value="${creditAmount }" readonly /></td>
				<td align="right" id="guest_info55">
					首次还款日:
				</td>
			  <td align="left" id="guest_info56" style="padding-left:4px;"><input size="10" type="text" name="clientJob.firstpayDate" readonly value="${bank2.bankName }"/></td>
				<td align="right" id="guest_info57">
					每月还款日:
				</td>
			  <td align="left" id="guest_info58" style="padding-left:4px;"><input size="10" type="text" name="clientJob.monthOfDate" readonly /></td>
		
				<td align="right" id="guest_info59">
					<table>
		
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<label for="contract.crAgentPay-1"
										class="checkboxLabel">
										银行代扣还款
									</label>
								</td>
							</tr>
		
		
						</tbody>
					</table>
				</td>
				<td align="left" id="guest_info60" style="padding-left:4px;" > 
		                                      					<input type="checkbox" name="contract.crAgentPay"
										value="银行代扣还款" id="contract.crAgentPay-1"
										checked="checked" disabled="disabled" size="10">
		                                       </td>
		  </tr>
		
			<tr>
				<td align="right" id="guest_info51">
					客户银行卡号/账号:
				</td>
			  <td align="left" id="guest_info52" style="padding-left:4px;"><input size="10" type="text" name="bank.debitCard" value="${bank2.bankName }"
		maxlength="24" /></td>
							<td align="right" id="guest_info53">
								客户开户银行:
							</td>
						  <td align="left" id="guest_info54" style="padding-left:4px;"><input size="10" type="text" name="bank.bankName" value="${bank2.bankName }"
		maxlength="50" /></td>
							<td align="right" id="guest_info55">
								月花费(元/月):
							</td>
						  <td align="left" id="guest_info56" style="padding-left:4px;"><input size="10" type="text" name="bank.monthPay" value="${bank2.bankName }"/></td>
				<td align="right" id="guest_info57">
					第二银行卡号:
				</td>
			  <td align="left" id="guest_info58" style="padding-left:4px;"><input size="10" type="text" name="bank2.debitCard" value="${bank2.bankName }"/></td>
		
				<td align="right" id="guest_info59">
					第二银行卡开户银行:
				</td>
			  <td align="left" id="guest_info60" style="padding-left:4px;"><input size="10" type="text" name="bank2.bankName" value="${bank2.bankName }"/></td>
		
								  </tr>
								</tbody>
							</table>
					  </td>
					</tr>
				</tbody>
			</table>
		  <table width="98%" border="1" cellpadding="0" cellspacing="0"
				class="tabVir" id="signMemo">
		<tbody>
					<tr>
					  <td rowspan="700" align="center" id="guest_info1">
				    <strong>征信注记 </strong></td>
						<td align="center" id="guest_info31">
							No
					  </td>
						<td align="center" id="guest_info32">
							CRT
						</td>
						<td align="center" id="guest_info33">
							电话类型
						</td>
						<td align="left" id="guest_info34" style="padding-left:4px;">
			MEMO
		</td>
		<td align="left" id="guest_info35" style="padding-left:4px;">
				TIME
			</td>
		</tr>
		
		<tr>
		
			<td align="center" id="guest_info31">
				1
			</td>
			<td align="center" id="guest_info32">222222</td>
			<td align="center" id="guest_info33"></td>
			<td align="left" id="guest_info34" style="padding-left:4px;"> 身份证审查 一致 </td>
			<td align="left" id="guest_info35">&nbsp;</td>
		 </tr>
		
		<tr>
		
			<td align="center" id="guest_info31">
				2
			</td>
			<td align="center" id="guest_info32">&nbsp;</td>
			<td align="center" id="guest_info33"></td>
			<td align="left" id="guest_info34" style="padding-left:4px;">公司电话审查 信息核对一致</td>
					<td align="left" id="guest_info35">&nbsp;</td>
			  </tr>
			</tbody>
		</table>
		<table width="98%" border="1" cellpadding="0" cellspacing="0"
			id="tab2">
			<tbody>
				<tr>
				  <td width="9%" rowspan="3" align="center" id="guest_info1">
		      <strong>添加新注记 </strong></td>
				  <td width="9%" align="right" id="guest_info71">审查步骤:</td>
					<td width="18%" id="guest_info72">
					  <table>
							<tbody>
								<tr>
									<td class="tdLabel"></td>
									<td>
										<select name="" id="memoList1" onChange="copyMemo()" width="95%">
											<option value="0">
												请选择
											</option>
											<option value="1">
												身份证审查
											</option>
											<option value="2">
												征信核查
											</option>
											<option value="3">
												网络审查
											</option>
											<option value="4">
												114审查
											</option>
											<option value="5">
												10000审查
											</option>
											<option value="6">
												本人手机审查
											</option>
											<option value="7">
												公司电话审查
											</option>
											<option value="8">
												家庭座机审查
											</option>
											<option value="9">
												亲属电话审查
											</option>
											<option value="10">
												其他联系人手机审查
											</option>
											<option value="11">
												工作/收入/学生证明文件审查
											</option>
		                                                   <option value="12">
												居住证明文件审查
											</option>
		                                                   <option value="13">
												其他
											</option>
							</select>
						</td>
					</tr>
		
				</tbody>
		  </table>
		 </td>
		<td width="19%" align="right" id="guest_info71">结果：</td>
		<td width="34%" align="left" id="guest_info77"><table>
		  <tbody>
		    <tr>
		      <td class="tdLabel"></td>
		      <td><select name="memoList" id="memoList2"  width="95%">
		        <option value="${client.otherPhone}"> 请选择 </option>
			       
			        </select></td>
		        </tr>
		      </tbody>
		    </table></td>
			<td width="11%" id="guest_info75"></td>
		</tr>
		<tr>
			<td align="right" id="guest_info71">
				备注
			:</td>
			<td id="guest_info72" colspan="3">
				<input type="text" value="${client.otherPhone}" name="" id="memo" size="100">
		  </td>
		
		 <td id="guest_info75" >
				30汉字/60字符
		  </td>
		 </tr>
		<tr>
			<td height="25px" colspan="7"
				align="center" bgcolor="#eafef3" style="background-color:#eafef3">
		<input type="button" name="" value="添加" onClick="addVerifyMemo(2, 222222)"style="height: 22px;">
					</td>
		
				</tr>
			</tbody>
		</table>
		<table width="98%" border="1" cellpadding="0" cellspacing="0"
			id="tab2">
			<tbody>
				<tr>
					<td id="guest_infos">
						[申请信息]
					</td>
				</tr>
				<tr>
					<td id="guest_info">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tab3">
							<tbody>
								<tr>
									<td id="guest_info1">
										CBSRC
									</td>
									<td id="guest_info82">
										<input type="text" name="" value="A" size="30">
									</td>
									<td id="guest_info83">
										[案件类型]
									</td>
									<td id="guest_info83">
										<input type="text" name="" value="B征中" size="30">
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td id="guest_info">
						<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tab3">
							<tbody>
								<tr>
									<td>
										<table width="100%" border="1" cellpadding="0"
											cellspacing="0" style="margin-bottom: 2px;">
						<tbody>
							<tr>
								<td width="12%" align="right" id="guest_infoh">
								期望申请额度:</td>
								<td colspan="2">
									<input type="text" value="10000" name="" size="12">
							  </td>
		
		                                                      <td width="6%" align="right" id="guest_infoh">
									不同意降普&nbsp;</td>												
								<td colspan="3" style="padding-left:6px;" >
									<input type="checkbox" value="${client.otherPhone}" name="" size="18">
								</td>
								<td width="5%" align="right" id="guest_infoh">
									原因:</td>
								<td width="46%" style="padding-left:4px;" >
									
									<input type="text" value="房屋贷款" name="" size="60">
								</td>
						  </tr>
		
							<tr>
		
								<td align="right" id="guest_infoh">
									A级审核
								</td>
		
		
								<td width="6%" align="right" id="guest_infoh">
									结果
								:</td>
		
		
								<td width="7%" id="guest_infoh"><input type="text" value="${client.otherPhone}" name="input5" size="10">
									
								</td>
		
								<td width="6%" align="right" id="guest_infoh">
									原因码:
		                                                       </td>												
								<td width="6%" id="guest_info95">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeOne" size="6" value="${client.otherPhone}"
														id="verifyForm_codeOne">
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							  <td width="6%" id="guest_info96">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeTwo" size="6" value="${client.otherPhone}" id="verifyForm_codeTwo">
												</td>
											</tr>
										</tbody>
									</table>
							  </td>
							  <td width="6%" id="guest_info97">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeThree" size="6"value="${client.otherPhone}" id="verifyForm_codeThree">
												</td>
											</tr>
										</tbody>
									</table>
							  </td>
								<td align="right" id="guest_infoh">
									MEMO
								</td>
								<td style="padding-left:4px;">
									
									<input type="text" value="房屋贷款" name="input" size="60">
		                                                    </td>
						  </tr>
							<tr>
								<td align="right" id="guest_infoh">
									B级审核
								</td>
		
								<td align="right" id="guest_infoh">
									结果
								:</td>
								<td id="guest_infoh"><input type="text" value="${client.otherPhone}" name="input4" size="10"></td>
								<td align="right" id="guest_infoh">
									原因码
								:</td>														
						  <td width="6%" id="guest_info95">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeOne" size="6" value="${client.otherPhone}"
														id="verifyForm_codeOne">
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							  <td width="6%" id="guest_info96">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeTwo" size="6" value="${client.otherPhone}" id="verifyForm_codeTwo">
												</td>
											</tr>
										</tbody>
									</table>
							  </td>
								<td width="6%" id="guest_info97">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeThree" size="6"value="${client.otherPhone}" id="verifyForm_codeThree">
												</td>
											</tr>
										</tbody>
									</table>
								</td>
								<td align="right" id="guest_infoh">
									MEMO
								</td>
								<td style="padding-left:4px;">
									<!-- <input type="text" value="${client.otherPhone}" name="" size="10"/> -->
									<input type="text" value="房屋贷款" name="input2" size="60"></td>
						  </tr>
		
							<tr>
		
								<td align="right" id="guest_infoh">
									A级审核
								</td>
								<td align="right" id="guest_info92">
									结果
								:</td>
								<td id="guest_info93">
									<input type="text" value="${client.otherPhone}" name="" size="10">
								</td>
								<td align="right" id="guest_info94">
									原因码
								:</td>
								<td width="6%" id="guest_info95">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeOne" size="6" value="${client.otherPhone}"
														id="verifyForm_codeOne">
												</td>
											</tr>
										</tbody>
									</table>
								</td>
								<td width="6%" id="guest_info96">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeTwo" size="6" value="${client.otherPhone}" id="verifyForm_codeTwo">
												</td>
											</tr>
										</tbody>
									</table>
								</td>
								<td width="6%" id="guest_info97">
									<table>
										<tbody>
											<tr>
												<td class="tdLabel"></td>
												<td>
													<input type="text" name="codeThree" size="6"value="${client.otherPhone}" id="verifyForm_codeThree">
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							
								<td align="right" id="guest_info98">
									MEMO
								</td >
								<td id="guest_info" style="padding-left:4px;">
		                                                           	<input type="text" value="房屋贷款" name="input3" size="60">
		                                                           </td>
											  </tr>
											</tbody>
										</table>
								  </td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
		  </tbody>
		 </table>
		<table width="100%" cellpadding="0" cellspacing="0"
			style="display: none;">
		
		<tbody>
			<tr>
				<td colspan="2">
					<table>
						<tbody>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<textarea name="newContractState" cols="" rows=""
										id="newContractState" style="display: none;"></textarea>
									</td>
								</tr>
		
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			id="tab2">
			<tbody>
				<tr style="background-color: #EEEEEE;" height="25px">
		<td width="48%" style="padding-left:530px;'">
		<!-- <input type="button" value="审核批准" name="" onclick="" style="height:22px;"/> -->
		<table>
			<tbody>
				<tr>
					<td colspan="2">
						<div align="right">
							<input type="submit" id="verifyForm_0" value="审核批准"
								style="height: 22px;  font-size:12px;" onClick=changeStatus(2);;>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</td>
		<td width="52%">
			<!-- <input type="button" value="审核拒绝" name="" onclick="" style="height:22px;"/> -->
		<table>
			<tbody>
				<tr>
					<td colspan="2">
						<div align="right">
							<input type="submit" id="verifyForm_2" value="审核拒绝"
								style="height: 22px; margin-right: 100%; font-size:12px;"
							onClick=changeStatus(6);;>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
					</table>
				</form>
</body>
	</html>
</fmt:bundle>
