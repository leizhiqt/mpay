package com.mooo.mycoz.framework;

import java.util.Vector;

public class Action {

	private String key;
	private String action;
	private String method;
	private boolean enable;
	
	private Vector<Action> childAction;
	
	public Action(){
		this.key=null;
		this.action=null;
		this.method=null;
		this.enable=false;
		this.childAction=new Vector<Action>();
	}
	
	public Action(Integer sessionId,String key,String action){
		this.key=key;
		this.action=action;
		this.childAction=new Vector<Action>();
		
		String actionPath = ActionUtil.execPath(action);
		ActionNode actionNode = (ActionNode) ActionFilter.actionMap.get(actionPath);
		this.enable = ActionFilter.auth.checkAuth(sessionId, actionPath, actionNode.getDefMethod());
	}
	
	public Action(Integer sessionId,String key,String action,String method){
		this.key=key;
		this.action=action;
		this.method=method;
		this.childAction=new Vector<Action>();
		
		this.enable = ActionFilter.auth.checkAuth(sessionId, ActionUtil.execPath(action), method);
	}
	
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public boolean isEnable() {
		return enable;
	}

	public void setEnable(boolean enable) {
		this.enable = enable;
	}

	public Vector<Action> getChildAction() {
		return childAction;
	}

	public void addChildAction(Action action) {
		childAction.add(action);
	}

}