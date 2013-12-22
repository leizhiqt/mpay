<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="1.0">
	
<xsl:template match="HBL">
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

 <fo:layout-master-set>
    <fo:simple-page-master master-name="all"
			page-width="210mm" page-height="297mm"
        	margin-top="6mm" margin-bottom="5mm" 
        	margin-left="5mm" margin-right="5mm">
  		<fo:region-body margin-top="4mm" margin-bottom="1mm"/>
 	</fo:simple-page-master>
 </fo:layout-master-set>


 <fo:page-sequence master-reference="all">
    <fo:flow flow-name="xsl-region-body">
      <fo:table>
      <fo:table-column column-width="100mm"/>
      <fo:table-column column-width="100mm"/>

      <fo:table-body>

       <fo:table-row >

		  <fo:table-cell>
        <!--left-table-->
            <fo:table>
             <fo:table-column column-width="100mm"/>
             <fo:table-body>
					<!-- Shiper -->
			 		<fo:table-row height="17mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">

                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
								<xsl:value-of select="ShipperKey"/>
							</fo:block>
							
          <xsl:for-each select="Lookup">
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
			   				<xsl:value-of select="ShipperValue"/>				
          </fo:block>
        </xsl:for-each>

                     
                   </fo:table-cell>
             	</fo:table-row>
					<!-- Consignee -->
             	<fo:table-row height="23mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       	<xsl:value-of select="ConsigneeKey"/>
							</fo:block>
         <xsl:for-each select="Lookup">
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
								<xsl:value-of select="ConsigneeValue"/>
							</fo:block>
				  </xsl:for-each>
                  </fo:table-cell>
             	</fo:table-row>
					<!-- NotifyParty -->
             	<fo:table-row height="23mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       	<xsl:value-of select="NotifyPartyKey"/>
							</fo:block>
                              
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
								<xsl:value-of select="NotifyPartyValue"/>
							</fo:block>
				
                  </fo:table-cell>
             	</fo:table-row>

				<!-- rowA4 -->
             <fo:table-row>
		  			<fo:table-cell>
                 <fo:table>
		      		<fo:table-column column-width="50mm"/>
		      		<fo:table-column column-width="50mm"/>
		      		<fo:table-body>
					<!--  left start row1 -->
                   <fo:table-row height="8mm">
						<!--  Place of Receipt -->
	                	<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       	<xsl:value-of select="ReceiptPlaceKey"/>
							</fo:block>
                              
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
								<xsl:value-of select="ReceiptPlaceValue"/>
							</fo:block>
                   </fo:table-cell>
						<!--  Precarrigge By -->
                   <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       	<xsl:value-of select="PreCarriageKey"/>
							</fo:block>
                              
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
								<xsl:value-of select="PreCarriageValue"/>
							</fo:block>
                  </fo:table-cell>
                </fo:table-row>
					<!--  left start row2 -->
                <fo:table-row height="8mm">
						<!--  Vessel &amp; Voy.No -->
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       	<xsl:value-of select="VesselKey"/>
							</fo:block>
                              
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
								<xsl:value-of select="VesselValue"/>
							</fo:block>
                   </fo:table-cell>
						<!--  Port of Loading -->
                   <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       	<xsl:value-of select="POLPlaceKey"/>
							</fo:block>
                              
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
								<xsl:value-of select="POLPlaceValue"/>
							</fo:block>
                    </fo:table-cell>
                </fo:table-row>
					<!--  left start row3 -->
                <fo:table-row height="8mm">
						<!--  Port of Discharge -->
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       	<xsl:value-of select="PODPlaceKey"/>
							</fo:block>
                              
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
								<xsl:value-of select="PODPlaceValue"/>
							</fo:block>
                   </fo:table-cell>
						<!--  Place of Delivery -->
                   <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       	<xsl:value-of select="DeliveryPlaceKey"/>
							</fo:block>
                              
							<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
								<xsl:value-of select="DeliveryPlaceValue"/>
							</fo:block>
                   </fo:table-cell>
                </fo:table-row>

             </fo:table-body>
           	</fo:table>
           </fo:table-cell>
           </fo:table-row >
         </fo:table-body>
     </fo:table>
  </fo:table-cell>

                              <!-- Top Rigth sub-table -->

		  <fo:table-cell border-width="1pt"  padding-left="0.00mm">

		     <fo:table>
		      		<fo:table-column column-width="100mm"/>
		      <fo:table-body>
					<!-- log text -->
                       <fo:table-row height="63mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="solid"
														padding-before="10mm" padding-after="0pt" padding-start="0pt" padding-end="0pt">
										<fo:block text-align="center" font-size="28pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>PACIFIC STAR</xsl:text>
										</fo:block>
										<fo:block text-align="center" font-size="15pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>EXPRESS CORPORATION</xsl:text>
										</fo:block>
										<fo:block text-align="center" font-size="20pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>OCEAN BILL OF LADING</xsl:text>
										</fo:block>
										<fo:block text-align="center" font-size="13pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>(FOR U.S.A TRADING ONLY)</xsl:text>
										</fo:block>
										<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>(FOR PORT TO PORT OR MULTIMODAL TRANSPORT SERVICE)</xsl:text>
										</fo:block>
										<fo:block text-align="center" font-size="10pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>NOT NEGOTIABLE UNLESS CONSIGNED "TO ORDER"</xsl:text>
										</fo:block>
										<fo:block text-align="center" font-size="6pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>THE INTERNATIONAL MULTIMODAL TRANSPORT OPERATOR &amp; CARRIER</xsl:text>
										</fo:block>
										<fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>LICENSED MINISTRY OF COMMUNICATIONS R.O.C. UNDER LICENSE NO 103</xsl:text>
										</fo:block>
									</fo:table-cell>
                       </fo:table-row>
							 <!--  right start row -->
                       <fo:table-row height="8mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="solid"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">

                              <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       				<xsl:value-of select="ValueDeclKey"/>
										</fo:block>

										<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
											<xsl:value-of select="ValueDeclValue"/>
										</fo:block>

									</fo:table-cell>
                       </fo:table-row>
							 <!--  right start row -->
                       <fo:table-row height="8mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="solid"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">

                              <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       				<xsl:value-of select="IniadRoutingKey"/>
										</fo:block>

										<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
											<xsl:value-of select="IniadRoutingValue"/>
										</fo:block>

									</fo:table-cell>
                       </fo:table-row>
							 <!--  right start row -->
                       <fo:table-row height="8mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="solid"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">

                              <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
					       				<xsl:value-of select="FinalDestKey"/>
										</fo:block>

										<fo:block text-align="start" font-size="6pt" font-family="sans-serif">
											<xsl:value-of select="FinalDestValue"/>
										</fo:block>

									</fo:table-cell>
                       </fo:table-row>
