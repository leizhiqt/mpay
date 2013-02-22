<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="Sale" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
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
 $(function () {
            $("#ischange").click(function () {
            	//alert("ssss");
                 $('#livingAddressBookZipCode').val($('#censusAddressBookZipCode').val())  ; //邮编
				 $('#livingAddressBookprovince').val($('#censusAddressBookprovince').val());
				 $('#livingAddressBookcity').val($('#censusAddressBookcity').val());
				 $('#livingAddressBookcounty').val($('#censusAddressBookcounty').val())  ;//区
				 $('#livingAddressBooktown').val($('#censusAddressBooktown').val())  ;//镇
				 $('#livingAddressBookstreet').val($('#censusAddressBookstreet').val()) ; //街
				 $('#livingAddressBookcommunity').val($('#censusAddressBookcommunity').val())  ;//楼
				 $('#livingAddressBookhouseNo').val($('#censusAddressBookhouseNo').val())  ;//房间号
				 $('#livingAddressBookother').val($('#censusAddressBookother').val())  ;//其它 
            })
            $("#ischange1").click(function () {
            	//alert("ssss");
                 $('#homeAddressBookzipCode').val($('#censusAddressBookZipCode').val())  ; //邮编
				 $('#homeAddressBookprovince').val($('#censusAddressBookprovince').val());
				 $('#homeAddressBookcity').val($('#censusAddressBookcity').val());
				 $('#homeAddressBookcounty').val($('#censusAddressBookcounty').val())  ;//区
				 $('#homeAddressBooktown').val($('#censusAddressBooktown').val())  ;//镇
				 $('#homeAddressBookstreet').val($('#censusAddressBookstreet').val()) ; //街
				 $('#homeAddressBookcommunity').val($('#censusAddressBookcommunity').val())  ;//楼
				 $('#homeAddressBookhouseNo').val($('#censusAddressBookhouseNo').val())  ;//房间号
				 $('#homeAddressBookother').val($('#censusAddressBookother').val())  ;//其它 
            })
});
 

</script>
<SCRIPT LANGUAGE="JavaScript">
function Dsy()
{
this.Items = {};
}
Dsy.prototype.add = function(id,iArray)
{
this.Items[id] = iArray;
}
Dsy.prototype.Exists = function(id)
{
if(typeof(this.Items[id]) == "undefined") return false;
return true;
}

function change(v){
var str="0";
for(i=0;i<v;i++){ str+=("_"+(document.getElementById(s[i]).selectedIndex-1));};
var ss=document.getElementById(s[v]);
with(ss){
length = 0;
options[0]=new Option(opt0[v],opt0[v]);
if(v && document.getElementById(s[v-1]).selectedIndex>0 || !v)
{
if(dsy.Exists(str)){
ar = dsy.Items[str];
for(i=0;i<ar.length;i++)options[length]=new Option(ar[i],ar[i]);
if(v)options[1].selected = true;
}
}
if(++v<s.length){change(v);}
}
}

function change1(v){
var str="0";
for(i=0;i<v;i++){ str+=("_"+(document.getElementById(st[i]).selectedIndex-1));};
var ss=document.getElementById(st[v]);
with(ss){
length = 0;
options[0]=new Option(opt0[v],opt0[v]);
if(v && document.getElementById(st[v-1]).selectedIndex>0 || !v)
{
if(dsy.Exists(str)){
ar = dsy.Items[str];
for(i=0;i<ar.length;i++)options[length]=new Option(ar[i],ar[i]);
if(v)options[1].selected = true;
}
}
if(++v<st.length){change(v);}
}
}

function change2(v){
var str="0";
for(i=0;i<v;i++){ str+=("_"+(document.getElementById(sk[i]).selectedIndex-1));};
var ss=document.getElementById(sk[v]);
with(ss){
length = 0;
options[0]=new Option(opt0[v],opt0[v]);
if(v && document.getElementById(sk[v-1]).selectedIndex>0 || !v)
{
if(dsy.Exists(str)){
ar = dsy.Items[str];
for(i=0;i<ar.length;i++)options[length]=new Option(ar[i],ar[i]);
if(v)options[1].selected = true;
}
}
if(++v<sk.length){change(v);}
}
}

function change3(v){
	var str="0";
	for(i=0;i<v;i++){ str+=("_"+(document.getElementById(sv[i]).selectedIndex-1));};
	var ss=document.getElementById(sv[v]);
	with(ss){
	length = 0;
	options[0]=new Option(opt0[v],opt0[v]);
	if(v && document.getElementById(sv[v-1]).selectedIndex>0 || !v)
	{
	if(dsy.Exists(str)){
	ar = dsy.Items[str];
	for(i=0;i<ar.length;i++)options[length]=new Option(ar[i],ar[i]);
	if(v)options[1].selected = true;
	}
	}
	if(++v<sv.length){change(v);}
	}
	}
var dsy = new Dsy();

dsy.add("0",["北京市","天津市","河北省","山西省","内蒙古","辽宁省","吉林省","黑龙江省","上海市","江苏省","浙江省","安徽省","福建省","江西省","山东省","河南省","湖北省","湖南省","广东省","广西自治区","海南省","重庆市","四川省","贵州省","云南省","西藏自治区","陕西省","甘肃省","青海省","宁夏回族自治区","新疆维吾尔自治区","香港特别行政区","澳门特别行政区","台湾省","其它"]);

