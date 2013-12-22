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
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">

                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
								
							</fo:block>
							
          <xsl:for-each select="Lookup">
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
			   				<xsl:value-of select="ShipperValue"/>				
          </fo:block>
        </xsl:for-each>

                     
                   </fo:table-cell>
             	</fo:table-row>
					<!-- Consignee -->
             	<fo:table-row height="23mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       	
							</fo:block>
         <xsl:for-each select="Lookup">
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
								<xsl:value-of select="ConsigneeValue"/>
							</fo:block>
				  </xsl:for-each>
                  </fo:table-cell>
             	</fo:table-row>
					<!-- NotifyParty -->
             	<fo:table-row height="23mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       	
							</fo:block>
                              <xsl:for-each select="Lookup">
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
								<xsl:value-of select="NotifyPartyValue"/>
							</fo:block></xsl:for-each>
				
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
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       	
							</fo:block>
                              
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
								<xsl:value-of select="ReceiptPlaceValue"/>
							</fo:block>
                   </fo:table-cell>
						<!--  Precarrigge By -->
                   <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       	
							</fo:block>
                              
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
								<xsl:value-of select="PreCarriageValue"/>
							</fo:block>
                  </fo:table-cell>
                </fo:table-row>
					<!--  left start row2 -->
                <fo:table-row height="8mm">
						<!--  Vessel &amp; Voy.No -->
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       
							</fo:block>
                              
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
								<xsl:value-of select="VesselValue"/>
							</fo:block>
                   </fo:table-cell>
						<!--  Port of Loading -->
                   <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       	
							</fo:block>
                              
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
								<xsl:value-of select="POLPlaceValue"/>
							</fo:block>
                    </fo:table-cell>
                </fo:table-row>
					<!--  left start row3 -->
                <fo:table-row height="8mm">
						<!--  Port of Discharge -->
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       	
							</fo:block>
                              
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
								<xsl:value-of select="PODPlaceValue"/>
							</fo:block>
                   </fo:table-cell>
						<!--  Place of Delivery -->
                   <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                      <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       	
							</fo:block>
                              
							<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
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
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="none"
														padding-before="10mm" padding-after="0pt" padding-start="0pt" padding-end="0pt">
									
									</fo:table-cell>
                       </fo:table-row>
							 <!--  right start row -->
                       <fo:table-row height="8mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="none"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">

                              <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       				
										</fo:block>

										<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
											<xsl:value-of select="ValueDeclValue"/>
										</fo:block>

									</fo:table-cell>
                       </fo:table-row>
							 <!--  right start row -->
                       <fo:table-row height="8mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="none"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">

                              <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       				
										</fo:block>

										<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
											<xsl:value-of select="IniadRoutingValue"/>
										</fo:block>

									</fo:table-cell>
                       </fo:table-row>
							 <!--  right start row -->
                       <fo:table-row height="8mm">
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="none"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">

                              <fo:block text-align="start" font-size="9pt" font-family="sans-serif">
					       				
										</fo:block>

										<fo:block text-align="start" font-size="9pt" font-family="sans-serif">
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
				 					<fo:table-cell border-color="black" border-width="1pt" border-style="none" number-columns-spanned="2"
														padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">

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
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                
								</fo:table-cell>

                     	<fo:table-cell text-align="center" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                
								</fo:table-cell>

                        <fo:table-cell text-align="center" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                 
								</fo:table-cell>

                        <fo:table-cell text-align="center" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
               
								</fo:table-cell>

                      </fo:table-row>
                  
                    	<fo:table-row height="80mm">

	              	<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
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
                       	<fo:block text-align="center" font-size="9pt" font-family="sans-serif">
                            <xsl:for-each select="FreightItem">
<xsl:for-each select="Lookup">
                              <fo:block text-align="left" font-size="9pt" font-family="sans-serif">
				<xsl:value-of select="FreightMark"/>
			      </fo:block>  
</xsl:for-each>
                            </xsl:for-each>
                            
								</fo:block>



								</fo:table-cell>
                       		</fo:table-row>

                       		<fo:table-row height="8mm">
	              			<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">

								</fo:table-cell>

                       		</fo:table-row>

		      					</fo:table-body>
									</fo:table>
								</fo:table-cell>

                     	<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                       	<fo:block text-align="center" font-size="9pt" font-family="sans-serif">
                            <xsl:for-each select="FreightItem">
                              <fo:block text-align="left" font-size="9pt" font-family="sans-serif">
											<xsl:value-of select="FreightNumOfPKG"/>
										</fo:block>  
                            </xsl:for-each> 
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                         <fo:block text-align="center" font-size="9pt" font-family="sans-serif">
                            <xsl:for-each select="FreightItem">