<!-- end  -->
                    </fo:table-body>
                  </fo:table>
                </fo:table-cell>
                </fo:table-row >

                <!--MIDDLE TABLE-->
                       <fo:table-row height="2mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="solid" number-columns-spanned="2"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">
										<fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>Particulars furnished by the Merchant</xsl:text>
										</fo:block>
									</fo:table-cell>
                       </fo:table-row>

							<!--  start -->
                      <fo:table-row>
                      <fo:table-cell>

                       <fo:table padding-before="0.0mm">
		      				<fo:table-column column-width="40mm"/>
		      				<fo:table-column column-width="30mm"/>
		      				<fo:table-column column-width="90mm"/>
		      				<fo:table-column column-width="40mm"/>
		     	 			  <fo:table-body>
                    	<fo:table-row height="4mm">

	              			<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:value-of select="Header1"/>
								</fo:block>                  
								</fo:table-cell>

                     	<fo:table-cell text-align="center" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:value-of select="Header2"/>
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="center" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                         <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:value-of select="Header3"/>
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="center" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                         <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:value-of select="Header4"/>
								</fo:block>                  
								</fo:table-cell>

                      </fo:table-row>
                  
                    	<fo:table-row height="80mm">

	              			<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">

		     					<fo:table>
		      					<fo:table-column column-width="39mm"/>
		      					<fo:table-body>
									<!-- log text -->
                       		<fo:table-row height="70mm">
	              			<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
                            <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
											<xsl:value-of select="FreightMark"/>
										</fo:block>  
                            </xsl:for-each>
								</fo:block>



								</fo:table-cell>
                       		</fo:table-row>

                       		<fo:table-row height="8mm">
	              			<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                        <fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>TOTAL NUMBER OF </xsl:text>
								</fo:block>
                       	<fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>CONTAINERS OR PACKAGES</xsl:text>
								</fo:block>
                       	<fo:block text-align="start" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>(IN WORDS)</xsl:text>
								</fo:block>
								</fo:table-cell>

                       		</fo:table-row>

		      					</fo:table-body>
									</fo:table>
								</fo:table-cell>

                     	<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
                            <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
											<xsl:value-of select="FreightNumOfPKG"/>
										</fo:block>  
                            </xsl:for-each> 
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                         <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
                            <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
											<xsl:value-of select="FreightDesc"/>
										</fo:block>  
                            </xsl:for-each> 
				<xsl:for-each select="FreightMessage">
                              <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
											<xsl:value-of select="FreightValue"/>
										</fo:block> 
				</xsl:for-each>
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                         <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
                            <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="7pt" font-family="sans-serif" font-weight="bold">
											<xsl:value-of select="FreightGross"/>
											<xsl:value-of select="FreightMeasure"/>
										</fo:block>  
                            </xsl:for-each>
								</fo:block>                  
								</fo:table-cell>

                      </fo:table-row>

                     </fo:table-body>
                    </fo:table>

                       <fo:table padding-before="0.0mm">
		      				<fo:table-column column-width="40mm"/>
		      				<fo:table-column column-width="40mm"/>
		      				<fo:table-column column-width="40mm"/>
		      				<fo:table-column column-width="40mm"/>
		      				<fo:table-column column-width="40mm"/>
		     	 			  <fo:table-body>
                  
                    	<fo:table-row height="33mm">

	              			<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">  
								            <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
																					<xsl:value-of select="FreightKey"/>
																</fo:block>
														   <fo:block text-align="left" font-size="7pt" font-family="sans-serif">
																				<xsl:value-of select="FreightValue"/>
																</fo:block>           
								</fo:table-cell>

                     	<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Revenue Tons</xsl:text>
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">

		     					<fo:table>
		      					<fo:table-column column-width="20mm"/>
		      					<fo:table-column column-width="20mm"/>
		      					<fo:table-body>
									<!-- log text -->
                       		<fo:table-row height="30mm" border-style="none">
                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Rate</xsl:text>
								</fo:block>
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="right" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Per</xsl:text>
								</fo:block>
								</fo:table-cell>

                       		</fo:table-row>

		      					</fo:table-body>
									</fo:table>
               
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                         <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Prepaid</xsl:text>
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="right"
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                         <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Collect</xsl:text>
								</fo:block>                  
								</fo:table-cell>

                      </fo:table-row>

                     </fo:table-body>
                    </fo:table>

                       <fo:table padding-before="0.0mm">
		      				<fo:table-column column-width="40mm"/>
		      				<fo:table-column column-width="80mm"/>
		      				<fo:table-column column-width="40mm"/>
		      				<fo:table-column column-width="40mm"/>
		     	 			  <fo:table-body>
                  
                    	<fo:table-row height="8mm">

	              			<fo:table-cell  text-align="right"
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Service Type</xsl:text>
								</fo:block>
								</fo:table-cell>

                     	<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt"  padding-end="1pt">
                       	<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Exchange Rate</xsl:text>
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt"  padding-end="1pt">
                         <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Prepaid at</xsl:text>
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt"  padding-end="1pt">
                         <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
									<xsl:text>Payable at</xsl:text>
								</fo:block>                  
								</fo:table-cell>

                      </fo:table-row>

                     </fo:table-body>
                    </fo:table>

                        </fo:table-cell>
                       </fo:table-row>

                       <fo:table-row height="24mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="solid" number-columns-spanned="2"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">
										<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>RECEIVEO by the Carrler the Goods as speclfled above In apparent Good order and condition unless otherwisc slated, to be transported to such place as agreed,</xsl:text>
										</fo:block>

										<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>authorized or permitted herein and subject to all the terms and condltions appearing on the front and reverse of
