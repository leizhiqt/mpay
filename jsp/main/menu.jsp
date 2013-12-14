<!DOCTYPE form PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc" %>
<fmt:bundle basename="MessageBundle" >

<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" rel="stylesheet" type="text/css">   
<script type="text/javascript" src="jsp/public/leftMenu.js"></script>
<script src="jsp/public/net.js"></script>
<script type="text/javascript">
 
function GetCookie(sName)
{
    var aCookie = document.cookie.split("; ");
    for (var i=0; i < aCookie.length; i++)
    {
        var aCrumb = aCookie[i].split("=");
        if (sName == aCrumb[0])
        {
            return aCrumb[1];
        }
    }
    return null;
}

function SetCookie(name, value, time, domain)
{
    var expdate = new Date();
    var expires = time;
    if(expires!=null){
      expdate.setTime(expdate.getTime() + ( expires * 1000 ));
      expd = "expires="+expdate.toGMTString()+";";
    }else
      expd = "";
    if (domain)
    {
        domain = "domain="+ domain +"; path=/; ";
    }
    document.cookie = name + "=" + escape (value) + "; " + expd + domain;
}
var cookieTag = "nd_skin";
var vSkin = GetCookie(cookieTag);

//皮肤撤销初始化皮肤
if(vSkin=="yx_subject0708"){setSkinColor('ISCSSobjects_style5');}

function setSkinColor(vSkinNum)
{
    SetCookie( cookieTag, vSkinNum, 60*60*24*30,"");
    if(vSkinNum=="yx_subject0708"){vSkinNum="blue";}
    document.getElementById("skinCss").href = "jsp/public/"+vSkinNum+".css";
}

if( vSkin && vSkin!="Style" )
{

    document.getElementById("skinCss").href = "jsp/public/"+vSkin+".css";
}
function subform(){
	var gtext=this.req.responseText;
    
    if(gtext.indexOf("validate_failed")!=-1){
          //当得到的值表示合法，则验证码通过。
		
     }else{

	 }
	
}



window.onbeforeunload = function (evt) {
	   
	         evt = (evt) ? evt : ((window.event) ? window.event : null);  
              var n = evt.screenX - window.screenLeft;    
              var b = n > document.documentElement.scrollWidth-20;    
              if(b && evt.clientY < 0 || evt.altKey)    
              {    
                  //if(confirm("你确认要退出系统么?")){
                      
		              // var url="../main/logout.smis";
                      // var newxmlhttp=new net.ContentLoader(url,subform,"","get",null,null); 
					  // evt.returnValue ="你已成功退出系统！"; //这里可以放置你想做的操作代码
                  // }
                 
				      
              }    
};

</script>   

</head>

<body id="main" oncontextmenu ='self.event.returnValue=false'>
<!--
<div style="width: 100%;height:60px;background:#99FF00 url(../images/mainTop/logo_style5.png) no-repeat fixed;"> </div>
-->
<%@ include file="config.jsp" %>

<div class="box">
    <ul class="menu">
	<%--
		<li class="level1" onClick="window.parent.mainFrame.location.href='jsp/main/defHome.jsp'">
			<a href="#none">管理首页</a>
		</li>
 	--%>
    	<c:if test="${!empty mainMenu}">
		<c:forEach var="ibar" items="${mainMenu}" varStatus="sbar">
			<c:if test="${ibar.enable==true}">
				<li class="level1"><a href="#none"><fmt:message key="${ibar.key }"/></a>
					
					<c:if test="${!empty ibar.childAction}">
						<ul class="level2">
							<c:forEach var="subm" items="${ibar.childAction}">
								<c:if test="${subm.enable==true}">
									<c:url value="${subm.action}" var="url">
										<c:if test="${!empty subm.method}">
											<c:param name="method">${subm.method}</c:param>
										</c:if>
									</c:url>
									<li onClick="window.parent.mainFrame.location.href='${url }'"><a  href="#"><fmt:message key="${subm.key }"/></a></li>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
				</li>
			</c:if>
		</c:forEach>
	</c:if>
    </ul>
</div>

</body>
</html>
</fmt:bundle>