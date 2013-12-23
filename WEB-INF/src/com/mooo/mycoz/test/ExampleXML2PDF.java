package com.mooo.mycoz.test;

import java.io.File;
import java.io.OutputStream;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.avalon.framework.ExceptionUtil;
import org.apache.avalon.framework.logger.ConsoleLogger;
import org.apache.fop.apps.Driver;
import org.apache.fop.apps.Options;
import org.apache.fop.messaging.MessageHandler;

public class ExampleXML2PDF {

	public static void main(String[] args) {

		try {

			System.out.println("FOP DebugXmlToPdf");

			new Options(new File("/usr/local/share/fonts/userconfig.xml"));

			// Setup directories
			File baseDir = new File(".");
			File outDir = new File(baseDir, "tmp");
			outDir.mkdirs();

			// Setup input and output files
			File xmlfile = new File(baseDir, "jsp/xslt/g.xml");
			File xsltfile = new File(baseDir, "jsp/xslt/htcopy.xsl");
			File pdffile = new File(outDir, "htcopy.pdf");
//			File xsltfile = new File(baseDir, "jsp/xslt/New.xsl");
//			File pdffile = new File(outDir, "New.pdf");

			System.out.println("Input: XML (" + xmlfile + ")");
			System.out.println("Stylesheet: " + xsltfile);
			System.out.println("Output: PDF (" + pdffile + ")");
			System.out.println();
			System.out.println("Transforming...");

			Driver driver = new Driver();
			ConsoleLogger logger = new ConsoleLogger(ConsoleLogger.LEVEL_INFO);
			driver.setLogger((org.apache.avalon.framework.logger.Logger) logger);
			MessageHandler.setScreenLogger((org.apache.avalon.framework.logger.Logger) logger);

			// Setup Renderer (output format)
			driver.setRenderer(Driver.RENDER_PDF);

			// Setup output
			OutputStream out = new java.io.FileOutputStream(pdffile);
			try {
				driver.setOutputStream(out);
				// Setup XSLT
				TransformerFactory factory = TransformerFactory.newInstance();
				Transformer transformer = factory
						.newTransformer(new StreamSource(xsltfile));
				// Setup input for XSLT transformation
				Source src = new StreamSource(xmlfile);
				// Resulting SAX events (the generated FO) must be piped through
				// to FOP
				Result res = new SAXResult(driver.getContentHandler());
				// Start XSLT transformation and FOP processing
				transformer.transform(src, res);

			} finally {

				out.close();

			}
			System.out.println("Success!");

		} catch (Exception e) {

			System.err.println(ExceptionUtil.printStackTrace(e));
			System.exit(-1);

		}

	}

}