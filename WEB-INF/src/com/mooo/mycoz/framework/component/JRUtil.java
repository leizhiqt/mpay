package com.mooo.mycoz.framework.component;

import java.util.Vector;


public class JRUtil {

    public static final int charPixel = 6;

    public static String containerNameFilter(String name){
        String newName = name.replaceAll("'", "");
        if (newName.matches("^\\d\\w+")) newName = "C" + newName;
        return newName;
    }

    /*
     * auto create JRXML
     */
    public static String createJRXML(String jrName, String title, String title2, Vector<String> colName, Vector<String> colSum, Vector<Integer> colWidth,String xPath){  //something was changed by gchen at 07,07,25
        int startX = 98;

    	int pageWidth=595,pageHeight=842;

    	int k = 0, x = 0, width = 0,height=14, totalWidth = 0;
    	
    	for (k=0; k<colName.size(); k++) {
          width = ((Integer)colWidth.get(k)).intValue() * charPixel + 2;
          totalWidth += width;
        }
        
    	
        if (totalWidth > 550 && totalWidth < 842){
        	pageWidth=842;
        	pageHeight=595;
        }
        
        if(totalWidth>842){
        	pageWidth=totalWidth+80;
        	pageHeight=595;
        }
        
        startX = (int) Math.ceil((pageWidth-totalWidth)/2);
        
        String pagePara = " pageWidth=\""+pageWidth+"\" pageHeight=\""+pageHeight+"\"";

        StringBuffer buffer = new StringBuffer();
        buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        buffer.append("<jasperReport xmlns=\"http://jasperreports.sourceforge.net/jasperreports\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd\" name=\"" + jrName + "\" " + pagePara + " columnWidth=\"500\" leftMargin=\"0\" rightMargin=\"0\" topMargin=\"0\" bottomMargin=\"0\">\n");
        buffer.append("	<property name=\"ireport.zoom\" value=\"1.0\"/>\n");
        buffer.append("	<property name=\"ireport.x\" value=\"0\"/>\n");
        buffer.append("	<property name=\"ireport.y\" value=\"0\"/>\n");
        buffer.append("	<style name=\"Sans_Normal\" isDefault=\"true\" fontName=\"Arial\" fontSize=\"6\" isBold=\"false\" isItalic=\"false\" isUnderline=\"false\" isStrikeThrough=\"false\"/>\n");
        buffer.append("	<style name=\"Sans_Bold\" fontName=\"Arial\" fontSize=\"8\" isBold=\"true\" isItalic=\"false\" isUnderline=\"false\" isStrikeThrough=\"false\"/>\n");
        buffer.append("	<style name=\"Sans_Italic\" fontName=\"Arial\" fontSize=\"8\" isBold=\"false\" isItalic=\"true\" isUnderline=\"false\" isStrikeThrough=\"false\"/>\n");
        buffer.append("	<queryString language=\"xPath\">\n");
        buffer.append("		<![CDATA["+xPath+"]]>\n");
        buffer.append("	</queryString>\n");

        for (k=0; k<colName.size(); k++) {
        	buffer.append("	<field name=\"Key" + k + "\"");
            if (colName.get(k).indexOf("I") > 0) {
                buffer.append(" class=\"java.lang.Integer\"");
            } else if (colName.get(k).indexOf("R") > 0) {
                    buffer.append(" class=\"java.lang.Double\"");
            } else {
                buffer.append(" class=\"java.lang.String\"");
            }
            buffer.append(">\n");
            buffer.append("		<fieldDescription><![CDATA[Key"+k+"]]></fieldDescription>\n");
            buffer.append("	</field>\n");
          }
        
        x = startX;
        
        buffer.append("	<title> \n");
        buffer.append("		<band height=\"62\"> \n");
        buffer.append("			<staticText> \n");
        buffer.append("				<reportElement x=\""+x+"\" y=\"5\" width=\"" + totalWidth + "\" height=\"30\"/> \n");
        buffer.append("				<textElement textAlignment=\"Center\"> \n");
        buffer.append("					<font reportFont=\"Sans_Bold\" size=\"20\"/> \n");
        buffer.append("				</textElement> \n");
        buffer.append("				<text><![CDATA[" + title + "]]></text> \n");
        buffer.append("			</staticText> \n");
        buffer.append("			<staticText> \n");
        buffer.append("				<reportElement x=\""+x+"\" y=\"35\" width=\"" + totalWidth + "\" height=\"15\"/> \n");
        buffer.append("				<textElement textAlignment=\"Center\"> \n");
        buffer.append("					<font reportFont=\"Sans_Bold\" size=\"10\"/> \n");
        buffer.append("				</textElement> \n");
        buffer.append("				<text><![CDATA[" + title2 + "]]></text> \n");
        buffer.append("			</staticText> \n");
        /*buffer.append("			<line> \n");
        buffer.append("				<reportElement x=\""+x+"\" y=\"55\" width=\"" + totalWidth + "\" height=\"1\"/> \n");
        buffer.append("				<graphicElement/> \n");
        buffer.append("			</line> \n");*/
        buffer.append("		</band> \n");
        buffer.append("	</title>\n");

        x = startX;

        buffer.append("	<pageHeader>\n");
        buffer.append("		<band height=\""+height+"\">\n");
        buffer.append("			<frame>\n");
        buffer.append("				<reportElement mode=\"Opaque\" x=\""+x+"\" y=\"2\" width=\""+totalWidth+"\" height=\""+(height-2)+"\" forecolor=\"#CCFFFF\" backcolor=\"#CCFFFF\"/>\n");
       
        x=0;
        for (k=0; k<colName.size(); k++) {
            width = ((Integer)colWidth.get(k)).intValue() * charPixel;
            if (width > 0) {
              width += 2;
              buffer.append("				<staticText>\n");
              buffer.append("					<reportElement style=\"Sans_Bold\" x=\""+x+"\" y=\"0\" width=\"" + width + "\" height=\""+(height-2)+"\" backcolor=\"#CCFFFF\"/>\n");
//              buffer.append("					<reportElement style=\"Sans_Bold\" mode=\"Opaque\" x=\""+x+"\" y=\"0\" width=\"" + width + "\" height=\""+(height-2)+"\" backcolor=\"#CCFFFF\"/>\n");
              buffer.append("					<textElement textAlignment=\"Center\"/>\n");
              buffer.append("					<text><![CDATA[" + colName.get(k) + "]]></text>\n");
              buffer.append("				</staticText>\n");
              x += width;
            }
          }
        buffer.append("			</frame>\n");
        buffer.append("		</band>\n");
        buffer.append("	</pageHeader>\n");

        buffer.append("	<detail>\n");
        buffer.append("		<band height=\""+height+"\">\n");

        x = startX;
        for (k=0; k<colName.size(); k++) {
          width = ((Integer)colWidth.get(k)).intValue() * charPixel;
          if (width > 0) {
            width += 2;
            buffer.append("			<textField isBlankWhenNull=\"true\" isStretchWithOverflow=\"true\">\n");
            buffer.append("				<reportElement positionType=\"Float\" x=\"" + x + "\" y=\"2\" width=\"" + width + "\" height=\""+(height-2)+"\"/>\n");
            buffer.append("				<textElement textAlignment=\"Center\"/>\n");
            buffer.append("				<textFieldExpression><![CDATA[$F{Key" + k + "}]]></textFieldExpression>\n");
            buffer.append("			</textField>\n");
            x +=width;
          }
        }
        buffer.append("		</band>\n");
        buffer.append("	</detail>\n");
        
        x = startX;

        buffer.append("	<pageFooter> \n");
        buffer.append("		<band height=\"70\"> \n");
       /*   buffer.append("			<line> \n");
        buffer.append("				<reportElement x=\""+x+"\" y=\"10\" width=\"" + totalWidth + "\" height=\"1\"/> \n");
        buffer.append("				<graphicElement/> \n");
        buffer.append("			</line> \n");
        
       startX = (int) Math.ceil((pageWidth-160)/2);
        x = startX;
        buffer.append("			<textField> \n");
        buffer.append("				<reportElement x=\""+x+"\" y=\"20\" width=\"80\" height=\"14\"/> \n");
        buffer.append("				<textElement textAlignment=\"Right\"/> \n");
        buffer.append("				<textFieldExpression class=\"java.lang.String\"><![CDATA[\"Page \" + String.valueOf($V{PAGE_NUMBER}) + \" of\"]]></textFieldExpression> \n");
        buffer.append("			</textField> \n");
        buffer.append("			<textField isBlankWhenNull=\"true\" evaluationTime=\"Report\"> \n");
        buffer.append("				<reportElement x=\""+(x+80)+"\" y=\"20\" width=\"80\" height=\"14\"/> \n");
        buffer.append("				<textElement/> \n");
        buffer.append("				<textFieldExpression class=\"java.lang.String\"><![CDATA[\" \" + String.valueOf($V{PAGE_NUMBER})]]></textFieldExpression> \n");
        buffer.append("			</textField> \n");*/
        buffer.append("		</band> \n");
        buffer.append("	</pageFooter> \n");

//      if (colSum != null && colSum.size()==colName.size()) { //simple summary
//      buffer.append (
//	" 	<summary>\n" + 
//	" 		<band height=\"18\">\n" + 
//	" 			<rectangle>\n" + 
//	" 				<reportElement x=\"0\" y=\"2\" width=\"" + totalWidth + "\" height=\"14\" forecolor=\"#33cccc\" backcolor=\"#33cccc\"/>\n" + 
//	" 				<graphicElement pen=\"Thin\"/>\n" + 
//	" 			</rectangle>\n");
//      x = 0;
//      for (k=0; k<colName.size(); k++) {
//        width = ((Integer)colWidth.get(k)).intValue() * charPixel;
//        if (width > 0) {
//          width += 2;
//          buffer.append(
//	" 			<staticText>\n" + 
//	" 				<reportElement mode=\"Opaque\" x=\"" + x + "\" y=\"2\" width=\"" + width + "\" height=\"14\" backcolor=\"#33cccc\"/>\n" + 
//	" 				<textElement textAlignment=\"Center\">\n" + 
//	" 					<font reportFont=\"Sans_Bold\"/>\n" + 
//	" 				</textElement>\n" + 
//	" 				<text><![CDATA[" + (String)colSum.get(k) + "]]></text>\n" + 
//	" 			</staticText>\n");
//          x +=width;
//        }
//      }
//      buffer.append(
//	" 		</band>\n" + 
//	" 	</summary>\n"  
//                    );
//      } //simple summary
        buffer.append("</jasperReport>\n");
        return buffer.toString();
    }
    /*
     * auto create createListBoxJRXML
     */
    public static String createListBoxJRXML(String jrName, String title, String title2, Vector<String> colName, Vector<String> colSum, Vector<Integer> colWidth,String xPath){  //something was changed by gchen at 07,07,25
        int k = 0, x = 0, width = 0, totalWidth = 0;
        for (k=0; k<colName.size(); k++) {
          width = ((Integer)colWidth.get(k)).intValue() * charPixel + 2;
          totalWidth += width;
        }
        String pagePara = " pageWidth=\"595\" pageHeight=\"842\" ";
        if (totalWidth > 550)
           pagePara = " pageWidth=\"" + (totalWidth+80) + "\" pageHeight=\"595\" ";
        
        StringBuffer buffer = new StringBuffer();
        buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        buffer.append("<jasperReport xmlns=\"http://jasperreports.sourceforge.net/jasperreports\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://jasperreports.sourceforge.net/jasperreports http://jasperreports.sourceforge.net/xsd/jasperreport.xsd\" name=\"" + jrName + "\" " + pagePara + " columnWidth=\"500\" leftMargin=\"0\" rightMargin=\"0\" topMargin=\"0\" bottomMargin=\"0\">\n");
        buffer.append("	<property name=\"ireport.zoom\" value=\"1.0\"/>\n");
        buffer.append("	<property name=\"ireport.x\" value=\"0\"/>\n");
        buffer.append("	<property name=\"ireport.y\" value=\"0\"/>\n");
        buffer.append("	<style name=\"Sans_Normal\" isDefault=\"true\" fontName=\"Arial\" fontSize=\"6\" isBold=\"false\" isItalic=\"false\" isUnderline=\"false\" isStrikeThrough=\"false\"/>\n");
        buffer.append("	<style name=\"Sans_Bold\" fontName=\"Arial\" fontSize=\"8\" isBold=\"true\" isItalic=\"false\" isUnderline=\"false\" isStrikeThrough=\"false\"/>\n");
        buffer.append("	<style name=\"Sans_Italic\" fontName=\"Arial\" fontSize=\"8\" isBold=\"false\" isItalic=\"true\" isUnderline=\"false\" isStrikeThrough=\"false\"/>\n");
        buffer.append("	<queryString language=\"xPath\">\n");
        buffer.append("		<![CDATA["+xPath+"]]>\n");
        buffer.append("	</queryString>\n");

        for (k=0; k<colName.size(); k++) {
        	buffer.append("	<field name=\"Key"+k+"\" class=\"java.lang.String\">\n");
            buffer.append("		<fieldDescription><![CDATA[Key"+k+"]]></fieldDescription>\n");
            buffer.append("	</field>\n");
          }
        
        buffer.append("	<title> \n");
        buffer.append("		<band height=\"60\"> \n");
        buffer.append("			<staticText> \n");
        buffer.append("				<reportElement x=\"0\" y=\"5\" width=\"" + totalWidth + "\" height=\"30\"/> \n");
        buffer.append("				<textElement textAlignment=\"Center\"> \n");
        buffer.append("					<font reportFont=\"Sans_Bold\" size=\"20\"/> \n");
        buffer.append("				</textElement> \n");
        buffer.append("				<text><![CDATA[" + title + "]]></text> \n");
        buffer.append("			</staticText> \n");
        buffer.append("			<staticText> \n");
        buffer.append("				<reportElement x=\"0\" y=\"35\" width=\"" + totalWidth + "\" height=\"15\"/> \n");
        buffer.append("				<textElement textAlignment=\"Center\"> \n");
        buffer.append("					<font reportFont=\"Sans_Bold\" size=\"10\"/> \n");
        buffer.append("				</textElement> \n");
        buffer.append("				<text><![CDATA[" + title2 + "]]></text> \n");
        buffer.append("			</staticText> \n");
        buffer.append("			<line> \n");
        buffer.append("				<reportElement x=\"0\" y=\"55\" width=\"610\" height=\"1\"/> \n");
        buffer.append("				<graphicElement/> \n");
        buffer.append("			</line> \n");
        buffer.append("		</band> \n");
        buffer.append("	</title>\n");

        buffer.append("	<pageHeader>\n");
        buffer.append("		<band height=\"14\">\n");
        buffer.append("			<frame>\n");
        buffer.append("				<reportElement mode=\"Opaque\" x=\"0\" y=\"2\" width=\""+totalWidth+"\" height=\"10\" forecolor=\"#CCFFFF\" backcolor=\"#CCFFFF\"/>\n");

        for (k=0; k<colName.size(); k++) {
            width = ((Integer)colWidth.get(k)).intValue() * charPixel;
            if (width > 0) {
              width += 2;
              buffer.append("				<staticText>\n");
              buffer.append("					<reportElement style=\"Sans_Bold\" mode=\"Opaque\" x=\""+ x + "\" y=\"0\" width=\"" + width + "\" height=\"10\" backcolor=\"#CCFFFF\"/>\n");
              buffer.append("					<textElement textAlignment=\"Center\"/>\n");
              buffer.append("					<text><![CDATA[" + colName.get(k) + "]]></text>\n");
              buffer.append("				</staticText>\n");
              x += width;
            }
          }
        buffer.append("			</frame>\n");
        buffer.append("		</band>\n");
        buffer.append("	</pageHeader>\n");

        buffer.append("	<detail>\n");
        buffer.append("		<band height=\"14\">\n");

        x = 0;
        for (k=0; k<colName.size(); k++) {
          width = ((Integer)colWidth.get(k)).intValue() * charPixel;
          if (width > 0) {
            width += 2;
            buffer.append("			<textField isBlankWhenNull=\"true\" isStretchWithOverflow=\"true\">\n");
            buffer.append("				<reportElement positionType=\"Float\" x=\"" + x + "\" y=\"2\" width=\"" + width + "\" height=\"10\"/>\n");
            buffer.append("				<textElement textAlignment=\"Center\"/>\n");
            buffer.append("				<textFieldExpression><![CDATA[$F{Key" + k + "}]]></textFieldExpression>\n");
            buffer.append("			</textField>\n");
            x +=width;
          }
        }
        buffer.append("		</band>\n");
        buffer.append("	</detail>\n");
        
        buffer.append("	<pageFooter> \n");
        buffer.append("		<band height=\"40\"> \n");
        buffer.append("			<line> \n");
        buffer.append("				<reportElement x=\"0\" y=\"10\" width=\"" + totalWidth + "\" height=\"1\"/> \n");
        buffer.append("				<graphicElement/> \n");
        buffer.append("			</line> \n");
        buffer.append("			<textField> \n");
        buffer.append("				<reportElement x=\"200\" y=\"20\" width=\"80\" height=\"14\"/> \n");
        buffer.append("				<textElement textAlignment=\"Right\"/> \n");
        buffer.append("				<textFieldExpression class=\"java.lang.String\"><![CDATA[\"Page \" + String.valueOf($V{PAGE_NUMBER}) + \" of\"]]></textFieldExpression> \n");
        buffer.append("			</textField> \n");
        buffer.append("			<textField isBlankWhenNull=\"true\" evaluationTime=\"Report\"> \n");
        buffer.append("				<reportElement x=\"280\" y=\"20\" width=\"75\" height=\"14\"/> \n");
        buffer.append("				<textElement/> \n");
        buffer.append("				<textFieldExpression class=\"java.lang.String\"><![CDATA[\" \" + String.valueOf($V{PAGE_NUMBER})]]></textFieldExpression> \n");
        buffer.append("			</textField> \n");
        buffer.append("		</band> \n");
        buffer.append("	</pageFooter> \n");

//      if (colSum != null && colSum.size()==colName.size()) { //simple summary
//      buffer.append (
//	" 	<summary>\n" + 
//	" 		<band height=\"18\">\n" + 
//	" 			<rectangle>\n" + 
//	" 				<reportElement x=\"0\" y=\"2\" width=\"" + totalWidth + "\" height=\"14\" forecolor=\"#33cccc\" backcolor=\"#33cccc\"/>\n" + 
//	" 				<graphicElement pen=\"Thin\"/>\n" + 
//	" 			</rectangle>\n");
//      x = 0;
//      for (k=0; k<colName.size(); k++) {
//        width = ((Integer)colWidth.get(k)).intValue() * charPixel;
//        if (width > 0) {
//          width += 2;
//          buffer.append(
//	" 			<staticText>\n" + 
//	" 				<reportElement mode=\"Opaque\" x=\"" + x + "\" y=\"2\" width=\"" + width + "\" height=\"14\" backcolor=\"#33cccc\"/>\n" + 
//	" 				<textElement textAlignment=\"Center\">\n" + 
//	" 					<font reportFont=\"Sans_Bold\"/>\n" + 
//	" 				</textElement>\n" + 
//	" 				<text><![CDATA[" + (String)colSum.get(k) + "]]></text>\n" + 
//	" 			</staticText>\n");
//          x +=width;
//        }
//      }
//      buffer.append(
//	" 		</band>\n" + 
//	" 	</summary>\n"  
//                    );
//      } //simple summary
        buffer.append("</jasperReport>\n");
        return buffer.toString();
    }
}