dsy.add("0_0",["北京","东城区","西城区","崇文区","宣武区","朝阳区","丰台区","石景山区"," 海淀区（中关村）","门头沟区","房山区","通州区","顺义区","昌平区","大兴区","怀柔区","平谷区","密云县","延庆县","其他"]);
dsy.add("0_1",["和平区","河东区","河西区","南开区","红桥区","塘沽区","汉沽区","大港区","西青区","津南区","武清区","蓟县","宁河县","静海县","其他"]);
dsy.add("0_2",["石家庄市","张家口市","承德市","秦皇岛市","唐山市","廊坊市","衡水市","沧州市","邢台市","邯郸市","保定市","其他"]);
dsy.add("0_3",["太原市","朔州市","大同市","长治市","晋城市","忻州市","晋中市","临汾市","吕梁市","运城市","其他"]);
dsy.add("0_4",["呼和浩特市","包头市","赤峰市","呼伦贝尔市","鄂尔多斯市","乌兰察布市","巴彦淖尔市","兴安盟","阿拉善盟","锡林郭勒盟","其他"]);
dsy.add("0_5",["沈阳市","朝阳市","阜新市","铁岭市","抚顺市","丹东市","本溪市","辽阳市","鞍山市","大连市","营口市","盘锦市","锦州市","葫芦岛市","其他"]);
dsy.add("0_6",["长春市","白城市","吉林市","四平市","辽源市","通化市","白山市","延边朝鲜族自治州","其他"]);
dsy.add("0_7",["哈尔滨市","七台河市","黑河市","大庆市","齐齐哈尔市","伊春市","佳木斯市","双鸭山市","鸡西市","大兴安岭地区(加格达奇)","牡丹江","鹤岗市","绥化市　","其他"]);
dsy.add("0_8",["黄浦区","卢湾区","徐汇区","长宁区","静安区","普陀区","闸北区","虹口区","杨浦区","闵行区","宝山区","嘉定区","浦东新区","金山区","松江区","青浦区","南汇区","奉贤区","崇明县","其他"]);
dsy.add("0_9",["南京市","徐州市","连云港市","宿迁市","淮安市","盐城市","扬州市","泰州市","南通市","镇江市","常州市","无锡市","苏州市","其他"]);
dsy.add("0_10",["杭州市","湖州市","嘉兴市","舟山市","宁波市","绍兴市","衢州市","金华市","台州市","温州市","丽水市","其他"]);
dsy.add("0_11",["合肥市","宿州市","淮北市","亳州市","阜阳市","蚌埠市","淮南市","滁州市","马鞍山市","芜湖市","铜陵市","安庆市","黄山市","六安市","巢湖市","池州市","宣城市","其他"]);
dsy.add("0_12",["福州市","南平市","莆田市","三明市","泉州市","厦门市","漳州市","龙岩市","宁德市","其他"]);
dsy.add("0_13",["南昌市","九江市","景德镇市","鹰潭市","新余市","萍乡市","赣州市","上饶市","抚州市","宜春市","吉安市","其他"]);
dsy.add("0_14",["济南市","聊城市","德州市","东营市","淄博市","潍坊市","烟台市","威海市","青岛市","日照市","临沂市","枣庄市","济宁市","泰安市","莱芜市","滨州市","菏泽市","其他"]);
dsy.add("0_15",["郑州市","三门峡市","洛阳市","焦作市","新乡市","鹤壁市","安阳市","濮阳市","开封市","商丘市","许昌市","漯河市","平顶山市","南阳市","信阳市","周口市","驻马店市","其他"]);
dsy.add("0_16",["武汉市","十堰市","襄樊市","荆门市","孝感市","黄冈市","鄂州市","黄石市","咸宁市","荆州市","宜昌市","随州市","恩施土家族苗族自治州","仙桃市","天门市","潜江市","神农架林区","其他"]);
dsy.add("0_17",["长沙市","张家界市","常德市","益阳市","岳阳市","株洲市","湘潭市","衡阳市","郴州市","永州市","邵阳市","怀化市","娄底市","湘西土家族苗族自治州","其他"]);
dsy.add("0_18",["广州市","清远市市","韶关市","河源市","梅州市","潮州市","汕头市","揭阳市","汕尾市","惠州市","东莞市","深圳市","珠海市","中山市","江门市","佛山市","肇庆市","云浮市","阳江市","茂名市","湛江市","其他"]);
dsy.add("0_19",["南宁市","桂林市","柳州市","梧州市","贵港市","玉林市","钦州市","北海市","防城港市","崇左市","百色市","河池市","来宾市","贺州市","其他"]);
dsy.add("0_20",["海口市","三亚市","其他"]);
dsy.add("0_21",["渝中区","大渡口区","江北区","沙坪坝区","九龙坡区","南岸区","北碚区","万盛区","双桥区","渝北区","巴南区","万州区","涪陵区","黔江区","长寿区","合川市","永川市","江津市","南川市","綦江县","潼南县","铜梁县","大足县","璧山县","垫江县","武隆县","丰都县","城口县","开县","巫溪县","巫山县","奉节县","云阳县","忠县","石柱土家族自治县","彭水苗族土家族自治县","酉阳土家族苗族自治县","秀山土家族苗族自治县","其他"]);
dsy.add("0_22",["请选择","广元市","绵阳市","德阳市","南充市","广安市","遂宁市","内江市","乐山市","自贡市","泸州市","宜宾市","攀枝花市","巴中市","资阳市","眉山市","雅安","阿坝藏族羌族自治州","甘孜藏族自治州","凉山彝族自治州县","其他"]);
dsy.add("0_23",["贵阳市","六盘水市","遵义市","安顺市","毕节地区","铜仁地区","黔东南苗族侗族自治州","黔南布依族苗族自治州","黔西南布依族苗族自治州","其他"]);
dsy.add("0_24",["昆明市","曲靖市","玉溪市","保山市","昭通市","丽江市","普洱市","临沧市","宁德市","德宏傣族景颇族自治州","怒江傈僳族自治州","楚雄彝族自治州","红河哈尼族彝族自治州","文山壮族苗族自治州","大理白族自治州","迪庆藏族自治州","西双版纳傣族自治州","其他"]);
dsy.add("0_25",["拉萨市","那曲地区","昌都地区","林芝地区","山南地区","日喀则地区","阿里地区","其他"]);
dsy.add("0_26",["西安市","延安市","铜川市","渭南市","咸阳市","宝鸡市","汉中市","安康市","商洛市","其他"]);
dsy.add("0_27",["兰州市 ","嘉峪关市","金昌市","白银市","天水市","武威市","酒泉市","张掖市","庆阳市","平凉市","定西市","陇南市","临夏回族自治州","甘南藏族自治州","其他"]);
dsy.add("0_28",["西宁市","海东地区","海北藏族自治州","黄南藏族自治州","玉树藏族自治州","海南藏族自治州","果洛藏族自治州","海西蒙古族藏族自治州","其他"]);
dsy.add("0_29",["银川市","石嘴山市","吴忠市","固原市","中卫市","其他"]);
dsy.add("0_30",["乌鲁木齐市","克拉玛依市","喀什地区","阿克苏地区","和田地区","吐鲁番地区","哈密地区","塔城地区","阿勒泰地区","克孜勒苏柯尔克孜自治州","博尔塔拉蒙古自治州","昌吉回族自治州 伊犁哈萨克自治州","巴音郭楞蒙古自治州","河子市","阿拉尔市","五家渠市","图木舒克市","其他"]);
dsy.add("0_31",["香港","其他"]);
dsy.add("0_31",["澳门","其他"])
dsy.add("0_32",["台湾","其他"])
//-->
</SCRIPT>
<SCRIPT LANGUAGE = JavaScript>


