<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="ClientInfo" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="jsp/js/myhy.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>


<style>
	td{
		line-height:24px;
	}
	* {margin:0;padding:0;}
#imglist {list-style:none; width:500px; margin:50px auto;}
#imglist li {float:left; margin-top:10px;}

body,table{
 font-size:12px;
}
table{
 table-layout:fixed;
 empty-cells:show; 
 border-collapse: collapse;
 margin:0 auto;
}

h1,h2,h3{
 font-size:12px;
 margin:0;
 padding:0;
}
 
.title { background: #FFF; border: 1px solid #9DB3C5; padding: 1px; width:90%;margin:20px auto; }
 .title h1 { line-height: 31px; text-align:center;  background: #2F589C url(th_bg2.gif); background-repeat: repeat-x; background-position: 0 0; color: #FFF; }
  .title th, .title td { border: 1px solid #CAD9EA; padding: 5px; }
 
//样式一
table.tab_css_1{
 border:1px solid #cad9ea;
 color:#666;
 margin:0;
}

table.tab_css_1 td,table.tab_css_1 th{
 border:1px solid #cad9ea;
 padding:0 1em 0;
}
table.tab_css_1 td.td_css{
 background-color:#f5fafe;
}
</style>
</head>

<body>
			<form method="post">
			<input type="hidden" name="id" value="${clientJob.id }">
			
		<div id="gtop">
			<jsp:include page="../../incl/action.jsp">
			<jsp:param name="type" value="cancel" />
			<jsp:param name="key" value="Cancel" />
			<jsp:param name="action" value="ClientInfo.do" />
			<jsp:param name="method" value="list" />
			</jsp:include>
		</div>
		
		
		<table class="tab_css_1" width="98%" border="0" cellpadding="0" cellspacing="0" >
				<tbody>
				
					<tr height="10px">
			  			<c:out value="身份证号在下列合同中出现："/>
			  			<c:forEach var="selfIdNoList" items="${selfIdNoList}" varStatus="s">
								<a href='/mpay/ClientInfo.do?method=promptApproval&id=${selfIdNoList.clientJob.id }' ><c:out value="${selfIdNoList.clientJob.jobNo }"/>&nbsp;</a>
						</c:forEach>	
						<c:forEach var="spuseIdNoList" items="${spuseIdNoList}" varStatus="s">
								<a href='/mpay/ClientInfo.do?method=promptApproval&id=${spuseIdNoList.clientJob.id }' ><c:out value="${spuseIdNoList.clientJob.jobNo }"/></a>
						</c:forEach>				
					</tr>
					<tr height="10px">
						
			  			
					</tr>
					<tr height="10px">
						<c:out value="手机号在下列合同中出现："/>
			  			<c:forEach var="selfPhoneList" items="${selfPhoneList}" varStatus="s">
								<a href="/mpay/ClientInfo.do?method=promptApproval&id=${selfPhoneList.clientJob.id }"><c:out value="${selfPhoneList.clientJob.jobNo }"/>&nbsp;</a>
						</c:forEach>
						<c:forEach var="spusePhoneNoList" items="${spusePhoneNoList}" varStatus="s">
								<a href="/mpay/ClientInfo.do?method=promptApproval&id=${spusePhoneNoList.clientJob.id }"><c:out value="${spusePhoneNoList.clientJob.jobNo }"/>&nbsp;</a>
						</c:forEach>
					</tr>
					<tr height="10px">
						<c:out value="座机号在下列合同中出现："/>
			  			<c:forEach var="homePhoneNoList" items="${homePhoneNoList}" varStatus="s">
								<a href='/mpay/ClientInfo.do?method=promptApproval&id=${homePhoneNoList.clientJob.id }' ><c:out value="${homePhoneNoList.clientJob.jobNo }"/></a>
						</c:forEach>
					</tr>
					
					<tr height="10px">
		
						<td height="28" colspan="2" align="right">
							销售顾问代码:
						</td>
					  <td width="17%">&nbsp;<c:out value="${UserName}"/></td>
					  <td align="right"  >内部代码</td>
					  <td>
			             <c:out  value="${clientJob.privateKey}"/>
			          </td>
			          <td >&nbsp;</td>
					</tr>

		
		<tr>
			<td colspan="6" align="center" bgcolor="#D6D6D6" style="background-color:#eafef3; line-height: 28px">
				<h2><strong>客户基本信息</strong></h2>
			</td>
		</tr>
		<tr>
		
		</tr>		
				
			</tbody>
		</table>
		<table class="tab_css_1" width="98%" >
            		<tr>
		
                <td width="100px" align="center"  class="td_css"><strong>
                  销售顾问备注:
                </strong></td>
                <td width="88%">
                  <table class="tab_css_1" width="100%" border="1" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                              <td align="left" colspan="11"><c:out value="${clientJob.saleRemark }"/></td>
            
                            </tr>
                        </tbody>
                    </table>
                </td>
				</tr>
            </table>
		<table class="tab_css_1" width="98%" border="1" cellpadding="0" cellspacing="0" >
			<tbody>
				<tr>
                	<td rowspan="5" class="td_css" width="100px"><strong>
					  客户资料
					</strong></td>
					<td colspan="6" align="right"  class="td_css">
					客户照片:
					</td>
				<td align="left" colspan="2">
				<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;"><div id="innerdiv" style="position:absolute;"><img id="bigimg" style="border:5px solid #fff;" src="" /></div></div>
					<c:if test="${!empty  client.photoPath}">
						<img src='${client.photoPath} 'class="pimg" width="120" height="120">
					</c:if>
				</td>
		      </tr>
			<tr>
				<td align="right" id="guest_infoA"  class="td_css">
					姓名:
				</td>
				<td align="left" id="guest_infoB" style="padding-left:4px;">
					<c:out  value="${client.clientName}"/></td>
				<td align="right" id="guest_infoC" style="padding-left:4px;" class="td_css">
					SSI号码/学生号码:
		                            </td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><c:out   value="${ client.otherNo}"/></td>
				<td align="right" id="guest_infoE" class="td_css">
					性别:
		                            </td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><c:out   value="${ client.sex}"/></td>
				<td align="right" id="guest_infoG" class="td_css">
					申请人年龄:
				</td>
				<td align="left" id="guest_infoK" style="padding-left:4px;"><c:out   value="${ client.age}"/></td>
		
		  </tr>
			<tr>
				<td align="right"  class="td_css">
					身份证号码:
				</td>
				<td align="left" id="guest_infoB"   ><c:out   value="${client.idNo}"/></td>
		
				<td align="right" class="td_css" >
					住宅电话登记人
				</td>
				<td align="left"  style="padding-left:4px;"><c:out  value="${ client.homePhoneName}" /></td>
				<td align="right"  class="td_css">
					身份证截止日期:
				</td>
				<td align="left" i style="padding-left:4px;"><fmt:formatDate value="${client.idEndDate}" type="date" pattern="yyyy-MM-dd"/></td>
				<td align="right" class="td_css">
					发证机关:
				</td>
				<td align="left"  style="padding-left:4px;"><c:out  value="${ client.idAuthority}" /></td> 
		  </tr>
			<tr>
		
				<td align="right" class="td_css">
					住房:
				</td>
				<td align="left"  style="padding-left:4px;"><c:out  value="${ client.housing}" /></td>
				<td align="right" class="td_css">
					教育程度:
				</td>
				<td align="left" style="padding-left:4px;"><c:out  value="${client.educationId }"/></td>
				<td align="right" class="td_css">
					婚姻状况:
				</td>
				<td align="left"  style="padding-left:4px;"><c:out value="${client.marry }" /></td>
				<td align="right" class="td_css">
					子女数目:
				</td>
				<td align="left" id="guest_infoK" style="padding-left:4px;"><c:out  value="${client.childs }"/></td>
		
		  </tr>
			<tr>
		
				<td align="right" class="td_css" >
					配偶姓名:
				</td>
				<td align="left" id="guest_infoB" style="padding-left:4px;"><c:out  value="${client.spuseName}"/></td>
				<td align="right" class="td_css">
					身份证号码:
				</td>
				<td align="left"  style="padding-left:4px;"><c:out value="${client.idSpuse}"/></td>
				<td align="right" class="td_css">
					电子邮箱:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><c:out  value="${client.homePhone}"/></td>
		
		
							<td align="right" id="guest_infoG"></td>
							<td align="left" id="guest_infoK"></td>
					  </tr>
					</tbody>
				</table>
                
                <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        <td align="center" class="td_css" width="100px">
                        <strong>户籍地址</strong>
                        </td>
							<td >

												<c:out 
													  value="${censusAddressBook.province }" />
		          	 		</td>
							<td >
								
												<c:out 
													  value="${censusAddressBook.city }" />	
		           			</td>
							<td >
						  
												<c:out  value="${censusAddressBook.county }" />				
		           			</td>
							<td >
								
												<c:out 
													  value="${censusAddressBook.town}" 
										  />				
		        			</td>
							<td>
									<c:out 
										  value="${censusAddressBook.street}"  />
                             </td>
							<td>
									<c:out
										  value="${censusAddressBook.community}" 
										 />							</td>
							
							<td>
									<c:out 
										 value="${censusAddressBook.houseNo}" 
										 />
		        				</td>
		
								<td>
									<c:out 
										 value="${censusAddressBook.other}" />
								</td>
		
				<td align="right"  class="td_css">
					邮编:
				</td>
				<td>
									<c:out 
										  value="${censusAddressBook.zipCode}" />
				</td>
						</tr>
					</tbody>
				</table>
                <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
							<td align="center"  width="100px" class="td_css"><strong>
			 				 现居住地址
						</strong></td>
											<td>
												<c:out 
													  value="${livingAddressBook.province}" 
										 />
								</td>
							
				
								<td>
									<c:out 
										  value="${livingAddressBook.city}"   />
								</td>
							
								<td>
									<c:out 
										  value="${livingAddressBook.county}"   />
								</td>
							
								<td>
									<c:out 
										 value="${livingAddressBook.town}" 
										/>
								</td>
							
                            
								<td>
									<c:out
										 value="${livingAddressBook.street}" />
								</td>
							
                            
								<td>
									<c:out
										
										 value="${livingAddressBook.community}" />
								</td>
							
                            
								<td>
									<c:out 
										 value="${livingAddressBook.houseNo}"
									/>
								</td>
							
		
				<td  class="td_css" align="center">
					居住(月):<c:out 	value="${contract.nowMonth}" />
				</td>
				<td align="right" class="td_css">
					邮编:
				</td>
				
								<td>
									<c:out value="${livingAddressBook.zipCode}"  />
											</td>
						</tr>
					</tbody>
				</table>
                
                <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
							<td align="center" width="100px"  class="td_css"><strong> 公司地址</strong></td>
											<td>
												<c:out
													value="${officeAddressBook.province}" 
										/>
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.city}" />
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.county}" 
										/>
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.town}" 
										/>
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.street}"   />
								</td>
							
								<td>
									<c:out
										
										value="${officeAddressBook.community}" 
										
										/>
								</td>
							
								<td>
									<c:out 
										 value="${officeAddressBook.houseNo}" 
										
										/>
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.other}" 
										/>
								</td>
				<td align="right"  class="td_css">
					邮编:
				</td>
							<td>
									<c:out
										value="${officeAddressBook.zipCode}" 
												/>
											</td>
						</tr>
					</tbody>
				</table>
                
                <table class="tab_css_1" width="98%">
					<tbody>
						<tr>
							<td align="center" width="100px"  class="td_css" ><strong>家庭成员地址</strong></td>
											<td>
												<c:out 
													value="${homeAddressBook.province}" />
								</td>
							
								<td>
									<c:out value="${homeAddressBook.city}" />
										
								</td>
								<td>
									<c:out value="${homeAddressBook.county}" />
								</td>
							
								<td>
									<c:out  value="${homeAddressBook.town}" />
								</td>
						
								<td>
									<c:out  value="${homeAddressBook.street}" />
								</td>
							
								<td>
									<c:out
										
										  value="${homeAddressBook.community}" />
								</td>
							
								<td>
									<c:out  value="${homeAddressBook.houseNo}" />
								</td>
							
								<td>
									<c:out value="${homeAddressBook.other}"/>
								</td>
							
				<td align="right"  class="td_css">
					邮编:
				</td>
				
								<td>
									<c:out value="${homeAddressBook.zipCode}" 
													/>
											</td>
						</tr>
					</tbody>
				</table>
                
                <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td rowspan="2" width="100px" class="td_css" ><strong>联系人信息</strong></td>
                            
							<td  align="right"  class="td_css">
								家庭成员名称:
							</td>
						  <td  >
								 <c:out  value="${client.homeName}"/>
			 				 </td>
                            <td  align="right" class="td_css" >
                                家庭成员类型:
                            </td>
                          <td style="padding-left:4px;">
                                <c:out  value="${client.homeType}" />
                          </td>
                            <td  align="right" class="td_css" >
                                家庭成员电话号:
                            </td>
                            <td >
                                <c:out  value="${client.homeTelephone}" />
                          </td>
			</tr>
			<tr>
            	<td align="right"  class="td_css">
					联系人姓名:
				</td>
				<td   style="padding-left:4px;">
				  <c:out  value="${client.otherContacts}" />
				</td>
				<td align="right"  class="td_css">
					与申请人关系:
				</td>
			  <td  style="padding-left:4px;">
				  <c:out  value="${client.otherNexus}" />
			  </td>
				<td align="right"  class="td_css">
					联系电话:
				</td>
				<td id="guest_info66" style="padding-left:4px;">
					<c:out  value="${client.otherPhone}" />
				</td>
						</tr>
					</tbody>
				</table>
                
          <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td rowspan="3" width="100px" class="td_css" ><strong>电话</strong></td>	
						  <td align="right"  class="td_css">
								本人手机号&nbsp;:			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;">							
			  	<c:out    value="${client.mobilePhone }"/>
			</td>
				<td align="right"  class="td_css">
					手机号码归属地:
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><c:out   value="${client.mobileAddress }"/></td>
				<td align="right"  class="td_css">
					住宅电话登记人:
				</td>
				<td align="left"   style="padding-left:4px;"><c:out   value="${client.homePhoneName }"
		  /></td>
							<td align="right" class="td_css">
								住宅/宿舍电话:
							</td>
							<td align="left" id="guest_infoK" style="padding-left:4px;"><c:out value="${client.homePhone }"/></td>
		
		
			</tr>
			<tr>
			  <td align="right"  class="td_css">
					办公电话&nbsp;:
			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;"><c:out   value="${client.onOfficePhone }"/></td>
							<td align="right"  class="td_css">
								办公电话分机:
							</td>
							<td align="left" id="guest_infoD" style="padding-left:4px;"><c:out value="${client.onExtPhone }"/></td>
				<td align="right" id="guest_infoE">家庭成员电话号</td>
				<td align="left" id="guest_infoF"><c:out value="${ client.homeTelephone}"/></td>
				<td align="right" id="guest_infoG"></td>
				<td align="left" id="guest_infoK"></td>
			</tr>
			<tr>
			  <td align="right"  class="td_css">
					配偶移动电话:
			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;"><c:out  value="${client.spuseMobile }"/></td>
				<td align="right"  class="td_css">
					配偶办公电话:
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><c:out  value="${client.spuseOfficePhone }"/></td>
				<td align="right"  class="td_css">
					配偶办公电话分机:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><c:out   value="${client.spuseExtPhone }"/></td>
				<td align="right"  class="td_css">
					配偶雇主:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><c:out   value="${client.spuseHirer }"
		  /></td>
		
						</tr>
					</tbody>
				</table>
                
            <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td width="100px"  rowspan="2" class="td_css"><strong>所在单位信息</strong></td>	
							<td width="125px" align="right" class="td_css">
								单位名称或大学名称:
							</td >
							<td width="127px">
												<c:out  value="${client.onShortName }"/>
								</td>
							
				<td width="125px" align="right"  class="td_css">
					单位/学校/个体全称:
				</td>
				
								<td width="11%">
									<c:out value="${client.onFullName }"
										   />
								</td>

				<td width="11%" align="right" class="td_css">
					单位性质:
				</td>
				
								<td width="12%">
									<c:out  value="${client.onFeature }"
										   />
								</td>
			
				<td width="10%" align="right" class="td_css">
					任职部门或班级:
				</td>
				
				      <td width="12%"><c:out  value="${client.onDivision }"
										   /></td>
			       
			</tr>
			<tr>
				<td align="right" class="td_css">
					行业类别:
				</td>
				
								<td>
								<c:out  value="${client.onSector }"
										  />
								</td>
						
		
				<td align="right"  class="td_css">
					职位:
				</td>
				
								<td>
									 <c:out  value="${client.onOffice }"
										  />
								</td>
							
				<td align="right" class="td_css">
					<p>
						总共工作经脸/总共大学学习时间:
					</p>
				</td>
								<td>
									<c:out  value="${client.onWorkTime }"
													  />
											</td>
										
							<td align="right" class="td_css" >
								现工作时间/大学开始时间(年):
							</td>
							
											<td>
												<label id="verifyForm_contract_xxStartTime"
													   >
													60
												</label>
											</td>
						</tr>
					</tbody>
				</table>    
                
                <table class="tab_css_1" width="98%">
					<tbody>
						<tr>
                        <td align="center" width="100px" class="td_css" ><strong> 收入资料</strong></td>
							<td align="right"  class="td_css">
								月收入总额(元):
							</td>
							<td align="left" id="guest_infoB" style="padding-left:4px;">
                                <c:out value="${client.masterInMonth }"  />
                          </td>
                            <td align="right"  class="td_css">
                                其他收入(元/月):
                            </td>
                            <td align="left" id="guest_infoD" style="padding-left:4px;">
                                <c:out  value="${client.otherInMonth }"/>
						  </td>
							<td align="right" class="td_css">
								其他收入来源:
							</td>
							<td align="left" id="guest_infoF" style="padding-left:4px;">
					<c:out value="${client.otherIncome }"/>
						  </td>
							<td align="right" class="td_css">
								家庭月收入(元):
							</td>
							<td align="left" id="guest_infoK" style="padding-left:4px;">
					<c:out  value="${client.homeInMonth }"/>
						  </td>
					  </tr>
					</tbody>
				</table>
             
             <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td rowspan="2" width="100px" class="td_css"><strong> 文件</strong></td>
							<td id="guest_infoM">
								<table class="tab_css_1">
		
									<tbody>
										<tr>
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
					<table class="tab_css_1">
		
						<tbody>
							<tr>
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
					<table class="tab_css_1">
		
						<tbody>
							<tr>
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
					<table class="tab_css_1">
		
						<tbody>
							<tr>
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
		
					<table class="tab_css_1">
		
						<tbody>
							<tr>
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
					<table class="tab_css_1">
		
						<tbody>
							<tr>
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
					<table class="tab_css_1">
		
						<tbody>
							<tr>
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
					<table >
		
						<tbody>
							<tr>
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
					<table class="tab_css_1">
						<tbody>
							<tr>
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
					<table class="tab_css_1">
						<tbody>
							<tr>
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
					<table class="tab_css_1">
		
						<tbody>
							<tr>
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
					<table class="tab_css_1">
		
						<tbody>
							<tr>
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
					<table class="tab_css_1">
						<tbody>
							<tr>
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
            <table class="tab_css_1" width="98%" border="1" cellpadding="0" cellspacing="0" >    
                <tr>
			<td width="100px" align="center"  class="td_css"><strong>
			  上传的图片
			</strong></td>
			<td width="88%" colspan="7">
			  <table class="tab_css_1" id="uploadfile">
		
					<tbody>
						<tr>
						<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;"><div id="innerdiv" style="position:absolute;"><img id="bigimg" style="border:5px solid #fff;" src="" /></div></div>
						<c:forEach var="clientDoc" items="${clientDocs}" varStatus="s">
							<td>
							<a href="${clientDoc.filepath}">附件${s.index }</a>
							</td>
							</c:forEach>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
        </table>
        <table class="tab_css_1" width="98%" >
        
        					<c:forEach var="sale" items="${sales}" varStatus="s">
								<tr  >
									<th colspan="6" align="left" class="tr8"><strong>商品 ${s.index }</strong></th>
								</tr>
								<tr>
			
									<td align="right"  ><b style="color:red">*</b> 商品 ${s.index }</td>
									<td align="left"><c:out value="${sale.saleName}"/></td>
									<td align="right"  >商品类型</td>
							        <td align="left"></td>
								    <td align="right"  >价格（元）</td>
									<td align="left"><c:out value="${sale.salePrice}"/></td>
								</tr>
								
								<tr>

									<td align="right"  >品牌</td>
									<td align="left"><c:out value="${sale.brand}"/></td>
									<td align="right"  >型号</td>
							        <td align="left"><c:out value="${sale.modelNo}"/></td>
								    <td align="right"  ></td>
									<td></td>
								</tr>
							</c:forEach>
				</table>
        	
            
        	<table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td rowspan="2" width="100px" class="td_css"><strong> 信用信息 </strong></td>
							<td align="right"  class="td_css">
								产品:
							</td>
							<td align="left" id="guest_info52" style="padding-left:4px;"><c:out value="${financialProduct.financialName }"/></td>
						<td align="right"  class="td_css">
							商品总价:
						</td>
					  <td align="left" id="guest_info54" style="padding-left:4px;"><c:out    value="${clientJob.totalPrice }"  /></td>
						<td align="right" class="td_css">
							贷款用途:
						</td>
					  <td align="left" id="guest_info56" style="padding-left:4px;"><c:out   value="${clientJob.byUse }"/></td>
						<td align="right"  class="td_css">
							自付金额(元):
						</td>
					  <td align="left" id="guest_info58" style="padding-left:4px;"><c:out   value="${clientJob.selfAmount }"/></td>
						<td align="right"  class="td_css">
							分期期数:
						</td>
					  <td align="left" id="guest_info60" style="padding-left:4px;"><c:out value="${financialProduct.cycleTotal }"/> </td>
		  </tr>
								</tbody>
							</table>
		<table class="tab_css_1"  width="98%">
				<tr>
				<td rowspan="2" width="100px" class="td_css"><strong> 银行卡信息 </strong></td>
				<td align="right"  class="td_css">
					每月还款额(元):
				</td>
			  <td align="left" id="guest_info52" style="padding-left:4px;"><c:out value="${clientJob.monthOfPay }"  /></td>
				<td align="right"  class="td_css">
					贷款本金(元):<c:out value="${clientJob.totalPrice-clientJob.selfAmount } "/>
				</td>
				
			  <td align="left" id="guest_info56" style="padding-left:4px;"></td>
				<td align="right"  class="td_css">
					每月还款日:
				</td>
			  <td align="left" id="guest_info58" style="padding-left:4px;"><fmt:formatDate value="${clientJob.monthOfDate}" type="date" pattern="yyyy-MM-dd"/></td>
		
				<td align="right"  class="td_css">
					<label for="contract.crAgentPay-1"
										class="checkboxLabel">
										银行代扣还款
									</label>
				</td>
				<td align="left" id="guest_info60" style="padding-left:4px;" > 
		                                      					<input type="checkbox" name="contract.crAgentPay"
										value="银行代扣还款" id="contract.crAgentPay-1"
										checked="checked" disabled="disabled" size="10">
		        </td>
		        <td></td><td></td>
		  </tr>
		
			

				
				<c:forEach var="bank" items="${banks}" varStatus="s">
				<tr>
								<td align="right"   class="td_css">
					客户银行卡号/账号:
				</td>
			  <td align="left" id="guest_info52" style="padding-left:4px;"><c:out   value="${bank.debitCard }" /></td>
							<td align="right" class="td_css">
								客户开户银行:
							</td>
						  <td align="left" id="guest_info54" style="padding-left:4px;"><c:out   value="${bank.bankName }"
	 /></td>
							<td align="right" class="td_css">
								月花费(元/月):
							</td>
						  <td align="left" id="guest_info56" style="padding-left:4px;"><c:out   value="${bank.monthPay }"/></td>
					</tr>	
				</c:forEach>
							
		</table>

		 
		 
		<table class="tab_css_1" width="100%" cellpadding="0" cellspacing="0"
			style="display: none;">
		
		<tbody>
			<tr>
				<td colspan="2">
					<table class="tab_css_1">
						<tbody>
							<tr>
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
		
		<table class="tab_css_1" width="98%" >
            		<tr>
		
                <td width="100px" align="center"  class="td_css"><strong>
                  销售顾问备注:
                </strong></td>
                <td width="88%">
                  <table class="tab_css_1" width="100%" border="1" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                              <td align="left" colspan="11">&nbsp;</td>
            
                            </tr>
                        </tbody>
                    </table>
                </td>
				</tr>
            </table>
				<tbody>
					<tr> 
							<td> <center><strong><h2>审批日志</h2></strong></center></td>
					</tr>
				</tbody>
			</table>
		<table class="tab_css_1" width="98%">
            <tbody>
            <tr>
					<td  class="textr"><fmt:message key="ID"/></td>
					<td  class="textr"><fmt:message key="UserName"/></td>
					<td  class="textr"><fmt:message key="JobType"/></td>
					<td  class="textr"><fmt:message key="JobRemark"/></td>
					<td  class="textr"><fmt:message key="JobDate"/></td>
					
				</tr>
				<c:forEach var="clientJobTracks" items="${clientJobTracks}" varStatus="status">
				<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
				<td><c:out value="${clientJobTracks.clientJobTrack.id}"></c:out>  </td>
				<td><c:out value="${clientJobTracks.user.name }"/></td>
				<td><c:out value="${clientJobTracks.jobType.jobKey }"/></td>
				<td><c:out value="${clientJobTracks.clientJobTrack.jobRemark }"/></td>
				<td><fmt:formatDate value="${clientJobTracks.clientJobTrack.jobDate }" type="both" /></td>
				</tr>
				</c:forEach>
				</tbody>
		</table>

		</form>
</body>
	</html>
</fmt:bundle>
