package com.mooo.mycoz.framework;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class JspFilter implements Filter {

	private static ActionConfigure conf;

	public void init(FilterConfig filterConfig) throws ServletException {
		conf = ActionConfigure.getInstance();
	}

	public void destroy() {
		conf = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		try {

			if (request instanceof HttpServletRequest) {

				HttpServletRequest hRequest = (HttpServletRequest) request;
//				HttpServletResponse hResponse = (HttpServletResponse) response;

				HttpSession session = hRequest.getSession();
				String contextPath = hRequest.getContextPath();
				String accessPath = hRequest.getServletPath();

				Pattern p = Pattern.compile("\\.jsp");
				Matcher m = p.matcher(accessPath);
				boolean isJsp = m.find();
				
				boolean isAuthenticated = true;
				System.out.println("Jsp EnableAuth:"+conf.isEnableAuth());

				//check sample action for configure
				if(conf.isEnableAuth()){
					// check advanced permissions
					Integer userId = (Integer) session.getAttribute(ActionSession.USER_SESSION_KEY);
					isAuthenticated = (null != userId && userId >0);
					
					System.out.println("--------Jsp filter start-------------");
					System.out.println("Jsp filter contextPath:" + contextPath);
					System.out.println("Jsp filter accessPath:" + accessPath);
					System.out.println("Jsp filter execPath:" + ActionUtil.execPath(accessPath));
					System.out.println("Jsp filter isJsp:" + isJsp);
					System.out.println("--------Jsp filter end-------------");
				}
				
				if (!isAuthenticated) {
//					hResponse.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
					if (isJsp) {
//						hResponse.setHeader("Location", contextPath + "/Login.do");
						String url = contextPath + "/Login.do";
						PrintWriter out = response.getWriter();
						out.println( "<script>");
						out.println( "window.top.location.href= '"+url+"';");
						out.println( "</script>"); 
					}
				}
			}
		} catch (Exception e) {
			System.out.println("Exception:" + e.getMessage());
			e.printStackTrace();
		} finally {
			request.setCharacterEncoding("UTF-8");
			chain.doFilter(request, response);
		}
	}
}