var s=["censusAddressBookprovince","censusAddressBookcity"];
var opt0 = ["请选择","请选择"];
function setup()
{
for(i=0;i<s.length-1;i++)
document.getElementById(s[i]).onchange=new Function("change("+(i+1)+")");
change(0);
}

var st=["livingAddressBookprovince","livingAddressBookcity"];
var opt0 = ["请选择","请选择"];
function setups()
{
for(i=0;i<st.length-1;i++)
document.getElementById(st[i]).onchange=new Function("change1("+(i+1)+")");
change1(0);
}

var sk=["homeAddressBookprovince","homeAddressBookcity"];
var opt0 = ["请选择","请选择"];
function setupss()
{
for(i=0;i<sk.length-1;i++)
document.getElementById(sk[i]).onchange=new Function("change2("+(i+1)+")");
change2(0);
}

var sv=["officeAddressBook","officeAddressBookcity"];
var opt0 = ["请选择","请选择"];
function setupsv()
{
for(i=0;i<sv.length-1;i++)
document.getElementById(sv[i]).onchange=new Function("change3("+(i+1)+")");
change3(0);
}

//##联动菜单结束-->
</SCRIPT>
</head>

<body>
	<form method="post" enctype="multipart/form-data">
		<div id="gtop">
			<jsp:include page="../../incl/action.jsp">
				<jsp:param name="type" value="cancel" />
				<jsp:param name="key" value="Cancel" />
				<jsp:param name="action" value="Sale.do" />
				<jsp:param name="method" value="promptDeclare" />
			</jsp:include>
		</div>

		<div id="container">
			<%@ include file="../../incl/b_message.jsp"%>

			<div>
				<table border="1" class="lt"  >
					<tr height="10px" style="border: 1px solid #FFF;">

						<td colspan="" align="right"  >销售顾问代码</td>
						<td><c:out value="${UserName} "/>
						<td align="right"  ><b style="color:red">*</b> 内部代码</td>
						<td><select name="clientJob.privateKey" id="innerCode"
							> 
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
						</select></td>
						<td></td>
						<td align="left"  >(<b style="color:red">*</b>)必填项</td>

					</tr>
					<tr>
						<th align="left" colspan="6" class="tr8"  ><strong>客户资料</strong></th>
					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 客户照片上传</td>
						<td align="left" colspan="2"><input type="file" name="clientPhoto" /> </td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					<tr>

						<td align="right" ><b style="color:red">*</b> 姓名</td>
						<td align="left" width="240px" ><input type="text" name="client.clientName" value="${client.clientName }" onblur="calc(this)" data="msg1" maxlength="10" id="name"   /> <b id="msg1"></b></td>
					    <td></td>
						<td></td>
						<td align="right"  ><b style="color:red">*</b> 身份证号码</td>
						<td align="left"><input type="text" name="client.idNo"  value="${client.idNo }" onblur="calcIdCard()" id="card" /> <b id="msg2"></b></td>
					</tr>
					<tr>


						<td align="right"  >身份证截止日期</td>
						<td align="left"><input type="text" name="client.idEndDate" id="validity" value='<fmt:formatDate value="${client.idEndDate}" type="date" pattern="yyyy-MM-dd"/>'
							onclick="displayCalendar(this,'yyyy-MM-dd');" /></td>
					    <td></td>
						<td></td>
						<td align="right"  ><b style="color:red">*</b> 发证机关</td>
						<td align="left"><input type="text" name="client.idAuthority" maxlength="50" value="${client.idAuthority }" onblur="calc(this)" data="msg3" maxlength="20" id="msg" /> <b id="msg3"></b></td>
					</tr>


					<tr>
						<td align="right"  >SSI号码/学生号码</td>
				    <td align="left"><input type="text" name="client.otherNo" value="${client.otherNo}"/></td>
						<td align="right" width="260px" ><b style="color:red">*</b> 申请人年龄</td>
						<td align="left"><input type="text" name="client.age" maxlength="10" value="${client.age }" data="msg4"  id="ages" onblur="calc(this)" /> <b id="msg4"></b></td>
						<td align="right"  ><b style="color:red">*</b>本人手机号</td>
					    <td align="left"><input type="text" name="client.mobilePhone" value="${client.mobilePhone }" onblur="getphonearea(this.value)" /><b id="msg5"></b></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 性别</td>
						<td align="left"><select name="client.sex" id="sex"
							>
								<option value="男">男</option>
								<option value="女">女</option>
						</select></td>
					    <td align="right"  ><b style="color:red">*</b> 婚姻状况</td>
						<td align="left"><select name="client.marry" id="marry"
							>
								<option value="未婚">未婚</option>
								<option value="已婚">已婚</option>
								<option value="离异">离异</option>
								<option value="丧偶">丧偶</option>
						</select></td>
					    <td align="right"  ><b style="color:red">*</b> 手机号码归属地</td>
					    <td align="left"><input type="text" name="client.mobileAddress" data="msg6" value="${client.mobileAddress }"  id="addr" onblur="calc(this)" /> <b id="msg6"></b></td>
					</tr>
					<tr>

						<td align="right"  >子女数目</td>
				        <td align="left"><input type="text" name="client.childs" value="${client.childs }"/></td>
					    <td align="right"  ><b style="color:red">*</b> 住房</td>
				        <td align="left"><select id="housing" name="client.housing"
							>
								<option value="自有房">自有房</option>
								<option value="租住房">租住房</option>
								<option value="父母房产">父母房产</option>
								<option value="单位提供的福利房">单位提供的福利房</option>
								<option value="集体宿舍">集体宿舍</option>
						</select></td>
					    <td align="right"  ><b style="color:red">*</b> 教育程度</td>
						<td align="left"><select name="client.educationId" id="educationId"
							>
								<option value="0">小学</option>
								<option value="1">初中</option>
								<option value="2">高中</option>
								<option value="3">职高，中专，技术学校</option>
								<option value="4">大学</option>
								<option value="5">硕士及以上</option>
								
						</select></td>
					</tr>
					<tr>
						<td align="right"  >住宅电话登记人</td>
						<td align="left"><input type="text" name="client.homePhoneName" value="${ client.homePhoneName}"
							maxlength="20" /></td>
					    <td align="right"  >住宅/宿舍电话</td>
				        <td align="left"><input type="text" name="client.homePhone" value="${client.homePhone }"/></td>
					    <td align="right"  >电子邮箱</td>
					    <td align="left"><input type="text" name="client.email" value="${client.email}"/></td>
					</tr>

					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>配偶资料</strong></th>

					</tr>
					<tr>

						<td align="right"  >配偶姓名</td>
						<td align="left"><input type="text" name="client.spuseName" maxlength="20" value="${client.spuseName }"/>
						</td>
					    <td align="right"  >配偶移动电话</td>
				        <td align="left"><input type="text" name="client.spuseMobile" value="${ client.spuseMobile}"/></td>
					    <td align="right"  >身份证号码</td>
					    <td align="left"><input type="text" name="client.idSpuse" value="${client.idSpuse }"/></td>
					</tr>

					<tr>

						<td align="right"  >配偶雇主</td>
				        <td align="left"><input type="text" name="client.spuseHirer" value="${client.spuseHirer }"
							maxlength="20" /></td>
					    <td align="right"  >配偶办公电话</td>
				        <td align="left"><input type="text" name="client.spuseOfficePhone" value="${client.spuseOfficePhone }"/></td>
					    <td align="right"  >配偶办公电话分机</td>
					    <td align="left"><input type="text" name="client.spuseExtPhone" value="${client.spuseExtPhone }"/></td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>户籍地址</strong></th>

					</tr>
					<tr>

			   		  <td align="right"  >邮编</td>
			          <td align="left"><input type="text" name="censusAddressBook.zipCode" value="${censusAddressBook.zipCode}" id="censusAddressBookZipCode"
						maxlength="20" /></td>
				      <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
			          <td align="left"><select  name="censusAddressBook.province"  id="censusAddressBookprovince"
						>
							<option value="四川省">四川省</option>
							<option value="湖南省">湖南省</option>
							<option value="河北省">河北省</option>
					    </select></td>
				      <td align="right"  ><b style="color:red">*</b> 市</td>
			          <td align="left"><input type="text" name="censusAddressBook.city" id="censusAddressBookcity" />
					</tr>

					<tr>

						  <td align="right"  ><b style="color:red">*</b> 区/县区</td>
				          <td align="left"><input type="text" name="censusAddressBook.county" value="${censusAddressBook.county }" 
							maxlength="20" data="msg17"  id="censusAddressBookcounty" onblur="calc(this)" /> <b id="msg17"></b></td>
					      <td align="right"  >镇</td>
				          <td align="left"><input type="text" name="censusAddressBook.town"
							maxlength="20" id="censusAddressBooktown" /></td>
					      <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
					      <td align="left"><input type="text" name="censusAddressBook.street" value="${censusAddressBook.street }"
							maxlength="20" data="msg16"  id="censusAddressBookstreet" onblur="calc(this)" /> <b id="msg16"></b></td>
					</tr>
					<tr>

						 <td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				    <td align="left"><input type="text" name="censusAddressBook.community" value="${censusAddressBook.community }"
							maxlength="20" data="msg15"  id="censusAddressBookcommunity" onblur="calc(this)" /> <b id="msg15"></b></td>
					     <td align="right"  >栋/单元/房间号</td>
				    <td align="left"><input type="text" name="censusAddressBook.houseNo" id="censusAddressBookhouseNo" value="${censusAddressBook.houseNo}"
							maxlength="20" /></td>
					     <td align="right"  >其它</td>
					     <td align="left"><input type="text" name="censusAddressBook.other" id="censusAddressBookother" value="${ censusAddressBook.other}"
							maxlength="50" /></td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>现居住地址</strong></th>

					</tr>
					<tr>
						 <td align="right"  >现居住地地址同户籍地址</td>
						 <td align="left">
							<input type="checkbox" id="ischange" name="isSameWitcensusAdd"/></td>
				    	 <td align="right"  >你在现居住城市住了多久？</td>
				    	 <td align="left"><input type="text" name="client.livingMonth" /></td>
					     <td align="right"  >月</td>
						 <td></td>
					</tr>
					<tr>
	
					     <td align="right"  >邮编</td>
					     <td align="left"><input type="text" name="livingAddressBook.zipCode" value="${livingAddressBook.zipCode }" id="livingAddressBookZipCode"
								maxlength="10" /></td>
						 <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
					     <td align="left"><select  name="livingAddressBook.province"  id="livingAddressBookprovince"
								>
									<option value="四川省">四川省</option>
									<option value="湖南省">湖南省</option> 	 
									<option value="河北省">河北省</option>
							</select></td>
				   		  <td align="right"  ><b style="color:red">*</b> 市</td>
					      <td align="left"><input  name="livingAddressBook.city" id="livingAddressBookcity" type="text"/>
									</td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
				    <td align="left"><input type="text" name="livingAddressBook.county" value="${livingAddressBook.county }"
							maxlength="20" data="msg14"  id="livingAddressBookcounty" onblur="calc(this)" /> <b id="msg14"></b></td>
					    <td align="right"  >镇</td>
				        <td align="left"><input type="text" name="livingAddressBook.town"   id="livingAddressBooktown" value="${livingAddressBook.town }"
							maxlength="20" /></td>
					    <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
						<td align="left"><input type="text" name="livingAddressBook.street" value="${livingAddressBook.street }"
							maxlength="20" data="msg13"  id="livingAddressBookstreet" onblur="calc(this)" /> <b id="msg13"></b></td>
					</tr>
					<tr>

					  <td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				  	  <td align="left"><input type="text" name="livingAddressBook.community" value="${livingAddressBook.community }"
							maxlength="20" data="msg12"  id="livingAddressBookcommunity" onblur="calc(this)" /> <b id="msg12"></b></td>
					  <td align="right"  >栋/单元/房间号</td>
					  <td align="left"><input type="text"  id="livingAddressBookhouseNo" name="livingAddressBook.houseNo" value="${livingAddressBook.houseNo }"
							maxlength="20" /></td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>家庭信息</strong></th>

					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 家庭成员名称</td>
						<td align="left"><input type="text" name="client.homeName" maxlength="20" value="${client.homeName }" data="msg11"  id="ming" onblur="calc(this)" /> <b id="msg11"></b></td>
					    <td align="right"  ><b style="color:red">*</b> 家庭成员类型</td>
				        <td align="left">
                        <select  name="client.homeType" >
								<option value="请选择">请选择</option>                        
								<option value="父亲">父亲</option>
								<option value="母亲">母亲</option>
								<option value="兄弟">兄弟</option>
 								<option value="姐妹">姐妹</option>
								<option value="儿子">儿子</option>
								<option value="女儿">女儿</option>
								<option value="其他">其他</option>
                           
						</select>
                        </td>
					    <td align="right"  ><b style="color:red">*</b>家庭成员电话号</td>
					    <td align="left"><input type="text" name="client.homeTelephone" value="${ client.homeTelephone}" onblur="calc(this)" data="msg40"/></td>
					</tr>
					<tr>
						<td align="right"  >家庭成员地址与户籍地址相同</td>
					    <td align="left"><input type="checkbox" 
							id="ischange1" style="margin-left: 10px" /></td>
				   		<td  ></td>
						<td></td>
						<td  ></td>
						<td></td>
					</tr>
					<tr>

						<td align="right"  >邮编</td>
				  		<td align="left"><input type="text" name="homeAddressBook.zipCode" id="homeAddressBookzipCode" value="${ homeAddressBook.zipCode}"
							maxlength="20" /></td>
					    <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
				        <td align="left"><select  name="homeAddressBook.province" id="homeAddressBookprovince"
							>
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
					    <td align="right"  ><b style="color:red">*</b> 市</td>
				        <td align="left"><input type="text" name="homeAddressBook.city" id="homeAddressBookcity"/>
							</td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
				        <td align="left"><input type="text" name="homeAddressBook.county" id="homeAddressBookcounty" value="${ homeAddressBook.county}"
							maxlength="20" data="msg7"  id="qu" onblur="calc(this)" /> <b id="msg7"></b></td>
					    <td align="right"  >镇</td>
				        <td align="left"><input type="text" id="homeAddressBooktown" name="homeAddressBook.town" value="${homeAddressBook.town}"
							maxlength="20" /></td>
					    <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
					    <td align="left"><input type="text" id="homeAddressBookstreet" name="homeAddressBook.street" value="${homeAddressBook.street}"
							maxlength="20" data="msg18"  id="jlc" onblur="calc(this)" /> <b id="msg18"></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				        <td align="left"><input type="text" id="homeAddressBookcommunity" name="homeAddressBook.community" value="${homeAddressBook.community }"
							maxlength="20"  data="msg8"  id="lou" onblur="calc(this)" /> <b id="msg8"></b> </td>
					    <td align="right"  >栋/单元/房间号</td>
				        <td align="left"><input type="text" id="homeAddressBookhouseNo" name="homeAddressBook.houseNo" value="${homeAddressBook.houseNo }"
							maxlength="20" /></td>
					    <td align="right"  >其它</td>
					    <td align="left"><input type="text" id="homeAddressBookother" name="homeAddressBook.other" value="${homeAddressBook.other }"
							maxlength="50" /></td>
					</tr>
					<tr >
						<th colspan="6" align="left" class="tr8"><strong>其他联系人资料</strong></th>

					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 联系人姓名</td>
				        <td align="left"><input type="text" name="client.otherContacts" value="${client.otherContacts }" data="msg20"  id="nam" onblur="calc(this)" /> <b id="msg20"></td>
					    <td align="right"  >与申请人关系</td>
				        <td align="left"><select id="otherNexus" name="client.otherNexus"
							>
                            	<option value="请选择">请选择</option>
								<option value="配偶">配偶</option>
								<option value="父母">父母</option>
								<option value="子女">子女</option>
								<option value="亲戚">亲戚</option>
								<option value="同事">同事</option>
								<option value="同学">同学</option>
								<option value="其他">其他</option>

						</select></td>
					    <td align="right"  ><b style="color:red">*</b> 联系电话</td>
					    <td align="left"><input type="text" name="client.otherPhone" value="${client.otherPhone }" onblur="getphon(this.value)" /><b id="msg9"></b></td>
					</tr>
					<tr>

						<td align="right"  >销售顾问备注</td>
					    <td align="left" colspan="5"><input type="text"
							name="clientJob.saleRemark"  value="${clientJob.saleRemark}" size="135" /></td>

					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>文件</strong></th>

					</tr>
					<tr>

						<td width="60" align="right">身份证</td>
				   	 <td align="left" width="272"><input type="file" name="contract.fIdCode" value="${ contract.fIdCode}"/></td>

						<td align="right">社保卡</td>
						<td colspan="3" align="left"><input type="file" name="contract.fSocialCard" value="${contract.fSocialCard }"/></td>

				    </tr>
					<tr>

						<td align="right">银行卡</td>
				    <td align="left"><input type="file" name="contract.fBankCard" /></td>

						<td align="right">银行对账单</td>
						<td colspan="3" align="left"><input type="file" name="contract.fBankStatement" /></td>

				    </tr>
					<tr>
						<td align="right">户口本</td>
						<td align="left"><input type="file" name="contract.fResidenceBooklet" /></td>

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

						<td colspan="3" align="left"><input type="file" name="contract.fUid" /></td>
					</tr>
					<tr>
						<td align="right">银行存折</td>
						<td align="left"><input type="file" name="contract.fBankDeposit" /></td>
					    <td align="right">驾驶证</td>
                        <td colspan="3" align="left"><input type="file" name="contract.fDirverCard" /></td>
					</tr>
					<tr>

						<td align="right"  >其它</td>
						<td align="left"><input type="file" name="contract.fOther" value="${contract.fOther }"/></td>
					    <td align="right">邮寄地址</td>
						<td colspan="3" align="left"><select id="postAddress" name="postAddress"
							>
					        <option value="户籍地址">户籍地址</option>
						    <option value="家庭地址">家庭地址</option>
						     <option value="现居地址">现居地址</option>
				        </select></td>
					</tr>


					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>收入资料</strong></th>

					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 月收入总额(元)</td>
						<td align="left"><input type="text" name="client.masterInMonth" value="${client.masterInMonth }"
							maxlength="10" data="msg21"  id="shour" onblur="calc(this)" /> <b id="msg21"></b></td>
						<td align="right"  >其他收入(元/月)</td>
				        <td align="left"><input type="text" name="client.otherInMonth" value="${client.otherInMonth }"
							maxlength="10" /></td>
					    <td align="right"  ><b style="color:red">*</b> 家庭月收入(元)</td>
						<td align="left"><input type="text" name="client.homeInMonth" value="${client.homeInMonth }"
							maxlength="10" data="msg22"  id="yue" onblur="calc(this)" /> <b id="msg22"></b></td>
					</tr>
					<tr>

						<td  ></td>
						<td align="left"></td>
						<td align="right"  >其他收入来源</td>
				        <td align="left"><input type="text" name="client.otherIncome" value="${client.otherIncome }"
							maxlength="10" /></td>
					    <td  ></td>
						<td></td>
					</tr>

					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>所在单位信息</strong></th>

					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 单位名称或大学名称</td>
						<td align="left"><select id="onWorkTime" name="client.onShortName" >
								<option value="公司或个人">公司或个人</option>
								<option value="大学">大学</option>
						</select>
						</td>
						<td align="right"  ><b style="color:red">*</b> 单位/学校/个体全称</td>
				        <td align="left"><input type="text" name="client.onFullName" value="${client.onFullName }"
							maxlength="20" data="msg24"  id="collegename" onblur="calc(this)" /> <b id="msg24"></b></td>
					    <td align="right"  ><b style="color:red">*</b> 任职部门或班级</td>
						<td align="left"><input type="text" name="client.onDivision" value="${client.onDivision }"
							maxlength="20" data="msg25"  id="collegebumen" onblur="calc(this)" /> <b id="msg25"></b></td>
					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 总共工作经脸/总共大学学习时间</td>
						<td align="left"><select id="onWorkTime" name="client.onWorkTime">
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
						<td align="left"><select id="onWorkTime" name="client.onSector" style="width:50px"
							>
								<option value="餐饮，酒店，旅游，美容美发保健">餐饮，酒店，旅游，美容美发保健</option>
								<option value="农业，林业，畜牧业和渔业">农业，林业，畜牧业和渔业</option>
								<option value="建筑">建筑</option>
								<option value="文化，运动，娱乐，传媒，广告设计">文化，运动，娱乐，传媒，广告设计</option>
								<option value="教育">教育</option>
								<option value="金融机构，专业性事务机构">金融机构，专业性事务机构</option>
								<option value="政府机构，社会团体">政府机构，社会团体</option>
								<option value="计算机，电信，通讯，互联网">计算机，电信，通讯，互联网</option>
								<option value="制造，快速消费品，耐用消费品">制造，快速消费品，耐用消费品</option>
								<option value="军队">军队</option>
								<option value="电力，煤气，和水的生产和供应">电力，煤气，和水的生产和供应</option>
								<option value="能源，化工，矿产">能源，化工，矿产</option>
								<option value="个体，自营，退休，居住，家政和其他服务">个体，自营，退休，居住，家政和其他服务</option>
								<option value="科研技术服务和地质勘探">科研技术服务和地质勘探</option>
								<option value="事业单位，公共设施，医疗卫生，社会保障和社会福利">事业单位，公共设施，医疗卫生，社会保障和社会福利</option>
								<option value="租赁和商业服务">租赁和商业服务</option>
								<option value="交通，运输，仓储，邮电和物流">交通，运输，仓储，邮电和物流</option>
								<option value="批发和零售贸品">批发和零售贸品</option>
						</select></td>
						<td align="right"  ><b style="color:red">*</b> 职位</td>
				        <td align="left"><select id="onOffice" name="client.onOffice" style="width:50px"
							>
								<option value="高层管理人员/总监以上/局级以上干部">高层管理人员/总监以上/局级以上干部</option>
								<option value="中层管理人员/经理以上/科级以上干部">中层管理人员/经理以上/科级以上干部</option>
								<option value="基层管理人员/主管组长/科员">基层管理人员/主管组长/科员</option>
								<option value="一般员工">一般员工</option>
								<option value="工人（包括生产，加工，建筑和设备操作人员及有关人员）">工人（包括生产，加工，建筑和设备操作人员及有关人员）</option>
								<option value="销售/中介/业务代表/促销">销售/中介/业务代表/促销</option>
								<option value="商业，服务人员">商业，服务人员</option>
								<option value="保安/治安/防损">保安/治安/防损</option>
								<option value="农民">农民</option>
								<option value="个体">个体</option>
								<option value="专业技术人员">专业技术人员</option>
								<option value="军人">军人</option>
								<option value="司机">司机</option>
								<option value="退休">退休</option>
								<option value="其他">其他</option>
								
						</select></td>
					    <td align="right"  >单位性质</td>
						<td align="left"><select id="onFeature" name="client.onFeature"
							>
								<option value="国有企业">国有企业</option>
								<option value="私有企业">私有企业</option>
								<option value="个体">个体</option>
								<option value="集体">集体</option>
								<option value="外商独资">外商独资</option>
								<option value="外商合资">外商合资</option>
								<option value="其他">其他</option>
								<option value="农民">农民</option>
						</select></td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 办公电话</td>
						<td align="left"><input type="text" name="client.onOfficePhone" value="${client.onOfficePhone}"
							maxlength="20" name="client.otherPhone" onblur="getphons(this.value)" /><b id="msg30"></b></td>
						<td align="right"  >办公电话分机</td>
				        <td align="left"><input type="text" name="client.onExtPhone" value="${client.onExtPhone }"/></td>
					    <td align="right"  ></td>
						<td align="left"></td>
					</tr>
					<tr>

						<td align="right"  >邮编</td>
						<td align="left"><input type="text" name="officeAddressBook.zipCode" value="${ officeAddressBook.zipCode}"
							maxlength="20" /></td>
						<td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
				        <td align="left">
				        <select name="officeAddressBook.province"  id="officeAddressBook">
								<option value="四川省">四川省</option>
								<option value="湖南省">湖南省</option>
								<option value="河北省">河北省</option>
						</select></td>
					    <td align="right"  ><b style="color:red">*</b> 市</td>
						<td align="left"><input type="text" id="city4" name="officeAddressBook.city" />
								</td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
						<td align="left"><input type="text" name="officeAddressBook.county" value="${officeAddressBook.county }"
							maxlength="20" data="msg31"  id="co" onblur="calc(this)" /> <b id="msg31"></b></td>
						<td align="right"  >镇</td>
				        <td align="left"><input type="text" name="officeAddressBook.town" value="${officeAddressBook.town }"
							maxlength="20" /></td>
					    <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
						<td align="left"><input type="text" name="officeAddressBook.street" value="${officeAddressBook.street }"
							maxlength="20" data="msg32"  id="coll" onblur="calc(this)" /> <b id="msg32"></b></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
						<td align="left"><input type="text" name="officeAddressBook.community" value="${ officeAddressBook.community}"
							maxlength="20" data="msg33"  id="loupan" onblur="calc(this)" /> <b id="msg33"></b></td>
						<td align="right"  >栋/单元/房间号</td>
				        <td align="left"><input type="text" name="officeAddressBook.houseNo" value="${officeAddressBook.houseNo }"
							maxlength="20" /></td>
					    <td align="right"  >其它</td>
						<td align="left"><input type="text" name="officeAddressBook.other" value="${officeAddressBook.other }"
							maxlength="50" /></td>
					</tr>

					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>商品1</strong></th>

					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 商品1</td>
						<td align="left"><input type="text" name="oSale.saleName" /></td>
						<td align="right"  >商品类型</td>
				        <td align="left"><input type="text" name="" /></td>
					    <td align="right"  >价格（元）</td>
						<td align="left"><input type="text" name="oSale.salePrice" /></td>
					</tr>
					<tr>

						<td align="right"  >品牌</td>
						<td align="left"><input type="text" name="oSale.brand" /></td>
						<td align="right"  >型号</td>
				        <td align="left"><input type="text" name="oSale.modelNo" /></td>
					    <td align="right"  ></td>
						<td></td>
					</tr>
                   <tr  >
						<th colspan="6" align="left" class="tr8"><strong>商品2</strong> </th>

					</tr>
					<tr>

						<td align="right"  >商品2</td>
						<td align="left"><input type="text" name="tSale.saleName" /></td>
						<td align="right"  >商品类型</td>
				        <td align="left"><input type="text" name="" /></td>
					    <td align="right"  >价格（元）</td>
						<td align="left"><input type="text" name="tSale.salePrice" /></td>
					</tr>
					<tr>

						<td align="right"  >品牌</td>
						<td align="left"><input type="text" name="tSale.brand" /></td>
						<td align="right"  >型号</td>
				        <td align="left"><input type="text" name="tSale.modelNo" /></td>
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
							<c:out value="${totalPrice }"/><input type="text" name="clientJob.totalPrice"  value="${totalPrice }"/>
						</td>
					  	<td align="right">贷款用途</td>
						<td align="left"><select id="city4" name="clientJob.byUse"  style="width:70px;"
						>
								<option value="请选择">请选择</option>
								<option value="家用电器">家用电器</option>
                                <option value="家具及住宅装饰用品">家具及住宅装饰用品</option>
                                <option value="计算机与办公室通讯（私人用途）">计算机与办公室通讯（私人用途）</option>
                                <option value="时尚电子产品">时尚电子产品</option>
                                <option value="其他">其他</option>
						</select></td>
					</tr>
					<tr>

						<td align="right"  >自付金额(元)</td>
						
						<td align="left">
							<c:out value="${selfAmount }"/><input type="text" name="clientJob.selfAmount"  value="${selfAmount }"/>
						</td>
						<td align="right"  >分期期数</td>
						
					    <td align="left"><c:out value="${financialProduct.cycleTotal }"/> </td>
						<td  align="right">每月还款额(元)</td>
						<td align="left"><input type="text" name="clientJob.monthOfPay"  value="${monthPay1 }"/></td>
						
						
					</tr>
					<tr>
						
						<td align="right"  >贷款本金(元)</td>
						<td align="left"><c:out value="${totalPrice-selfAmount } "/></td>
						<td align="right"  ></td>
						<td align="left"></td>
						<td  align="right">每月还款日</td>
						
						<td align="left">
						<input type="text" name="clientJob.monthOfDate"  value ="<fmt:formatDate value="${monthOfDay}" type="date" pattern="yyyy-MM-dd"/>"/></td>			 
					</tr>

					<tr>
					    
						<td align="right"  ><b style="color:red">*</b> 客户银行卡号/账号</td>
						<td align="left"><input type="text" name="oBank.debitCard"
							maxlength="24" /></td>
						<td align="right"  ><b style="color:red">*</b> 客户开户银行</td>
				        <td align="left"><input type="text" name="oBank.bankName"
							maxlength="50" /></td>
						<td  align="right">月花费(元/月)</td>
						<td align="left"><input type="text" name="oBank.monthPay" /></td>
					
					</tr>

					<tr>
						
						<td align="right"  >第二银行卡号</td>
						<td align="left"><input type="text" name="tBank.debitCard" /></td>
						<td align="right"  >第二银行卡开户银行</td>
				    	<td align="left"><input type="text" name="tBank.bankName" /></td>
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
								<jsp:param name="key" value="Confirm" />
								<jsp:param name="action" value="Sale.do" />
								<jsp:param name="method" value="processAdd" />
							</jsp:include>
						</td>
					</tr>

				</table>
			</div>

			<jsp:include page="../../incl/g_footer.jsp" />
		</div>
	</form>
   <SCRIPT language="javascript">
   setups()
   </SCRIPT>
   <SCRIPT language="javascript">
   setup()
   </SCRIPT>
    <SCRIPT language="javascript">
   setupss()
   </SCRIPT>
    <SCRIPT language="javascript">
    setupsv()
   </SCRIPT>
</body>

	</html>
</fmt:bundle>
