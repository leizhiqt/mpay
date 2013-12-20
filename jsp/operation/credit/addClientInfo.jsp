<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="ClientInfo" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css"
	type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
<script type="text/javascript" src="jsp/js/jquery-1.9.0.js"></script>
<style>
<!--
body,td,th {
	font-size: 14px;
}
-->
</style>
<script language="javascript">
	function calcIdCard(){
			if($('#card').val().length==15 || $('#card').val().length==18 ){
				$('#msg2').html('<b style=" color:green"></b>');
			}else{
				$('#msg2').html('<b style=" color:#F00">格式错误</b>');
			}
		}
		function getphonearea(val){
			if(val.length==11){
				$('#msg5').html('<b style=" color:green"></b>');
			}else{
				$('#msg5').html('<b style=" color:#F00">格式错误</b>');
			}
		}
		function getphon(val){
			if(val.length==11 || val.length==8){
				$('#msg9').html('<b style=" color:green"></b>');
			}else{
				$('#msg9').html('<b style=" color:#F00">格式错误</b>');
			}
		}
		function getphons(val){
			if(val.length==11 || val.length==8){
				$('#msg30').html('<b style=" color:green"></b>');
			}else{
				$('#msg30').html('<b style=" color:#F00">格式错误</b>');
			}
		}
		function calc(val){
			
			var id = $("#"+val.id).attr('data')
			if(val.value.length !=0 ){
				$('#'+id).html('<b style=" color:green"></b>');
			}else{
				$('#'+id).html('<b style=" color:#F00">请输入</b>');
			}
			}
</script>
</head>

