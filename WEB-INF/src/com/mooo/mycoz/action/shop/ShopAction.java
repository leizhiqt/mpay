package com.mooo.mycoz.action.shop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ShopAction {
	private static Log log = LogFactory.getLog(ShopAction.class);

	public String browseShop(HttpServletRequest request,HttpServletResponse response) {
		try {
			if (log.isDebugEnabled()) log.debug("browseShop begin!");

			if (log.isDebugEnabled()) log.debug("browseShop OK!");
		} catch (Exception e) {
			if (log.isErrorEnabled())log.error("Exception Load error of: " + e.getMessage());
		}
		return "success";
	}
}