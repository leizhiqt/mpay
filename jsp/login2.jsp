<!DOCTYPE form PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc" %>

<c:if test="${!empty param.locale}">
	<fmt:setLocale value="${param.locale}" scope="session" />
	<fmt:setTimeZone value="${param.locale}" scope="session" />
</c:if>

<c:if test="${empty param.locale}">
	<fmt:setLocale value="zh_CN" scope="session" />
	<fmt:setTimeZone value="Asia/Chongqing" scope="session"/>
</c:if>

<fmt:bundle basename="MessageBundle">
<html>
<head>
<title>原酒产业联盟</title>
<meta name="keywords" content="原酒,原酒产业联盟,86999.org,y9jy.com,scy9.com,门户,资讯" />
<meta name="description" content="中国白酒线上线下 防伪溯原立体平台 打造全国物联网,移动互联网,多方位立体服务用户体验" />
<meta name="application-name" content="原酒首页"/>
<script type="text/javascript" src="jsp/js/util.js"></script>

<style type="text/css">
.msg,.err {
	text-align:center;
}

.err {
	color: red;
}

.msg {
	color: green;
}
</style>

<script type="text/javascript" language="javascript">
	if (top.location !== self.location){
		top.location=self.location;
	}
</script>

<link href="skins/office/default/regist.css" rel="stylesheet" type="text/css" />

<style type="text/css">
input{
	border: 1px solid #36a602;
}

input[type='text']{
	font: 110% "Arial" , "Helvetica" , sans-serif;
	width: 220px;
	background: #ffffff;
	color: #000000;
	text-align: default;
	text-indent: 0px;
	text-transform: none;
}

input	{
	font: 110% "Arial" , "Helvetica" , sans-serif;
	width: 220px;
	background: #ffffff;
	color: #000000;
	text-align: default;
	text-indent: 0px;
	text-transform: none;
}

#MainPosition{
	border: 1px solid gray;
	-moz-box-shadow: 6px 6px 4px #333232;
	-webkit-box-shadow: 6px 6px 4px #333232;
	box-shadow: 6px 6px 4px #333232;
	width: 652px;
	height: 362px;
}

.btn{
	background: url('skins/office/default/images/bg_regist.jpg') no-repeat -154px -148px;
	width: 91px;
	height: 38px;
	border: solid 0px white;
	color: white;
	font-weight: 900;
	font-size: 17;
	cursor: pointer;
}

.txt{
	background: url('skins/office/default/images/bg_regist.jpg') no-repeat -1px -188px;
	height: 28px;
	width: 134px;
	border: solid 0px white;
}

.item li{
	vertical-align: middle;
}

span input{
	vertical-align: middle;
}
</style>

<script language="javascript" type="text/javascript">
function menushow() {
	menu1 = document.getElementById('dicatop1').style;
	menu2 = document.getElementById('dicatop2').style;
	menu3 = document.getElementById('dicatop3').style;
	menu4 = document.getElementById('dicatop4').style;

	if (menu1.display == "block") {
	menu2.display = 'none';
	menu3.display = 'none';
	menu4.display = 'none';
	}
	if (menu2.display == "block") {
	menu1.display = 'none';
	menu3.display = 'none';
	menu4.display = 'none';
	}
	if (menu3.display == "block") {
	menu2.display = 'none';
	menu1.display = 'none';
	menu4.display = 'none';
	}
	if (menu4.display == "block") {
	menu2.display = 'none';
	menu3.display = 'none';
	menu1.display = 'none';
	}
}

function topmenu(num) {
	menu1 = document.getElementById('dicatop1').style;
	menu2 = document.getElementById('dicatop2').style;
	menu3 = document.getElementById('dicatop3').style;
	menu4 = document.getElementById('dicatop4').style;
	if (num == 1) {
	menu1.display = 'block';
	menu2.display = 'none';
	menu3.display = 'none';
	menu4.display = 'none';
	}
	else if (num == 2) {
	menu1.display = 'none';
	menu2.display = 'block';
	menu3.display = 'none';
	menu4.display = 'none';
	}
	else if (num == 3) {
	menu1.display = 'none';
	menu2.display = 'none';
	menu3.display = 'block';
	menu4.display = 'none';
	}
	else if (num == 4) {
	menu1.display = 'none';
	menu2.display = 'none';
	menu3.display = 'none';
	menu4.display = 'block';
	}
}
</script>

