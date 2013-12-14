package com.mooo.mycoz.framework;

public class MethodNode {
	private String name;
	private String forwardPath;
	private boolean allow;

	public MethodNode(){
		this.name="";
		this.forwardPath="";
		this.allow=false;
	}
	
	public MethodNode(String name,String forwardPath,boolean allow){
		this.name=name;
		this.forwardPath=forwardPath;
		this.allow=allow;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getForwardPath() {
		return forwardPath;
	}

	public void setForwardPath(String forwardPath) {
		this.forwardPath = forwardPath;
	}

	public boolean isAllow() {
		return allow;
	}

	public void setAllow(boolean allow) {
		this.allow = allow;
	}

}
