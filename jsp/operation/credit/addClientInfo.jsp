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
									<input type="text" name="contract.userName"   maxlength="10"/>
								</table></td>
							<td id="guest_info4"></td>
							<td id="guest_info5"></td>
							<td id="guest_info6">*  身份证号码</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.userIdCode"  dtype="identity" onblur="calcIdCard()"/>
								</table></td>
						</tr>
						<tr>
							

							<td align="right" id="guest_info2">  身份证截止日期</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.validity"  id="validity" 
									 onclick="displayCalendar(this,'yyyy-mm-dd',this)"/>
								</table></td>
							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<html:checkbox    name="contract.isLongTime"  cssStyle="margin-left:10px"
									 onclick="checkV()" >
									</html:checkbox>
								</table></td>
							<td id="guest_info6">*  发证机关</td>
							<td id="guest_info7"><table>
									<input type="text"
										name="contract.licenceAddress"    maxlength="50"/>
								</table></td>
						</tr>

						
						<tr>
							<td id="guest_info2">  SSI号码/学生号码</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.sslCode"/>
								</table></td>
							<td id="guest_info4">* 申请人年龄</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.guestAge"   dtype="number"/>
								</table></td>
							<td id="guest_info6">*  手机</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.phoneCode"   dtype="mobile" onblur="getphonearea(this.value)"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">* 性别</td>
							<td id="guest_info3"><table>
							<select>
							  <option value ="volvo">男</option>
							  <option value ="saab">女</option>
							  <option value="opel">Opel</option>
							  <option value="audi">Audi</option>
							</select>
							
								</table></td>
							<td id="guest_info4">* 婚姻状况</td>
							<td id="guest_info5"><table>
							<select>
							  <option value ="volvo">未婚</option>
							  <option value ="saab">已婚</option>
							  <option value="opel">离异</option>
							  <option value="audi">丧偶</option>
							</select>
									
								</table></td>
							<td id="guest_info6">*  手机号码归属地</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.phoneCodeSource"   />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">子女数目</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.childsCount"  dtype="number"/>
								</table></td>
							<td id="guest_info4">*  住房</td>
							<td id="guest_info5"><table>
									<select>
							  <option value ="volvo">自有房</option>
							 
							</select>
								</table></td>
							<td id="guest_info6">*  教育程度</td>
							<td id="guest_info7"><table>
									<select>
										  <option value ="volvo">大學</option>
										  <option value ="saab">高中</option>
									</select>
								</table></td>
						</tr>
						<tr>
							<td id="guest_info2">  住宅电话登记人</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="contract.homePhoneRegiatrationPerson" maxlength="20"/>
								</table></td>
							<td id="guest_info4">住宅/宿舍电话</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.homePhone" />
								</table></td>
							<td id="guest_info6">  电子邮箱</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.email"  dtype="email"/>
								</table></td>
						</tr>

						<tr>
							<td colspan="6" align="left" class="tr8">配偶资料</td>

						</tr>
						<tr>
							
							<td id="guest_info2">  配偶姓名</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.spName" maxlength="20"/>
								</table></td>
							<td id="guest_info4">配偶移动电话</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.spPhone"  dtype="mobile"/>
								</table></td>
							<td id="guest_info6">  身份证号码</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.spIdCode" dtype="identity"/>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">  配偶雇主</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.spEmployer" maxlength="20"/>
								</table></td>
							<td id="guest_info4">配偶办公电话</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="contract.spOfficePhone"  dtype="mobile"/>
								</table></td>
							<td id="guest_info6">配偶办公电话分机</td>
							<td id="guest_info7"><table>
									<input type="text"
										name="contract.spExtencePhone"  dtype="mobile" />
								</table></td>
						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">户籍地址</td>

						</tr>
						<tr>
							
							<td id="guest_info2">邮编</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.adPostCode"  isempty="true" dtype="number" maxlength="20"/>
								</table></td>
							<td id="guest_info4">*  省/直辖市</td>
							<td id="guest_info5"><table>
									<select>
								  		<option value ="volvo">四川省</option>
									</select>
								</table></td>
							<td id="guest_info6">*  市</td>
							<td id="guest_info7"><table>
									<select>
								  		<option value ="volvo">成都市</option>
									</select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">*  区/县区</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.adCounty"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  镇</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.adTown"  maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  街道/路/村</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.adStreet"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  小区/楼盘</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="contract.adNeighborhoodPremises"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  栋/单元/房间号</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="contract.adUnitHomeNumber"  isempty="true" maxlength="20"/>
								</table></td>
							<td id="guest_info6">其它</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.adOther"  isempty="true" maxlength="50"/>
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
									<input type="text" name="contract.nowMonth"
										 />
								</table></td>
							<td align="left" style="background-color:#EEEEEE" >月</td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2">  邮编</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.nowPostCode"  dtype="number" maxlength="10"/>
								</table></td>
							<td id="guest_info4">*  省/直辖市</td>
							<td id="guest_info5"><table>
									<select display="width:95%" >
									
									</select>
								</table></td>
							<td id="guest_info6">*  市</td>
							<td id="guest_info7">
								<table>
									
								</table>
							</td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  区/县区</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.nowCounty"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  镇</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.nowTown" maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  街道/路/村</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.nowStreet"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  小区/楼盘</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.nowNeighborhoodPremises"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  栋/单元/房间号</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="contract.nowUnitHomeNumber"  isempty="true" maxlength="20"/>
								</table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">家庭信息</td>

						</tr>
						<tr>
							<td id="guest_info2">*  家庭成员名称</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.faMemberName"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">*  家庭成员类型</td>
							<td id="guest_info5"><table>
								</table></td>
							<td id="guest_info6">家庭成员电话号</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.faPhone"  "/>
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
									<input type="text" name="contract.faPostCode"  isempty="true" dtype="number" maxlength="10"/>
								</table></td>
							<td id="guest_info4">*  省/直辖市</td>
							<td id="guest_info5"><table>
									<s:select list="cityList" listKey="name" listValue="name"   headerKey=""  headerValue="请选择" cssStyle="width:95%"
										name="contract.faProvince"  onchange="searchCity(this.options[this.options.selectedIndex].value,'contract.faCity')"   maxlength="20">
									</s:select>
								</table></td>
							<td id="guest_info6">*  市</td>
							<td id="guest_info7"><table>
									<s:select  list="familyCity" listKey="name" listValue="name"  headerKey=""  headerValue="请选择" cssStyle="width:95%"
										name="contract.faCity" id="contract.faCity"  maxlength="20">
									</s:select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">*  区/县区</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.faCounty"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  镇</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.faTown" maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  街道/路/村</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.faStreet"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">*  小区/楼盘</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="contract.faNeighborhoodPremises"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">  栋/单元/房间号</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="contract.faUnitHomeNumber"   maxlength="20"/>
								</table></td>
							<td id="guest_info6">其它</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.faOther" />
								</table></td>
						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">其他联系人资料</td>

						</tr>
						<tr>
							
							<td id="guest_info2">* 联系人姓名</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.oName" />
								</table></td>
							<td id="guest_info4">与申请人关系</td>
							<td id="guest_info5"><table>
								</table></td>
							<td id="guest_info6">* 联系电话</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.oPhone"  dtype="mobile" />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2" > 销售顾问备注</td>
							<td align="left" colspan="5"><table>
									<input type="text" name="contract.oSa"
										size="135" />
								</table></td>

						</tr>
						<tr>
							<td colspan="6" align="left" class="tr8">文件</td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<html:checkbox  name="contract.fIdCode">
									</html:checkbox>
								</table></td>

							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<html:checkbox  name="contract.fSocialCard">
									</html:checkbox>
								</table></td>

							<td id="guest_info6"></td>
							<td id="guest_info7"><table>
									<html:checkbox  name="contract.fWorkCard">
									</html:checkbox>
								</table></td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<html:checkbox  name="contract.fBankCard">
									</html:checkbox>
								</table></td>

							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<html:checkbox 
										name="contract.fBankStatement">
									</html:checkbox>
								</table></td>

							<td id="guest_info6"></td>
							<td id="guest_info7"><table>
									<html:checkbox 
										name="contract.fBankDeposit">
									</html:checkbox>
								</table></td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<html:checkbox 
										name="contract.fResidenceBooklet" >
									</html:checkbox>
								</table></td>

							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<html:checkbox  name="contract.fSid" >
									</html:checkbox>
								</table>
							<td id="guest_info6"></td>
							<td id="guest_info7"><table>
									<html:checkbox 
										name="contract.fUid" >
									</html:checkbox>
								</table></td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<html:checkbox  name="contract.fHouseCard">
									</html:checkbox>
								</table></td>
							<td id="guest_info4"></td>
							<td id="guest_info5"><table>
									<html:checkbox  name="contract.fDirvingCard">
									</html:checkbox>
								</table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"><table>
									<html:checkbox  name="contract.fDirverCard">
									</html:checkbox>
								</table></td>

						</tr>
						<tr>
							
							<td id="guest_info2"></td>
							<td id="guest_info3"><table>
									<html:checkbox  name="contract.fOther">
									</html:checkbox>
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
									<s:select list="postCity" listKey="name" listValue="name"  headerKey=""  headerValue="请选择" cssStyle="width:95%"
										name="contract.stPostAddr" id="stPostAddr" onclik="choosseAddress(this,'post')"></s:select>
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
										name="contract.inMonthlyIncome"   dtype="float" maxlength="10"/>
								</table></td>
							<td  id="guest_info4">  其他收入(元/月)</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="contract.inOtherIncome" dtype="float" maxlength="10"/>
								</table></td>
							<td  id="guest_info6">*  家庭月收入(元)</td>
							<td id="guest_info7"><table>
									<input type="text"
										name="contract.inFamilyIncome"   dtype="float" maxlength="10"/>
								</table></td>
						</tr>
						<tr>
							
							<td  id="guest_info2"></td>
							<td id="guest_info3"></td>
							<td  id="guest_info4">  其他收入来源</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="contract.inOtherIncomeSource"  maxlength="10"/>
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
									<input type="text" name="contract.xxName"   maxlength="20"/>
								</table></td>
							<td id="guest_info4">*  单位/学校/个体全称</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.xxxName"   maxlength="20"/>
								</table></td>
							<td id="guest_info6">*  任职部门或班级</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.xxClass"   maxlength="20"/>
								</table></td>
						</tr>
						<tr>
							<td id="guest_info2">*  总共工作经脸/总共大学学习时间</td>
							<td id="guest_info3"><table>
									<s:select
										list=" yearList" listKey="name" listValue="name"  headerKey=""  headerValue="请选择"
										name="contract.xxTime"   maxlength="10" cssStyle="width:95%">
									</s:select>
								</table></td>
							<td id="guest_info4">*  现工作时间/大学开始时间(以月为单位)</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.xxStartTime"   dtype="number"  maxlength="20"/>
								</table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2"> * 行业类别</td>
							<td id="guest_info3"><table>
									<s:select
										list="businessList" listKey="name" listValue="name"  headerKey=""  headerValue="请选择" 
										name="contract.xxType" cssStyle="width:95%">
									</s:select>
								</table></td>
							<td id="guest_info4">* 职位</td>
							<td id="guest_info5"><table>
									<s:select
										list=" positionList" listKey="name" listValue="name"  headerKey=""  headerValue="请选择" 
										name="contract.xxPosition" cssStyle="width:95%">
									</s:select>
								</table></td>
							<td id="guest_info6">单位性质</td>
							<td id="guest_info7"><table>
									<s:select
										list=" unitList" listKey="name" listValue="name"  headerKey=""  headerValue="请选择"
										name="contract.xxOrName" cssStyle="width:95%">
									</s:select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">*  办公电话</td>
							<td id="guest_info3"><table>
									<input type="text"
										name="contract.xxOfficePhone"    maxlength="20" dtype="mobile"/>
								</table></td>
							<td id="guest_info4">办公电话分机</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.xxExtension"  dtype="mobile"/>
								</table></td>
							<td id="guest_info6"></td>
							<td id="guest_info7"></td>
						</tr>
						<tr>
							
							<td id="guest_info2">邮编</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.xxPostCode" dtype="number" maxlength="10"/>
								</table></td>
							<td id="guest_info4">* 省/直辖市</td>
							<td id="guest_info5">
								<table>
									<s:select list="cityList" listKey="name" listValue="name"  headerKey=""  headerValue="请选择"  cssStyle="width:95%"
										name="contract.xxProvince"  onchange="searchCity(this.options[this.options.selectedIndex].value,'contract.xxCity')">
									</s:select>
								</table>
							</td>
							<td id="guest_info6">* 市</td>
				            <td id="guest_info7"><table>
									<s:select list="unitCity" listKey="name" listValue="name"  headerKey=""  headerValue="请选择" 
										name="contract.xxCity" id="contract.xxCity" cssStyle="width:95%">
									</s:select>
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">* 区/县区</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.xxCounty" />
								</table></td>
							<td id="guest_info4">镇</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.xxTown"  maxlength="20" />
								</table></td>
							<td id="guest_info6">* 街道/路/村</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.xxStreet" />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">* 小区/楼盘</td>
							<td id="guest_info3"><table>
									<input type="text" 
										name="contract.xxNeighborhoodPremises" />
								</table></td>
							<td id="guest_info4">栋/单元/房间号</td>
							<td id="guest_info5"><table>
									<input type="text"
										name="contract.xxUnitHomeNumber" />
								</table></td>
							<td id="guest_info6">其它</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.xxOther" />
								</table></td>
						</tr>

						<tr>
							<td colspan="6" align="left" class="tr8">商品1</td>

						</tr>
						<tr>
							
							<td  id="guest_info2">商品</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.g1Type" />
								</table></td>
							<td  id="guest_info4">商品类型</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.g1Form" />
								</table></td>
							<td id="guest_info6">价格（元）</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.g1Price" dtype="float" />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">品牌</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.g1Brand" />
								</table></td>
							<td id="guest_info4">型号</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.g1Model" />
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
									<input type="text" name="contract.crProduct"
										readonly="true" />
								</table></td>
							<td  id="guest_info4">商品总价</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.crTotalPrice"
										readonly="true" />
								</table></td>
							<td  id="guest_info6">贷款用途</td>
							<td id="guest_info7">
								<table>
									<s:select list="purposeList" listKey="name" listValue="name" headerKey=""  headerValue="请选择"
										name="contract.crUse" cssStyle="width:95%">
									</s:select>
								</table>
							</td>
						</tr>
						<tr>
							
							<td id="guest_info2">自付金额(元)</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.crOwnPayment"
										readonly="true" />
								</table></td>
							<td id="guest_info4">分期期数</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.crMonth"
										readonly="true" />
								</table></td>
							<td id="guest_info6">每月还款额(元)</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.crPayMonth"
										readonly="true" />
								</table></td>
						</tr>
						<tr>
							
							<td id="guest_info2">贷款本金(元)</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.crCapital"
										readonly="true" />
								</table></td>
							<td id="guest_info4">首次还款日</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.crFirstPay"
										readonly="true" />
								</table></td>
							<td id="guest_info6">每月还款日</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.crPayDay"
										readonly="true" />
								</table></td>
						</tr>
						
						<tr>
							<td id="guest_info2">*  客户银行卡号/账号</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.crBankCard"   maxlength="24" dtype="number"/>
								</table></td>
							<td id="guest_info4">*  客户开户银行</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.crOpenBank"   maxlength="50"/>
								</table></td>
							<td id="guest_info6">月花费(元/月)</td>
							<td id="guest_info7"><table>
									<input type="text" name="contract.crMonthPay" />
								</table></td>
						</tr>
						
						<tr>
							
							<td id="guest_info2">第二银行卡号</td>
							<td id="guest_info3"><table>
									<input type="text" name="contract.crBankOsCard"  dtype="number" />
								</table></td>
							<td id="guest_info4">第二银行卡开户银行</td>
							<td id="guest_info5"><table>
									<input type="text" name="contract.crBankOsOpen" />
								</table></td>
							<td colspan="1"  id="guest_info6"></td>
							<td id="guest_info7"><table>
							<html:checkbox  name="contract.crAgentPay" cssStyle="margin-left:10px">
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
