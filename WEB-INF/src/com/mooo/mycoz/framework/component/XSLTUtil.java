package com.mooo.mycoz.framework.component;


import java.io.ByteArrayOutputStream;
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.avalon.framework.logger.ConsoleLogger;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.fop.apps.Driver;
import org.apache.fop.apps.Options;
import org.apache.fop.messaging.MessageHandler;

public class XSLTUtil {

	private static Log log = LogFactory.getLog(XSLTUtil.class);

	public static String buildPDF(HttpServletRequest request,HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("buildJasper");
		
//		String physicalPath = request.getSession().getServletContext().getRealPath("/");

		String noteName=request.getParameter("noteName");

		String xml = (String)request.getAttribute("xml");
		String xsl = (String)request.getAttribute("xslt");
		noteName= (String)request.getAttribute("noteName");
		try {
			byte[] content = null;

//				String tmpFNPrefix=physicalPath+"tmp/"+noteName;
//				String xml = physicalPath+"jsp/xslt/t.xml";
//				String xsl = physicalPath+"jsp/xslt/ht.xsl";

			content = xslt(xml,xsl);
			response.setHeader("Content-Disposition", "attachment;filename=" + noteName+".pdf");
			response.setContentType("application/pdf");
			response.setContentLength(content.length);
			response.getOutputStream().write(content);
			response.getOutputStream().flush();
			response.getOutputStream().close();
			response.flushBuffer();
			
		} catch (Exception e) {
			e.printStackTrace();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	/**
	 *
	 */
	public static byte[] xslt(String xmlFile,String xslFile){
		long start = System.currentTimeMillis();
		byte[] bytes = null;
		try{
			System.out.println("FOP DebugXmlToPdf");

			new Options(new File("/usr/local/share/fonts/userconfig.xml"));

			// Setup directories
//			File baseDir = new File(".");
//			File outDir = new File(baseDir, "tmp");
//			outDir.mkdirs();

			// Setup input and output files
//			File xmlfile = new File(baseDir, xmlFile);
//			File xsltfile = new File(baseDir, xslFile);
			File xmlfile = new File(xmlFile);
			File xsltfile = new File(xslFile);
//			File pdffile = new File(outDir, "ResultXML2PDF.pdf");

			System.out.println("Input: XML (" + xmlfile + ")");
			System.out.println("Stylesheet: " + xsltfile);
//			System.out.println("Output: PDF (" + pdffile + ")");
			System.out.println();
			System.out.println("Transforming...");

			Driver driver = new Driver();
			ConsoleLogger logger = new ConsoleLogger(ConsoleLogger.LEVEL_INFO);
			driver.setLogger((org.apache.avalon.framework.logger.Logger) logger);
			MessageHandler.setScreenLogger((org.apache.avalon.framework.logger.Logger) logger);

			// Setup Renderer (output format)
			driver.setRenderer(Driver.RENDER_PDF);

//            ByteArrayOutputStream bout = new ByteArrayOutputStream();
			// Setup output
            ByteArrayOutputStream out = new ByteArrayOutputStream();
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

				bytes = out.toByteArray();
			} finally {

				out.close();

			}
			System.out.println("Success!");
			
		}catch (Exception e){
			System.out.println("JRException:" + e.getMessage());
		}
		System.err.println("Compile time : " + (System.currentTimeMillis() - start));
		return bytes;
	}
}
