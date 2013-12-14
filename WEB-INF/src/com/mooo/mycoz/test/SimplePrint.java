package com.mooo.mycoz.test;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintServiceAttribute;
import javax.print.attribute.standard.PrinterName;

public class SimplePrint {

	public static void main(String[] args) {
		try {

			PrintService psZebra = null;
			String sPrinterName = null;
			PrintService[] services = PrintServiceLookup.lookupPrintServices(null, null);

			for (int i = 0; i < services.length; i++) {
				PrintServiceAttribute attr = services[i].getAttribute(PrinterName.class);
				sPrinterName = ((PrinterName) attr).getValue();
				System.out.println("PrinterName:"+sPrinterName);

				if (sPrinterName.indexOf("ZPL") >= 0) {
					psZebra = services[i];
					break;
				}
			}

			if (psZebra == null) {
				System.out.println("Zebra printer is not found.");
				return;
			}

			DocPrintJob job = psZebra.createPrintJob();

			String s = "^XA" +
					"^FO50,100^BQN,2,3" +
					"^FDMA," +
					"\n防伪码:SCYJPT13031900001" +
					"\n名称:源酒15年52度500ml(浓香型)" +
					"\n产地:四川宜宾市李庄下坝" +
					"\n生产日期:2010.10.01(瓶号:YF012005)" +
					"\n朔源地址:http://www.86999.org" +
					"^FS" +
					
					"^FO350,100^BQN,2,3" +
					"^FDMA," +
					"\n防伪码:SCYJPT13031900002" +
					"\n名称:源酒15年52度500ml(浓香型)" +
					"\n产地:四川宜宾市李庄下坝" +
					"\n生产日期:2010.10.01(瓶号:YF012006)" +
					"\n朔源地址:http://www.86999.org" +
					"^FS" +

					"^XZ";
			
			byte[] by = s.getBytes("GBK");
			job.print(new SimpleDoc(by, DocFlavor.BYTE_ARRAY.AUTOSENSE, null), new HashPrintRequestAttributeSet());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