<xsl:for-each select="Lookup">
                              <fo:block text-align="left" font-size="9pt" font-family="sans-serif">
											<xsl:value-of select="FreightDesc"/>
										</fo:block>
</xsl:for-each> 
                            </xsl:for-each> 
				<xsl:for-each select="FreightMessage">
                              <fo:block text-align="left" font-size="9pt" font-family="sans-serif">
											<xsl:value-of select="FreightValue"/>
										</fo:block> 
				</xsl:for-each> 
								</fo:block>                  
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                         <fo:block text-align="center" font-size="9pt" font-family="sans-serif">
                            <xsl:for-each select="Lookup">
                              <fo:block text-align="left" font-size="9pt" font-family="sans-serif">
											<xsl:value-of select="Freight"/>
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
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">  
			 <fo:block text-align="center" font-size="9pt" font-family="sans-serif">
				<xsl:value-of select="FreightValue"/>
			</fo:block>
			</fo:table-cell>

                     	<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                
			</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
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
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">

								</fo:table-cell>

                       		</fo:table-row>

		      					</fo:table-body>
									</fo:table>
               
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
                    
								</fo:table-cell>

                        <fo:table-cell text-align="right"
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
               
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
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt" padding-end="1pt">
								</fo:table-cell>

                     	<fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt"  padding-end="1pt">
               
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt"  padding-end="1pt">
              
								</fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="none"
                         padding-before="1pt" padding-after="1pt"
                         padding-start="1pt"  padding-end="1pt">
              
								</fo:table-cell>

                      </fo:table-row>

                     </fo:table-body>
                    </fo:table>

                        </fo:table-cell>
                       </fo:table-row>

                       <fo:table-row height="24mm">
			<fo:table-cell border-color="black" border-width="1pt" border-style="none" number-columns-spanned="2"
				padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">
			</fo:table-cell>
                       </fo:table-row>


                       <fo:table-row>
				<fo:table-cell border-color="black" border-width="1pt" border-style="none" number-columns-spanned="2"
						padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">
						<fo:table>
		      							<fo:table-column column-width="40mm"/>
		      							<fo:table-column column-width="80mm"/>
		      							<fo:table-column column-width="80mm"/>

		      				<fo:table-body>

                            			<fo:table-row height="7mm">
                              			<fo:table-cell  
                               				border-color="black" border-width="1pt" border-style="none"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
						<fo:block text-align="left" font-size="9pt" font-family="sans-serif">
							<xsl:value-of select="NumOfOrgValue"/>
						</fo:block>
						</fo:table-cell>

                              			<fo:table-cell  
                               				border-color="black" border-width="1pt" border-style="none"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
						<fo:block text-align="left" font-size="9pt" font-family="sans-serif">
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
                               				border-color="black" border-width="1pt" border-style="none"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
						<fo:block text-align="left" font-size="9pt" font-family="sans-serif">
							<xsl:value-of select="HouseBillNoValue"/>
						</fo:block>
						</fo:table-cell>

                              			<fo:table-cell  
                               				border-color="black" border-width="1pt" border-style="none"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
						<fo:block text-align="left" font-size="9pt" font-family="sans-serif">
							<xsl:value-of select="VesselValue"/>
						</fo:block>
						</fo:table-cell>

                            			</fo:table-row>

                            			<fo:table-row height="16mm">
                              			<fo:table-cell  number-columns-spanned="2"
                               				border-color="black" border-width="1pt" border-style="none"
                               				padding-before="1pt" padding-after="1pt"
                               				padding-start="1pt" padding-end="1pt">
						<xsl:for-each select="Lookup">
                              				<fo:block text-align="left" font-size="9pt" font-family="sans-serif">
							<xsl:value-of select="DeliveryAgentValue"/>
							</fo:block>
						</xsl:for-each>
						</fo:table-cell>

                            			</fo:table-row>

       		      					</fo:table-body>
									    </fo:table>

									</fo:table-cell>
                       </fo:table-row>

                       <fo:table-row height="5mm">
				<fo:table-cell border-color="black" border-width="0pt" border-style="none" number-columns-spanned="2"
					padding-before="0pt" padding-after="0pt" padding-start="0pt" padding-end="0pt">
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
