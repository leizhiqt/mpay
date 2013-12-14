package com.mooo.mycoz.test;


import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.EncodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.Result;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

public class ZxingTest {

	private static Log log = LogFactory.getLog(ZxingTest.class);

	/**
	 * 编码
	 * 
	 * @param contents
	 * @param width
	 * @param height
	 * @param imgPath
	 */
	public void codingQRCode(String contents, int width, int height, String imgPath) {
        try {
            Hashtable<EncodeHintType, Object> hintMap = new Hashtable<EncodeHintType, Object>();
            //指定纠错等级
            hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
            //指定编码格式
            //hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            //hintMap.put(EncodeHintType.CHARACTER_SET, "GB18030");
            
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            
            String buf = new String(contents.getBytes("UTF-8"),"ISO-8859-1");
            BitMatrix byteMatrix = qrCodeWriter.encode(buf,BarcodeFormat.QR_CODE, width, height, hintMap);
            
            int CrunchifyWidth = byteMatrix.getWidth();
            BufferedImage image = new BufferedImage(CrunchifyWidth, CrunchifyWidth,BufferedImage.TYPE_INT_RGB);
            //image.createGraphics();
 
            Graphics2D graphics = (Graphics2D) image.getGraphics();
            graphics.setColor(Color.WHITE);
            graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
            graphics.setColor(Color.BLACK);
 
            for (int i = 0; i < CrunchifyWidth; i++) {
                for (int j = 0; j < CrunchifyWidth; j++) {
                    if (byteMatrix.get(i, j)) {
                        graphics.fillRect(i, j, 1, 1);
                    }
                }
            }
            ImageIO.write(image, "png", new File(imgPath));
        } catch (WriterException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
	}

	/**
	 * 解码
	 * 
	 * @param imgPath
	 */
    public String decodeQRCode(String imgPath) {  
        BufferedImage image = null;  
        Result result = null;  
        try {  
            image = ImageIO.read(new File(imgPath));  
            if (image == null) {  
                System.out.println("the decode image may be not exit.");  
            }  
            LuminanceSource source = new BufferedImageLuminanceSource(image);  
            BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(source));  
  
            Map<Object, Object> hints = new HashMap<Object, Object>();  
            hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");  
  
            result = new MultiFormatReader().decode(bitmap);  
            return result.getText();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return null;  
    }  
   
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		int width = 384, height = 384;
		width = 256;height = 256;
		String contents="BEGIN:VCARD\n"+
			"VERSION:3.0\n"+
			"N:陈季平\n"+
			"EMAIL:510572722@qq.com\n"+
			"TEL;TYPE=VOICE,MSG,WORK:028-85936684\n"+
			"TEL;TYPE=FAX,WORK:028-85936645\n"+
			"TEL;CELL:13308081698\n"+
			"ADR:成都市锦江工业园区锦盛路佳霖科创大厦5-1\n"+
			"ORG:四川源酒投资咨询有限公司\n"+
			"ORG:四川源酒商贸有限公司\n"+
			"ORG:四川源酒网路科技有限公司\n"+
			"TITLE:董事长\n"+
			"URL:www.y9jy.com\n"+
			"END:VCARD";
		
		contents="BEGIN:VCARD\n"+
				"VERSION:3.0\n"+
				"N:陈季平\n"+
				"EMAIL:510572722@qq.com\n"+
				"TEL;TYPE=VOICE,MSG,WORK:028-86129211\n"+
				//"TEL;TYPE=FAX,WORK:028-85936645\n"+
				"TEL;CELL:13308081698\n"+
				"ADR:成都市东城根南街30号（食品大楼2楼）\n"+
				"ORG:四川省酿酒研究所政银企联络办\n"+
				"TITLE:主任\n"+
				"URL:www.scy9.com\n"+
				"END:VCARD";
			try {
				ZxingTest handler = new ZxingTest();
//				String buf = new String(contents.getBytes("UTF-8"),"ISO-8859-1");
//				String buf = contents;
				handler.codingQRCode(contents, width, height, "/home/zlei/hday1.png");
				if(log.isDebugEnabled())log.debug(contents);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
}
