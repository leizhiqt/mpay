package com.mooo.mycoz.action.help;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelpAction {
	public String version(HttpServletRequest request, HttpServletResponse response) {
		return "success";
	}
	
	public String document(HttpServletRequest request, HttpServletResponse response) {
		return "success";
	}
}