package com.mooo.mycoz.framework;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;

import com.mooo.mycoz.framework.cache.Cache;
import com.mooo.mycoz.framework.cache.CacheManager;

public class ActionConfigure {

	private static Object initLock = new Object();
	private static ActionConfigure factory = null;

	private static Log log = LogFactory.getLog(ActionConfigure.class);

	private String conf = "/myconfig.xml";
	
	private InputStream confStream = null;

	private HashMap<String, Cache> caches;
	
	private boolean enableAuth;
	
	private Map<String, ActionNode> actionMap;
	
	public static ActionConfigure getInstance() {

		if (factory == null) {
			synchronized (initLock) {
				if (factory == null) {
					factory = new ActionConfigure();
				}
			}
		}
		return factory;
	}

	private ActionConfigure() {
		flush();
		
		enableAuth = false;
	}

	public String getConf() {
		return conf;
	}

	public void setConf(String conf) {
		this.conf = conf;
	}

	public HashMap<String, Cache> getCaches() {
		return caches;
	}

	public void setCaches(HashMap<String, Cache> caches) {
		this.caches = caches;
	}

	public boolean isEnableAuth() {
		return enableAuth;
	}

	public void setEnableAuth(boolean enableAuth) {
		this.enableAuth = enableAuth;
	}

	public Map<String, ActionNode> getActionMap() {
		return actionMap;
	}

	public void setActionMap(Map<String, ActionNode> actionMap) {
		this.actionMap = actionMap;
	}

	public void flush() {
		try {
			confStream = new FileInputStream(conf);
		} catch (FileNotFoundException e) {
			confStream = getClass().getResourceAsStream(conf);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void configure() {
		try {
			flush();

			SAXReader saxReader = new SAXReader();
			saxReader.setEntityResolver(
					new EntityResolver() {
						public InputSource resolveEntity(String publicId,String systemId) {
							if (publicId.equals("-//Apache Software Foundation//DTD Struts Configuration 2.0//EN")) {
								InputStream in = getClass().getResourceAsStream("/struts-2.0.dtd");
								return new InputSource(in);
							}
							return null;
						}
					});
			if(log.isDebugEnabled()) log.debug("SAXReader start");

			//loading XML file
			Document doc = saxReader.read(confStream);
			Element root = doc.getRootElement();
			
			//cache configure
			caches = new HashMap<String, Cache>();
			Iterator<?> itrCache = root.selectNodes("package/cache").iterator();
			Element cacheNode;
			String value = "K";

			while (itrCache.hasNext()) {
				cacheNode = (Element) itrCache.next();

				int size = Integer.valueOf(cacheNode.attributeValue("size"))
						.intValue();
				value = cacheNode.attributeValue("sizeUnit");
				if (value.equals("K"))
					size = size * CacheManager.K;
				else if (value.equals("M"))
					size = size * CacheManager.M;

				int time = Integer.valueOf(cacheNode.attributeValue("time")).intValue();
				
				value = cacheNode.attributeValue("timeUnit");
				
				if (value.equals("SECOND"))
					time = time * CacheManager.SECOND;
				else if (value.equals("MINUTE"))
					time = time * CacheManager.MINUTE;
				else if (value.equals("HOUR"))
					time = time * CacheManager.HOUR;

				caches.put(cacheNode.attributeValue("name"), new Cache(size,time));
			}

			//parse action methods
			actionMap = new HashMap<String, ActionNode>();
			Iterator<?> itrAction = root.selectNodes("package/action").iterator();

			Element actionNode;
			Element methodNode;
			ActionNode aNode;
			String action;
			while (itrAction.hasNext()) {
				aNode = new ActionNode();

				actionNode = (Element) itrAction.next();
				// set filed
				action = actionNode.attributeValue("name");
				aNode.setName(action);
				aNode.setCls(actionNode.attributeValue("class"));
				aNode.setDefMethod(actionNode.attributeValue("default"));
				// System.out.println("----------"+action+"----------");
				for (Iterator<?> itrResult = actionNode.selectNodes("result")
						.iterator(); itrResult.hasNext();) {
					methodNode = (Element) itrResult.next();

					boolean allow = false;
					
					value = methodNode.attributeValue("allow");
					
					if(value!=null && value.equals("true"))
						allow = true;
					
					aNode.addResult(methodNode.attributeValue("name"),
							new MethodNode(methodNode.attributeValue("name"),methodNode.getTextTrim(),allow));
					
//					System.out.println(methodNode.attributeValue("name")+":"+methodNode.getTextTrim()+":"+allow+":"+value);
				}
				actionMap.put(action, aNode);
			}
			
			//plugins configure
			Iterator<?> itrAuth = root.selectNodes("package/plugins").iterator();
			Element plugNode;
			String plugName;
			while (itrAuth.hasNext()) {
				plugNode = (Element) itrAuth.next();
				plugName = plugNode.attributeValue("name");
				if(plugName.equals("Auth")){
					value = plugNode.attributeValue("enable");
					if(value.equals("true")){
						enableAuth = true;
					}else{
						enableAuth = false;
					}
				}
			}
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
	
	public void printConf() {
		try {
			Iterator<?> iterator;
			String key;
			ActionNode action;

			System.out.println(".............XML...........");

			iterator = actionMap.keySet().iterator();
			while (iterator.hasNext()) {
				key = iterator.next().toString();
				System.out.println("............." + key + "...........");

				action = (ActionNode) actionMap.get(key);
				System.out.println("name=" + action.getName() + " class="
						+ action.getCls());
				Hashtable<String, MethodNode> results = action.getResults();
				Iterator<?> resultIterator = results.keySet().iterator();
				while (resultIterator.hasNext()) {
					key = resultIterator.next().toString();
					System.out.println("result key=" + key + " value="
							+ results.get(key));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
