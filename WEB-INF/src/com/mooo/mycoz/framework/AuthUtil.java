package com.mooo.mycoz.framework;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.GroupMember;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineFrameWork.Action;
import com.mooo.mycoz.dbobj.wineFrameWork.AuthRole;
import com.mooo.mycoz.dbobj.wineFrameWork.GroupRoleMapping;
import com.mooo.mycoz.dbobj.wineFrameWork.Method;
import com.mooo.mycoz.dbobj.wineFrameWork.WorkGroup;
import com.mooo.mycoz.dbobj.wineFrameWork.Role;
import com.mooo.mycoz.framework.util.IDGenerator;

public class AuthUtil {

	private static Log log = LogFactory.getLog(AuthUtil.class);

	private static Object initLock = new Object();
	private static AuthUtil factory = null;
	
	public static AuthUtil getInstance() {

		if (factory == null) {
			synchronized (initLock) {
				if (factory == null) {
					factory = new AuthUtil();
				}
			}
		}
		return factory;
	}
	
	private boolean enable = false;
	private ActionConfigure conf = ActionConfigure.getInstance();

	private AuthUtil() {
		enable = conf.isEnableAuth();
		
		if(enable){
			parseXML();
			parseDatabase();
			refresh();
		}
	}

	private Map<String, ActionNode> xmlMap;
	private Map<String, ActionNode> dababaseMap;
	
	public Map<String, ActionNode> getXmlMap() {
		return xmlMap;
	}

	public void setXmlMap(Map<String, ActionNode> xmlMap) {
		this.xmlMap = xmlMap;
	}

	public Map<String, ActionNode> getDababaseMap() {
		return dababaseMap;
	}

	public void setDababaseMap(Map<String, ActionNode> dababaseMap) {
		this.dababaseMap = dababaseMap;
	}

	public void parseXML() {
		xmlMap = ActionConfigure.getInstance().getActionMap();
	}
	
	public void parseDatabase() {
		Transaction tx = new Transaction();
		try {
			tx.start();
			
			dababaseMap = new HashMap<String, ActionNode>();
			
			Action action = new Action();
			List<?> actions = action.searchAndRetrieveList(tx.getConnection());
			
			for(Object a:actions){
				ActionNode actionNode = new ActionNode();

				action = (Action) a;
				
				actionNode.setName(action.getDefinition());
				
				Method method = new Method();
				method.setActionId(action.getId());
				
				List<?> methods = method.searchAndRetrieveList(tx.getConnection());
				
				for(Object m:methods){
					method = (Method) m;
					actionNode.addResult(method.getMethodName(), new MethodNode());
				}
				
				dababaseMap.put(actionNode.getName(), actionNode);
			}
			
			tx.commit();
		} catch (Exception e) {
			e.printStackTrace();
			tx.rollback();
		} finally{
			tx.end();
		}
	}
	
