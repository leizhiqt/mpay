<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="ForgeryCode"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<style type="text/css">
body,td{font-family:Arial,Helvetica,sans-serif,"宋体";font-size:14px;color:#000;margin:0;padding:0;}
div,h1,h2,h3,h4,p,form,label,textarea,span,body,div,dl,dt,dd,ul,ol,li,pre,fieldset,input,textarea,blockquote,emBED{margin:0;padding:0;line-height: 28px;}
img{border:none;}

ul,li{list-style-type:none;}
body{background-image:url(jsp/images/strack/top_bg.gif); background-repeat:repeat-x;}
.top_bg{background-image:url(jsp/images/strack/top.jpg); background-repeat:no-repeat; height:184px;}
.title_bg{background-image:url(jsp/images/strack/tit_bg.gif); background-repeat:no-repeat; height:39px; font-size:20px; font-family:Arial,Helvetica,sans-serif,"黑体"; font-weight:bold; padding-left:10px; color:#FFFFFF; text-align:left;}

a:link{color:#0069d4;text-decoration:none;}
a:visited{color:#0069d4;text-decoration:none;}
a:hover{color:#f24f00;text-decoration:underline;}
a:active{color:#0069d4;}
a:focus{outline:none;}

.copyright_bg{background-image:url(jsp/images/strack/copyright_bg.gif); background-repeat:repeat-x; padding:0 30px 0 10px; height:104px; text-align:center; }

.style1 {
	color: #0066CC;
	font-weight: bold;
	font-size: 18px;
}
.style3 {color: #009900; font-weight: bold; font-size: 18px; }
.style5 {color: #FF9900; font-weight: bold; font-size: 18px; }
</style>

<script type="text/javascript">
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
</script>
</head>

<body>
<center>
  <table width="890" cellspacing="0" cellpadding="0">
    <tr>
      <td class="top_bg">&nbsp;</td>
    </tr>
  </table>
  <%-- 
  <table width="850" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="jsp/images/strack/k_left_top.gif" alt="kuang" width="12" height="10" /></td>
      <td height="10" background="jsp/images/strack/k_top.gif"><img src="jsp/images/strack/k_top.gif" alt="k" width="836" height="10" /></td>
      <td><img src="jsp/images/strack/k_right_top.gif" alt="k" width="12" height="10" /></td>
    </tr>
    
    <tr>
      <td width="12" background="jsp/images/strack/k_left_m.gif">&nbsp;</td>
      <td align="left"><table width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="title_bg">二维码标签内容</td>
          </tr>
        </table>
        　　1、评分及溯源链接：<br />
        　　2、企业及产品名称：四川宝莲酒业有限公司　　　宝莲青花瓷<br />
        　　3、度数及容量：52％vol 　　500ml<br />
        　　4、专家酒体评分：93.95分<br />
        　　5、市场售价：48元／瓶（2013版）</td>
      <td width="12" background="jsp/images/strack/k_right_r.gif">&nbsp;</td>
    </tr>
    
    <tr>
      <td><img src="jsp/images/strack/k_left_b.gif" alt="k" width="12" height="10" /></td>
      <td height="10"><img src="jsp/images/strack/k_bottom.gif" alt="k" width="836" height="10" /></td>
      <td><img src="jsp/images/strack/k_right_b.gif" alt="k" width="12" height="10" /></td>
    </tr>
    
  </table>
  --%>
  
  <table width="850" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="jsp/images/strack/k_left_top.gif" alt="kuang" width="12" height="10" /></td>
      <td height="10" background="jsp/images/strack/k_top.gif"><img src="jsp/images/strack/k_top.gif" alt="k" width="836" height="10" /></td>
      <td><img src="jsp/images/strack/k_right_top.gif" alt="k" width="12" height="10" /></td>
    </tr>
    <tr>
      <td width="12" background="jsp/images/strack/k_left_m.gif">&nbsp;</td>
      <td align="center"><table width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="title_bg">评分及溯源详细内容</td>
          </tr>
        </table>
        <br />
        <table width="95%" cellpadding="0" cellspacing="1" bgcolor="#ffe9be">
          <tr>
            <td height="43" colspan="4" align="center" bgcolor="#FFFFFF"><span class="style5">被评白酒基本信息</span></td>
          </tr>
          <tr>
            <td width="12%" align="center" bgcolor="#fff1d5">企业名称</td>
            <td colspan="3" bgcolor="#fff1d5">${winery.enterpriseName }</td>
          </tr>
          <tr>
            <td align="center" bgcolor="#fff1d5">产品名称</td>
            <td width="46%" bgcolor="#fffbf2">${product.productName }</td>
            <td width="11%" align="center" bgcolor="#fff1d5">香型</td>
            <td width="31%" bgcolor="#fffbf2">${product.flavor }</td>
          </tr>
          <tr>
            <td align="center" bgcolor="#fff1d5">净含量</td>
            <td bgcolor="#fffbf2">${saleItem.saleVol }${saleItem.volUnit } <fmt:formatNumber value="${saleItem.salePrice }" type="currency"/>/瓶</td>
            <td align="center" bgcolor="#fff1d5">酒精度</td>
            <td bgcolor="#fffbf2">${product.alcohol }度</td>
          </tr>
          <%-- 
          <tr>
            <td align="center" bgcolor="#fff1d5">产地</td>
            <td bgcolor="#fffbf2">四川资阳</td>
            <td align="center" bgcolor="#fff1d5">生产日期</td>
            <td bgcolor="#fffbf2">2013年4月</td>
          </tr>
          --%>
          
      </table>
        <br />
        <table width="95%" cellpadding="0" cellspacing="1" bgcolor="#a4f6a5">
          <tr>
            <td height="43" colspan="4" align="center" bgcolor="#FFFFFF"><span class="style3">酒评结果</span></td>
          </tr>

          <tr>
            <td width="12%" align="center" bgcolor="#BCFFBD">评酒时间</td>
            <td width="46%" bgcolor="#F5FFFA"><fmt:formatDate value="${sampleProduct.tastingStartTime }" type="both" />~<fmt:formatDate value="${sampleProduct.tastingEndTime }" type="both" /></td>
            <td width="11%" align="center" bgcolor="#BCFFBD">评酒地点</td>
            <td width="31%" bgcolor="#F5FFFA">${sampleProduct.tastingSite }</td>
          </tr>
          <tr>
            <td align="center" bgcolor="#BCFFBD">综合平均得分</td>
            <td bgcolor="#F5FFFA">${sampleProduct.expertScore } 分</td>
            <td align="center" bgcolor="#BCFFBD">醉酒度评价</td>
            <td bgcolor="#F5FFFA">${sampleProduct.drunkLevel } 分</td>
          </tr>
          <tr>
            <td align="center" bgcolor="#BCFFBD">酒评人评语</td>
            <td colspan="3" bgcolor="#F5FFFA">${sampleProduct.tastingComment }</td>
          </tr>
          <%--
          <tr>
            <td align="center" bgcolor="#BCFFBD">附件</td>
            <td colspan="3" bgcolor="#F5FFFA">评分系统图片</td>
          </tr>
          --%>
          <tr>
            <td align="center" bgcolor="#BCFFBD">评酒人</td>
            <td colspan="3" bgcolor="#F5FFFA">见下表</td>
          </tr>
        </table>
        <br />
        <table width="95%" cellpadding="0" cellspacing="1" bgcolor="#bfe8ff">
          <tr>
            <td height="43" colspan="2" align="center" bgcolor="#FFFFFF"><span class="style1">参评专家组成员</span></td>
          </tr>

          <tr>
            <td width="12%" align="center" bgcolor="#d5f0ff">专家名</td>
            <td width="88%" align="center" bgcolor="#f4fbff">专家资历</td>
          </tr>
          
          <c:forEach var="item" items="${sampleTastings}" varStatus="status">
          <tr>
            <td align="center" bgcolor="#d5f0ff"><c:out value="${item.wineTaster.tasterName }"/></td>
            <td bgcolor="#f4fbff"><c:out value="${item.wineTaster.tasterLicense }"/></td>
          </tr>
          </c:forEach>
        </table>
        <br />
  <table width="850" cellspacing="0" cellpadding="0">
    <tr>
      <td><img src="jsp/images/strack/k_left_top.gif" alt="kuang" width="12" height="10" /></td>
      <td height="10" background="jsp/images/strack/k_top.gif"><img src="jsp/images/strack/k_top.gif" alt="k" width="836" height="10" /></td>
      <td><img src="jsp/images/strack/k_right_top.gif" alt="k" width="12" height="10" /></td>
    </tr>
    <tr>
      <td width="12" background="jsp/images/strack/k_left_m.gif">&nbsp;</td>
      <td align="center"><table width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="title_bg">酿造溯源</td>
          </tr>
        </table>
        <table width="95%" cellspacing="1" cellpadding="4">
          <tr>
            <td height="43" align="center"><span class="style1">企业介绍</span></td>
          </tr>
          <tr>
            <td align="left" bgcolor="#f4fbff">
				${winery.introduction }<br/>
				公司地址：${winery.address }<br/>
				邮编：${winery.zipcode }<br/>
				电话：${winery.telephone }
			</td>
          </tr>
        </table>
        <br />
        <table width="95%" cellpadding="0" cellspacing="1" bgcolor="#bfe8ff">
          <tr>
            <td height="43" colspan="4" align="center" bgcolor="#FFFFFF"><span class="style1">原酒酿造</span></td>
          </tr>

          <tr>
            <td width="17%" align="center" bgcolor="#d5f0ff">生产原料</td>
            <td width="37%" bgcolor="#f4fbff">${product.material }</td>
            <td width="15%" align="center" bgcolor="#d5f0ff">生产工艺</td>
            <td width="31%" bgcolor="#f4fbff">${product.production }</td>
          </tr>
          <tr>
            <td align="center" bgcolor="#d5f0ff">窖池数量</td>
            <td bgcolor="#f4fbff">${winery.totalPits }口</td>
            <td align="center" bgcolor="#d5f0ff">窖池平均窖龄</td>
            <td bgcolor="#f4fbff">${winery.averageAgePits }年</td>
          </tr>
          <tr>
            <td align="center" bgcolor="#d5f0ff">20年以上窖池数量</td>
            <td bgcolor="#f4fbff">${winery.hightAgePits }</td>
            <td align="center" bgcolor="#d5f0ff">发酵时长</td>
            <td bgcolor="#f4fbff">${product.fermentDays }天</td>
          </tr>
          <tr>
            <td align="center" bgcolor="#d5f0ff">每天产酒量</td>
            <td bgcolor="#f4fbff">${winery.nissan }吨</td>
            <td align="center" bgcolor="#d5f0ff">优级酒以上数量</td>
            <td bgcolor="#f4fbff">平均${winery.nissanTop }吨/天</td>
          </tr>
        </table>
      <br />
      <%--
      <table width="95%" cellpadding="0" cellspacing="1" bgcolor="#bfe8ff">
        <tr>
          <td height="43" colspan="4" align="center" bgcolor="#FFFFFF"><span class="style1">原酒储存</span></td>
        </tr>
        <tr>
          <td width="20%" align="center" bgcolor="#d5f0ff">入库时间</td>
          <td width="34%" bgcolor="#f4fbff">2008年7月前</td>
          <td width="15%" align="center" bgcolor="#d5f0ff">等级评定</td>
          <td width="31%" bgcolor="#f4fbff">优级</td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">入库品酒师</td>
          <td bgcolor="#f4fbff">龙玉智、郭毅、罗仕彬</td>
          <td align="center" bgcolor="#d5f0ff">储存容器</td>
          <td bgcolor="#f4fbff">陶坛</td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">储存容器连续使用年限</td>
          <td bgcolor="#f4fbff">30年</td>
          <td align="center" bgcolor="#d5f0ff">储存时间</td>
          <td bgcolor="#f4fbff">3年</td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">特殊储存模式</td>
          <td bgcolor="#f4fbff">恒温储存</td>
          <td align="center" bgcolor="#d5f0ff">出库时间</td>
          <td bgcolor="#f4fbff">2011年9月</td>
        </tr>
      </table>
      <br />
      --%>
      
      <table width="95%" cellpadding="0" cellspacing="1" bgcolor="#bfe8ff">
        <tr>
          <td height="43" colspan="4" align="center" bgcolor="#FFFFFF"><span class="style1">成品酒组合</span></td>
        </tr>
        <tr>
          <td width="17%" align="center" bgcolor="#d5f0ff">组合时间</td>
          <td width="37%" bgcolor="#f4fbff"><fmt:formatDate value="${sampleProduct.buildDate }" type="date" /></td>
          <td width="15%" align="center" bgcolor="#d5f0ff">调酒师</td>
          <td width="31%" bgcolor="#f4fbff"><c:out value="${sampleProduct.buildPeople }"/></td>
        </tr>
       
       <c:forEach var="item" items="${sampleItems}" varStatus="status">
	       <tr>
	          <td align="center" bgcolor="#d5f0ff"><c:out value="${item.itemName }"/></td>
	          <td bgcolor="#f4fbff"><c:out value="${item.itemAge }"/>年</td>
	          <td align="center" bgcolor="#d5f0ff"><c:out value="${item.itemVol }"/><c:out value="${item.itemVolUnit }"/></td>
	          <td bgcolor="#f4fbff"><fmt:formatNumber value="${item.itemVol/totalVol }" type="percent" /></td>
	        </tr>
       </c:forEach>
        <%-- 
        <tr>
          <td align="center" bgcolor="#d5f0ff">品酒师</td>
          <td bgcolor="#f4fbff">李泽隆、潘林涛、郭光彬、肖波、李梦秋、余鸣凤</td>
          <td align="center" bgcolor="#d5f0ff">二次储存时长</td>
          <td bgcolor="#f4fbff">6个月</td>
        </tr>
        --%>
      </table>
      <br />
      <%--
      <table width="95%" cellpadding="0" cellspacing="1" bgcolor="#bfe8ff">
        <tr>
          <td height="43" colspan="4" align="center" bgcolor="#FFFFFF"><span class="style1">成品酒灌装</span></td>
        </tr>
        <tr>
          <td width="17%" align="center" bgcolor="#d5f0ff">洗瓶方式</td>
          <td width="37%" bgcolor="#f4fbff">全自动</td>
          <td width="15%" align="center" bgcolor="#d5f0ff">灌装方式</td>
          <td width="31%" bgcolor="#f4fbff">机械化</td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">灌装设备材质</td>
          <td bgcolor="#f4fbff">不锈钢</td>
          <td align="center" bgcolor="#d5f0ff">洗涤用水</td>
          <td bgcolor="#f4fbff">软化处理纯净水</td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">精滤材质</td>
          <td bgcolor="#f4fbff">微孔膜板</td>
          <td align="center" bgcolor="#d5f0ff">灌装时间</td>
          <td bgcolor="#f4fbff">&nbsp;</td>
        </tr>
      </table>
      <br />
            --%>
      <table width="95%" cellpadding="0" cellspacing="1" bgcolor="#bfe8ff">
        <tr>
          <td height="43" colspan="4" align="center" bgcolor="#FFFFFF"><span class="style1">质量检验</span></td>
        </tr>
        <tr>
          <td width="17%" align="center" bgcolor="#d5f0ff">常规检验</td>
          <td width="37%" bgcolor="#f4fbff"><c:if test="${sampleTest.generalTesting=='Y' }">有</c:if><c:if test="${sampleTest.generalTesting=='N' }">无</c:if></td>
          <td width="15%" align="center" bgcolor="#d5f0ff">理化检测</td>
          <td width="31%" bgcolor="#f4fbff"><c:if test="${sampleTest.generalTesting=='Y' }">有</c:if><c:if test="${sampleTest.generalTesting=='N' }">无</c:if></td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">塑化剂检测</td>
          <td bgcolor="#f4fbff"><c:if test="${sampleTest.generalTesting=='Y' }">有</c:if><c:if test="${sampleTest.generalTesting=='N' }">无</c:if></td>
          <td align="center" bgcolor="#d5f0ff">检测时间</td>
          <td bgcolor="#f4fbff"><fmt:formatDate value="${sampleTest.testingDate }" type="date" /></td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">检验报告编号</td>
          <td bgcolor="#f4fbff"><c:out value="${sampleTest.reportNo }"/></td>
          <td align="center" bgcolor="#d5f0ff">检测人</td>
          <td bgcolor="#f4fbff"><c:out value="${sampleTest.testingPerson }"/></td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">主要检验器具</td>
          <td bgcolor="#f4fbff" colspan="3"><c:out value="${sampleTest.testTools }"/></td>
        </tr>
        <tr>
          <td align="center" bgcolor="#d5f0ff">检验标准</td>
          <td bgcolor="#f4fbff" colspan="3"><c:out value="${sampleTest.testNorm }"/></td>
        </tr>
      </table>

      </td>
      <td width="12" background="jsp/images/strack/k_right_r.gif">&nbsp;</td>
    </tr>
    <tr>
      <td><img src="jsp/images/strack/k_left_b.gif" alt="k" width="12" height="10" /></td>
      <td height="10"><img src="jsp/images/strack/k_bottom.gif" alt="k" width="836" height="10" /></td>
      <td><img src="jsp/images/strack/k_right_b.gif" alt="k" width="12" height="10" /></td>
    </tr>
  </table>
  
  <table width="100%" cellspacing="0" cellpadding="0">
    <tr>
      <td height="10"> </td>
    </tr>
    <tr>
      <td class="copyright_bg">Copyright 四川省酿酒研究所</td>
    </tr>
  </table>
</center>
</body>
</html>
</fmt:bundle>