<script src="jsp/js/jquery-1.4.2-vsdoc.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript">
  function hov(bg) {
	var hid_Index = $("#currentIndex");
	hid_Index.val(bg);
	h1 = document.getElementById('hov01');
	h2 = document.getElementById('hov02');
	h3 = document.getElementById('hov03');
	h4 = document.getElementById('hov04');
	if (bg == 1) {
		h1.className = "curr";
		h2.className = "line";
		h3.className = "line";
		h4.className = "line";
	}
	else if (bg == 2) {
		h1.className = "line";
		h2.className = "curr";
		h3.className = "line";
		h4.className = "line";
	}
	else if (bg == 3) {
		h1.className = "line";
		h2.className = "line";
		h3.className = "curr";
		h4.className = "line";
	}
	else if (bg == 4) {
		h1.className = "line";
		h2.className = "line";
		h3.className = "line";
		h4.className = "curr";
	}
  }

function user_check() {
	if (document.Longin_Form.UserName.value == "") {
	alert("请输入“用户名”！")
	document.Longin_Form.UserName.focus()
	return false
	}
	else if (document.Longin_Form.Password.value == "") {
	alert("请输入“密码”！")
	document.Longin_Form.Password.focus()
	return false
	}
	else if (document.Longin_Form.check_num.value == "") {
	alert("请输入“验证码”！")
	document.Longin_Form.check_num.focus()
	return false
	}
}


function en_check() {
	if (document.Longin_Form.unitcode.value == "") {
	alert("请输入“企业代码”！")
	document.Longin_Form.unitcode.focus()
	return false
	}
	else if (document.Longin_Form.unitname.value == "") {
	alert("请输入“用户名”！");
	document.Longin_Form.unitname.focus(); return false;
	}
	else if (document.Longin_Form.unitpass.value == "") {
	alert("请输入“密码”！")
	document.Longin_Form.unitpass.focus()
	return false
	}
}

function mem_check() {
	if (document.Longin_Form.txtUsername.value == "") {
	alert("请输入“会员账号”！")
	document.Longin_Form.txtUsername.focus()
	return false
	}else if (document.Longin_Form.txtPassword.value == "") {
	alert("请输入“会员密码”！")
	document.Longin_Form.txtPassword.focus()
	return false
	}
}
</script>
</head>

<body bgcolor="#ffffff">
<c:url value="/Login.do" var="processLogin">
	<c:param name="method">processLogin</c:param>
</c:url>

<c:url value="/Login.do" var="promptLogin">
	<c:param name="method">promptLogin</c:param>
</c:url>

<c:url value="/Login.do" var="promptRegister">
	<c:param name="method">promptRegister</c:param>
</c:url>

<c:url value="/ForgeryCode.do" var="checkFC">
	<c:param name="method">check</c:param>
</c:url>

<c:url value="skins/default/skins/office/default/images/logo_style5.png" var="logURL"/>

<c:url value="/Index.do" var="homeURL"/>

<!-- login.jsp -->


<div class="w" style="height: 10%;"></div>

