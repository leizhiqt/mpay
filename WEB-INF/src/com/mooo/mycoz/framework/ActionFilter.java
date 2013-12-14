package com.mooo.mycoz.framework;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Hashtable;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.xml.DOMConfigurator;

import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.framework.cache.CacheManager;

public class ActionFilter implements Filter {

	private static Log log = LogFactory.getLog(ActionFilter.class);
	
	private static ActionConfigure conf;

	public static AuthUtil auth;

	public static Map<String, ActionNode> actionMap;
	private static CacheManager cacheManager;
	
	public void init(FilterConfig filterConfig) throws ServletException {
		
		String logDir = filterConfig.getInitParameter("LogDir");
		
		if(logDir==null || logDir.equals(""))
			logDir = "WEB-INF/log";
		
	
		// get web app real directory   
		String prefix = filterConfig.getServletContext().getRealPath("/");
		String confDir = filterConfig.getServletContext().getInitParameter("configDir");
		
		System.setProperty("LogDir",prefix+"/"+logDir);

		conf = ActionConfigure.getInstance();
		
		//super.init();
		
		//load log4j configure file
		// read parameter from web.xml file to set log4j property   
		// set log4j
		if (confDir != null) {
			DOMConfigurator.configure(prefix + confDir+"/log4j.xml");
		}
		
		conf = ActionConfigure.getInstance();
		conf.setConf(prefix + confDir +"/myconfig.xml");
		conf.configure();
		
		// get mvc configure
		actionMap = conf.getActionMap();
		cacheManager = CacheManager.getInstance();
		
		//auth configure
		auth = AuthUtil.getInstance();
		//auth.printConf();
		//auth.printDatabase();
	}

	public void destroy() {
		cacheManager = null;
		actionMap = null;
		auth = null;
		conf = null;
	}

	public void addCache(String key, Object object){
		cacheManager.add("action", key, object);
	}

