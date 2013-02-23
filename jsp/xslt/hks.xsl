<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0"
exclude-result-prefixes="fo">

<xsl:template match="SN">

<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

<fo:layout-master-set>
	<fo:simple-page-master master-name="simpleA4"
		page-height="29.7cm" page-width="21cm" margin-top="2cm"
		margin-bottom="2cm" margin-left="1.5cm" margin-right="1.5cm">
		<fo:region-body />
	</fo:simple-page-master>
</fo:layout-master-set>


<fo:page-sequence master-reference="simpleA4">

    <fo:flow flow-name="xsl-region-body">
		<fo:block font-size="18pt" font-weight="bold" space-before="5mm" text-align="center">
			划款授权书
		</fo:block>
		<fo:block font-size="16pt" font-weight="bold" space-before="5mm"  text-align="left">		
			成都汉易联信商贸有限公司：
		</fo:block>
			
		<fo:block font-size="12pt" margin-left="1cm"  text-align="left" space-before="5mm">
        	我为方便、快捷、安全的与贵公司开展货款支付业务，自愿向贵公司作如下授权：
        </fo:block>
        <fo:block font-size="12pt"   text-align="left" space-before="5mm">
      		一、本人自愿授权通过 成都汉易联信商贸有限公司 按照<xsl:value-of select="ClientName"/>（身份证号<xsl:value-of select="IdNo"/>）购货及欠款情况将本人
      		</fo:block>
      		<fo:block  font-size="12pt"   text-align="left" space-before="5mm">
      			储蓄卡（折），无需在每次划款前征求本人意见。
       		 </fo:block>
		<fo:block font-size="12pt"   text-align="left" space-before="5mm" >
      		二、本人授权指定的划款账户户名为<xsl:value-of select="ClientName"/>，开户行为<xsl:value-of select="BankName"/>,（或卡号）为<xsl:value-of select="DebitCard"/>，身份证件类型 第二代 ，</fo:block>
      		<fo:block font-size="12pt"   text-align="left" space-before="5mm">本人身份证件号：<xsl:value-of select="IdNo"/> 。</fo:block>
        
        <fo:block font-size="12pt"   text-align="left" space-before="5mm" >
      		三、本人承认对贵公司按第一条进行的划款行为，均视同本人自行划款的行为，其后果由我本人承担。
        </fo:block>
        <fo:block font-size="12pt"   text-align="left" space-before="5mm" >
      		四、在本人书面提出"终止划款授权通知书"之前，本授权书始终有效。 
        </fo:block>
        <fo:block font-size="12pt"   text-align="left" space-before="5mm" space-after="5mm">
      		五、建议客户在其开户银行开通短信业务。 
        </fo:block>
		
      	<fo:block font-size="12pt"  text-align="left" space-before="3cm">客户签字或盖章：____________________________</fo:block>
   
      	<fo:block font-size="12pt"  text-align="left" space-before="1cm">身 份 证 件号：____________________________</fo:block>
  
      	<fo:block font-size="12pt"  text-align="left" space-before="1cm">日        期：_________年_____月_____日 </fo:block>
  			
</fo:flow>
</fo:page-sequence>
</fo:root>
</xsl:template>
</xsl:stylesheet>		  
  


 
