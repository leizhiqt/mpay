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
				<table border="1">
					<tr height="10px" style="border: 1px solid #FFF;">

						<td colspan="" align="right">销售顾问代码</td>
						<td><input type="text" name="user.userId" readonly /></td>
						<td align="right">* 内部代码</td>
						<td></td>
						<td></td>
						<td>(*)必填项</td>

					</tr>
					<tr>
						<td colspan="6" align="center"
							style="background-color: #0285c7; line-height: 28px">客户基本信息</td>
					</tr>
					<tr>
						<td align="left" colspan="6" class="tr8">客户资料</td>
					</tr>
					<tr>
						<td>* 客户照片上传</td>
						<td align="left" colspan="2"><input /> <input /></td>


						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>

						<td>* 姓名</td>
						<td><input type="text" name="client.clientName"
							maxlength="10" /></td>
						<td></td>
						<td></td>
						<td>* 身份证号码</td>
						<td><input type="text" name="client.idNo"
							onblur="calcIdCard()" /></td>
					</tr>
					<tr>


						<td align="right">身份证截止日期</td>
						<td><input type="text" name="client.idEndDate" id="validity"
							onclick="displayCalendar(this,'yyyy-MM-dd');" /></td>
						<td></td>
						<td></td>
						<td>* 发证机关</td>
						<td><input type="text" name="client.idAuthority"
							maxlength="50" /></td>
					</tr>


					<tr>
						<td>SSI号码/学生号码</td>
						<td><input type="text" name="client.otherNo" /></td>
						<td>* 申请人年龄</td>
						<td><input type="text" name="client.age" /></td>
						<td>* 手机号</td>
						<td><input type="text" name="client.mobilePhone"
							onblur="getphonearea(this.value)" /></td>
					</tr>
					<tr>

						<td>* 性别</td>
						<td><select name="client.sex" id="sex"
							onchange="document.getElementById('sex').value += ' ' + this.options[this.selectedIndex].text">
								<option value="男">男</option>
								<option value="女">女</option>
						</select></td>
						<td>* 婚姻状况</td>
						<td><select name="client.marry" id="marry"
							onchange="document.getElementById('marry').value += ' ' + this.options[this.selectedIndex].text">
								<option value="未婚">未婚</option>
								<option value="已婚">已婚</option>
								<option value="离异">离异</option>
								<option value="丧偶">丧偶</option>
						</select></td>
						<td>* 手机号码归属地</td>
						<td><input type="text" name="client.mobileAddress" /></td>
					</tr>
					<tr>

						<td>子女数目</td>
						<td><input type="text" name="client.childs" /></td>
						<td>* 住房</td>
						<td><select id="housing"
							onchange="document.getElementById('housing').value += ' ' + this.options[this.selectedIndex].text">
								<option value="自有房">自有房</option>
								<option value="租房">租房</option>
						</select></td>
						<td>* 教育程度</td>
						<td><select name="client.educationId" id="educationId"
							onchange="document.getElementById('educationId').value += ' ' + this.options[this.selectedIndex].text">
								<option value=1>大學</option>
								<option value=2>高中</option>
						</select></td>
					</tr>
					<tr>
						<td>住宅电话登记人</td>
						<td><input type="text" name="client.homePhoneName"
							maxlength="20" /></td>
						<td>住宅/宿舍电话</td>
						<td><input type="text" name="client.homePhone" /></td>
						<td>电子邮箱</td>
						<td><input type="text" name="client.email" /></td>
					</tr>

					<tr>
						<td colspan="6" align="left" class="tr8">配偶资料</td>

					</tr>
					<tr>

						<td>配偶姓名</td>
						<td><input type="text" name="client.spuseName" maxlength="20" />
						</td>
						<td>配偶移动电话</td>
						<td><input type="text" name="client.spuseMobile" /></td>
						<td>身份证号码</td>
						<td><input type="text" name="client.idSpuse" /></td>
					</tr>

					<tr>

						<td>配偶雇主</td>
						<td><input type="text" name="client.spuseHirer"
							maxlength="20" /></td>
						<td>配偶办公电话</td>
						<td><input type="text" name="client.spuseOfficePhone" /></td>
						<td>配偶办公电话分机</td>
						<td><input type="text" name="client.spuseExtPhone" /></td>
					</tr>
					<tr>
						<td colspan="6" align="left" class="tr8">户籍地址</td>

					</tr>
					<tr>

						<td>邮编</td>
						<td><input type="text" name="censusAddressBook.zipCode"
							maxlength="20" /></td>
						<td>* 省/直辖市</td>
						<td><select id="province1" name="censusAddressBook.province"
							onchange="document.getElementById('province1').value += ' ' + this.options[this.selectedIndex].text">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
						<td>* 市</td>
						<td><select id="city1" name="censusAddressBook.city"
							onchange="document.getElementById('city1').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="內江市">內江市</option>
						</select></td>
					</tr>

					<tr>

						<td>* 区/县区</td>
						<td><input type="text" name="censusAddressBook.county"
							maxlength="20" /></td>
						<td>镇</td>
						<td><input type="text" name="censusAddressBook.town"
							maxlength="20" /></td>
						<td>* 街道/路/村</td>
						<td><input type="text" name="censusAddressBook.street"
							maxlength="20" /></td>
					</tr>
					<tr>

						<td>* 小区/楼盘</td>
						<td><input type="text" name="censusAddressBook.community"
							maxlength="20" /></td>
						<td>栋/单元/房间号</td>
						<td><input type="text" name="censusAddressBook.houseNo"
							maxlength="20" /></td>
						<td>其它</td>
						<td><input type="text" name="censusAddressBook.other"
							maxlength="50" /></td>
					</tr>
					<tr>
						<td colspan="6" align="left" class="tr8">现居住地址</td>

					</tr>
					<tr>
						<td>现居住地地址同户籍地址</td>
						<td align="center">
							<input type="checkbox" onclick="autoFillAddress(this, 'now');"/>
						</td>
						<td>你在现居住城市住了多久？</td>
						<td><input type="text" name="" /></td>
						<td>月</td>
						<td></td>
					</tr>
					<tr>

						<td>邮编</td>
						<td><input type="text" name="livingAddressBook.zipCode"
							maxlength="10" /></td>
						<td>* 省/直辖市</td>
						<td><select id="province2" name="livingAddressBook.province"
							onchange="document.getElementById('province2').value += ' ' + this.options[this.selectedIndex].text">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
						<td>* 市</td>
						<td><select id="city2" name="livingAddressBook.city"
							onchange="document.getElementById('city2').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="內江市">內江市</option>
						</select></td>
					</tr>

					<tr>

						<td>* 区/县区</td>
						<td><input type="text" name="livingAddressBook.county"
							maxlength="20" /></td>
						<td>镇</td>
						<td><input type="text" name="livingAddressBook.town"
							maxlength="20" /></td>
						<td>* 街道/路/村</td>
						<td><input type="text" name="livingAddressBook.street"
							maxlength="20" /></td>
					</tr>
					<tr>

						<td>* 小区/楼盘</td>
						<td><input type="text" name="livingAddressBook.community"
							maxlength="20" /></td>
						<td>栋/单元/房间号</td>
						<td><input type="text" name="livingAddressBook.houseNo"
							maxlength="20" /></td>

					</tr>
					<tr>
						<td colspan="6" align="left" class="tr8">家庭信息</td>

					</tr>
					<tr>
						<td>* 家庭成员名称</td>
						<td><input type="text" name="client.homeName" maxlength="20" />
						</td>
						<td>* 家庭成员类型</td>
						<td><input type="text" name="client.homeType" /></td>
						<td>家庭成员电话号</td>
						<td><input type="text" name="client.homeTelephone" /></td>
					</tr>
					<tr>
						<td>家庭成员地址与户籍地址相同</td>
						<td><input type="checkbox"
							onclick="autoFillAddress(this, 'fa');" style="margin-left: 10px" /></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>

						<td>邮编</td>
						<td><input type="text" name="homeAddressBook.zipCode"
							maxlength="20" /></td>
						<td>* 省/直辖市</td>
						<td><select id="province3" name="homeAddressBook.province"
							onchange="document.getElementById('province3').value += ' ' + this.options[this.selectedIndex].text">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
						<td>* 市</td>
						<td><select id="city3" name="homeAddressBook.city"
							onchange="document.getElementById('city3').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="內江市">內江市</option>
						</select></td>
					</tr>

					<tr>

						<td>* 区/县区</td>
						<td><input type="text" name="homeAddressBook.county"
							maxlength="20" /></td>
						<td>镇</td>
						<td><input type="text" name="homeAddressBook.town"
							maxlength="20" /></td>
						<td>* 街道/路/村</td>
						<td><input type="text" name="homeAddressBook.street"
							maxlength="20" /></td>
					</tr>
					<tr>

						<td>* 小区/楼盘</td>
						<td><input type="text" name="homeAddressBook.community"
							maxlength="20" /></td>
						<td>栋/单元/房间号</td>
						<td><input type="text" name="homeAddressBook.houseNo"
							maxlength="20" /></td>
						<td>其它</td>
						<td><input type="text" name="homeAddressBook.other"
							maxlength="50" /></td>
					</tr>
					<tr>
						<td colspan="6" align="left" class="tr8">其他联系人资料</td>

					</tr>
					<tr>

						<td>* 联系人姓名</td>
						<td><input type="text" name="client.otherContacts" /></td>
						<td>与申请人关系</td>
						<td><select id="otherNexus" name="client.otherNexus"
							onchange="document.getElementById('otherNexus').value += ' ' + this.options[this.selectedIndex].text">
								<option value="朋友">朋友</option>
								<option value="亲戚">亲戚</option>
						</select></td>
						<td>* 联系电话</td>
						<td><input type="text" name="client.otherPhone" /></td>
					</tr>
					<tr>

						<td>销售顾问备注</td>
						<td align="left" colspan="5"><input type="text"
							name="" size="135" /></td>

					</tr>
					<tr>
						<td colspan="6" align="left" class="tr8">文件</td>

					</tr>
					<tr>

						<td></td>
						<td><input type="checkbox" name="contract.fIdCode" />身份证</td>

						<td></td>
						<td><input type="checkbox" name="contract.fSocialCard" />社保卡
						</td>

						<td></td>
						<td><input type="checkbox" name="contract.fWorkCard" />工卡</td>

					</tr>
					<tr>

						<td></td>
						<td><input type="checkbox" name="contract.fBankCard" />银行卡</td>

						<td></td>
						<td><input type="checkbox" name="contract.fBankStatement" />银行对账单
						</td>

						<td></td>
						<td><input type="checkbox" name="contract.fBankDeposit" />银行存折
						</td>

					</tr>
					<tr>
						<td></td>
						<td><input type="checkbox" name="contract.fResidenceBooklet" />户口本
						</td>

						<td></td>
						<td><input type="checkbox" name="contract.fSid" />大学学生证
						<td></td>
						<td><input type="checkbox" name="contract.fUid" />大学学生证明":"大学学生证明（仅适用全日制大学学生）
						</td>
					</tr>
					<tr>

						<td></td>
						<td><input type="checkbox" name="contract.fHouseCard" />房产证</td>
						<td></td>
						<td><input type="checkbox" name="contract.fDirvingCard" />行驶证
						</td>
						<td></td>
						<td><input type="checkbox" name="contract.fDirverCard" />驾驶证
						</td>

					</tr>
					<tr>

						<td></td>
						<td><input type="checkbox" name="contract.fOther" />其它</td>

						<td></td>

						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="button" value="上传各种证件图片" onclick="addfile()"
							style="height: 25px" /></td>
						<td colspan=2></td>
						<td></td>
						<td></td>
					</tr>
					<tr>

						<td>邮寄地址</td>
						<td><select id="postAddress" name="postAddress"
							onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="重庆市">重庆市</option>
						</select></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>


					<tr>
						<td colspan="6" align="left" class="tr8">收入资料</td>

					</tr>
					<tr>

						<td>* 月收入总额(元)</td>
						<td><input type="text" name="client.masterInMonth"
							maxlength="10" /></td>
						<td>其他收入(元/月)</td>
						<td><input type="text" name="client.otherInMonth"
							maxlength="10" /></td>
						<td>* 家庭月收入(元)</td>
						<td><input type="text" name="client.homeInMonth"
							maxlength="10" /></td>
					</tr>
					<tr>

						<td></td>
						<td></td>
						<td>其他收入来源</td>
						<td><input type="text" name="client.otherIncome"
							maxlength="10" /></td>
						<td></td>
						<td></td>
					</tr>

					<tr>
						<td colspan="6" align="left" class="tr8">所在单位信息</td>

					</tr>
					<tr>
						<td>* 单位名称或大学名称</td>
						<td><input type="text" name="client.onShortName"
							maxlength="20" /></td>
						<td>* 单位/学校/个体全称</td>
						<td><input type="text" name="client.onFullName"
							maxlength="20" /></td>
						<td>* 任职部门或班级</td>
						<td><input type="text" name="client.onDivision"
							maxlength="20" /></td>
					</tr>
					<tr>
						<td>* 总共工作经脸/总共大学学习时间</td>
						<td><select id="onWorkTime" name="client.onWorkTime"
							onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
								<option value="0-1年">0-1年</option>
								<option value="0-1年">1-2年</option>
								<option value="0-1年">2-3年</option>
								<option value="0-1年">3-5年</option>
								<option value="0-1年">5-10年</option>
								<option value="0-1年">大于10年</option>
						</select></td>
						<td>* 现工作时间/大学开始时间(以月为单位)</td>
						<td><input type="text" name="" maxlength="20" /></td>
						<td></td>
						<td></td>
					</tr>
					<tr>

						<td>* 行业类别</td>
						<td><select id="onWorkTime" name="client.onSector"
							onchange="document.getElementById('postAddress').value += ' ' + this.options[this.selectedIndex].text">
								<option value="IT">IT</option>
								<option value="金融">金融</option>
						</select></td>
						<td>* 职位</td>
						<td><select id="onOffice" name="client.onSector"
							onchange="document.getElementById('onOffice').value += ' ' + this.options[this.selectedIndex].text">
								<option value="经理">经理</option>
								<option value="总监">总监</option>
						</select></td>
						<td>单位性质</td>
						<td><select id="onFeature" name="client.onFeature"
							onchange="document.getElementById('onFeature').value += ' ' + this.options[this.selectedIndex].text">
								<option value="国有企业">国有企业</option>
								<option value="私有企业">私有企业</option>
						</select></td>
					</tr>

					<tr>

						<td>* 办公电话</td>
						<td><input type="text" name="client.onOfficePhone"
							maxlength="20" /></td>
						<td>办公电话分机</td>
						<td><input type="text" name="client.onExtPhone" /></td>
						<td></td>
						<td></td>
					</tr>
					<tr>

						<td>邮编</td>
						<td><input type="text" name="officeAddressBook.zipCode"
							maxlength="20" /></td>
						<td>* 省/直辖市</td>
						<td><select id="province4" name="officeAddressBook.province"
							onchange="document.getElementById('province4').value += ' ' + this.options[this.selectedIndex].text">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
						<td>* 市</td>
						<td><select id="city4" name="officeAddressBook.city"
							onchange="document.getElementById('city4').value += ' ' + this.options[this.selectedIndex].text">
								<option value="成都市">成都市</option>
								<option value="內江市">內江市</option>
						</select></td>
					</tr>

					<tr>

						<td>* 区/县区</td>
						<td><input type="text" name="officeAddressBook.county"
							maxlength="20" /></td>
						<td>镇</td>
						<td><input type="text" name="officeAddressBook.town"
							maxlength="20" /></td>
						<td>* 街道/路/村</td>
						<td><input type="text" name="officeAddressBook.street"
							maxlength="20" /></td>
					</tr>
					<tr>

						<td>* 小区/楼盘</td>
						<td><input type="text" name="officeAddressBook.community"
							maxlength="20" /></td>
						<td>栋/单元/房间号</td>
						<td><input type="text" name="officeAddressBook.houseNo"
							maxlength="20" /></td>
						<td>其它</td>
						<td><input type="text" name="officeAddressBook.other"
							maxlength="50" /></td>
					</tr>

					<tr>
						<td colspan="6" align="left" class="tr8">商品1</td>

					</tr>
					<tr>

						<td>商品</td>
						<td><input type="text" name="" /></td>
						<td>商品类型</td>
						<td><input type="text" name="" /></td>
						<td>价格（元）</td>
						<td><input type="text" name="" /></td>
					</tr>
					<tr>

						<td>品牌</td>
						<td><input type="text" name="" /></td>
						<td>型号</td>
						<td><input type="text" name="" /></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="6" align="left" class="tr8">信用信息</td>

					</tr>
					<tr>

						<td>产品</td>
						<td></td>
						<td>商品总价</td>
						<td><input type="text" name="clientJob.salePrice" readonly />
						</td>
						<td>贷款用途</td>
						<td></td>
					</tr>
					<tr>

						<td>自付金额(元)</td>
						<td><input type="text" name="clientJob.downAmount" readonly />
						<input type="hidden" name="clientJob.financialProductId" value="${pId }">
						</td>
						<td>分期期数</td>
						<td></td>
						<td>每月还款额(元)</td>
						<td></td>
					</tr>
					<tr>

						<td>贷款本金(元)</td>
						<td><input type="text" name="clientJob.creditAmount" readonly /></td>
						<td>首次还款日</td>
						<td><input type="text" name="clientJob.firstpayDate" readonly />
						</td>
						<td>每月还款日</td>
						<td><input type="text" name="clientJob.epaymentDate" readonly /></td>
					</tr>

					<tr>
						<td>* 客户银行卡号/账号</td>
						<td><input type="text" name="bank.debitCard"
							maxlength="24" /></td>
						<td>* 客户开户银行</td>
						<td><input type="text" name="bank.bankName"
							maxlength="50" /></td>
						<td>月花费(元/月)</td>
						<td><input type="text" name="bank.monthPay" /></td>
					</tr>

					<tr>
						<td>第二银行卡号</td>
						<td><input type="text" name="bank2.debitCard" /></td>
						<td>第二银行卡开户银行</td>
						<td><input type="text" name="bank2.bankName" /></td>
						<td colspan="1"></td>
						<td></td>
					</tr>

				</table>
				
				<table style="width:100%;text-align:center;">
					<tr>
						<td>用户</td>
						<td><input type="text" name="user.name"></input></td>
					</tr>
					
					<tr>
						<td>口令</td>
						<td><input type="password" name="pwdConfirm" /></td>
					</tr>
					
					<tr>
						<td colspan="2">
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
