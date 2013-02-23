<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0"
exclude-result-prefixes="fo">

<xsl:template match="SN">

<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

<fo:layout-master-set>
	<fo:simple-page-master master-name="simpleA4"
		page-height="29.7cm" page-width="21cm" margin-top="2cm"
		margin-bottom="2cm" margin-left="1.5cm" margin-right="1cm">
		<fo:region-body />
	</fo:simple-page-master>
</fo:layout-master-set>


<fo:page-sequence master-reference="simpleA4">

	<fo:flow flow-name="xsl-region-body">
		<!-- find a mechanism to handle the company specific logo and document 
			name -->
		<!-- <xsl:apply-templates select="companyName"/> <xsl:apply-templates 
			select="DocumentName"/> -->

		<fo:block font-size="16pt" font-weight="bold" space-after="5mm"
			text-align="center">
			个人分期付款消费及相关服务合同
		</fo:block>
		<fo:block font-size="12pt" text-align="center"  >
			前 言
		</fo:block>
		<fo:block font-size="6pt"  text-align="center">
			本合同分通用条款部分和专用条款部分，其中通用条款部分对全体缔约者有约束力，专用条款部分仅对约定方有约束力。
		</fo:block>
		<fo:block font-size="12pt" text-align="center"  >
			释  义
		</fo:block>
		<!-- 1 table -->
		<fo:table>
			<fo:table-column column-width="2cm" />
			<fo:table-column column-width="16.6cm" />
			<fo:table-header>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black"   >
						<fo:block font-size="6pt">
							消费者
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指签署本合同，通过分期付款方式从销售方购买产品并接受担保方和服务提供方的担保和消费服务且具备完全民事行为能力的自然人。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-header>

			<fo:table-body>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							销售方
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指成都汉易联信非融资性担保有限公司。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							担保方
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指成都汉易联信非融资性担保有限公司。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							服务提供方
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指成都汉易时代资产管理有限公司。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							货款
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指消费者从销售方购买产品应按月分期向销售方支付的价款。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							担保费
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指担保方为消费者向销售方和服务提供方提供担保服务而向消费者收取的费用。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							服务费
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指服务提供方为消费者提供本合同约定服务而向消费者收取的费用。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							签约方
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指消费者、担保方、服务提供方以及销售方四方。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							账户
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指本合同约定的，消费者支付货款、担保费和服务费的指定银行账号。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							元
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							若非特别指出币种，均指中国的法定货币人民币元。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							月
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"   
							 >
							指日历月。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black"  number-columns-spanned="2" >
						<fo:block font-size="6pt" text-align="center"  >
							除非另有说明，上述词语在本合同中仅指本释义所指含义。
						</fo:block>

					</fo:table-cell>

				</fo:table-row>

			</fo:table-body>

		</fo:table>
						<fo:block font-size="6pt" font-weight="bold" text-align="center">通用条款</fo:block>
					
						<fo:block font-size="6pt"   >
						1、本协议从签约方签字盖章之日起生效。
						</fo:block>
					
						<fo:block font-size="6pt" >
							2、 消费者个人信息及联系方式如下表，费者更改联系方式和住所（居所）的， 应当提前书面通知服务提供方，
						</fo:block>
					   <fo:block font-size="6pt"     >否则应当向其他各方分别支付产品价款总额20%的违约金：</fo:block>
		<fo:table>
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black"  >
						<fo:block font-size="6pt"       >
						姓名
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"      >
						身份证号
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"       >
						通讯地址
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"       >
						所属单位(学校）
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"       >
						电话
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="ClientName"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="ClientID"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt"  wrap-option="wrap" language="zh" text-align="start"
							 ><xsl:value-of select="Address"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="FromIn"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="TelePhone"/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"         >
						邮箱
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"        >
						商户名称
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"         >
						商户号
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"        >
							 门店名称
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt"        >
						门店号
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
				<fo:table-row >
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="Email"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="StoreName"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="StoreKey"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="StoreName"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black">
						<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start"   
							 ><xsl:value-of select="StoreKey"/>
						</fo:block>
					</fo:table-cell>
					
				</fo:table-row>
				<fo:table-row >
					<fo:table-cell number-columns-spanned="10">
						<fo:block font-size="6pt"   
							border-width="0.5pt" border-style="solid" text-algin="center">
							消费者变更联系方式未通知其他各方的，则各方按此联系方式发送通知达到的，视为有效送达，且造成的一切后果由消费者自行承担。
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		<!-- will handle footer later <xsl:apply-templates select="footer"/> -->

						<fo:block font-size="6pt" space-before="2mm" >3、
							违约方承担诉讼费、差旅费和律师费。
							4.1消费者签署本合同即表明不可撤销地授权<xsl:value-of select="BankName"/>银行代为从其在《还款指引》上指定的还款账户
							（账号： <xsl:value-of select="DebitCard"/>开户行：<xsl:value-of select="BankName"/>）中按月代扣当月应付销售方、担保方以及服务提供方相应款项。
							4.2消费者如遇卡上余额不足，造成银行扣款不成功，责任由消费者自行承担，与银行无关。
							4.3如遇银行扣款不成功（如扣款费用计算错误、非银行造成的扣款延迟等）由消费者及销售方自行承担，与银行无关。
						4.4消费者与销售方、担保方、服务提供方产生的一切经济与法律纠纷由消费者、销售方及担保行自行承担，与银行无关。

							5、消费者应分别向销售方、担保方和服务提供方支付价款和服务费，金额和支付方式以经消费者确认的《还款指引》为准。

							销售方收到消费者支付的款项后，应当按月将担保方应收担保费以及服务提供方应收服务费分别支付与担保方和服务提供方。

							6、本合同一式四份，各方各执一份，从各方签字盖章之日起生效。
						</fo:block>
						<fo:block font-size="6pt" font-weight="bold" text-align="center" space-before="2mm" >
							专用条款一：分期付款买卖条款
						</fo:block>
					

						<fo:block  font-size="6pt" space-before="2mm">
						1、 本专用条款由消费者与销售方缔结，对双方有约束力
							2、 销售方向消费者提供的产品信息如下</fo:block>
		<fo:table>
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-column column-width="4cm" />
			<fo:table-column column-width="3cm" />
			<fo:table-body>
				<fo:table-row >
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt" 
							   
							>产品名称
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt" 
							  
							>型号及编号
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt" 
							   
							>品牌
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt" 
							   
							>数量（单位：台）
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
						<fo:block font-size="6pt" 
							   
							>价款（单位：元）
						</fo:block>
					</fo:table-cell>
				</fo:table-row >
				<fo:table-row height="2cm">
					<fo:table-cell  border="1pt solid black" >
							<xsl:for-each select="Lookup">
								<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start">
									<xsl:value-of select="ProductName"/>
								</fo:block>
				  			</xsl:for-each>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
							<xsl:for-each select="Lookup">
								<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start">
									<xsl:value-of select="ProductModelNo"/>
								</fo:block>
				  			</xsl:for-each>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
							<xsl:for-each select="Lookup">
								<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start">
									<xsl:value-of select="ProductBrand"/>
								</fo:block>
				  			</xsl:for-each>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
							<xsl:for-each select="Lookup">
								<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start">
									<xsl:value-of select="ProductQuantity"/>
								</fo:block>
				  			</xsl:for-each>
					</fo:table-cell>
					<fo:table-cell  border="1pt solid black" >
							<xsl:for-each select="Lookup">
								<fo:block font-size="6pt" wrap-option="wrap" language="zh" text-align="start">
									<xsl:value-of select="ProductPrice"/>
								</fo:block>
				  			</xsl:for-each>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>

						<fo:block font-size="6pt"    >
							3、 消费者购买本合同约定产品应向销售方支付<xsl:value-of select="TotalPrice"/>元价款，于签订本合同时支付首付款<xsl:value-of select="SelfAmount"/>元，余款采用按月分期付款方式支付，<fo:block text-indent="0.2in">共分为<xsl:value-of select="CycleTotal"/>期（以《还款指引》为准）。销售方委托消费者将应付首付款直接支付与<xsl:value-of select="StoreName"/>门店。</fo:block>
						
							4、 销售方所供的产品须符合国家技术规范和质量标准，须为经国家“三C”认证或检验的合格产品。
						
							5、 本合同签订后，销售方向消费者当场交付所购产品，消费者验收后出具收据。
						
							6、 销售方向消费者交付产品时，须同时向消费者提供产品使用说明书、质量保证书、三包凭证等相关资料和原配的附件（如有）。
						
							7、 退货条件与处理程序根据生产厂家质保书和三包证以及国家法律规定为准。
						
							8、 本产品质保期以质保书为准。在质保期内如消费者所购产品出现产品本身质量问题的，由<xsl:value-of select="StoreName"/>（门店）负责维修、更换。
						
							9、 违约责任
						
								 9.1  消费者应当按期支付货款，如有迟延，销售方有权要求消费者限期一次性支付剩余价款，并有权要求消费者按照价款总额的20%支付违约金。
						
								 9.2消费者使用所购产品遭受损失的，销售方应当赔偿。
						
						 	10、 争议由销售方所在地人民法院管辖。
						 </fo:block>
						
		

						<fo:block font-size="6pt" text-align="center" font-weight="bold"   space-before="2mm" >
							专用条款二：消费服务条款
						</fo:block>
					
						<fo:block font-size="6pt"  space-before="1mm" >
							1、本专用条款由消费者与服务提供方缔结，对双方有约束力。
							2、销售服务上向消费者提供如下服务：

							2.1 协助消费者办理分期付款消费与担保申请手续，包括制作各种申请文件、搜集整理相关信息资料，代为保管本合

							同和消费者签署的申请表的正本等相关资料

							2.2 消费者同意其签署的与本分期付款消费有关的合同文件由客户服务供应商保存；

							2.3 将担保方出具的担保审核意见书提供给销售方；

							2.4 协助消费者处理产品交付、维修、更换等；

							2.5 电话或短信提醒还款服务、客户咨询的热线电话服务（热线电话为：028-69164290），消费者提前还款结算服务等客户服务。

							3、 消费者接受前述服务应向服务提供方支付服务费，服务费总金额为<xsl:value-of select="MonthOfPay"/>元按月分期支付，共分<xsl:value-of select="CycleTotal"/>期（以《还款指引》为准）。

							4、 如分期付款期间，消费者选择提前一次性支付所欠产品 价款的，则服务提供方按照《个人分期付款消费及相关服务合同》

							一次性收取消费者服务费，余下服务费不再收取。

							5、 服务提供方应当提前三日以电话或短信通知消费者还款（含担保费、服务费以及分期价款），服务提供方未尽通知义务导致

							消费者遭受损失的，由服务提供方赔偿消费者所遭受的全部损失。

							6、 争议由服务提供方人民法院管辖。
							</fo:block>
					
						<fo:block font-size="6pt" font-weight="bold" text-align="center"   space-before="2mm">专用条款三：担保条款
						</fo:block>
					
						<fo:block font-size="6pt"  space-before="1mm" >
						1、 本专用条款由消费者与担保方缔结，对双方有约束力。
					
							2、 担保方向消费者提供如下担保服务：
						
							2.1 就消费者在专用条款一项下的产品价款支付义务和专用条款二项下的服务费支付义务，向权利人提供连带保证责任担保；
							
							2.2 担保范围包括主债权以及相应的违约责任（含违约金支付义务、律师费支付义务）等。
							
							3、 担保方应当于本合同签订后分别向销售方和服务提供方出具担保函。MonthOfPay
							
							4、 消费者接受前述担保服务应向担保方支付担保费，服务费总金额为<xsl:value-of select="MonthOfPay"/>元按月分期支付，共分<xsl:value-of select="CycleTotal"/>期（以《还款指引》为准）。
							
							5、 消费者违反《专用条款二：消费服务条款》或《专用条款三：担保条款》款项支付义务的，担保方根据《专用条款二：消费服务条款》和
							
							《专用条款三：担保条款》约定向权利人代偿后，有权向消费者追偿，追偿范围包括代偿本金、违约金以及律师费等。

							6、 争议由担保方所在地人民法院管辖。
							</fo:block>
					
		
		
		<fo:table>
			<fo:table-column column-width="10cm" />
			<fo:table-column column-width="10cm" />
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell  >
						<fo:block font-size="6pt" font-weight="bold"   space-before="2mm"
							text-algin="center">消费者：_________
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  >
						<fo:block font-size="6pt" font-weight="bold"   space-before="2mm"
							text-algin="center">销售方：___________
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		
		<fo:table>
			<fo:table-column column-width="10cm" />
			<fo:table-column column-width="10cm" />
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell >
						<fo:block font-size="6pt" font-weight="bold"   space-before="2mm"
							text-algin="center">服务提供方：_________
						</fo:block>
					</fo:table-cell>
					<fo:table-cell  >
						<fo:block font-size="6pt" font-weight="bold"   space-before="2mm"
							text-algin="center">担保方：___________
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
		
		
		<fo:table>
			<fo:table-column column-width="10cm" />
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell  >
						<fo:block font-size="6pt" font-weight="bold"   space-before="2mm"
							text-algin="center">签订日期：_________
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
  


 
