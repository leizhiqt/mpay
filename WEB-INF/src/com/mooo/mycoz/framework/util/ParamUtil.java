package com.mooo.mycoz.framework.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.db.DbBridgingBean;

public class ParamUtil {
	private static Log log = LogFactory.getLog(ParamUtil.class);

	/**
	 * 动态从request.getParameter里绑定javaBean属性值.
	 * 
	 * @param request
	 *            http响应对象
	 * @param bean
	 *            绑定的javaBean
	 * @param excludes
	 *            过滤参数
	 * @param prefix
	 *            前缀 只取前缀的
	 */
	public static void bindData(HttpServletRequest request, Object bean,
			List<?> excludes, String prefix) {
		try {
			Enumeration<?> em = request.getParameterNames();
			while (em.hasMoreElements()) {
					String name = (String)em.nextElement();
					String value = request.getParameter(name);
	
					if (value == null) {
						continue;
					}
	
					if (excludes != null && excludes.contains(value)) {
						continue;
					}
	
					if (prefix != null) {
						if (name.indexOf(prefix + ".") != 0) {
							continue;
						}
						name = name.replaceFirst(prefix + ".", "");
					}
	
					value = value.trim();
					
					System.out.println("ParamUtil:"+name + "->" + value);

					if (name.indexOf(".") > -1) {
						int start = name.indexOf(".");
						String objName = name.substring(0, start);
						String propertyName = name.substring(start + 1, name.length());
						DbBridgingBean.bindSubObject(bean, objName, propertyName, value);
					} else {
						DbBridgingBean.bindProperty(bean, name, value);
					}
	
			}
		} catch (Exception e) {
			e.printStackTrace(); // To change body of catch statement use
			// File | Settings | File Templates.
		}
	}

	public static void bindData(HttpServletRequest request, Map<Object,Object> beans) {
		bindData(request, beans, null, null);
	}
	
	public static void bindData(HttpServletRequest request, Map<Object,Object> beans,
			List<?> excludes, String prefix) {

		try {
			Enumeration<?> enums = request.getParameterNames();
			
			while (enums.hasMoreElements()) {
					String name = (String) enums.nextElement();
					String value = request.getParameter(name);
	
					if (value == null) {
						continue;
					}
	
					if (excludes != null && excludes.contains(value)) {
						continue;
					}
	
					if (prefix != null) {
						if (name.indexOf(prefix + ".") != 0) {
							continue;
						}
						name = name.replaceFirst(prefix + ".", "");
					}
	
					value = value.trim();
					System.out.println("ParamUtil:"+name + "->" + value);
	
					if (name.indexOf(".") > -1) {
						int start = name.indexOf(".");
						String objName = name.substring(0, start);
						String propertyName = name.substring(start + 1, name.length());
						
						Object obj = beans.get(objName);
	
						Map<Object,Object> subMap = (Map<Object, Object>) obj;
						
						if(subMap != null){
							subMap.put(propertyName,value);
						} else {
							subMap = new HashMap<Object,Object>();
							subMap.put(propertyName, value);
							
							beans.put(objName, subMap);
						}
					} else {
						beans.put(name, value);
					}
			} // end while
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 动态从request.getParameter里绑定javaBean属性值.
	 * 
	 * @param request
	 *            http响应对象
	 * @param bean
	 *            绑定的javaBean
	 */
	public static void bindData(HttpServletRequest request, Object bean) {
		bindData(request, bean, null, null);
	}
	
	/**
	 * 动态从request.getParameter里绑定javaBean属性值.
	 * 
	 * @param request
	 *            http响应对象
	 * @param bean
	 *            绑定的javaBean
	 * @param bean
	 *            绑定的javaBran前缀
	 */
	public static void bindData(HttpServletRequest request, Object bean,String prefix) {
		bindData(request, bean, null, prefix);
	}
	
	public static void fillMap(Class<?> c, Object obj, Map<String, Object> params) {
		Method[] methods = c.getDeclaredMethods();
		for (Method m : methods) {
			if (Modifier.isPublic(m.getModifiers())
					&& m.getName().startsWith("get")) {
				try {
					params.put(m.getName().substring(3), m.invoke(obj));
				} catch (Exception e) {
					System.err.println(e.getMessage());
				}
			}
		}
	}

	public static void fillObject(Class<?> c, Object obj, Map<?, ?> params) {
		for (Object key : params.keySet()) {
			String paramName = (String) key;
			try {
				Method getMethod = c.getMethod("get" + paramName);
				Method setMethod = c.getMethod("set" + paramName, getMethod.getReturnType());
				setMethod.invoke(obj, params.get(key));
				if(log.isDebugEnabled()) log.debug("");
			} catch (NoSuchMethodException e) {
				continue;
			} catch (Exception e) {
				System.err.println(e.getMessage());
			}
		}
	}
	
	public static String WriteUTF8(String input) {
		try {
			return new String(input.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}

}
