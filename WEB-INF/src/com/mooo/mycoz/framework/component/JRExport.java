package com.mooo.mycoz.framework.component;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperPrintManager;
import net.sf.jasperreports.engine.export.JExcelApiExporter;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXhtmlExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.oasis.JROdsExporter;
import net.sf.jasperreports.engine.export.oasis.JROdtExporter;
import net.sf.jasperreports.engine.export.ooxml.JRDocxExporter;
import net.sf.jasperreports.engine.export.ooxml.JRPptxExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.query.JRXPathQueryExecuterFactory;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.JRXmlUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.w3c.dom.Document;

public class JRExport {

	private static Log log = LogFactory.getLog(JRExport.class);

	public static String buildJasper(HttpServletRequest request,HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("buildJasper");
		
		String physicalPath = request.getSession().getServletContext().getRealPath("/");

		String reportName=request.getParameter("reportName");
		String reportType=request.getParameter("reportType");

		if(reportType!=null){
			try {
				byte[] content = null;
	
				String tmpFNPrefix=physicalPath+"tmp/"+reportName;

				compile(tmpFNPrefix+".jrxml",tmpFNPrefix+".jasper");

				fill(tmpFNPrefix+".jasper",tmpFNPrefix+".xml",tmpFNPrefix+".jrprint");
			
				if(reportType.equals("xls")){
					content = xls(tmpFNPrefix+".jrprint");
					response.setHeader("Content-Disposition", "attachment;filename=" + reportName+".xls");
					response.setContentType("application/vnd.ms-excel");
					response.setContentLength(content.length);
					response.getOutputStream().write(content);
					response.getOutputStream().flush();
					response.getOutputStream().close();
					response.flushBuffer();
				}else if(reportType.equals("pdf")){
					content = pdf(tmpFNPrefix+".jrprint");
					response.setHeader("Content-Disposition", "attachment;filename=" + reportName+".pdf");
					response.setContentType("application/pdf");
					response.setContentLength(content.length);
					response.getOutputStream().write(content);
					response.getOutputStream().flush();
					response.getOutputStream().close();
					response.flushBuffer();
				}else if(reportType.equals("html")){
					content = html(tmpFNPrefix+".jrprint");
					response.setHeader("Content-Disposition", "inline;filename=" + reportName+".html");
					response.setContentType("text/html");
					response.setContentLength(content.length);
					response.getOutputStream().write(content);
					response.getOutputStream().flush();
					//response.getOutputStream().close();
					response.flushBuffer();
				}
			} catch (Exception e) {
				e.printStackTrace();
				if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
				request.setAttribute("error", e.getMessage());
			}
		}
		return "success";
	}
	
	/**
	 *
	 */
	public static void compile(String jrxmlFile,String jrprintFile){
		long start = System.currentTimeMillis();
		try{
			JasperCompileManager.compileReportToFile(jrxmlFile,jrprintFile);
		}catch (JRException e){
			System.out.println("JRException:" + e.getMessage());
		}
		System.err.println("Compile time : " + (System.currentTimeMillis() - start));
	}
	
	/**
	 *
	 */
	public static void fill(String jasperFile,String dxmlFile,String jrprintFile) throws JRException{
		long start = System.currentTimeMillis();
		System.err.println("Compile time : " + (System.currentTimeMillis() - start));
		try{
			Map<String,Object> params = new HashMap<String,Object>();
			Document document = JRXmlUtils.parse(JRLoader.getLocationInputStream(dxmlFile));
			params.put(JRXPathQueryExecuterFactory.PARAMETER_XML_DATA_DOCUMENT, document);
			params.put(JRXPathQueryExecuterFactory.XML_DATE_PATTERN, "yyyy-MM-dd");
			params.put(JRXPathQueryExecuterFactory.XML_NUMBER_PATTERN, "#,##0.##");
			//params.put(JRXPathQueryExecuterFactory.XML_LOCALE, Locale.ENGLISH);
			//params.put(JRParameter.REPORT_LOCALE, Locale.US);

			JasperFillManager.fillReportToFile(jasperFile,jrprintFile,params);
		}catch (JRException e){
			System.out.println("JRException:" + e.getMessage());
		}
		System.err.println("Filling time : " + (System.currentTimeMillis() - start));
	}

