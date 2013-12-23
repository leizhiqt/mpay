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
						<td> <c:out value="${clientJob.privateKey} "/></td>
						<td></td>
						<td align="left"  >(<b style="color:red">*</b>)必填项</td>

					</tr>
					<tr>
						<th align="left" colspan="6" class="tr8"  ><strong>客户资料</strong></th>
					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 客户照片上传</td>
						<td align="left" colspan="5"><input type="file" name="clientPhoto"  /> </td>
					</tr>
					<tr>

						<td align="right" ><b style="color:red">*</b> 姓名</td>
						<td align="left" width="240px" ><c:out value="${client.clientName}"/> </td>
					    <td align="right"><b style="color:red">*</b> 申请人年龄</td>
					  <td align="left"><c:out value="${client.age}"/></td>
						<td align="right"  ><b style="color:red">*</b> 身份证号码</td>
						<td align="left"><c:out value="${client.idNo}"/></td>
					</tr>
					<tr>


						<td align="right"  >身份证截止日期</td>
						<td align="left"><fmt:formatDate value="${clientJob.monthOfDate}" type="date" pattern="yyyy-MM-dd"/></td>
					    <td align="right"><b style="color:red">*</b> 婚姻状况</td>
						<td align="left">
                        <c:out value="${client.marry}"/> 
                        </td>
					  <td align="right"  ><b style="color:red">*</b> 发证机关</td>
						<td align="left">
                        <c:out value="${client.idAuthority}"/>
                        </td>
					</tr>


					<tr>
						<td align="right"  >SSI号码/学生号码</td>
				    <td align="left"> <c:out value="${client.otherNo}"/></td>
						<td align="right" width="260px" ><b style="color:red">*</b> 住房</td>
						<td align="left"><c:out value="${client.housing}"/></td>
						<td align="right"  ><b style="color:red">*</b>本人手机号</td>
					    <td align="left"><c:out value="${client.mobilePhone}"/>
                        </td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 性别</td>
						<td align="left"><c:out value="${client.sex}"/></td>
					    <td align="right"  >住宅/宿舍电话</td>
						<td align="left"><c:out value="${client.homePhone}"/></td>
					    <td align="right"  ><b style="color:red">*</b> 手机号码归属地</td>
					    <td align="left"><c:out value="${client.mobileAddress}"/></td>
					</tr>
					<tr>

						<td align="right"  >子女数目</td>
				        <td align="left"><c:out value="${client.childs}"/></td>
					    <td align="right"  >QQ:</td>
				        <td align="left"><c:out value="${client.qq}"/></td>
					    <td align="right"  ><b style="color:red">*</b> 教育程度</td>
						<td align="left"><c:out value="${client.educationId}"/>
                        </td>
					</tr>
					<tr>
						<td align="right"  >住宅电话登记人</td>
						<td align="left"><c:out value="${client.homePhoneName}"/></td>
					    <td align="right"  >淘宝账号：</td>
				        <td align="left"><c:out value="${client.tbao}"/></td>
					    <td align="right"  >电子邮箱</td>
					    <td align="left"><c:out value="${client.email}"/></td>
					</tr>


					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>配偶资料</strong></th>

					</tr>
					<tr>

						<td align="right"  >配偶姓名</td>
						<td align="left"><c:out value="${client.spuseName}"/>
						</td>
					    <td align="right"  >配偶移动电话</td>
				        <td align="left"><c:out value="${client.spuseMobile}"/>
                        </td>
					    <td align="right"  >身份证号码</td>
					    <td align="left"><c:out value="${client.idSpuse}"/>
                        </td>
					</tr>

					<tr>

						<td align="right"  >配偶雇主</td>
				        <td align="left"><c:out value="${client.spuseHirer}"/>
                        </td>
					    <td align="right"  >配偶办公电话</td>
				        <td align="left"><c:out value="${client.spuseOfficePhone}"/>
                        </td>
					    <td align="right"  >配偶办公电话分机</td>
					    <td align="left"><c:out value="${client.spuseExtPhone}"/>
                        </td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>户籍地址</strong></th>

					</tr>
					<tr>

			   		  <td align="right"  >邮编</td>
			          <td align="left"><c:out value="${censusAddressBook.zipCode}"/>
                      </td>
				      <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
			          <td align="left"><c:out value="${censusAddressBook.province}"/>
                      </td>
				      <td align="right"  ><b style="color:red">*</b> 市</td>
			          <td align="left"><c:out value="${censusAddressBook.city}"/>
					</tr>

					<tr>

						  <td align="right"  ><b style="color:red">*</b> 区/县区</td>
				          <td align="left"><c:out value="${censusAddressBook.county}"/></td>
					      <td align="right"  >镇</td>
				          <td align="left"><c:out value="${censusAddressBook.town}"/></td>
					      <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
					      <td align="left"><c:out value="${censusAddressBook.street}"/></td>
					</tr>
					<tr>

						 <td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				    <td align="left"><c:out value="${censusAddressBook.community}"/></td>
					     <td align="right"  >栋/单元/房间号</td>
				    <td align="left"><c:out value="${censusAddressBook.houseNo}"/>
                    </td>
					     <td align="right"  >其它</td>
					     <td align="left"><c:out value="${censusAddressBook.other}"/></td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>现居住地址</strong></th>

					</tr>
					<tr>
						 <td align="right"  >现居住地地址同户籍地址</td>
						 <td align="left">
							<input type="checkbox" id="ischange" name="isSameWitcensusAdd"/></td>
				    	 <td align="right"  >你在现居住城市住了多久？</td>
				    	 <td align="left"><input type="text" name="" /></td>
					     <td align="right"  >月</td>
						 <td></td>
					</tr>
					<tr>
	
					     <td align="right"  >邮编</td>
					     <td align="left"><c:out value="${livingAddressBook.zipCode}"/></td>
						 <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
					     <td align="left"><c:out value="${livingAddressBookprovince}"/></td>
				   		  <td align="right"  ><b style="color:red">*</b> 市</td>
					      <td align="left"><c:out value="${livingAddressBook.city}"/>
									</td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
				    <td align="left"><c:out value="${livingAddressBook.county}"/></td>
					    <td align="right"  >镇</td>
				        <td align="left"><c:out value="${livingAddressBook.town}"/>
                        </td>
					    <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
						<td align="left"><c:out value="${livingAddressBook.street}"/></td>
					</tr>
					<tr>

					  <td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				  	  <td align="left"><c:out value="${livingAddressBook.community}"/>
                      </td>
					  <td align="right"  >栋/单元/房间号</td>
					  <td align="left"><c:out value="${livingAddressBookhouseNo}"/>
                      </td>
					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>家庭信息</strong></th>

					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 家庭成员名称</td>
						<td align="left"><c:out value="${client.homeName}"/></td>
					    <td align="right"  ><b style="color:red">*</b> 家庭成员类型</td>
				        <td align="left"><c:out value="${client.homeType}"/>
                        </td>
					    <td align="right"  ><b style="color:red">*</b>家庭成员电话号</td>
					    <td align="left"><c:out value="${client.homeTelephone}"/>
                        </td>
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
				  		<td align="left"><c:out value="${homeAddressBook.zipCode}"/>
                        </td>
					    <td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
				        <td align="left"><c:out value="${homeAddressBook.province}"/>
                        </td>
					    <td align="right"  ><b style="color:red">*</b> 市</td>
				        <td align="left"><c:out value="${homeAddressBook.city}"/>
						</td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
				        <td align="left"><c:out value="${homeAddressBook.county}"/></td>
					    <td align="right"  >镇</td>
				        <td align="left"><c:out value="${homeAddressBook.town}"/></td>
					    <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
					    <td align="left"><c:out value="${homeAddressBook.street}"/></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
				        <td align="left"><c:out value="${homeAddressBook.community}"/> </td>
					    <td align="right"  >栋/单元/房间号</td>
				        <td align="left"><c:out value="${homeAddressBookhouseNo}"/></td>
					    <td align="right"  >其它</td>
					    <td align="left"><c:out value="${homeAddressBook.other}"/></td>
					</tr>
					<tr >
						<th colspan="6" align="left" class="tr8"><strong>其他联系人资料</strong></th>

					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 联系人姓名</td>
				        <td align="left"><c:out value="${client.otherContacts}"/></td>
					    <td align="right"  >与申请人关系</td>
				        <td align="left"><c:out value="${client.otherNexus}"/>
                        </td>
					    <td align="right"  ><b style="color:red">*</b> 联系电话</td>
					    <td align="left"><c:out value="${client.otherPhone}"/>
                        </td>
					</tr>
					<tr>

						<td align="right"  >销售顾问备注</td>
					    <td align="left" colspan="5"><c:out value="${clientJob.saleRemark}"/> </td>

					</tr>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>文件</strong></th>

					</tr>
					<tr>
						<td width="60" align="right">身份证</td>
				   	 <td align="left" width="272"><c:out value="${contract.fIdCode}"/></td>

						<td align="right">社保卡</td>
						<td colspan="3" align="left"><c:out value="${contract.fSocialCard}"/></td>

				    </tr>
					<tr>

						<td align="right">银行卡</td>
				    <td align="left"><c:out value="${contract.fBankCard}"/></td>

						<td align="right">银行对账单</td>
						<td colspan="3" align="left"><c:out value="${contract.fBankStatement}"/></td>

				    </tr>
					<tr>
						<td align="right">户口本</td>
						<td align="left"><c:out value="${contract.fResidenceBooklet}"/></td>

						<td align="right">大学学生证</td>
						<td colspan="3" align="left"><c:out value="${contract.fSid}"/>				  
					</tr>
					<tr>

						<td align="right">房产证</td>
				    <td align="left"><c:out value="${contract.fHouseCard}"/></td>
						<td align="right">行驶证</td>
						<td colspan="3" align="left"><c:out value="${contract.fDirvingCard}"/></td>
				    </tr>
					<tr>

						<td align="right">工卡</td>
					    <td align="left"><c:out value="${contract.fWorkCard}"/></td>

					  	<td align="right">大学学生证明（仅适用全日制大学学生)</td>

						<td colspan="3" align="left"><c:out value="${contract.fUid}"/></td>
					</tr>
					<tr>
						<td align="right">银行存折</td>
						<td align="left"><c:out value="${contract.fBankDeposit}"/></td>
					    <td align="right">驾驶证</td>
                        <td colspan="3" align="left"><c:out value="${contract.fDirverCard}"/></td>
					</tr>
					<tr>

						<td align="right"  >其它</td>
						<td align="left"><c:out value="${contract.fOther}"/></td>
					    <td align="right">邮寄地址</td>
						<td colspan="3" align="left"><c:out value="${postAddress}"/></td>
					</tr>


					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>收入资料</strong></th>

					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 月收入总额(元)</td>
						<td align="left"><c:out value="${client.masterInMonth}"/></td>
						<td align="right"  >其他收入(元/月)</td>
				        <td align="left"><c:out value="${client.otherInMonth}"/></td>
					    <td align="right"  ><b style="color:red">*</b> 家庭月收入(元)</td>
						<td align="left"><c:out value="${client.homeInMonth}"/></td>
					</tr>
					<tr>

						<td  ></td>
						<td align="left"></td>
						<td align="right"  >其他收入来源</td>
				        <td align="left"><c:out value="${client.otherIncome}"/></td>
					    <td  ></td>
						<td></td>
					</tr>

					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>所在单位信息</strong></th>

					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 单位名称或大学名称</td>
						<td align="left"><c:out value="${client.onShortName}"/>
						</td>
						<td align="right"  ><b style="color:red">*</b> 单位/学校/个体全称</td>
				        <td align="left"><c:out value="${client.onFullName}"/>
                        </td>
					    <td align="right"  ><b style="color:red">*</b> 任职部门或班级</td>
						<td align="left"><c:out value="${client.onDivision}"/>
                        </td>
					</tr>
					<tr>
						<td align="right"  ><b style="color:red">*</b> 总共工作经脸/总共大学学习时间</td>
						<td align="left"><c:out value="${client.onWorkTime}"/></td>
						<td align="right"  ><b style="color:red">*</b> 现工作时间/大学开始时间(以月为单位)</td>
				        <td align="left"> <input type="text" name="" maxlength="20" data="msg26"  id="college1" onBlur="calc(this)" /> <b id="msg26"></b></td>
					    <td align="right"  ></td>
						<td align="left"></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 行业类别</td>
						<td align="left"><c:out value="${client.onSector}"/>
                        </td>
						<td align="right"  ><b style="color:red">*</b> 职位</td>
				        <td align="left"><c:out value="${client.onOffice}"/>
                        </td>
					    <td align="right"  >单位性质</td>
						<td align="left"><c:out value="${client.onFeature}"/>
                        </td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 办公电话</td>
						<td align="left"><c:out value="${client.onOfficePhone}"/>
                        </td>
						<td align="right"  >办公电话分机</td>
				        <td align="left"> <c:out value="${client.onExtPhone}"/></td>
					    <td align="right"  ></td>
						<td align="left"></td>
					</tr>
					<tr>

						<td align="right"  >邮编</td>
						<td align="left"><c:out value="${officeAddressBook.zipCode}"/></td>
						<td align="right"  ><b style="color:red">*</b> 省/直辖市</td>
				        <td align="left"><c:out value="${officeAddressBook.province}"/>
				        </td>
					    <td align="right"  ><b style="color:red">*</b> 市</td>
						<td align="left"><c:out value="${officeAddressBook.city}"/>
								</td>
					</tr>

					<tr>

						<td align="right"  ><b style="color:red">*</b> 区/县区</td>
						<td align="left"><c:out value="${officeAddressBook.county}"/></td>
						<td align="right"  >镇</td>
				        <td align="left"><c:out value="${officeAddressBook.town}"/></td>
					    <td align="right"  ><b style="color:red">*</b> 街道/路/村</td>
						<td align="left"><c:out value="${officeAddressBook.street}"/></td>
					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 小区/楼盘</td>
						<td align="left"><c:out value="${officeAddressBook.community}"/></td>
						<td align="right"  >栋/单元/房间号</td>
				        <td align="left"><c:out value="${officeAddressBook.houseNo}"/></td>
					    <td align="right"  >其它</td>
						<td align="left"><c:out value="${officeAddressBook.other}"/></td>
					</tr>
						
						<c:forEach var="clientDoc" items="${clientDocs}" varStatus="s">
							<td>
							
								<img src="${clientDoc.filepath}" class="pimg" width="120" height="120">
							</td>
						</c:forEach>
