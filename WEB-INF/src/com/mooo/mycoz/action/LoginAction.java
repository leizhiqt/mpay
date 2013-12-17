package com.mooo.mycoz.action;

import java.util.Date;
import java.util.Locale;

import java.io.File;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.AccessLog;
import com.mooo.mycoz.dbobj.wineBranch.GroupMember;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.SessionCounter;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;
import com.mooo.mycoz.framework.component.ValidateCode;

public class LoginAction extends BaseSupport {

	private static Log log = LogFactory.getLog(LoginAction.class);
	
	public String promptLogin(HttpServletRequest request,
			HttpServletResponse response) {
		try {
			if (log.isDebugEnabled())log.debug("promptLogin");
			//HttpSession session = request.getSession(true);
			//session.setAttribute(USER_SESSION_KEY, -1);

			//Locale[] locales = java.text.NumberFormat.getAvailableLocales();
			Locale[] locales = new Locale[2];
			locales[0] = new Locale("en","US");
			locales[1] = new Locale("zh","CN");
			request.setAttribute("locales", locales);

			Locale.setDefault(locales[1]);
			
			if(!StringUtils.isNull(request.getParameter("locale")))
				Locale.setDefault(new Locale(request.getParameter("locale")));

			if (log.isDebugEnabled()) log.debug("IP:"+getClinetIp(request));
			
			/**
			* 生成随机图片
			*/
			HttpSession session = request.getSession();
			String physicalPath = request.getSession().getServletContext().getRealPath("/");
			String tmpFNPrefix="tmp/"+System.currentTimeMillis()+".jpg";
			
			ValidateCode validateCode= new ValidateCode();
			String randomString = validateCode.draw(new File(physicalPath+tmpFNPrefix));
			
			session.removeAttribute(ValidateCode.RANDOMCODEKEY);
			session.setAttribute(ValidateCode.RANDOMCODEKEY, randomString);
			System.out.println(randomString);
			
			request.setAttribute("validateCode", tmpFNPrefix);
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			return "promptLogin";
		}
		return "success";
	}

	public String processLogin(HttpServletRequest request,HttpServletResponse response) {
		try {
			
			User user = new User();
			ParamUtil.bindData(request, user, "user");

			StringUtils.noNull(user.getName());
			StringUtils.noNull(user.getPassword());
			
			HttpSession session = request.getSession(true);
			
			String svc = (String)session.getAttribute(ValidateCode.RANDOMCODEKEY);
			if(!request.getParameter("validateCode").equalsIgnoreCase(svc)){
				throw new Exception("验证码错误");
			}else{
				session.removeAttribute(ValidateCode.RANDOMCODEKEY);
			}

			user.setPassword(StringUtils.hash(user.getPassword()));
			user.setActive("Y");
			
			if (user.count() < 1) {
				if (log.isDebugEnabled())log.debug("<1");
				return "promptLogin";
			} else {
				if (log.isDebugEnabled())log.debug("else");
				user.retrieve();
				
				String ip = getClinetIp(request);
				if (log.isDebugEnabled())log.debug("Clinet IP:"+ip);


				session.setAttribute(ActionSession.USER_SESSION_KEY, user.getId());
				session.setAttribute(ActionSession.BRANCH_SESSION_KEY, user.getBranchId());
				session.setAttribute(ActionSession.USER_NAME_KEY, user.getName());
				session.setAttribute(ActionSession.IP, ip);
				
				if (log.isDebugEnabled()) log.debug("USER_SESSION_KEY: " + session.getAttribute(ActionSession.USER_SESSION_KEY));

				AccessLog al = new AccessLog();
				if (log.isDebugEnabled()) log.debug("AccessLog: " + IDGenerator.getNextInt(AccessLog.class));

				al.setId(IDGenerator.getNextInt(AccessLog.class));
				al.setIp(ip);
				al.setStartdate(new Date(session.getCreationTime()));
				al.add();
				
				SessionCounter.login();
				if (log.isDebugEnabled()) log.debug("SessionCounter: " + SessionCounter.getCount());
			}
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			return "promptLogin";
		}
		return "success";

	}
	
	public String promptRegister(HttpServletRequest request,HttpServletResponse response) {
		try {
			if (log.isDebugEnabled())log.debug("promptRegister");
			User user = new User();
			user.setId(IDGenerator.getNextInt(User.class));
			request.setAttribute("user", user);
			
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			return "promptRegister";
		}
		return "success";
	}

	public String processRegister(HttpServletRequest request,HttpServletResponse response) {
		Transaction tx = new Transaction();
		try {
			tx.start();

			if (log.isDebugEnabled())log.debug("promptRegister");
			String value="";
			
			User user = new User();
			ParamUtil.bindData(request, user, "user");
			
			StringUtils.noNull(user.getName());
			StringUtils.noNull(user.getPassword());
			
			value = request.getParameter("dpassword");
			
			if (log.isDebugEnabled()) log.debug("dpassword=" + value);
			if (log.isDebugEnabled()) log.debug("password=" + user.getPassword());

			if(!value.equals(user.getPassword())){
				if (log.isDebugEnabled()) log.debug("not as same password");
				throw new Exception("not as same password");
			}
			
			user.setPassword(StringUtils.hash(user.getPassword()));
		
			user.add(tx.getConnection());
			
//			AddressBook addressBook = new AddressBook();
//			addressBook.setId(IDGenerator.getNextInt(AddressBook.class));
//			addressBook.setUserId(user.getId());
//			
//			addressBook.add(tx.getConnection());

			GroupMember groupMember = new GroupMember();
			groupMember.setId(IDGenerator.getNextInt(GroupMember.class));
//			groupMember.setGroupId(1);
			groupMember.setUserId(user.getId());
			groupMember.add(tx.getConnection());

			tx.commit();
	} catch (Exception e) {
		if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		tx.rollback();
		return "promptRegister";
	} finally {
		tx.end();
	}
		return "success";
	}
	
	public String processLogout(HttpServletRequest request,HttpServletResponse response) {
		try {
				HttpSession session = request.getSession(true);
				if (log.isDebugEnabled()) log.debug("online datatime = " + (session.getLastAccessedTime() - session.getCreationTime()) );
				session.invalidate();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return "success";
	}
	
	public String getClinetIp(HttpServletRequest request) {   
	     String ip = request.getHeader("x-forwarded-for");   
	     if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	         ip = request.getHeader("Proxy-Client-IP");   
	     }   
	     if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	         ip = request.getHeader("WL-Proxy-Client-IP");   
	     }   
	     if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {   
	         ip = request.getRemoteAddr();   
	     }   
	     return ip;   
	} 
}