this Bill of Lading to which the Merchant agreess by accepting this Bill of Lading, any local privileges and Customs notwithstanding</xsl:text>
										</fo:block>

										<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>The Particulars given above as stated by the shiper and the weight,measure,quantity,condltion,contents and value of the Goods are unknown to the Carrier.</xsl:text>
										</fo:block>

										<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>In WITNESS whereof three original Bills Lading has been signed if not otherwise stated beiow,one of which to be completed the other(s) to be void. IF Required by the Carrier three original Bills of Lading must be surrendered duly endorsed In exchange for the Goods or delivery order.</xsl:text>
										</fo:block>

									</fo:table-cell>
                       </fo:table-row>


                       <fo:table-row>
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="solid" number-columns-spanned="2"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">
									    <fo:table>
		      							<fo:table-column column-width="40mm"/>
		      							<fo:table-column column-width="80mm"/>
		      							<fo:table-column column-width="80mm"/>

		      							<fo:table-body>

                            			<fo:table-row height="7mm">
                              			<fo:table-cell  
                               				border-color="black" border-width="1pt" border-style="solid"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
                         						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
																								<xsl:value-of select="NumOfOrgKey"/>
																					</fo:block>
														           <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
																								<xsl:value-of select="NumOfOrgValue"/>
																					</fo:block>
													</fo:table-cell>

                              			<fo:table-cell  
                               				border-color="black" border-width="1pt" border-style="solid"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
                         						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
															<xsl:value-of select="PlaceOfIssueKey"/>
														</fo:block>
														            <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
															<xsl:value-of select="PlaceOfIssueValue"/>
														</fo:block>
													</fo:table-cell>

                              			<fo:table-cell  number-rows-spanned="3"
                               				border-color="black" border-width="1pt" border-style="none"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
													</fo:table-cell>

                            			</fo:table-row>

                            			<fo:table-row height="7mm">
                              			<fo:table-cell  
                               				border-color="black" border-width="1pt" border-style="solid"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
                         						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
															<xsl:value-of select="HouseBillNoKey"/>
														</fo:block>
														            <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
															<xsl:value-of select="HouseBillNoValue"/>
														</fo:block>
													</fo:table-cell>

                              			<fo:table-cell  
                               				border-color="black" border-width="1pt" border-style="solid"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
                         						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
															<xsl:value-of select="VesselKey"/>
														</fo:block>
														            <fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
															<xsl:value-of select="VesselValue"/>
														</fo:block>
													</fo:table-cell>

                            			</fo:table-row>

                            			<fo:table-row height="16mm">
                              			<fo:table-cell  number-columns-spanned="2"
                               				border-color="black" border-width="1pt" border-style="solid"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
																						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    																	<xsl:text>For Delivery of goods please apply to</xsl:text>
																						</fo:block>
																						
																						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    																	<xsl:text>PAN FACIFIC EXPRESS CORP.</xsl:text>
																						</fo:block>
																						
																						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    																	<xsl:text>20021 S.Rancho Way Rancho Dominguez,</xsl:text>
																						</fo:block>
																						
																						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    																	<xsl:text>CA 96220</xsl:text>
																						</fo:block>
																						
																						<fo:block text-align="left" font-size="7pt" font-family="sans-serif" font-weight="bold">
					    																	<xsl:text>Tel:310-638-3887</xsl:text>
																						</fo:block>
													</fo:table-cell>

                            			</fo:table-row>

       		      					</fo:table-body>
									    </fo:table>

									</fo:table-cell>
                       </fo:table-row>

                       <fo:table-row height="5mm">
				 					<fo:table-cell border-color="black" border-width="0pt" border-style="solid" number-columns-spanned="2"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">
										<fo:block text-align="right" font-size="16pt" font-family="sans-serif" font-weight="bold">
					    					<xsl:text>BBLREF. No (012450)</xsl:text>
										</fo:block>
									</fo:table-cell>
                       </fo:table-row>
            </fo:table-body> 
           </fo:table>

<!--  will handle footer later
     <xsl:apply-templates select="footer"/>
 -->
    </fo:flow>
 </fo:page-sequence>
</fo:root>
</xsl:template>
</xsl:stylesheet>