	public void refresh() {
		try {
			clearAction();
			addAction();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void clearAction() {
		Transaction tx = new Transaction();

		try {
			tx.start();
			
			Action action = new Action();
			List<?> actions = action.searchAndRetrieveList(tx.getConnection());
			
			List<String> xmlMethods;
			List<String> dataMethods;

			Iterator<?> iterator = actions.iterator();
			
			while (iterator.hasNext()) {
				action = (Action) iterator.next();
				String actionName = action.getDefinition();

				Method method = new Method();
				method.setActionId(action.getId());
				
				List<?> methods = method.searchAndRetrieveList(tx.getConnection());
				
				if (xmlMap.containsKey(actionName)) {
					
					// database Methods
					dataMethods = new ArrayList<String>();

					for(Object obj:methods){
						method = (Method) obj;
						dataMethods.add(method.getMethodName());
					}
					
					// XML file Methods		
					xmlMethods = new ArrayList<String>();
					Hashtable<String, MethodNode> results = xmlMap.get(actionName).getResults();
					
					for(Entry<String, MethodNode> entry:results.entrySet()){
						xmlMethods.add(entry.getKey());
					}

					for(String methodName:dataMethods){
						
						if (!xmlMethods.contains(methodName)) {
							Method methodBean = new Method();
							methodBean.setMethodName(methodName);
							methodBean.retrieve(tx.getConnection());
							
							AuthRole authRole = new AuthRole();
							authRole.setMethodId(methodBean.getId());
							authRole.delete(tx.getConnection());

							methodBean.delete(tx.getConnection());
						}
					}
				} else {

					for(Object obj:methods){
						method = (Method) obj;
						
						AuthRole authRole = new AuthRole();
						authRole.setMethodId(method.getId());
						authRole.delete(tx.getConnection());

						method.delete(tx.getConnection());
					}
					action.delete(tx.getConnection());
				}
			}
			tx.commit();
		} catch (Exception e) {
			if (log.isErrorEnabled()) log.error("Exception:" + e.getMessage());
			e.printStackTrace();
			tx.rollback();
		} finally {
			tx.end();
		}
	}

	public void addAction() {
		Transaction tx = new Transaction();
		try {
			tx.start();

			String actionName;
			String actionCls;

			String methodName;

			for(Entry<String, ActionNode> entry:xmlMap.entrySet()){
				actionName = entry.getKey();
				actionCls = entry.getValue().getCls();
				
				if (dababaseMap.containsKey(actionName)) {
					
					Action action = new Action();
					action.setDefinition(actionName);
					action.retrieve(tx.getConnection());
					
					action.setCls(actionCls);
					action.update(tx.getConnection());
					
					Method method = new Method();
					method.setActionId(action.getId());
					
					List<?> methods = method.searchAndRetrieveList(tx.getConnection());
					List<String> dataMethods = new ArrayList<String>();

					for(Object obj:methods){
						method = (Method)obj;
						methodName = method.getMethodName();
						dataMethods.add(methodName);
					}
					
					Hashtable<String, MethodNode> results = xmlMap.get(actionName).getResults();
					
					for(Entry<String, MethodNode> e:results.entrySet()){
						methodName = e.getKey();

						if(!dataMethods.contains(methodName)){
							method = new Method();
							method.setId(IDGenerator.getNextID(tx.getConnection(), Method.class));
							method.setActionId(action.getId());
							method.setMethodName(methodName);
							method.setDescription(methodName);
							
							method.add(tx.getConnection());
						}
					}
					
				} else {
					Action action = new Action();
					action.setId(IDGenerator.getNextID(tx.getConnection(), Action.class));
					action.setDefinition(actionName);
					action.setDescription(actionName);
					action.setCls(actionCls);
					action.add(tx.getConnection());
					
					Hashtable<String, MethodNode> results = xmlMap.get(actionName).getResults();
					
					for(Entry<String, MethodNode> e:results.entrySet()){
						methodName = e.getKey();

						Method method = new Method();
						method.setId(IDGenerator.getNextID(tx.getConnection(), Method.class));
						method.setActionId(action.getId());
						method.setMethodName(methodName);
						method.setDescription(methodName);

						method.add(tx.getConnection());
					}
				}
			}
			tx.commit();
		} catch (Exception e) {
			if (log.isErrorEnabled())
				log.error("Exception:" + e.getMessage());
			e.printStackTrace();
			tx.rollback();
		} finally{
			tx.end();
		}
	}
	
	public Boolean checkAuth(Integer userId,String action,String method) {
		try {

			if ( !enable || userId == 1)
				return true;

			MultiDBObject mdobject = new MultiDBObject();
			mdobject.addTable(User.class, "user");
			mdobject.addTable(WorkGroup.class, "userGroup");
			mdobject.addTable(GroupMember.class, "groupMember");
			mdobject.addTable(GroupRoleMapping.class, "groupRoleMapping");
			mdobject.addTable(Role.class, "userRole");
			mdobject.addTable(AuthRole.class, "authRole");
			mdobject.addTable(Action.class, "action");
			mdobject.addTable(Method.class, "method");

			mdobject.setForeignKey("groupMember", "userId","user", "id");
			mdobject.setForeignKey("groupMember", "groupId","userGroup", "id");
			
			mdobject.setForeignKey("groupRoleMapping", "roleId", "userRole", "id");
			mdobject.setForeignKey("groupRoleMapping", "groupId", "userGroup", "id");
			
			mdobject.setForeignKey("authRole", "roleId", "userRole", "id");
			mdobject.setForeignKey("authRole", "methodId", "method", "id");

			mdobject.setForeignKey("method", "actionId", "action", "id");
			
			mdobject.setField("user", "id", userId);
			mdobject.setField("action", "definition", action);
			
			mdobject.setField("method", "methodName", method);

			mdobject.setRetrieveField("user", "id");
			
			if(mdobject.count() >0)
				return true;
			else
				return false;
			
		} catch (Exception e) {
			e.fillInStackTrace();
		}
		return true; // default return
	}
	
/*
	public void print() {
		try {
			Iterator<?> iterator;
			String key;
			List<String> actions;

			System.out.println(".............XML...........");

			iterator = xmlMap.keySet().iterator();
			while (iterator.hasNext()) {
				key = iterator.next().toString();
				System.out.println("............." + key + "...........");

				actions = (List<String>) xmlMap.get(key);
				for (Iterator<String> it = actions.iterator(); it.hasNext();) {
					System.out.println(it.next());
					// it.next();
				}
			}

			System.out.println(".............Databases...........");

			iterator = dababaseMap.keySet().iterator();
			while (iterator.hasNext()) {
				key = iterator.next().toString();
				System.out.println("............." + key + "...........");

				actions = (List<String>) xmlMap.get(key);
				for (Iterator<String> it = actions.iterator(); it.hasNext();) {
					System.out.println(it.next());
					// it.next();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void printDatabase() {
		try {
			Iterator<?> iterator;
			String key;
			ActionNode action;

			System.out.println(".............XML...........");

			iterator = dababaseMap.keySet().iterator();
			while (iterator.hasNext()) {
				key = iterator.next().toString();
				System.out.println("............." + key + "...........");

				action = (ActionNode) dababaseMap.get(key);
				System.out.println("name=" + action.getDefinition() + " class="+ action.getCls());
				Hashtable<String, String> results = action.getResults();
				Iterator<?> resultIterator = results.keySet().iterator();
				while (resultIterator.hasNext()) {
					key = resultIterator.next().toString();
					System.out.println("result key=" + key + " value="+ results.get(key));
					if(log.isDebugEnabled()) log.debug("result key=" + key + " value="+ results.get(key));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void printConf() {
		try {
			Iterator<?> iterator;
			String key;
			ActionNode action;

			System.out.println(".............XML...........");

			iterator = xmlMap.keySet().iterator();
			while (iterator.hasNext()) {
				key = iterator.next().toString();
				System.out.println("............." + key + "...........");

				action = (ActionNode) xmlMap.get(key);
				System.out.println("name=" + action.getDefinition() + " class="+ action.getCls());
				Hashtable<String, String> results = action.getResults();
				Iterator<?> resultIterator = results.keySet().iterator();
				while (resultIterator.hasNext()) {
					key = resultIterator.next().toString();
					System.out.println("result key=" + key + " value="+ results.get(key));
					if(log.isDebugEnabled()) log.debug("result key=" + key + " value="+ results.get(key));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	*/
}

