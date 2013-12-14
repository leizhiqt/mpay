package com.mooo.mycoz.framework;

import java.util.Hashtable;

public class ActionNode {

	private String name;
	private String cls;
	private String method;
	private String defMethod;
	private boolean allow;

	private Hashtable<String, MethodNode> results;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCls() {
		return cls;
	}

	public void setCls(String cls) {
		this.cls = cls;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public Hashtable<String, MethodNode> getResults() {
		return results;
	}

	public void setResults(Hashtable<String, MethodNode> results) {
		this.results = results;
	}

	public String getDefMethod() {
		return defMethod;
	}

	public void setDefMethod(String defMethod) {
		this.defMethod = defMethod;
	}

	public void addResult(String name, MethodNode methodNode) {
		if (results == null)
			results = new Hashtable<String, MethodNode>();
		results.put(name, methodNode);
	}

	public boolean isAllow() {
		return allow;
	}

	public void setAllow(boolean allow) {
		this.allow = allow;
	}
}
