package com.mooo.mycoz.action;

/**
 * Base Action class for the controller package.
 */

public class BaseSupport {
	
	/*
	 * configure general action
	 */

	public String layout;
	
	public String getLayout() {
		return layout;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}

	public BaseSupport() {
		setLayout("skin/office/default");
	}
	
}
