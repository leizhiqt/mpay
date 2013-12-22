<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	version="1.0">
	
<xsl:template match="HBL">
<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

 <fo:layout-master-set>
    <fo:simple-page-master master-name="all"
	page-height="11.0in" page-width="8.5in"
        margin-top="0.2in" margin-bottom="0.2in" 
        margin-left="0.25in" margin-right="0.25in">
  <fo:region-body margin-top="0.25in" margin-bottom="0.25in"/>
    </fo:simple-page-master>
 </fo:layout-master-set>


 <fo:page-sequence master-reference="all">
    <fo:flow flow-name="xsl-region-body">
<fo:block font-size="16pt" font-weight="bold" space-after="1mm" text-align="right" color="black">
     BILL OF LADING
</fo:block>

<fo:block space-after="2mm"  font-weight="bold" font-style="italic">
<fo:inline font-size="30pt"><xsl:value-of select="TitleLeft"/></fo:inline>
<fo:inline font-size="15pt"><xsl:value-of select="TitleRight"/></fo:inline>
</fo:block>
<fo:block font-weight="bold">
As trade name of DAS international Pte Ltd
</fo:block>
<!--
     <xsl:apply-templates select="companyName"/>
     <xsl:apply-templates select="DocumentName"/>
 -->
      <fo:table>
      <fo:table-column column-width="4in"/>
      <fo:table-column column-width="4in"/>
      <fo:table-body>
                  <fo:table-row >
		  <fo:table-cell>
                                 <!--left-table-->

               <fo:table>
             <fo:table-column column-width="4in"/>
              <fo:table-body>
               
                                      <!-- rowA1 -->
			 	<fo:table-row height="25mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="ShipperKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
			   <xsl:value-of select="ShipperValue"/>				
                                 </fo:block>
                               </fo:table-cell>
                               </fo:table-row>

                      <fo:table-row height="25mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="ConsigneeKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="ConsigneeValue"/>
					</fo:block>
				
                               </fo:table-cell>
                               </fo:table-row>

                        <fo:table-row height="21mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="NotifyPartyKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="NotifyPartyValue"/>
					</fo:block>
                               </fo:table-cell>
                               </fo:table-row>
                          <fo:table-row height="4mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="1pt" padding-after="1pt" border-top-color="white"
                         padding-start="1pt" padding-end="1pt">
				 <fo:block text-align="justify"  font-size="5pt" font-family="sans-serif" font-weight="bold">
				<xsl:text>(No claim shall bttach for failure to notify)</xsl:text>
					</fo:block>
                               </fo:table-cell>
                               </fo:table-row>
                <fo:table-row >
		  <fo:table-cell>
                 <fo:table>
		      <fo:table-column column-width="2.3in"/>
		      <fo:table-column column-width="1.7in"/>
		      <fo:table-body>
                       <fo:table-row height="12mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="PreCarriageKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="PreCarriageValue"/>
					</fo:block>
                               </fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="VesselKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="VesselValue"/>
					</fo:block>
                               </fo:table-cell>
                               </fo:table-row>

                           <fo:table-row height="9mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="ReceiptPlaceKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="ReceiptPlaceValue"/>
					</fo:block>
                               </fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="POLPlaceKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="POLPlaceValue"/>
					</fo:block>
                               </fo:table-cell>
                               </fo:table-row>
                           <fo:table-row height="9mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="PODPlaceKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="PODPlaceValue"/>
					</fo:block>
                               </fo:table-cell>

                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="DeliveryPlaceKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
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

		  <fo:table-cell border-width="1pt"  padding-left="0.06in">
		     <fo:table>
		      <fo:table-column column-width="1.96in"/>
                      <fo:table-column column-width="1.98in"/>
		      <fo:table-body>

                    <fo:table-row height="8mm">
	                <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt"> 
                          <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="DocNoKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="DocNoValue"/>
					</fo:block>             
                        </fo:table-cell>
      
                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="HouseBillNoKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="HouseBillNoValue"/>
					</fo:block>
                               </fo:table-cell>
                               </fo:table-row>

                       <fo:table-row height="17mm">
	                <fo:table-cell text-align="right" number-columns-spanned="2"
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt" >  
                         <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="ExpRefNoKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="ExpRefNoValue"/>
					</fo:block>
                        </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row height="25mm">
	                <fo:table-cell text-align="right" number-columns-spanned="2"
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt" >  
                         <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="DeliveryAgentKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="DeliveryAgentValue"/>
					</fo:block>
                        </fo:table-cell>
                        </fo:table-row>

                      <fo:table-row height="25mm">
                       <fo:table-cell text-align="right" number-columns-spanned="2"
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="NotifyParty2Key"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="NotifyParty2Value"/>
					</fo:block>
                               </fo:table-cell>
                               </fo:table-row>
                       <fo:table-row height="12mm">
                       <fo:table-cell text-align="right" number-columns-spanned="2"
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="ContainerInfoKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="ContainerInfoValue"/>
					</fo:block>
                               </fo:table-cell>
                               </fo:table-row>
                         <fo:table-row height="9mm">
                       <fo:table-cell text-align="right" number-columns-spanned="2"
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="3pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="FinalDestKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="FinalDestValue"/>
					</fo:block>
                               </fo:table-cell>
                               </fo:table-row>


                      <fo:table-row>
                      <fo:table-cell number-columns-spanned="2" height="9mm">
                   				    <fo:table>
				   <fo:table-column column-width="1.5in"/>
				   <fo:table-column column-width="2.44in"/>
				      <fo:table-body>
                          <fo:table-row height="9mm">
				 <fo:table-cell text-align="left" 
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="0pt"
                               padding-start="3pt" padding-end="3pt">
						<fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="FreightStatusKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="FreightStatusValue"/>
					</fo:block>
					</fo:table-cell>
                                <fo:table-cell text-align="left" 
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="0pt"
                               padding-start="3pt" padding-end="3pt">
						<fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="NumOfOrgKey"/>
					</fo:block>
                              
					<fo:block text-align="start" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="NumOfOrgValue"/>
					</fo:block>
					</fo:table-cell>
                                     </fo:table-row>
                  </fo:table-body>
                </fo:table>
              </fo:table-cell>
            </fo:table-row>        
                    </fo:table-body>
                  </fo:table>
                </fo:table-cell>
                </fo:table-row > 

                                 <!--MIDDLE TABLE-->
                    

                      <fo:table-row>
                      <fo:table-cell>
                          <fo:table padding-before="0.06in">
		      <fo:table-column column-width="2in"/>
		      <fo:table-column column-width="1in"/>
		      <fo:table-column column-width="3in"/>
		      <fo:table-column column-width="1in"/>
		      <fo:table-column column-width="1in"/>
		      <fo:table-body>
                  
                    <fo:table-row height="9mm">
	              <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="8pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="Header1"/>
					</fo:block>                  
				</fo:table-cell>
                         <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="8pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="Header2"/>
					</fo:block>                  
				</fo:table-cell>
                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="8pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="Header3"/>
					</fo:block>                  
				</fo:table-cell>
                        <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="8pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="Header4"/>
					</fo:block>                  
				</fo:table-cell>
                         <fo:table-cell text-align="right" 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="8pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="Header5"/>
					</fo:block>                  
				</fo:table-cell>
                                </fo:table-row>
                              
                      <fo:table-row height="55mm">
	                <fo:table-cell 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                            <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="FreightMark"/>
					</fo:block>  
                              	</xsl:for-each>                
				</fo:table-cell>
                        <fo:table-cell 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                           <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="FreightNumOfPKG"/>
					</fo:block>  
                 	</xsl:for-each>                
				</fo:table-cell>
                        <fo:table-cell 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
             <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="FreightDesc"/>
					</fo:block> 
                     	</xsl:for-each>                 
				</fo:table-cell>
                        <fo:table-cell 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                      <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="FreightGross"/>
					</fo:block> 
                                     	</xsl:for-each>                 
				</fo:table-cell>
                        <fo:table-cell 
                         border-color="black" border-width="1pt" border-style="solid"
                         padding-before="3pt" padding-after="1pt"
                         padding-start="3pt" padding-end="3pt">
                       <xsl:for-each select="FreightItem">
                              <fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
						<xsl:value-of select="FreightMeasure"/>
					</fo:block> 
                                  	</xsl:for-each>                 
				</fo:table-cell>
                           </fo:table-row>
		      
			         <fo:table-row height="3mm">
                                <fo:table-cell text-align="left" number-columns-spanned="5"
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="3pt" padding-end="3pt">
						<fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:text>ABOVE PARTICULARS AS DECLARED BY SHIPPER</xsl:text>
					</fo:block>                         
					</fo:table-cell>
                                     </fo:table-row>

                                 <fo:table-row height="3mm">
                                <fo:table-cell text-align="left" number-columns-spanned="5"
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="3pt" padding-end="3pt">
						<fo:block text-align="start" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="ValueDeclKey"/>
					</fo:block>
                              
					<fo:block text-align="right" font-size="5pt" font-family="sans-serif">
						<xsl:value-of select="ValueDeclValue"/>
					</fo:block>
					</fo:table-cell>
                                     </fo:table-row>
                            <fo:table-row height="6mm">
                                <fo:table-cell text-align="left" number-columns-spanned="5"
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="3pt" padding-end="3pt">
						<fo:block text-align="left" font-size="8pt" font-family="sans-serif" font-weight="bold" >
					       <xsl:text>TOTAL NO OF PACKAGES</xsl:text>
					</fo:block>
                              
					<fo:block text-align="left" font-size="8pt" font-family="sans-serif" font-weight="bold" >
						<xsl:text>OR CONTAINERS (IN WORDS)</xsl:text>
					</fo:block>
					</fo:table-cell>
                                     </fo:table-row>

                           </fo:table-body>
                         </fo:table>
                        </fo:table-cell>
                       </fo:table-row>

                      <fo:table-row>
                      <fo:table-cell>
                         <fo:table>
		      <fo:table-column column-width="2.5in"/>
		      <fo:table-column column-width="1in"/>
		      <fo:table-column column-width="1in"/>
		      <fo:table-column column-width="3.5in"/>		     
		      <fo:table-body>                
                            <fo:table-row height="5mm">
				 <fo:table-cell   
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="FreightHeader"/>
					</fo:block>
					</fo:table-cell>
                              <fo:table-cell  
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="PrepaidHeader"/>
					</fo:block>
					</fo:table-cell>
                              <fo:table-cell  
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="CollectHeader"/>
					</fo:block>
					</fo:table-cell> 
                    <fo:table-cell text-align="middle" border-style="solid"
                           number-rows-spanned="3"
                           border-color="black" border-width="1pt"
                           padding-before="3pt" padding-after="3pt"
                           padding-start="3pt"  padding-end="3pt"> 
		<fo:block text-align="center" font-size="8pt" font-family="sans-serif">	
					       <xsl:text>  =====</xsl:text> 
					</fo:block>
					</fo:table-cell>
                                        </fo:table-row>
                         <fo:table-row height="30mm">
				 <fo:table-cell  
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="Freight"/>
					</fo:block>
					</fo:table-cell>
                               <fo:table-cell  
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="Prepaid"/>
					</fo:block>
					</fo:table-cell>
                              <fo:table-cell  
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="Collect"/>
					</fo:block>
					</fo:table-cell>
                                         </fo:table-row>
                              <fo:table-row height="5mm">
				 <fo:table-cell  
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="AmountDueKey"/>
					</fo:block>
					</fo:table-cell>
				 <fo:table-cell  
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="PrepaidDue"/>
					</fo:block>
					</fo:table-cell>
				 <fo:table-cell  
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="center" font-size="8pt" font-family="sans-serif" font-weight="bold">
					       <xsl:value-of select="CollectDue"/>
					</fo:block>
					</fo:table-cell>
                                        </fo:table-row>
                   <fo:table-row height="10mm">
				 <fo:table-cell  number-columns-spanned="4" 
                               border-color="black" border-width="1pt" border-style="solid"
                               padding-before="3pt" padding-after="1pt"
                               padding-start="1pt" padding-end="1pt">
						<fo:block text-align="left" font-size="8pt" font-family="sans-serif" font-weight="bold">
					    <xsl:text>URISDIGTION AND LAW CLAUSE</xsl:text>
					</fo:block>
					</fo:table-cell>  
                                        </fo:table-row>                            
                           </fo:table-body>
                         </fo:table>
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
