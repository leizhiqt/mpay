package com.mooo.mycoz.applet;

import java.applet.Applet;
import java.awt.Button;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintServiceAttribute;
import javax.print.attribute.standard.PrinterName;

public class ZPLApplet extends Applet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Button print = new Button();

	private String zplS;

    public void init() {
    	print.setLabel("打印");

    	print.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent ae) {
//		        System.out.println(ae.getSource().toString());
		           if (ae.getSource() == print) {
		        	   printEPL();
		              }
			}
    	}); 
    	add(print);
    	
    	repaint();
    }
    
    public void paint(Graphics g){
//    	g.drawString("Hello World!",5,35);
  }
	public void printEPL() {
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

			zplS = getParameter("ZPL");
			byte[] by = zplS.getBytes("GBK");
			job.print(new SimpleDoc(by, DocFlavor.BYTE_ARRAY.AUTOSENSE, null), new HashPrintRequestAttributeSet());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