	/**
	 *
	 */
	public void print(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		JasperPrintManager.printReport(jrprintFile, true);
		System.err.println("Printing time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public static byte[] html(String jrprintFile) {
		long start = System.currentTimeMillis();
		byte[] bytes = null;
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			File sourceFile = new File(jrprintFile);

			JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

			File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".html");

			JRHtmlExporter exporter = new JRHtmlExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
			exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
			exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
			exporter.setParameter(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
			exporter.exportReport();

			bytes = baos.toByteArray();
			baos.close();
		} catch (JRException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.err.println("HTML creation time : " + (System.currentTimeMillis() - start));
		return bytes;
	}

	/**
	 *
	 */
	public static byte[] xls(String jrprintFile) {
		long start = System.currentTimeMillis();
		byte[] bytes = null;
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			File sourceFile = new File(jrprintFile);

			JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

			File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".xls");

			JRXlsExporter exporter = new JRXlsExporter();

			exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
			exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
			
			exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
			exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
			exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
			exporter.setParameter(JRXlsExporterParameter.IS_FONT_SIZE_FIX_ENABLED, Boolean.FALSE);
			exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
		
			exporter.exportReport();

			bytes = baos.toByteArray();
			baos.close();
		} catch (JRException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.err.println("XLS creation time : " + (System.currentTimeMillis() - start));
		return bytes;
	}

	/**
	 *
	 */
	public static byte[] pdf(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		byte[] bytes = null;
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();

			JRPdfExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
			
			JasperPrint jp = (JasperPrint)JRLoader.loadObject(new File(jrprintFile));
			exporter.setParameter(JRExporterParameter.JASPER_PRINT, jp);

			// Include structure tags for PDF/A-1a compliance; unnecessary for PDF/A-1b
			//exporter.setParameter(JRPdfExporterParameter.IS_TAGGED, Boolean.TRUE);
			//exporter.setParameter(JRPdfExporterParameter.PDFA_CONFORMANCE, JRPdfExporterParameter.PDFA_CONFORMANCE_1A);
			exporter.exportReport();

			bytes = baos.toByteArray();
			baos.close();
		} catch (JRException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.err.println("PDF creation time : " + (System.currentTimeMillis() - start));
		return bytes;
	}
	/**
	 *
	 */
	public void rtf(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".rtf");
		
		JRRtfExporter exporter = new JRRtfExporter();
		
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("RTF creation time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public void xml(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		JasperExportManager.exportReportToXmlFile(jrprintFile, false);
		System.err.println("XML creation time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public void xmlEmbed(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		JasperExportManager.exportReportToXmlFile(jrprintFile, true);
		System.err.println("XML creation time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public void jxl(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".jxl.xls");

		JExcelApiExporter exporter = new JExcelApiExporter();

		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("XLS creation time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public void csv(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".csv");
		
		JRCsvExporter exporter = new JRCsvExporter();
		
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		//exporter.setParameter(JRCsvExporterParameter.FIELD_DELIMITER, "|");
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("CSV creation time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public void odt(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".odt");
		
		JROdtExporter exporter = new JROdtExporter();
		
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("ODT creation time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public void ods(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".ods");
		
		JROdsExporter exporter = new JROdsExporter();
		
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("ODS creation time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public void docx(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".docx");
		
		JRDocxExporter exporter = new JRDocxExporter();
		
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("DOCX creation time : " + (System.currentTimeMillis() - start));
	}


	/**
	 *
	 */
	public void xlsx(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".xlsx");
		
		JRXlsxExporter exporter = new JRXlsxExporter();
		
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("XLSX creation time : " + (System.currentTimeMillis() - start));
	}
	
	
	/**
	 *
	 */
	public void pptx(String jrprintFile) throws JRException	{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".pptx");
		
		JRPptxExporter exporter = new JRPptxExporter();
		
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("PPTX creation time : " + (System.currentTimeMillis() - start));
	}
	
	
	/**
	 *
	 */
	public void xhtml(String jrprintFile) throws JRException{
		long start = System.currentTimeMillis();
		File sourceFile = new File(jrprintFile);

		JasperPrint jasperPrint = (JasperPrint)JRLoader.loadObject(sourceFile);

		File destFile = new File(sourceFile.getParent(), jasperPrint.getName() + ".x.html");
		
		JRXhtmlExporter exporter = new JRXhtmlExporter();
		
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, destFile.toString());
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS,Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE); 

		exporter.exportReport();

		System.err.println("XHTML creation time : " + (System.currentTimeMillis() - start));
	}
}