<div class="w" id="regist">
	<%@ include file="incl/b_message.jsp" %>

	<div class="mt">
	<h2>系统登录</h2>

	<b></b><span style="text-align: right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
	
	<c:forEach var="locItem" items="${locales}" varStatus="s">
		<c:url value="/Login.do" var="changeLocale">
			<c:param name="method">promptLogin</c:param>
			<c:param name="locale">${locItem }</c:param>
		</c:url>
		<a href="${changeLocale }">${locItem.displayLanguage}</a>
	</c:forEach>


	<a href="${homeURL }">访问主页</a></span>
	</div>
	
	<div class="mc" style="background-color: White">
		<ul class="tab">
			<li class="curr" id="hov01"><a href="javascript: topmenu(1);" onclick="hov(1)">金融系统</a></li>
			<li class="line" id="hov02"><a href="javascript: topmenu(2);" onclick="hov(2)">经销商</a></li>
			<li class="line" id="hov03"><a href="javascript: topmenu(3);" onclick="hov(3)">物流查询</a></li>
			<li class="line" id="hov04"><a href="javascript: topmenu(4);" onclick="hov(4)">防伪查询</a></li>
		</ul>
		<div class="">
			
				<span id="dicatop1" style="display: block;">
					<div class="item"><form method="post" action="${processLogin}">
						<div style="margin-left: 110px;">
							<span style="vertical-align: middle;">账&nbsp;&nbsp;&nbsp;号：</span>
							<input type="text" name="user.name" id="UserName" style="vertical-align: middle; margin-left: 10px;" />
							<br />
							<br />
						
							<span style="vertical-align: middle;">密&nbsp;&nbsp;&nbsp;码：</span>
							<input type="password" name="user.password" id="Password" style="vertical-align: middle;
							margin-left: 10px;" />
							<br />
							<br />
						
							<span>验证码：</span>
							<input type="text" name="validateCode" id="check_num" style="vertical-align: middle; margin-left: 10px;
							width: 120px" />
						
							<div style="margin-left: 220px; margin-top: -26px;">
							<img id="Image1" src="${validateCode}" style="border-width:0px;" /></div>
						
							<div style="margin-left: 90px;">
								<input type="submit" name="cmdLongi" value="登录" onclick="return user_check();" id="cmdLongi" class="btn" style="margin-top: 20px;" />
								<input name="clearAll" type="button" id="clearAll" class="btn" value="重置" style="margin-top: 18px;
								margin-left: 20px;" />
							</div>
						<div id="labinfo" style="color: Red; display: none;"></div>
					</div></form>
				</div>
				</span>
			
                <span id="dicatop2" style="display: none; text-align: left;">
                    <div class="item">
                        <div style="margin-left: 110px;">
                             <br />
                            <span style="vertical-align: middle;">客户编号：</span>
                            <input name="unitname" type="text" id="unitname" style="vertical-align: middle; margin-left: 20px;" />
                            <br />
                            <br />
                            <span>客户密码：</span>
                            <input name="unitpass" type="password" id="unitpass" style="vertical-align: middle;
                                margin-left: 20px;" />
                              <br />
                                <br />
                            <div style="margin-left: 90px;">
                                <input type="submit" name="cmdenlogin" value="登录" onclick="return en_check();" id="cmdenlogin" class="btn" style="margin-top: 20px;" />
                                <input name="clearBtn" type="button" id="clearBtn" class="btn" value="重置" style="margin-top: 18px;
                                    margin-left: 20px;" /></div>
                            <div id="labinfo2" style="color: Red; display: none;">
                            </div>
                        </div>
                    </div>
                </span>
                <span id="dicatop3" style="display: none; text-align: left;">
                                        <div class="item">
                        <div style="margin-left: 110px;">
                            <span>物流码：</span>
                            <input name="wlcode" type="text" id="wlcode" style="vertical-align: middle; margin-left: 26px;" />
                                                        <br />
                            <br />
                                      <br />
                            <br />
                            <div style="margin-left: 90px;">
                                <input type="submit" name="Button1" value="查询" id="Button1" class="btn" style="margin-top: 20px;" />
                            </div>
                            <div id="Div1" style="color: Red; display: none;">
                            </div>
                        </div>
                    </div>
                    
                </span>
 
                
	                <span id="dicatop4" style="display: none; text-align: left;">
	                    <div class="item"><form method="post" action="${checkFC}">
	                        <div style="margin-left: 110px;">
	                            <br />
	                            <span>防伪码：</span>
	                            <input name="FC" type="text" id="FC" style="vertical-align: middle; margin-left: 20px;" />
	                            <br />
	                            <br />
	                            <br />
	                            <div style="margin-left: 90px;">
	                                <input type="submit" name="Button2" value="查询" id="Button2" class="btn" style="margin-top: 20px;" />
	                            </div>
	                            <div id="Div2" style="color: Red; display: none;">
	                            </div>
	                        </div></form>
	                    </div>
	                </span>
                
            </div>
            <input name="currentIndex" type="hidden" id="currentIndex" value="1" />
            <!--[if !ie]>form end<![endif]-->
        </div>
	</div>
	<div class="w" id="footer">Copyright&copy;2012 86999.org</div>
	

    <script type="text/javascript">
        var items = $("input");
        var lab = $("#labinfo");
        var img = $("#Image1");
        img.css("cursor", "pointer");
        items.focus(function() { lab.hide("slow"); $("#labinfo2").hide(); });
        img.click(function() {
            var src = $(this).attr("src");
            $("#img").attr("src", src);
        });
        $("#clearAll").click(function() { Longin_Form.UserName.value = ""; Longin_Form.Password.value = ""; Longin_Form.check_num.value = ""; });
        $("#clearBtn").click(function() { Longin_Form.unitcode.value = ""; Longin_Form.unitname.value = ""; Longin_Form.unitpass.value = ""; });
        $(function() {
            hov($("#currentIndex").val());
            topmenu($("#currentIndex").val());
        })
    </script>
    
</body>
</fmt:bundle>
