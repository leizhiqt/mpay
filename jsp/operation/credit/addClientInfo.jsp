<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="ClientInfo"/></title>
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
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="processBatchAdd"/>
	</jsp:include>
	<jsp:include page="../../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="ClientInfo.do"/>
		<jsp:param name="method" value="listClientInfo"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../../incl/b_message.jsp" %>

<div>
			<div>
					<table width="100%" border="1" cellpadding="0" cellspacing="0">
						<tr height="10px" style="border:1px solid #FFF;">

							<td colspan="" align="right">销售顾问代码</td>
							<td><table>
									<input type="text" name="user.userId" readonly="true" />
								</table></td>
							<td align="right">*  内部代码</td>
							<td><table>
								</table></td>
							<td></td>
							<td>(*)必填项</td>

						</tr>
						<tr>
							<td colspan="6" align="center"
								style="background-color:#0285c7;line-height:28px">客户基本信息</td>
						</tr>
						<tr>
							<td align="left" colspan="6" class="tr8">客户资料</td>
						</tr>
						<tr>
							<td id="guest_info2">* 客户照片上传</td>
							<td id="guest_info4" align="left" colspan="2"><table style="border:0">
									<input style="display:none" type=text disabled=true id=filesize>
									<input type=file style="height:30px;align:left"  isempty=false name=upload onchange="checkfile(this,'filesize')">
								</table></td>

							
							<td id="guest_info5"></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  姓名</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.clientName"   maxlength="10"/>
								</table></td>
							<td id="guest_info4"></td>
							<td id="guest_info5"></td>
							<td id="guest_info6">*  身份证号码</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.idNo"  dtype="identity" onblur="calcIdCard()"/>
								</table></td>
						</tr>
						<tr>
							

							<td align="right" id="guest_info2">  身份证截止日期</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.idEndDate"  id="validity" 
									 onclick="displayCalendar(this,'yyyy-mm-dd',this)"/>
								</table></td>
							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<html:checkbox    name="client.isLongTime"  cssStyle="margin-left:10px"
									 onclick="checkV()" >
									</html:checkbox>
								</table></td>
							<td id="guest_info6">*  发证机关</td>
							<td id="guest_info7"><table>
									<input type="text"
										name="client.idAuthority"    maxlength="50"/>
								</table></td>
						</tr>

						
						<tr>
							<td id="guest_info2">  SSI号码/学生号码</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.otherNo"/>
								</table></td>
							<td id="guest_info4">* 申请人年龄</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.age"   dtype="number"/>
								</table></td>
							<td id="guest_info6">*  手机号</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.mobilePhone"   dtype="mobile" onblur="getphonearea(this.value)"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">* 性别</td>
							<td id="guest_info3"><table>
							<select name="client.sex"  id ="sex" onchange="document.getElementById('sex').value += ' ' + this.options[this.selectedIndex].text" width="95%">
							  <option value ="男">男</option>
							  <option value ="女">女</option>
							</select>
							
								</table></td>
							<td id="guest_info4">* 婚姻状况</td>
							<td id="guest_info5"><table>
							<select name="client.marry"  id ="marry" onchange="document.getElementById('marry').value += ' ' + this.options[this.selectedIndex].text">
							  <option value ="未婚">未婚</option>
							  <option value ="已婚">已婚</option>
							  <option value="离异">离异</option>
							  <option value="丧偶">丧偶</option>
							</select>
									
								</table></td>
							<td id="guest_info6">*  手机号码归属地</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.mobileAddress"   />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">子女数目</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.childs"  dtype="number"/>
								</table></td>
							<td id="guest_info4">*  住房</td>
							<td id="guest_info5"><table>
							<select  id ="housing" onchange="document.getElementById('housing').value += ' ' + this.options[this.selectedIndex].text">
							  <option value ="自有房">自有房</option>
							  <option value ="租房">租房</option>
						    </select>
								</table></td>
							<td id="guest_info6">*  教育程度</td>
							<td id="guest_info7"><table>
									<select name="client.educationId" id="educationId" onchange="document.getElementById('educationId').value += ' ' + this.options[this.selectedIndex].text">
										  <option value =1>大學</option>
										  <option value =2>高中</option>
									</select>
								</table></td>
						</tr>
						<tr>
							<td >  住宅电话登记人</td>
							<td ><table>
									<input type="text"
										name="client.homePhoneName" maxlength="20"/>
								</table></td>
							<td id="guest_info4">住宅/宿舍电话</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.homePhone" />
								</table></td>
							<td id="guest_info6">  电子邮箱</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.email"  dtype="email"/>
								</table></td>
						</tr>

						<tr>
							<td colspan="6" align="left" class="tr8">配偶资料</td>

						</tr>
						<tr>
							
							<td id="guest_info2">  配偶姓名</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.spuseName" maxlength="20"/>
								</table></td>
							<td id="guest_info4">配偶移动电话</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.spuseMobile"  dtype="mobile"/>
								</table></td>
							<td id="guest_info6">  身份证号码</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.idSpuse" dtype="identity"/>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">  配偶雇主</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.spuseHirer" maxlength="20"/>
								</table></td>
							<td id="guest_info4">配偶办公电话</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="client.spuseOfficePhone"  dtype="mobile"/>
								</table></td>
							<td id="guest_info6">配偶办公电话分机</td>
							<td id="guest_info7"><table>
									<input type="text"
										name="client.spuseExtPhone"  dtype="mobile" />
								</table></td>
						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">户籍地址</td>

						</tr>
						<tr>
							
							<td id="guest_info2">邮编</td>
							<td id="guest_info3"><table>
									<input type="text" name="censusAddressBook.zipCode"  isempty="true" dtype="number" maxlength="20"/>
								</table></td>
							<td id="guest_info4">*  省/直辖市</td>
							<td id="guest_info5"><table>
									<select id="province1" name="censusAddressBook.province" onchange="document.getElementById('province1').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="四川省">四川省</option>
								  		<option value ="湖南省">湖南省</option>
								  		<option value ="河北省">河北省</option>
									</select>
								</table></td>
							<td id="guest_info6">*  市</td>
							<td id="guest_info7"><table>
									<select id="city1" name="censusAddressBook.city" onchange="document.getElementById('city1').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="成都市">成都市</option>
								  		<option value ="內江市">內江市</option>
									</select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">*  区/县区</td>
							<td id="guest_info3"><table>
									<input type="text" name="censusAddressBook.county"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  镇</td>
							<td id="guest_info5"><table>
									<input type="text" name="censusAddressBook.town"  maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  街道/路/村</td>
							<td id="guest_info7"><table>
									<input type="text" name="censusAddressBook.street"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  小区/楼盘</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="censusAddressBook.community"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  栋/单元/房间号</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="censusAddressBook.houseNo"  isempty="true" maxlength="20"/>
								</table></td>
							<td id="guest_info6">其它</td>
							<td id="guest_info7"><table>
									<input type="text" name="censusAddressBook.other"  isempty="true" maxlength="50"/>
								</table></td>
						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">现居住地址</td>

						</tr>
						<tr>
							<td id="guest_info2">现居住地地址同户籍地址</td>
							<td align="center" id="guest_info3"><input type="checkbox" onclick="autoFillAddress(this, 'now');" style="margin-left:10px"/></td>
							<td id="guest_info4">你在现居住城市住了多久？</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.nowMonth"
										 />
								</table></td>
							<td align="left" style="background-color:#EEEEEE" >月</td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2">  邮编</td>
							<td id="guest_info3"><table>
									<input type="text" name="livingAddressBook.zipCode"  dtype="number" maxlength="10"/>
								</table></td>
							<td id="guest_info4">*  省/直辖市</td>
							<td id="guest_info5"><table>
									<select id="province2" name="livingAddressBook.province" onchange="document.getElementById('province2').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="四川省">四川省</option>
								  		<option value ="湖南省">湖南省</option>
								  		<option value ="河北省">河北省</option>
									</select>
								</table></td>
							<td id="guest_info6">*  市</td>
							<td id="guest_info7"><table>
									<select id="city2" name="livingAddressBook.city" onchange="document.getElementById('city2').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="成都市">成都市</option>
								  		<option value ="內江市">內江市</option>
									</select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">*  区/县区</td>
							<td id="guest_info3"><table>
									<input type="text" name="livingAddressBook.county"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  镇</td>
							<td id="guest_info5"><table>
									<input type="text" name="livingAddressBook.town"  maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  街道/路/村</td>
							<td id="guest_info7"><table>
									<input type="text" name="livingAddressBook.street"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  小区/楼盘</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="livingAddressBook.community"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  栋/单元/房间号</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="livingAddressBook.houseNo"  isempty="true" maxlength="20"/>
								</table></td>
							
						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">家庭信息</td>

						</tr>
						<tr>
							<td id="guest_info2">*  家庭成员名称</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.homeName"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">*  家庭成员类型</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.homeType"  "/>
								</table></td>
							<td id="guest_info6">家庭成员电话号</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.homeTelephone"  "/>
								</table></td>
						</tr>
						<tr>
							<td id="guest_info2">家庭成员地址与户籍地址相同</td>
							<td id="guest_info3"><input type="checkbox"  onclick="autoFillAddress(this, 'fa');" style="margin-left:10px"/></td>
							<td id="guest_info4"></td>
							<td id="guest_info5"></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2">邮编</td>
							<td id="guest_info3"><table>
									<input type="text" name="homeAddressBook.zipCode"  isempty="true" dtype="number" maxlength="20"/>
								</table></td>
							<td id="guest_info4">*  省/直辖市</td>
							<td id="guest_info5"><table>
									<select id="province3" name="homeAddressBook.province" onchange="document.getElementById('province3').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="四川省">四川省</option>
								  		<option value ="湖南省">湖南省</option>
								  		<option value ="河北省">河北省</option>
									</select>
								</table></td>
							<td id="guest_info6">*  市</td>
							<td id="guest_info7"><table>
									<select id="city3" name="homeAddressBook.city" onchange="document.getElementById('city3').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="成都市">成都市</option>
								  		<option value ="內江市">內江市</option>
									</select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">*  区/县区</td>
							<td id="guest_info3"><table>
									<input type="text" name="homeAddressBook.county"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  镇</td>
							<td id="guest_info5"><table>
									<input type="text" name="homeAddressBook.town"  maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  街道/路/村</td>
							<td id="guest_info7"><table>
									<input type="text" name="homeAddressBook.street"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  小区/楼盘</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="homeAddressBook.community"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  栋/单元/房间号</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="homeAddressBook.houseNo"  isempty="true" maxlength="20"/>
								</table></td>
							<td id="guest_info6">其它</td>
							<td id="guest_info7"><table>
									<input type="text" name="homeAddressBook.other"  isempty="true" maxlength="50"/>
								</table></td>
						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">其他联系人资料</td>

						</tr>
						<tr>
							
							<td id="guest_info2">* 联系人姓名</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.otherContacts" />
								</table></td>
							<td id="guest_info4">与申请人关系</td>
							<td id="guest_info5"><table>
									<select id="otherNexus" name="client.otherNexus" onchange="document.getElementById('otherNexus').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="朋友">朋友</option>
								  		<option value ="亲戚">亲戚</option>
									</select>
								</table></td>
							<td id="guest_info6">* 联系电话</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.otherPhone"  dtype="mobile" />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2" > 销售顾问备注</td>
							<td align="left" colspan="5"><table>
									<input type="text" name="client.oSa"
										size="135" />
								</table></td>

						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">文件</td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
							
									<input type="checkbox"  name="contract.fIdCode">身份证
									</input>
								</table></td>

							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<input type="checkbox"  name="contract.fSocialCard">社保卡
									</input>
								</table></td>

							<td id="guest_info6"></td>
							<td id="guest_info7"><table>
									<input type="checkbox"  name="contract.fWorkCard">工卡
									</input>
								</table></td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<input type="checkbox"  name="contract.fBankCard">银行卡
									</input>
								</table></td>

							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<input type="checkbox" 
										name="contract.fBankStatement">银行对账单
									</input>
								</table></td>

							<td id="guest_info6"></td>
							<td id="guest_info7"><table>
									<input type="checkbox" 
										name="contract.fBankDeposit">银行存折
									</input>
								</table></td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<input type="checkbox"
										name="contract.fResidenceBooklet" cssClass="inputStyle" >户口本
									</input>
								</table></td>

							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<input type="checkbox"  name="contract.fSid" cssClass="inputStyle" >大学学生证
									</input>
								</table>
							<td id="guest_info6"></td>
							<td id="guest_info7"><table>
									<input type="checkbox" 
										name="contract.fUid" cssClass="inputStyle" >大学学生证明":"大学学生证明（仅适用全日制大学学生）
									</input>
								</table></td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<input type="checkbox"  name="contract.fHouseCard">房产证
									</input>
								</table></td>
							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<input type="checkbox"  name="contract.fDirvingCard">行驶证
									</input>
								</table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"><table>
									<input type="checkbox" name="contract.fDirverCard">驾驶证
									</input>
								</table></td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<input type="checkbox" name="contract.fOther">其它
									</input>
								</table></td>

							<td id="guest_info4"></td>

							<td id="guest_info5"></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<input type="button" value="上传各种证件图片" onclick="addfile()" style="height:25px"/>
								</table></td>
							<td colspan=2><table id="uploadfile"></table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2">邮寄地址</td>
							<td id="guest_info3">
							   <table>
									<select id="postAddress" name="postAddress" onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="成都市">成都市</option>
								  		<option value ="重庆市">重庆市</option>
									</select>
								</table></td>
							<td id="guest_info4"></td>
							<td id="guest_info5"></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>


						<tr>
							<td colspan="6" align="left" class="tr8">收入资料</td>

						</tr>
						<tr>
							
							<td  id="guest_info2">*  月收入总额(元)</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="client.masterInMonth"   dtype="float" maxlength="10"/>
								</table></td>
							<td  id="guest_info4">  其他收入(元/月)</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="client.otherInMonth" dtype="float" maxlength="10"/>
								</table></td>
							<td  id="guest_info6">*  家庭月收入(元)</td>
							<td id="guest_info7"><table>
									<input type="text"
										name="client.homeInMonth"   dtype="float" maxlength="10"/>
								</table></td>
						</tr>
						<tr>
							
							<td  id="guest_info2"></td>
							<td id="guest_info3"></td>
							<td  id="guest_info4">  其他收入来源</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="client.otherIncome"  maxlength="10"/>
								</table></td>
							<td  id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						
						<tr>
							<td colspan="6" align="left" class="tr8">所在单位信息</td>

						</tr>
						<tr>
							<td id="guest_info2">*  单位名称或大学名称</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.onShortName"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">*  单位/学校/个体全称</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.onFullName"   maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  任职部门或班级</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.onDivision"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							<td id="guest_info2">*  总共工作经脸/总共大学学习时间</td>
							<td id="guest_info3"><table>
									<select id="onWorkTime" name="client.onWorkTime" onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="0-1年">0-1年</option>
								  		<option value ="0-1年">1-2年</option>
								  		<option value ="0-1年">2-3年</option>
								  		<option value ="0-1年">3-5年</option>
								  		<option value ="0-1年">5-10年</option>
								  		<option value ="0-1年">'>'10年</option>
									</select>
								</table></td>
							<td id="guest_info4">*  现工作时间/大学开始时间(以月为单位)</td>
							<td id="guest_info5"><table>
									<input type="text" name=""   dtype="number"  maxlength="20"/>
								</table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2"> * 行业类别</td>
							<td id="guest_info3"><table>
									<select id="onWorkTime" name="client.onSector" onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="IT">IT</option>
								  		<option value ="金融">金融</option>
									</select>
								</table></td>
							<td id="guest_info4">* 职位</td>
							<td id="guest_info5"><table>
									<select id="onOffice" name="client.onSector" onchange="document.getElementById('onOffice').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="经理">经理</option>
								  		<option value ="总监">总监</option>
									</select>
								</table></td>
							<td id="guest_info6">单位性质</td>
							<td id="guest_info7"><table>
									<select id="onFeature" name="client.onFeature" onchange="document.getElementById('onFeature').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="国有企业">国有企业</option>
								  		<option value ="私有企业">私有企业</option>
									</select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">*  办公电话</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="client.xxOfficePhone"    maxlength="20" dtype="mobile"/>
								</table></td>
							<td id="guest_info4">办公电话分机</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.onOfficePhone"  dtype="mobile"/>
								</table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2">邮编</td>
							<td id="guest_info3"><table>
									<input type="text" name="officeAddressBook.zipCode"  isempty="true" dtype="number" maxlength="20"/>
								</table></td>
							<td id="guest_info4">*  省/直辖市</td>
							<td id="guest_info5"><table>
									<select id="province4" name="officeAddressBook.province" onchange="document.getElementById('province4').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="四川省">四川省</option>
								  		<option value ="湖南省">湖南省</option>
								  		<option value ="河北省">河北省</option>
									</select>
								</table></td>
							<td id="guest_info6">*  市</td>
							<td id="guest_info7"><table>
									<select id="city4" name="officeAddressBook.city" onchange="document.getElementById('city4').value += ' ' + this.options[this.selectedIndex].text">
								  		<option value ="成都市">成都市</option>
								  		<option value ="內江市">內江市</option>
									</select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">*  区/县区</td>
							<td id="guest_info3"><table>
									<input type="text" name="officeAddressBook.county"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  镇</td>
							<td id="guest_info5"><table>
									<input type="text" name="officeAddressBook.town"  maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  街道/路/村</td>
							<td id="guest_info7"><table>
									<input type="text" name="officeAddressBook.street"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  小区/楼盘</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="officeAddressBook.community"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  栋/单元/房间号</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="officeAddressBook.houseNo"  isempty="true" maxlength="20"/>
								</table></td>
							<td id="guest_info6">其它</td>
							<td id="guest_info7"><table>
									<input type="text" name="officeAddressBook.other"  isempty="true" maxlength="50"/>
								</table></td>
						</tr>

						<tr>
							<td colspan="6" align="left" class="tr8">商品1</td>

						</tr>
						<tr>
							
							<td  id="guest_info2">商品</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.g1Type" />
								</table></td>
							<td  id="guest_info4">商品类型</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.g1Form" />
								</table></td>
							<td id="guest_info6">价格（元）</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.g1Price" dtype="float" />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">品牌</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.g1Brand" />
								</table></td>
							<td id="guest_info4">型号</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.g1Model" />
								</table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">信用信息</td>

						</tr>
						<tr>
							
							<td  id="guest_info2">产品</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.crProduct"
										readonly="true" />
								</table></td>
							<td  id="guest_info4">商品总价</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.crTotalPrice"
										readonly="true" />
								</table></td>
							<td  id="guest_info6">贷款用途</td>
							<td id="guest_info7">
								<table>
									<s:select list="purposeList" listKey="name" listValue="name" headerKey=""  headerValue="请选择"
										name="client.crUse" cssStyle="width:95%">
									</s:select>
								</table>
							</td>
						</tr>
						<tr>
							
							<td id="guest_info2">自付金额(元)</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.crOwnPayment"
										readonly="true" />
								</table></td>
							<td id="guest_info4">分期期数</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.crMonth"
										readonly="true" />
								</table></td>
							<td id="guest_info6">每月还款额(元)</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.crPayMonth"
										readonly="true" />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">贷款本金(元)</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.crCapital"
										readonly="true" />
								</table></td>
							<td id="guest_info4">首次还款日</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.crFirstPay"
										readonly="true" />
								</table></td>
							<td id="guest_info6">每月还款日</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.crPayDay"
										readonly="true" />
								</table></td>
						</tr>
						
						<tr>
							<td id="guest_info2">*  客户银行卡号/账号</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.crBankCard"   maxlength="24" dtype="number"/>
								</table></td>
							<td id="guest_info4">*  客户开户银行</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.crOpenBank"   maxlength="50"/>
								</table></td>
							<td id="guest_info6">月花费(元/月)</td>
							<td id="guest_info7"><table>
									<input type="text" name="client.crMonthPay" />
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">第二银行卡号</td>
							<td id="guest_info3"><table>
									<input type="text" name="client.crBankOsCard"  dtype="number" />
								</table></td>
							<td id="guest_info4">第二银行卡开户银行</td>
							<td id="guest_info5"><table>
									<input type="text" name="client.crBankOsOpen" />
								</table></td>
							<td colspan="1"  id="guest_info6"></td>
							<td id="guest_info7"><table>
							<html:checkbox  name="client.crAgentPay" cssStyle="margin-left:10px">
									</html:checkbox></table></td>
						</tr>
						
					</table>
					<table id="tb10" align="center" width="100%" 
						cellpadding="1" cellspacing="0" style="padding-right: 10px;border:0">
						<tr height="25">
							<td  colspan="2" align="right" width="50%">用户</td>
							<td width="50%" colspan="" align="left"><table>
									<input type="text" name="user.name" cssStyle="border:0"></input>
								</table></td>

						</tr>
						<tr >
							<td height="29" colspan="2" align="right" width="50%">口令</td>
							<td colspan="" align="left" width="50%"><table>
									<input type="password"  name="pwdConfirm" cssStyle="border:1"/>
								</table></td>
						</tr>
						<tr >
							<td align="right" colspan="2">
									<input type="submit" key="keyButtonConfirm" cssClass="inputBut" align="right"></input type="submit">
								</td>
						</tr>
						
					</table>
	</div>

<jsp:include page="../../incl/g_footer.jsp" />
</div>
</form>
</body>
</html>
</fmt:bundle>
