package com.mooo.mycoz.framework.util;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class ImageUtil {
    /** 
	 * 压缩图片文件<br> 
	 * 先保存原文件，再压缩、上传 
	 *  
	 * @param oldFile 
	 *            要进行压缩的文件全路径 
	 * @param width 
	 *            宽度 
	 * @param height 
	 *            高度 
	 * @param quality 
	 *            质量 
	 * @param smallIcon 
	 *            小图片的后缀 
	 * @return 返回压缩后的文件的全路径 
	 */  
	public static String zipImageFile(String oldFile, int width, int height,  
	        float quality, String smallIcon) {  
	    if (oldFile == null) {  
	        return null;  
	    }  
	    String newImage = null;  
	    try {  
	        /** 对服务器上的临时文件进行处理 */  
	        Image srcFile = ImageIO.read(new File(oldFile));  
	        /** 宽,高设定 */  
	        BufferedImage tag = new BufferedImage(width, height,  
	                BufferedImage.TYPE_INT_RGB);  
	        tag.getGraphics().drawImage(srcFile, 0, 0, width, height, null);  
	        String filePrex = oldFile.substring(0, oldFile.indexOf('.'));  
	        /** 压缩后的文件名 */  
	            newImage = filePrex + smallIcon  
	                    + oldFile.substring(filePrex.length());  
	  
	            /** 压缩之后临时存放位置 */  
	            FileOutputStream out = new FileOutputStream(newImage);  
	  
	            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);  
	            JPEGEncodeParam jep = JPEGCodec.getDefaultJPEGEncodeParam(tag);  
	            /** 压缩质量 */  
	            jep.setQuality(quality, true);  
	            encoder.encode(tag, jep);  
	            out.close();  
	  
	        } catch (FileNotFoundException e) {  
	            e.printStackTrace();  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	        return newImage;  
	    }  
	
	public static void scale(String path,String fileName,String toFileName){
		try {
			Image image = javax.imageio.ImageIO.read(new File(path + fileName));
			int imageWidth = image.getWidth(null);
			int imageHeight = image.getHeight(null);
			
			image = image.getScaledInstance(imageWidth, imageHeight, Image.SCALE_SMOOTH);
			// Make a BufferedImage from the Image.
			BufferedImage mBufferedImage = new BufferedImage(imageWidth, imageHeight,BufferedImage.TYPE_INT_RGB);
			Graphics2D g2 = mBufferedImage.createGraphics();
			    
			g2.drawImage(image, 0, 0,null);
			FileOutputStream out = new FileOutputStream(path + toFileName);
			
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(mBufferedImage);
			out.close();
		}catch (FileNotFoundException fnf){
			
		}catch (IOException ioe){
			
		}finally{
		
		}
	}
	  
	public static void main(String args[]){  
		zipImageFile("d:\\1.jpg", 85, 117, 0.5f, "x");
		    
		long c = System.currentTimeMillis();
		//ImageScale();
		System.out.println("elapse time:" + (System.currentTimeMillis() - c)/1000.0f + "s");
	}
}
