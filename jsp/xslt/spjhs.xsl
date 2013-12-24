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
		<fo:block font-size="16pt" font-weight="bold" space-before="5mm" text-align="center">
			商品交付确认书及自付金额支付确认书
		</fo:block>
		<fo:block font-size="14pt" font-weight="bold" space-before="5mm"  text-align="center">		
			(一式三份）
		</fo:block>
			
		<fo:block font-size="8pt"   text-align="left" space-before="5mm">本人<xsl:value-of select="ClientName"/>（身份证号 <xsl:value-of select="ClientID"/>）于______年___月___日与成都汉易联信非融资性担保有限公司</fo:block>
        <fo:block font-size="8pt"   text-align="left" space-before="1mm" space-after="5mm">签订分期付款消费合同，购买商品:___________________________________商品信息描述如下：</fo:block>
		
		<!-- 1 table -->
		<fo:table border="1pt solid black" >  
		<fo:table-column column-width="5cm"/>
		<fo:table-column column-width="5cm"/>
		<fo:table-column column-width="4cm"/>
		<fo:table-column column-width="4cm"/>
		

		
		<fo:table-body>
		  <fo:table-row>
		    <fo:table-cell  border="1pt solid black">
		      <fo:block font-size="8pt"   text-align="left" space-before="1mm" >商品类型1： </fo:block>
		    </fo:table-cell>
		    <fo:table-cell  border="1pt solid black">
		      <fo:block font-size="8pt"    text-align="left" space-before="1mm">品牌1：</fo:block>
		    </fo:table-cell>
		      <fo:table-cell  border="1pt solid black">
		      	<fo:block font-size="8pt"    text-align="left" space-before="1mm">商品型号1：</fo:block>
		      </fo:table-cell>
	 		<fo:table-cell  border="1pt solid black">
		      	<fo:block font-size="8pt"    text-align="left" space-before="1mm">价格1：</fo:block>
		      </fo:table-cell>
		  </fo:table-row>
		  		  <fo:table-row>
		    <fo:table-cell  border="1pt solid black">
		      <fo:block font-size="8pt"   text-align="left" space-before="1mm" >商品类型2： </fo:block>
		    </fo:table-cell>
		    <fo:table-cell  border="1pt solid black">
		      <fo:block font-size="8pt"    text-align="left" space-before="1mm">品牌2：</fo:block>
		    </fo:table-cell>
		      <fo:table-cell  border="1pt solid black">
		      	<fo:block font-size="8pt"    text-align="left" space-before="1mm">商品型号2：</fo:block>
		      </fo:table-cell>
	 		<fo:table-cell  border="1pt solid black">
		      	<fo:block font-size="8pt"    text-align="left" space-before="1mm">价格2：</fo:block>
		      </fo:table-cell>
		  </fo:table-row>
		   <fo:table-row>
		    <fo:table-cell  border="1pt solid black">
		      <fo:block font-size="8pt"    text-align="right" space-before="1mm"  >总货款金额： </fo:block>
		  	</fo:table-cell>
	 		<fo:table-cell  border="1pt solid black">
		      	<fo:block font-size="8pt"  text-align="left" space-before="1mm"  >10000</fo:block>
		    </fo:table-cell>
		  	<fo:table-cell  border="1pt solid black">
		      <fo:block font-size="8pt"    text-align="right" space-before="1mm"   >自付款金额： </fo:block>
		  	</fo:table-cell>
		  	<fo:table-cell  border="1pt solid black">
		      <fo:block font-size="8pt"    text-align="left" space-before="1mm"  >2000000</fo:block>
		  	</fo:table-cell>
		  </fo:table-row>
		</fo:table-body> 
		</fo:table>

      	<fo:block font-size="8pt"  text-align="left" space-before="5mm" >各方签署本文件以确认，本文件签署时： </fo:block>
 
      	<fo:block font-size="8pt"  text-align="left" space-before="1mm">（1）以上商品描述准确； </fo:block>
   
      	<fo:block font-size="8pt"  text-align="left" space-before="1mm">（2）客户已支付_____________元金首付款，该首付款已由成都汉易联信非融资性担保有限公司委托客户直接支付______________</fo:block>
      	
      	<fo:block font-size="8pt"  text-align="left" space-before="1mm">（3）成都汉易联信非融资性担保有限公司已通过商家将货物直接交付与客户； </fo:block>
   
      	<fo:block font-size="8pt"  text-align="left" space-before="1mm">（4）客户已取得该商品或取货凭证；并且商品与分期消费合同中的描述一致； </fo:block>
  
      	<fo:block font-size="8pt"  text-align="left" space-before="1mm">（5）成都汉易联信非融资性担保有限公司依据与客户签署的分期付款消费合同承担的质保责任，由商家向客户承担。</fo:block>
   
      	<fo:block font-size="8pt"  text-align="left" space-before="1cm">商家名称（盖章)：____________________________</fo:block>
   
      	<fo:block font-size="8pt"  text-align="left" space-before="5mm">商家店员姓名 ：____________________________</fo:block>
  
      	<fo:block font-size="8pt"  text-align="left" space-before="5mm">客户签名 ：____________________________</fo:block>
  
      	<fo:block font-size="8pt"  text-align="left" space-before="5mm">签署日期 ：____________________________</fo:block>
			
</fo:flow>
</fo:page-sequence>
</fo:root>
</xsl:template>
</xsl:stylesheet>		  
  


 