	public Object getCache(String key){
		return cacheManager.get("action", key);
	}
	
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		try {
			System.out.println("Actiong filter start");

			if (request instanceof HttpServletRequest) {

				String accessPath = "";
				String execPath = "";
	
				String execAction = "";
				String execResult = "";
				String execMethod = "";
				String resultMethod ="";
				
				HttpServletRequest hRequest = (HttpServletRequest) request;
				HttpServletResponse hResponse = (HttpServletResponse) response;
	
				String contextPath = hRequest.getContextPath();
				accessPath = hRequest.getServletPath();
				
				//accessPath = request.getServletPath();
				execPath = ActionUtil.execPath(accessPath);
				execMethod = request.getParameter("method");
	
				//set controller,execState for execPath
				ActionNode actionNode = (ActionNode) actionMap.get(execPath);
				
				execAction = actionNode.getCls();
				if (execMethod == null)
					execMethod = actionNode.getDefMethod();
				
				Hashtable<String, MethodNode> results = actionNode.getResults();
				
				if(log.isDebugEnabled())log.debug("accessPath:" + accessPath);
				if(log.isDebugEnabled())log.debug("execPath:" + execPath);
				if(log.isDebugEnabled())log.debug("execMethod:" + execMethod);
				
				//check allow url
				boolean allow = results.get(execMethod).isAllow();
				
				if(log.isDebugEnabled())log.debug("isAllow:" + allow);

				//check sample action for configure
				if(!allow){
					if(conf.isEnableAuth()){
						HttpSession session = hRequest.getSession(true);
		
						Object sampleValue = session.getAttribute(ActionSession.USER_SESSION_KEY);
						boolean allowSample = sampleValue != null;

						if(log.isDebugEnabled())log.debug("sampleKey:" + ActionSession.USER_SESSION_KEY);
						if(log.isDebugEnabled())log.debug("sampleValue:" + sampleValue);
						if(log.isDebugEnabled())log.debug("allowSample:" + allowSample);
						
						if(log.isDebugEnabled())log.debug("execPath:" + execPath);
						if(log.isDebugEnabled())log.debug("execMethod:" + execMethod);
		
						// check advanced permissions
						if(allowSample){
							Integer userId = (Integer) sampleValue;
							
							if(log.isDebugEnabled())log.debug("userId:" + userId);
							if(log.isDebugEnabled())log.debug("checkAuth:" + !auth.checkAuth(userId, execPath, execMethod));
		
							if(!auth.checkAuth(userId, execPath, execMethod)){
								if(log.isDebugEnabled())log.debug("Note Auth!");
		
								actionNode = (ActionNode) actionMap.get("Login");
								execAction = actionNode.getCls();
								execMethod = "promptLogin";
								
								results = actionNode.getResults();
								
//								hResponse.sendRedirect(contextPath+"/jsp/error.jsp");
//								return;
							}
						}else{
							if(log.isDebugEnabled())log.debug("Note Auth!");
							
							actionNode = (ActionNode) actionMap.get("Login");
							execAction = actionNode.getCls();
							execMethod = "promptLogin";
							
							results = actionNode.getResults();
						}//end allowSample
					}//end enableAuth
				}//end allow
				
				if(log.isDebugEnabled())log.debug("========exec start=======");
				if(log.isDebugEnabled())log.debug("execAction="+execAction);
				if(log.isDebugEnabled())log.debug("execMethod="+execMethod);
				
				// exec Controller request aciton
				Object obj = getCache(execAction);
	
				if(obj == null) {
					obj = Class.forName(execAction).newInstance();
					addCache(execAction, obj);
				}

				//Forward to Action or URL
				Class<? extends Object> cls = obj.getClass();
				Class<?>[] paraTypes = new Class[] { HttpServletRequest.class,HttpServletResponse.class };
				Method method = cls.getMethod(execMethod, paraTypes);
				Object paraValues[] = new Object[] { request, response };
				
				// set Transition jsp for execMethod
				resultMethod = (String) method.invoke(obj, paraValues);
				execResult = results.get(execMethod).getForwardPath();
	
				if(log.isDebugEnabled())log.debug("========exec end=======");
				if(log.isDebugEnabled())log.debug("resultMethod="+resultMethod);
				if(log.isDebugEnabled())log.debug("execResult="+execResult);
	
				if(resultMethod != null){
					// not success then exec return method and fowward jsp		
					if(!resultMethod.equals("success")) {
						
						execMethod=resultMethod;
						method = cls.getMethod(execMethod, paraTypes);
						resultMethod = (String) method.invoke(obj, paraValues);
	
						System.out.println("execMethod->"+execMethod);
						System.out.println("resultMethod->"+resultMethod);
	
						if(resultMethod.equals("success"))
							execResult = results.get(execMethod).getForwardPath();
						else
							execResult = results.get(resultMethod).getForwardPath();
					}
					
					if(StringUtils.checkString(execResult, "\\.jsp")){// is jsp
						System.out.println("execResult:"+execResult);
						hRequest.getRequestDispatcher(execResult).forward(request,response);
					} else if(StringUtils.checkString(execResult, "\\.do")){// is action
						hResponse.sendRedirect(contextPath+execResult);
					}
				}//end resultMethod
			}//is HttpServletRequest
		} catch (NullPointerException e) {
			if(log.isErrorEnabled()) log.error("NullPointerException:"+e.getMessage());
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			if(log.isErrorEnabled()) log.error("NullPointerException:"+e.getMessage());
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			if(log.isErrorEnabled()) log.error("InvocationTargetException:"+e.getMessage());
			e.printStackTrace();
		} catch (RuntimeException e) {
			if(log.isErrorEnabled()) log.error("RuntimeException:"+e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			if(log.isErrorEnabled()) log.error("Exception:"+e.getMessage());
			e.printStackTrace();
		} catch (Throwable e) {
			if(log.isErrorEnabled()) log.error("Throwable:"+e.getMessage());
			e.printStackTrace();
		}
		System.out.println("Actiong filter end");
	}
}