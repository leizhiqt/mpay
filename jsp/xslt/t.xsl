<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="1.0" exclude-result-prefixes="fo">
	
<xsl:template match="HBL">

<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

<fo:layout-master-set>
  <fo:simple-page-master master-name="simpleA4" page-height="29.7cm" page-width="21cm" margin-top="2cm" margin-bottom="2cm" margin-left="0.5cm" margin-right="0.5cm">
    <fo:region-body/>
  </fo:simple-page-master>
</fo:layout-master-set>


 <fo:page-sequence master-reference="simpleA4">

    <fo:flow flow-name="xsl-region-body">
<!-- find a mechanism to handle the company specific logo and document name-->
<!--
     <xsl:apply-templates select="companyName"/>     
     <xsl:apply-templates select="DocumentName"/>
-->

<fo:block font-size="16pt" font-weight="bold" space-after="5mm"  text-align="center">
个人分期付款消费及相关服务合同
</fo:block>
    
<fo:block font-size="12pt" space-after="5mm"  text-align="center">
前 言
</fo:block>      
<fo:block font-size="8pt" space-after="5mm"  text-align="center">
本合同分通用条款部分和专用条款部分，其中通用条款部分对全体缔约者有约束力，专用条款部分仅对约定方有约束力。
</fo:block> 
<!-- 1 table -->
<fo:table>
	<fo:table-column column-width="2cm" />
	<fo:table-column column-width="18cm" />
	<fo:table-header>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>

	</fo:table-header>
	
	<fo:table-body>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>		
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid">
				消费者
				</fo:block>
			</fo:table-cell>
			<fo:table-cell>
				<fo:block  font-size="8pt" border-color="black" border-width="1pt" border-style="solid" wrap-option="word">
				指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</fo:table-body>
</fo:table> 
       
<!--  will handle footer later
     <xsl:apply-templates select="footer"/>
 -->

      <fo:table>
         <fo:table-column column-width="4in"/>
         <fo:table-column column-width="4in"/>
    <fo:table-header>
     <fo:table-row>
        <fo:table-cell>
          <fo:block font-weight="bold" color="#ff00ff" text-indent="0.5in">Car</fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block font-weight="bold" color="#9acd32" text-indent="0.5in">Price</fo:block>
         </fo:table-cell>
      </fo:table-row>
     </fo:table-header> 
        <fo:table-body> 
          <fo:table-row>
    <fo:table-cell>
      <fo:block font-size="12pt" text-indent="0.5in">Volvo</fo:block>
    </fo:table-cell>
    <fo:table-cell>
      <fo:block font-size="12pt" text-indent="0.5in">$50000</fo:block>

    </fo:table-cell>
  </fo:table-row>
  <fo:table-row>
    <fo:table-cell>

      <fo:block font-size="12pt" text-indent="0.5in" space-before="5mm" space-after="5mm"
font-family="verdana">SAAB</fo:block>
<fo:block>
  LL
<fo:inline ID="A">LLL</fo:inline>
<fo:bidi-override direction="rtl">
   <fo:inline ID="A+">RRR</fo:inline>
   RRz
</fo:bidi-override>

</fo:block>

    </fo:table-cell>
    <fo:table-cell>
      <fo:block font-size="12pt" text-indent="0.5in">$48000</fo:block>

<fo:list-block>

<fo:list-item>
 <fo:list-item-label>
   <fo:block>*</fo:block>
 </fo:list-item-label>
 <fo:list-item-body>
   <fo:block text-indent="0.1in"  text-align="center">Volvo</fo:block>
 </fo:list-item-body>
</fo:list-item>

<fo:list-item  color="green">
 <fo:list-item-label>
   <fo:block>*</fo:block>
 </fo:list-item-label>
 <fo:list-item-body background-color="red">
   <fo:block background-color="inherited-property-value(color)">SAAB</fo:block>
 </fo:list-item-body>
</fo:list-item>

</fo:list-block>
<fo:block text-indent="0pc" space-after="7pt"
  space-before.minimum="6pt" space-before.optimum="8pt"
  space-before.maximum="10pt">Section one's first paragraph.
</fo:block>

    </fo:table-cell>
  </fo:table-row>			 
	</fo:table-body>		
       </fo:table>      
     </fo:flow>
</fo:page-sequence>
</fo:root>
</xsl:template>
</xsl:stylesheet>		  
  


 