<%-- 
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>商品1</strong></th>

					</tr>
					<tr>

						<td align="right"  ><b style="color:red">*</b> 商品1</td>
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
					
					--%>
					<tr  >
						<th colspan="6" align="left" class="tr8"><strong>信用信息</strong></th>
					</tr>
					<tr>

						<td align="right"  >产品</td>
						<td align="left"><c:out value="${financialProduct.financialName }"/><input type="hidden" name="clientJob.financialProductId" value="${pId }"/></td>
						<td align="right">商品总价</td>
						<td align="left">
							<c:out value="${clientJob.totalPrice}"/>
						</td>
					  	<td align="right">贷款用途</td>
						<td align="left"> <c:out value="${clientJob.byUse}"/></td>
					</tr>
					<tr>

						<td align="right"  >自付金额(元)</td>
						
						<td align="left">
							<c:out value="${clientJob.selfAmount }"/>
						</td>
						<td align="right"  >分期期数</td>
						
					    <td align="left"><c:out value="${financialProduct.cycleTotal }"/> </td>
						<td  align="right">每月还款额(元)</td>
						<td align="left"><c:out value="${clientJob.monthOfPay}"/></td>
						
						
					</tr>
					<tr>
						
						<td align="right"  >贷款本金(元)</td>
						<td align="left"><c:out value="${clientJob.totalPrice-clientJob.selfAmount } "/></td>
						<td align="right"  ></td>
						<td align="left"></td>
						<td  align="right">每月还款日</td>
						<td align="left"><fmt:formatDate value="${clientJob.monthOfDate}" type="date" pattern="yyyy-MM-dd"/></td>			 
					</tr>

					<tr>
					    
						<td align="right"  ><b style="color:red">*</b> 客户银行卡号/账号</td>
						<td align="left"> <c:out value="${bank.debitCard} "/></td>
						<td align="right"  ><b style="color:red">*</b> 客户开户银行</td>
				        <td align="left"><c:out value="${bank.bankName}"/></td>
						<td  align="right">月花费(元/月)</td>
						<td align="left"><c:out value="${bank.monthPay} "/></td>
					
					</tr>

					<tr>
						
						<td align="right"  >第二银行卡号</td>
						<td align="left"><c:out value="${bank2.debitCard} "/></td>
						<td align="right"  >第二银行卡开户银行</td>
				    	<td align="left"><c:out value="${bank2.bankName} "/></td>
					  
						
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
