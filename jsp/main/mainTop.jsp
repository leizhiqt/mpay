<!DOCTYPE form PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.mooo.mycoz.framework.SessionCounter" %>
<%@ include file="/jsp/incl/static.inc" %>
<fmt:bundle basename="MessageBundle" >

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>汉易联信</title>

<link id="skinCss" href="jsp/public/ISCSSobjects_style4.css" type="text/css" rel="stylesheet">   
<script TYPE="text/javascript" language="JavaScript" src="../public/util.js">  </script> 
<script type="text/javascript" src="jsp/public/skin.js"></script>

<c:url value="Login.do" var="logout">
	<c:param name="method">processLogout</c:param>
</c:url>

<SCRIPT language=JavaScript>
function logout ()
{
     parent.parent.location="${logout}";

}
function closeWin()
	{
		if(confirm('要关闭浏览器吗？'))
        {
		 parent.parent.location="${logout}";
         top.window.close();
        }
	}
function addfavorite()
{
   if (document.all)
   {
      window.external.addFavorite('http://','汉易联信首页');
   }
   else if (window.sidebar)
   {
      window.sidebar.addPanel('汉易联信首页', 'http://', "");
   }
} 
	
</script>
<script>
var def;
function mover(object){
	def=object;
  	var i=1;
	for (i=1;i<=1;i++)
	{
		if (i != object)
		{
			var mmm=document.getElementById("m_"+ i);
			mmm.className="m_li";
		}
	}
  var mm=document.getElementById("m_"+object);
  mm.className="m_li_a";
    var j=1;
	for (j=1;j<=1;j++)
	{
		if (j != object)
		{
			var sss=document.getElementById("s_"+ j);
			sss.style.display="none";
		}
	}
  var ss=document.getElementById("s_"+object);
  ss.style.display="block";
}

function mout(object){
  var mm=document.getElementById("m_"+object);
  mm.className="m_li";
	var i=1;
	for (i=1;i<=1;i++)
	{
		if (i == object)
		{
			var mmm=document.getElementById("m_"+object);
			mmm.className="m_li_a";
		}
	}
  var ss=document.getElementById("s_"+object);
  ss.style.display="none";
  
  	var j=1;
	for (j=1;j<=1;j++)
	{
		if (j == object)
		{
			var sss=document.getElementById("s_"+object);
			sss.style.display="block";
		}
	}
}
</script>


<script language="javascript">
function sw_click() 
{ 
if(document.getElementById("sw_div").style.display=="block") 
{ 
document.getElementById("sw_div").style.display="none"; 
} 
else 
{ 
document.getElementById("sw_div").style.display="block"; 
} 
} 
function sw_out(){
document.getElementById("sw_div").style.display="none"; 
} 
function sw_over(){
document.getElementById("sw_div").style.display="block"; 
} 

</script> 

</head>

<body oncontextmenu ='self.event.returnValue=false'>
<noscript><iframe src="*.html"></iframe></noscript>
<div id="container">
  <div id="top_right">
    <div id="Inf_Bar">
      <div id="topmenu">
        <ul>
         <!--   <li id="m_1" class='m_li' onmouseover='mover(1);' onmouseout='mout(1);'><a href="#"><img id="ico_menu" src="../images/mainTop/icon_menu_0.png"; border="none"/>用户菜单</a></li>
           <li id="m_2" class='m_li' onmouseover='mover(2);' onmouseout='mout(2);'><a href="#"><img id="ico_menu" src="../images/mainTop/icon_menu_1.png"; border="none"/>客户名录</a></li>
  			<li id="m_3" class='m_li' onmouseover='mover(3);' onmouseout='mout(3);'><a href="#"><img id="ico_menu" src="../images/mainTop/icon_menu_2.png"; border="none"/>运行设备</a></li>
   			<li id="m_4" class='m_li' onmouseover='mover(4);' onmouseout='mout(4);'><a href="#"><img id="ico_menu" src="../images/mainTop/icon_menu_3.png"; border="none"/>地图节点</a></li>
   			<li id="m_5" class='m_li' onmouseover='mover(5);' onmouseout='mout(5);'><a href="#"><img id="ico_menu" src="../images/mainTop/icon_menu_4.png"; border="none"/>界面切换</a></li>-->
        </ul>
      </div>
      
      <div id="Inf_user">
        <ul>
          <li class="user_bg_l_li"></li>
          <li class="userlogo_li" title="<fmt:message key='UserName'/>"></li>
          <li class="user_inftext_li">
            <c:out value="${UserName }"/>
          </li>
          <li class="Deplogo_li" title="<fmt:message key='Branch'/>"></li>
          <li class="user_inftext1_li">
            <c:out value="${branchName }"/> 
          </li>
           <li class="user_inftext2_li">
            <fmt:message key="IP"/>:<c:out value="${IP }"/>
            <fmt:message key="Online"/>:<%=SessionCounter.getCount() %>
          </li>
          <li class='btn_Collection_li' onmouseover="this.className='btn_Collection_li_a';" onmouseout="this.className='btn_Collection_li';"  title="收藏" onclick="addfavorite();"><a href="#"></a></li>
          <li class='btn_off_li' onmouseover="this.className='btn_off_li_a';" onmouseout="this.className='btn_off_li';"  title="注销" onclick="logout();"><a href="#"></a></li>
          <li class='btn_quit_li' onmouseover="this.className='btn_quit_li_a';" onmouseout="this.className='btn_quit_li';"  title="退出" onclick="closeWin();"><a href="#"></a></li>
        </ul>
      </div>
      <div style="height:31px;">
        <ul class="smenu">
          <!--<li style="padding-left:4px;" id="s_1" class='s_li'  onmouseover='mover(1);' onmouseout='mout(1);'>
            <ww:iterator value="menus" status="menus"> <a href="#" onclick="window.parent.mainFrame.window.location='<ww:property value="limit.actionPath"/>'">
             <ww:property value="limit.name" escape="false"/>
            </ww:iterator>
          </li>
          <li style="padding-left:40px;" id="s_2" class='s_li' onmouseover='mover(2);' onmouseout='mout(2);'> <a href="/">综合</a> <a href="/">固定视频</a> <a href="/">移动视频</a> <a href="/">气体探测</a> <a href="/">矿井</a> <a href="/">其他</a> <a href="/">关键字搜索</a> </li>
          <li style="padding-left:156px;" id="s_3" class='s_li' onmouseover='mover(3);' onmouseout='mout(3);'> <a href="/">监控</a> <a href="/">正常</a> <a href="/">报警</a> <a href="/">网络故障</a> <a href="/">通讯故障</a></li>
          <li style="padding-left:52px;" id="s_4" class='s_li' onmouseover='mover(4);' onmouseout='mout(4);'> <a href="/">仅视频用户</a> <a href="/">无视频用户</a> <a href="/">含视频用户</a> <a href="/">移动危险源用户</a> <a href="/">所有用户</a></li>
          <li style="padding-left:308px;" id="s_5" class='s_li' onmouseover='mover(5);' onmouseout='mout(5);'> <a href="/">移动危险源</a> <a href="/">固定危险源</a> </li>-->
        </ul>
      </div>
    </div>
  
  </div>
  <div id="top_logo">
 
  
  </div>

</body>
<script language="javascript">
mover(1);
mout(1);
</script>
<SCRIPT language=javascript>
	if("invalidationDate"=='<ww:property value="ajaxMessage"/>'){
		alert("您的密码已过期，请修改密码后重新登陆系统。");
		parent.mainFrame.location="../user/getLoginUser.smis?kind=error";
	}

</SCRIPT>
</html>

</fmt:bundle>