<body>
	<form method="post" enctype="multipart/form-data">
		<div id="gtop">
			<jsp:include page="../../incl/action.jsp">
				<jsp:param name="type" value="cancel" />
				<jsp:param name="key" value="Cancel" />
				<jsp:param name="action" value="ClientInfo.do" />
				<jsp:param name="method" value="promptDeclare" />
			</jsp:include>
		</div>

		<div id="container">
			<%@ include file="../../incl/b_message.jsp"%>

			<div>
				<table border="1" class="lt" >
					<tr height="10px" style="border: 1px solid #FFF;">

						<td colspan="" align="right"  >销售顾问代码</td>
						<td><c:out value="${UserName} "/>
						<%-- <%=session.getAttribute("UserName") %> --%></td>
						<td align="right"  ><b style="color:red"><b style="color:red">*</b></b> 内部代码</td>
						<td><select name="clientJob.privateKey" id="innerCode"
							onchange="document.getElementById('innerCode').value += ' ' + this.options[this.selectedIndex].text"> 
							<option value="XY24324">XY24324</option>
							<option value="XY24325">XY24325</option>
							<option value="XY24326">XY24326</option>
							<option value="XY24327">XY24327</option>
						</select></td>
						<td></td>
						<td align="left"  >(<b style="color:red">*</b>)必填项</td>

					</tr>
					<tr>
						<th align="left" colspan="6" class="tr8"  ><strong>客户资料</strong></th>
					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 客户照片上传</td>
						<td align="left" colspan="2">
						<input type="file" name="clientPhoto" /> </td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 姓名</td>
						<td align="left"><input type="text" name="client.clientName" value="${client.clientName }" onblur="calc(this)" data="msg1" maxlength="10" id="name"   /> <b id="msg1"></b></td>
					  <td></td>
						<td></td>
						<td align="right"  ><b style="color:red">*</b> 身份证号码</td>
						<td align="left"><input type="text" name="client.idNo" onblur="calcIdCard()" id="card" /> <b id="msg2"></b></td>
					</tr>
					<tr>


						<td align="right"  >身份证截止日期</td>
						<td align="left"><input type="text" name="client.idEndDate" id="validity"
							onclick="displayCalendar(this,'yyyy-MM-dd');" /></td>
					  <td></td>
						<td></td>
						<td align="right"  ><b style="color:red">*</b> 发证机关</td>
						<td align="left"><input type="text" name="client.idAuthority" maxlength="50" onblur="calc(this)" data="msg3" maxlength="20" id="msg" /> <b id="msg3"></b></td>
					</tr>


					<tr>
						<td align="right"  >SSI号码/学生号码</td>
				    <td align="left"><input type="text" name="client.otherNo" /></td>
						<td align="right"  ><b style="color:red">*</b> 申请人年龄</td>
						<td align="left"><input type="text" name="client.age" maxlength="10" data="msg4"  id="ages" onblur="calc(this)" /> <b id="msg4"></b></td>
						<td align="right"  ><b style="color:red">*</b> 手机号</td>
					  <td align="left"><input type="text" name="client.mobilePhone" onblur="getphonearea(this.value)" /><b id="msg5"></b></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 性别</td>
						<td align="left"><select name="client.sex" id="sex"
							onchange="document.getElementById('sex').value += ' ' + this.options[this.selectedIndex].text">
								<option value="男">男</option>
								<option value="女">女</option>
						</select></td>
					  <td align="right"  ><b style="color:red">*</b> 婚姻状况</td>
						<td align="left"><select name="client.marry" id="marry"
							onchange="document.getElementById('marry').value += ' ' + this.options[this.selectedIndex].text">
								<option value="未婚">未婚</option>
								<option value="已婚">已婚</option>
								<option value="离异">离异</option>
								<option value="丧偶">丧偶</option>
						</select></td>
					  <td align="right"  ><b style="color:red">*</b> 手机号码归属地</td>
					  <td align="left"><input type="text" name="client.mobileAddress" data="msg6"  id="addr" onblur="calc(this)" /> <b id="msg6"></b></td>
					</tr>
					<tr>

						<td align="right"  >子女数目</td>
				    <td align="left"><input type="text" name="client.childs" /></td>
					  <td align="right"  ><b style="color:red">*</b> 住房</td>
				  <td align="left"><select id="housing" name="client.housing"
							onchange="document.getElementById('housing').value += ' ' + this.options[this.selectedIndex].text">
								<option value="自有房">自有房</option>
								<option value="租房">租房</option>
						</select></td>
					  <td align="right"  ><b style="color:red">*</b> 教育程度</td>
						<td align="left"><select name="client.educationId" id="educationId"
							onchange="document.getElementById('educationId').value += ' ' + this.options[this.selectedIndex].text">
								<option value=1>大學</option>
								<option value=2>高中</option>
						</select></td>
					</tr>
					<tr>
						<td align="right"  >住宅电话登记人</td>
						<td align="left"><input type="text" name="client.homePhoneName"
							maxlength="20" /></td>
					  <td align="right"  >住宅/宿舍电话</td>
				    <td align="left"><input type="text" name="client.homePhone" /></td>
					  <td align="right"  >电子邮箱</td>
					  <td align="left"><input type="text" name="client.email" /></td>
					</tr>

					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>配偶资料</strong></th>

					</tr>
					<tr>

						<td align="right"  >配偶姓名</td>
						<td align="left"><input type="text" name="client.spuseName" maxlength="20" />
						</td>
					  <td align="right"  >配偶移动电话</td>
				    <td align="left"><input type="text" name="client.spuseMobile" /></td>
					  <td align="right"  >身份证号码</td>
					  <td align="left"><input type="text" name="client.idSpuse" /></td>
					</tr>

					<tr>

						<td align="right"  >配偶雇主</td>
				    <td align="left"><input type="text" name="client.spuseHirer"
							maxlength="20" /></td>
					  <td align="right"  >配偶办公电话</td>
				    <td align="left"><input type="text" name="client.spuseOfficePhone" /></td>
					  <td align="right"  >配偶办公电话分机</td>
					  <td align="left"><input type="text" name="client.spuseExtPhone" /></td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>户籍地址</strong></th>

					</tr>
					<tr>

						<td align="right"  >邮编</td>
				    <td align="left"><input type="text" name="censusAddressBook.zipCode"
							maxlength="20" /></td>
					  <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
				  <td align="left"><select id="province1" name="censusAddressBook.province"
							onchange="document.getElementById('province1').value += ' ' + this.options[this.selectedIndex].text">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
					  <td align="right"  ><b style="color:red">*</b> 市</td>
				  <td align="left"><select id="city1" name="censusAddressBook.city"
							onchange="document.getElementById('city1').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="內江市">內江市</option>
						</select></td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
				    <td align="left"><input type="text" name="censusAddressBook.county"
							maxlength="20" data="msg17"  id="xian" onblur="calc(this)" /> <b id="msg17"></b></td>
					  <td align="right"  >镇</td>
				    <td align="left"><input type="text" name="censusAddressBook.town"
							maxlength="20" /></td>
					  <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
					  <td align="left"><input type="text" name="censusAddressBook.street"
							maxlength="20" data="msg16"  id="jieda" onblur="calc(this)" /> <b id="msg16"></b></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				    <td align="left"><input type="text" name="censusAddressBook.community"
							maxlength="20" data="msg15"  id="lou8" onblur="calc(this)" /> <b id="msg15"></b></td>
					  <td align="right"  >栋/单元/房间号</td>
				    <td align="left"><input type="text" name="censusAddressBook.houseNo"
							maxlength="20" /></td>
					  <td align="right"  >其它</td>
					  <td align="left"><input type="text" name="censusAddressBook.other"
							maxlength="50" /></td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>现居住地址</strong></th>

					</tr>
					<tr>
						<td align="right"  >现居住地地址同户籍地址</td>
						<td align="left">
							<input type="checkbox" onClick="autoFillAddress(this, 'now');"/>
						</td>
				    <td align="right"  >你在现居住城市住了多久？</td>
				    <td align="left"><input type="text" name="" /></td>
					  <td align="right"  >月</td>
						<td></td>
					</tr>
					<tr>

						<td align="right"  >邮编</td>
				    <td align="left"><input type="text" name="livingAddressBook.zipCode"
							maxlength="10" /></td>
					  <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
				  <td align="left"><select id="province2" name="livingAddressBook.province"
							onchange="document.getElementById('province2').value += ' ' + this.options[this.selectedIndex].text">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
					  <td align="right"  ><b style="color:red">*</b> 市</td>
				  <td align="left"><select id="city2" name="livingAddressBook.city"
							onchange="document.getElementById('city2').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="內江市">內江市</option>
						</select></td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
				    <td align="left"><input type="text" name="livingAddressBook.county"
							maxlength="20" data="msg14"  id="qu3" onblur="calc(this)" /> <b id="msg14"></b></td>
					  <td align="right"  >镇</td>
				    <td align="left"><input type="text" name="livingAddressBook.town"
							maxlength="20" /></td>
					  <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
						<td align="left"><input type="text" name="livingAddressBook.street"
							maxlength="20" data="msg13"  id="ludao" onblur="calc(this)" /> <b id="msg13"></b></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				    <td align="left"><input type="text" name="livingAddressBook.community"
							maxlength="20" data="msg12"  id="qu1" onblur="calc(this)" /> <b id="msg12"></b></td>
					  <td align="right"  >栋/单元/房间号</td>
					  <td align="left"><input type="text" name="livingAddressBook.houseNo"
							maxlength="20" /></td>

					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>家庭信息</strong></th>

					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 家庭成员名称</td>
						<td align="left"><input type="text" name="client.homeName" maxlength="20" data="msg11"  id="ming" onblur="calc(this)" /> <b id="msg11"></b>
						</td>
					  <td align="right"  ><b style="color:red">*</b> 家庭成员类型</td>
				    <td align="left"><input type="text" name="client.homeType"  data="msg10"  id="lie" onblur="calc(this)" /> <b id="msg10"></b></td>
					  <td align="right"  >家庭成员电话号</td>
					  <td align="left"><input type="text" name="client.homeTelephone" /></td>
					</tr>
					<tr>
						<td align="right"  >家庭成员地址与户籍地址相同</td>
				    <td align="left"><input type="checkbox"
							onclick="autoFillAddress(this, 'fa');" style="margin-left: 10px" /></td>
				    <td  ></td>
						<td></td>
						<td  ></td>
						<td></td>
					</tr>
					<tr>

						<td align="right"  >邮编</td>
				    <td align="left"><input type="text" name="homeAddressBook.zipCode"
							maxlength="20" /></td>
					  <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
				  <td align="left"><select id="province3" name="homeAddressBook.province"
							onchange="document.getElementById('province3').value += ' ' + this.options[this.selectedIndex].text">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
					  <td align="right"  ><b style="color:red">*</b> 市</td>
				  <td align="left"><select id="city3" name="homeAddressBook.city"
							onchange="document.getElementById('city3').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="內江市">內江市</option>
						</select></td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
				    <td align="left"><input type="text" name="homeAddressBook.county"
							maxlength="20" data="msg7"  id="qu" onblur="calc(this)" /> <b id="msg7"></b></td>
					  <td align="right"  >镇</td>
				    <td align="left"><input type="text" name="homeAddressBook.town"
							maxlength="20" /></td>
					  <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
					  <td align="left"><input type="text" name="homeAddressBook.street"
							maxlength="20" data="msg18"  id="jlc" onblur="calc(this)" /> <b id="msg18"></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				    <td align="left"><input type="text" name="homeAddressBook.community"
							maxlength="20"  data="msg8"  id="lou" onblur="calc(this)" /> <b id="msg8"></b> </td>
					  <td align="right"  >栋/单元/房间号</td>
				    <td align="left"><input type="text" name="homeAddressBook.houseNo"
							maxlength="20" /></td>
					  <td align="right"  >其它</td>
					  <td align="left"><input type="text" name="homeAddressBook.other"
							maxlength="50" /></td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>其他联系人资料</strong></th>

					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 联系人姓名</td>
				    <td align="left"><input type="text" name="client.otherContacts" data="msg20"  id="nam" onblur="calc(this)" /> <b id="msg20"></td>
					  <td align="right"  >与申请人关系</td>
				  <td align="left"><select id="otherNexus" name="client.otherNexus"
							onchange="document.getElementById('otherNexus').value += ' ' + this.options[this.selectedIndex].text">
								<option value="朋友">朋友</option>
								<option value="亲戚">亲戚</option>
						</select></td>
					  <td align="right"  ><b style="color:red">*</b> 联系电话</td>
					  <td align="left"><input type="text" name="client.otherPhone" onblur="getphon(this.value)" /><b id="msg9"></b></td>
					</tr>
					<tr>

						<td align="right"  >销售顾问备注</td>
					  <td align="left" colspan="5"><input type="text"
							name="" size="135" /></td>

					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>文件</strong></th>

					</tr>
					<tr>

						<td width="60" align="right">身份证</td>
				    <td align="left" width="272"><input type="file" name="contract.fIdCode" /></td>

						<td align="right">社保卡</td>
						<td colspan="3" align="left"><input type="file" name="contract.fSocialCard" />
						</td>

				    </tr>
					<tr>

						<td align="right">银行卡</td>
				    <td align="left"><input type="file" name="contract.fBankCard" /></td>

						<td align="right">银行对账单</td>
						<td colspan="3" align="left"><input type="file" name="contract.fBankStatement" /></td>

				    </tr>
					<tr>
						<td align="right">户口本</td>
						<td align="left"><input type="file" name="contract.fResidenceBooklet" />
						</td>

						<td align="right">大学学生证</td>
						<td colspan="3" align="left"><input type="file" name="contract.fSid" />					  
					</tr>
					<tr>

						<td align="right">房产证</td>
				    <td align="left"><input type="file" name="contract.fHouseCard" /></td>
						<td align="right">行驶证</td>
						<td colspan="3" align="left"><input type="file" name="contract.fDirvingCard" /></td>
				    </tr>
					<tr>

						<td align="right">工卡</td>
					  <td align="left"><input type="file" name="contract.fWorkCard" /></td>

					  	<td align="right">大学学生证明（仅适用全日制大学学生)</td>

						<td colspan="3" align="left"><input type="checkbox" name="contract.fUid" /></td>
					</tr>
					<tr>
						<td align="right">银行存折</td>
						<td align="left"><input type="file" name="contract.fBankDeposit" /></td>
					  <td align="right">驾驶证</td>
                      <td colspan="3" align="left"><input type="file" name="contract.fDirverCard" /></td>
					</tr>
					<tr>

						<td align="right"  >其它</td>
						<td align="left"><input type="file" name="contract.fOther" /></td>
					  <td align="right">邮寄地址</td>
						<td colspan="3" align="left"><select id="postAddress" name="postAddress"
							onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
					      <option value="成都市">成都市</option>
						    <option value="重庆市">重庆市</option>
				        </select></td>
					</tr>


					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>收入资料</strong></th>

					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 月收入总额(元)</td>
						<td align="left"><input type="text" name="client.masterInMonth"
							maxlength="10" data="msg21"  id="shour" onblur="calc(this)" /> <b id="msg21"></b></td>
						<td align="right"  >其他收入(元/月)</td>
				    <td align="left"><input type="text" name="client.otherInMonth"
							maxlength="10" /></td>
					  <td align="right"  ><b style="color:red">*</b> 家庭月收入(元)</td>
						<td align="left"><input type="text" name="client.homeInMonth"
							maxlength="10" data="msg22"  id="yue" onblur="calc(this)" /> <b id="msg22"></b></td>
					</tr>
					<tr>

						<td  ></td>
						<td align="left"></td>
						<td align="right"  >其他收入来源</td>
				    <td align="left"><input type="text" name="client.otherIncome"
							maxlength="10" /></td>
					  <td  ></td>
						<td></td>
					</tr>

					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>所在单位信息</strong></th>

					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 单位名称或大学名称</td>
						<td align="left"><input type="text" name="client.onShortName"
							maxlength="20" data="msg23"  id="college" onblur="calc(this)" /> <b id="msg23"></b></td>
						<td align="right"  ><b style="color:red">*</b> 单位/学校/个体全称</td>
				    <td align="left"><input type="text" name="client.onFullName"
							maxlength="20" data="msg24"  id="collegename" onblur="calc(this)" /> <b id="msg24"></b></td>
					  <td align="right"  ><b style="color:red">*</b> 任职部门或班级</td>
						<td align="left"><input type="text" name="client.onDivision"
							maxlength="20" data="msg25"  id="collegebumen" onblur="calc(this)" /> <b id="msg25"></b></td>
					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 总共工作经脸/总共大学学习时间</td>
						<td align="left"><select id="onWorkTime" name="client.onWorkTime"
							onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
								<option value="0-1年">0-1年</option>
								<option value="0-1年">1-2年</option>
								<option value="0-1年">2-3年</option>
								<option value="0-1年">3-5年</option>
								<option value="0-1年">5-10年</option>
								<option value="0-1年">大于10年</option>
						</select></td>
						<td align="right"  ><b style="color:red">*</b> 现工作时间/大学开始时间(以月为单位)</td>
				    <td align="left"><input type="text" name="" maxlength="20" data="msg26"  id="college1" onblur="calc(this)" /> <b id="msg26"></b></td>
					  <td align="right"  ></td>
						<td align="left"></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 行业类别</td>
						<td align="left"><select id="onWorkTime" name="client.onSector"
							onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
								<option value="IT">IT</option>
								<option value="金融">金融</option>
						</select></td>
						<td align="right"  ><b style="color:red">*</b> 职位</td>
				  <td align="left"><select id="onOffice" name="client.onOffice"
							onchange="document.getElementById('onOffice').value += ' ' + this.options[this.selectedIndex].text">
								<option value="经理">经理</option>
								<option value="总监">总监</option>
						</select></td>
					  <td align="right"  >单位性质</td>
						<td align="left"><select id="onFeature" name="client.onFeature"
							onchange="document.getElementById('onFeature').value += ' ' + this.options[this.selectedIndex].text">
								<option value="国有企业">国有企业</option>
								<option value="私有企业">私有企业</option>
						</select></td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 办公电话</td>
						<td align="left"><input type="text" name="client.onOfficePhone"
							maxlength="20" name="client.otherPhone" onblur="getphons(this.value)" /><b id="msg30"></b></td>
						<td align="right"  >办公电话分机</td>
				    <td align="left"><input type="text" name="client.onExtPhone" /></td>
					  <td align="right"  ></td>
						<td align="left"></td>
					</tr>
					<tr>

						<td align="right"  >邮编</td>
						<td align="left"><input type="text" name="officeAddressBook.zipCode"
							maxlength="20" /></td>
						<td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
				  <td align="left"><select id="province4" name="officeAddressBook.province"
							onchange="document.getElementById('province4').value += ' ' + this.options[this.selectedIndex].text">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
					  <td align="right"  ><b style="color:red">*</b> 市</td>
						<td align="left"><select id="city4" name="officeAddressBook.city"
							onchange="document.getElementById('city4').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="內江市">內江市</option>
						</select></td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
						<td align="left"><input type="text" name="officeAddressBook.county"
							maxlength="20" data="msg31"  id="co" onblur="calc(this)" /> <b id="msg31"></b></td>
						<td align="right"  >镇</td>
				    <td align="left"><input type="text" name="officeAddressBook.town"
							maxlength="20" /></td>
					  <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
						<td align="left"><input type="text" name="officeAddressBook.street"
							maxlength="20" data="msg32"  id="coll" onblur="calc(this)" /> <b id="msg32"></b></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
						<td align="left"><input type="text" name="officeAddressBook.community"
							maxlength="20" data="msg33"  id="loupan" onblur="calc(this)" /> <b id="msg33"></b></td>
						<td align="right"  >栋/单元/房间号</td>
				    <td align="left"><input type="text" name="officeAddressBook.houseNo"
							maxlength="20" /></td>
					  <td align="right"  >其它</td>
						<td align="left"><input type="text" name="officeAddressBook.other"
							maxlength="50" /></td>
					</tr>

					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>商品1</strong></th>

					</tr>
					<tr>

						<td align="right"  >商品1</td>
						<td align="left"><input type="text" name="" /></td>
						<td align="right"  >商品类型</td>
				    <td align="left"><input type="text" name="" /></td>
					  <td align="right"  >价格（元）</td>
						<td align="left"><input type="text" name="" /></td>
					</tr>
					<tr>

						<td align="right"  >品牌</td>
						<td align="left"><input type="text" name="" /></td>
						<td align="right"  >型号</td>
				    <td align="left"><input type="text" name="" /></td>
					  <td align="right"  ></td>
						<td></td>
					</tr>
                   <tr  >
						<th colspan="6" align="left" class="tr8"><strong>商品2</strong> </th>

					</tr>
					<tr>

						<td align="right"  >商品2</td>
						<td align="left"><input type="text" name="" /></td>
						<td align="right"  >商品类型</td>
				    <td align="left"><input type="text" name="" /></td>
					  <td align="right"  >价格（元）</td>
						<td align="left"><input type="text" name="" /></td>
					</tr>
					<tr>

						<td align="right"  >品牌</td>
						<td align="left"><input type="text" name="" /></td>
						<td align="right"  >型号</td>
				    <td align="left"><input type="text" name="" /></td>
					  <td align="right"  ></td>
						<td></td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>信用信息</strong></th>
					</tr>
					<tr>

						<td align="right"  >产品</td>
						<td align="left"><c:out value="${financialProduct.financialName }"/><input type="hidden" name="clientJob.financialProductId" value="${pId }"/></td>
						<td align="right">商品总价</td>
						<td align="left">
							<input type="text" name="clientJob.totalPrice"  value="${salePrice }" readonly />
						</td>
					  	<td>贷款用途</td>
						<td><input type="text" name="clientJob.byUse"/></td>
					</tr>
					<tr>

						<td align="right"  >自付金额(元)</td>
						
						<td align="left">
							<input type="text" name="clientJob.selfAmount" value="${onePay }"/>
						</td>
						<td align="right"  >分期期数</td>
						
					  <td align="left"><c:out value="${financialProduct.cycleTotal }"/> </td>
						<td  >每月还款额(元)</td>
						<td align="left"><input type="text" name="clientJob.monthOfPay"  value="${monthPay1 }"/></td>
						
						
					</tr>
					<tr>
						<td align="right">首次还款额（元）</td>
						<td align="left"><input type="text" name="clientJob.firstpayAmount" value="${monthPay }"/></td>
						<td align="right"  >贷款本金(元)</td>
						<td align="left"><input type="text" name="clientJob.creditAmount" value="${creditAmount }" readonly /></td>
						<td align="right"  >首次还款日</td>
						<td align="left"><input type="text" name="clientJob.firstpayDate" onclick="displayCalendar(this,'yyyy-MM-dd');"  /></td>
					 
					</tr>

					<tr>
					    <td  >每月还款日</td>
						<td align="left"><input type="text" name="clientJob.monthOfDate"  value ="${clientJob.monthOfDate }" onclick="displayCalendar(this,'yyyy-MM-dd');"/></td>
						<td align="right"  ><b style="color:red">*</b> 客户银行卡号/账号</td>
						<td align="left"><input type="text" name="bank.debitCard"
							maxlength="24" /></td>
						<td align="right"  ><b style="color:red">*</b> 客户开户银行</td>
				    <td align="left"><input type="text" name="bank.bankName"
							maxlength="50" /></td>
					
					</tr>

					<tr>
						<td  >月花费(元/月)</td>
						<td align="left"><input type="text" name="bank.monthPay" /></td>
						<td align="right"  >第二银行卡号</td>
						<td align="left"><input type="text" name="bank2.debitCard" /></td>
						<td align="right"  >第二银行卡开户银行</td>
				    	<td align="left"><input type="text" name="bank2.bankName" /></td>
					  
						
					</tr>

				</table>
				
				<table style="width:100%;text-align:center;">
<tr>
						<td width="39%" align="right">用户</td>
						<td width="61%" align="left"><input type="text" name="user.name"></input></td>
					</tr>
					
					<tr>
						<td align="right">口令</td>
						<td align="left"><input type="password" name="pwdConfirm" /></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<jsp:include page="../../incl/actionb.jsp">
								<jsp:param name="key" value="keyButtonConfirm" />
								<jsp:param name="action" value="ClientInfo.do" />
								<jsp:param name="method" value="processAdd" />
							</jsp:include>
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
