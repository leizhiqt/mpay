<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0"
exclude-result-prefixes="fo">

<xsl:template match="HBL">

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
		<fo:block  space-before="1mm" font-size="16pt" font-weight="bold"   text-align="center">
			成都汉易联信非融资性担保有限公司
		</fo:block>
		<fo:block  space-before="1mm" font-size="14pt" font-weight="bold"   text-align="center">		
			分期付款还款指引
		</fo:block>
		<fo:block  space-before="1mm" font-size="10pt" font-weight="bold"   text-align="center">		
			(一式两份)
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"   text-align="left">		
			尊敬的________
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"   text-align="left" margin-left="5mm" >		
			非常感谢您选择分期付款这一最新的消费方式。希望我们的服务在提高您生活质量的同时，能让您的生活更加时尚，更加现代化。
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"   text-align="left" space-after="5mm" >	
			在您充分享受美好的生活之际，请按时按计划还款。以下是您的分期付款业务的详情：
		</fo:block>
		<!-- 1 table -->
		<fo:table border="1pt solid black" >  
		<fo:table-column column-width="6cm"/>
		<fo:table-column column-width="6cm"/>
		<fo:table-column column-width="6cm"/>
		
		<fo:table-header>
		  <fo:table-row>
		    <fo:table-cell  border="1pt solid black" >
		      <fo:block  space-before="1mm"  text-align="left" padding-left="2mm" font-size="8pt">应付总金额（元）:________￥ </fo:block>
		    </fo:table-cell>
		    <fo:table-cell  border="1pt solid black" font-size="8pt">
		      <fo:block  space-before="1mm" text-align="left" padding-left="2mm" >每月还款额:_________￥ </fo:block>
		    </fo:table-cell>
		      <fo:table-cell  border="1pt solid black" font-size="8pt">
		      	<fo:block  space-before="1mm"  text-align="left" padding-left="2mm">分期期数：________</fo:block>
		      </fo:table-cell>
		  </fo:table-row>
		</fo:table-header>
		
		<fo:table-body>
		  <fo:table-row>
		    <fo:table-cell  border="1pt solid black">
		      <fo:block  space-before="1mm" font-size="8pt">首次还款日:</fo:block>
		    </fo:table-cell>
		    <fo:table-cell  border="1pt solid black" number-columns-spanned="2" > //number-columns-spanned="2"
		      <fo:block  space-before="1mm" font-size="8pt"> 每月还款日：</fo:block>
		    </fo:table-cell>
		    
		  </fo:table-row>
		</fo:table-body> 
		</fo:table>
		
		<fo:block  space-before="4mm"    text-align="left"  font-size="8pt" >		
			本分期付款可通过以下还款方式还款，并按如下优先顺序进行选择：
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"   text-align="left"    >		
			1. 银行代扣
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"  padding-left="5mm"      text-align="left">		
			 如果您在《分期付款申请表》中选择了银行代扣还款服务，我们将在每月还款日通过银行从您指定的银行账户内自动划扣。
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"  padding-left="5mm"      text-align="left">		
			对比其他还款渠道,银行代扣有如下优点：
		</fo:block>		
			 <fo:block  margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  >a. 我司提供给您的免费便利服务，您无需支付任何代扣手续费；</fo:block>
			 <fo:block  margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  >b. 您无需每月前往银行还款，为您节约了在银行排队等待的时间；</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  >c. 避免您忘记按时还款，只要您保证每个指定还款日前在代扣账户有足够的余额即可；</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  >d. 避免因为写错帐号导致款项不能及时到帐，方便您的还款及时到账。</fo:block>
			<fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > 如您的银行账户有变动，请致电联信服热线为您变更银行代扣账户信息。</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"    text-align="left"    >		
			2. 使用你的银行卡在银行、超市、便利店等带有拉卡拉标志          的自助终端缴款
		</fo:block>		
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > a. 在终端屏幕上选择“拉卡拉支付”；</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > b. 选择”账单号支付”;</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > c. 输入还款帐号xxxxxxxxxxxxx和还款金额；</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > d. 输入您的手机号；</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > e. 按终端机的提示确认；</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > f. 打印并保存好收据，作为还款凭证。</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > 如在操作过程中遇到任何问题或需要求助，请拨打拉卡拉客服热线400-666-1234</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"    text-align="left"    >		
			3.通过账户进行转账（包括网上银行，电话银行，自助服务终端机，和柜台转账等）
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"  margin-left="5mm"   text-align="left">		
			 请您咨询相关银行进行办理。转账所需信息均能在此文件上找到，如还款金额，还款账户等。<fo:block></fo:block>
			 温馨提醒：请将以下25位指定还款账号完整提供给办理转账的银行，如有银行职员提供不一致信息请致电联信客服热线核对以确保还款时<fo:block></fo:block>
			 间不受延误。
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt"        text-align="left">		
			4.如果您不方便通过以上3种渠道进行还款，您也可前往中国邮政储蓄银行柜台进行现金还款
		</fo:block>		
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > a. 到上述银行的各营业网点索取中国邮政储蓄银行汇款单</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > b. 收款人姓名为</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > c. 填写还款金额</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > d. 选择商务汇款，填写9位商户客户号xxxxxxxxx</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > e. 必须在附言中填写指定还款账户账号。</fo:block>
			 <fo:block margin-left="5mm" space-before="1mm" text-align="left" font-size="8pt"  > f. 必须保留汇款收据。</fo:block>
		<fo:block  space-before="1mm" font-size="8pt" font-weight="bold" space-after="2mm" >
			请知悉每月还款账户信息：
		</fo:block>

		<fo:table border="1pt solid black" >  
		
		<fo:table-column column-width="5cm"/>
		<fo:table-column column-width="13cm"/>
		
		<fo:table-body>
		<fo:table-row>
		<fo:table-cell  border="1pt solid black">
		<fo:block  space-before="1mm" font-size="8pt"> 开户银行：</fo:block>
		</fo:table-cell>
		<fo:table-cell  border="1pt solid black">
		<fo:block  space-before="1mm" font-size="8pt">中国银行</fo:block>
		</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
		<fo:table-cell  border="1pt solid black">
		<fo:block  space-before="1mm" font-size="8pt">户名：</fo:block>
		</fo:table-cell>
		<fo:table-cell  border="1pt solid black">
		<fo:block  space-before="1mm" font-size="8pt">$48000</fo:block>
		</fo:table-cell>
		</fo:table-row>
		<fo:table-row>
		<fo:table-cell  border="1pt solid black">
		<fo:block  space-before="1mm" font-size="8pt">指定还款账号：</fo:block>
		</fo:table-cell>
		<fo:table-cell  border="1pt solid black">
		<fo:block  space-before="1mm" font-size="8pt">$48000</fo:block>
		</fo:table-cell>
		</fo:table-row>
		</fo:table-body>
		
		</fo:table>
		

		<fo:block  space-before="3mm" font-size="8pt" font-weight="bold" >
			重要风险提示：
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt">
				*请不要用其他的还款方式还款（如请零售商或销售人员代为还款等），使用不正确的还款方式可能导致还款失败或延迟还款，届时您需承担
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt">
				全部后果。
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt">
				*为了避免影响您的个人信用记录，请按时还款。如果您未能按时还款，我们将会按照合同条款向您收取逾期费用。
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt">
				*请务必使用您本人的真实身份证及真实个人资料申请分期付款，如有发现虚假资料，将立即报警处理。
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt">
				若您有建议或疑问，欢迎致电我们的客户服务热线：028-66526698
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt">
				珍爱个人信用记录，实现美好生活品质！
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt">
				再次感谢您选择我们的服务，祝您身体健康，工作顺利！
		</fo:block>
		<fo:block  space-before="1mm" font-size="8pt">
				如您已经阅读并了解以上内容，请在本页下方确认。（本提示一式两份，一份由您带走，一份我司存档）
		</fo:block>
		<fo:block  space-before="3mm" text-align="center" font-size="8pt" space-after="2cm">
				客户签名确认：_____________   日期：______________
		</fo:block>
		<!-- <fo:block  space-before="1mm" font-size="16pt" font-weight="bold"   text-align="center">
			成都汉易联信非融资性担保有限公司
		</fo:block>
		<fo:block  space-before="1mm" font-size="14pt" font-weight="bold"   text-align="center">		
			分期付款还款指引
		</fo:block>
		<fo:block  space-before="1mm" font-size="10pt" font-weight="bold"   text-align="center" space-after="5mm">		
			(一式两份)
		</fo:block>
	<fo:table  >  
		
		<fo:table-column column-width="9cm"/>
		<fo:table-column column-width="5mm"/>
		<fo:table-column column-width="9cm"/>
		
		<fo:table-body>
		
			<fo:table-row>
				<fo:table-cell  border="1pt solid black" >
					<fo:block text-align="center" color="red" font-size="14pt"  font-weight="bold"   > 还款提示卡：</fo:block>
					<fo:block text-align="center" font-size="8pt" space-before="2mm" space-after="2mm"  > 客户服务热线: 028-69164290</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="1mm" >非常感谢您选择分期付款这一最新的消费方式。在您充分享受美好的生活之</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="1mm" >际，请记得按时按计划还款。以下是您的分期付款业务的详情:</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="2mm">每月还款额(元):__________ 还款期数:_________</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="1mm">_________________________________________________</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="2mm">首次还款日:                          每月还款日:</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="1mm">_________________________________________________</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="2mm" space-after="5mm">为了避免产生不必要的逾期滞纳金.我们建议您在还款日前5天存入相应金额。</fo:block>
				</fo:table-cell>
				<fo:table-cell  >
					<fo:block ></fo:block>
				</fo:table-cell >
				<fo:table-cell  border="1pt solid black" >
					<fo:block text-align="center" color="red" font-size="14pt"  font-weight="bold"   >还款账号:</fo:block>
					<fo:block text-align="center" font-size="8pt" space-before="2mm" space-after="2mm"  > 客户服务热线: 028-69164290</fo:block>
					<fo:block text-align="left" font-size="6pt"  margin-left="5mm" space-before="1mm" >为了避免产生不必要的逾期滞纳金.我们建议您在每月还款日前5天存入相</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="1mm" >应款项，请您将每月还款额存入以下还款账户:</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="2mm">开户银行:_______________________________________</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="2mm">户名:___________________________________________</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="2mm">指定还款账号:___________________________________</fo:block>
					<fo:block text-align="left" font-size="6pt" margin-left="5mm" space-before="2mm" space-after="5mm">邮政储蓄银行商户客户号:__________________________</fo:block>
				</fo:table-cell>
			</fo:table-row>
		
		</fo:table-body>
		
		</fo:table> -->
	
</fo:flow>
</fo:page-sequence>
</fo:root>
</xsl:template>
</xsl:stylesheet>		  
  


 
