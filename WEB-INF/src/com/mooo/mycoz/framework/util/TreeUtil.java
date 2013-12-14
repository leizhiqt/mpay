package com.mooo.mycoz.framework.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.dbobj.wineBranch.FileInfo;
import com.mooo.mycoz.dbobj.wineBranch.FileTree;

public class TreeUtil {
	private static Log log = LogFactory.getLog(TreeUtil.class);

	////////////search any node
	public List<FileInfo> getChildList(FileInfo fileInfo) {
		List<FileInfo> childList = new ArrayList<FileInfo>();
		try {

			FileTree fileTree = new FileTree();
			fileTree.setParentId(fileInfo.getId());

			List<Object> retrives = fileTree.searchAndRetrieveList();
			FileTree ft;

			for (Iterator<Object> it = retrives.iterator(); it.hasNext();) {
				ft = (FileTree) it.next();
				FileInfo fi = new FileInfo();
				fi.setId(ft.getChildId());
				
				fi.retrieve();

				if (log.isDebugEnabled()) log.debug("ft id =======" + ft.getId());
				childList.add(fi);
			}
			if (log.isDebugEnabled()) log.debug("Size =======" + retrives.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return childList;
	}
	
	private StringBuilder treeString;
	
	public String buildTree(){
		treeString = new StringBuilder();
		
		treeString.append("<ul id=\"dhtmlgoodies_tree2\" class=\"dhtmlgoodies_tree\">\n");
		treeString.append("<li  id=\"node0\" noDrag=\"true\" noSiblings=\"true\" noDelete=\"true\" noRename=\"true\" > <a href=\"#\">"+"root"+"</a>\n");
		treeString.append("<ul>\n");
		
		try {
		
		FileTree fileTree = new FileTree();
		fileTree.setParentId(0);
		List<Object> retrives = fileTree.searchAndRetrieveList();

		FileTree ft;
		for(Iterator<Object> it = retrives.iterator(); it.hasNext();){
			ft = (FileTree)it.next();

			FileInfo fi = new FileInfo();
			fi.setId(ft.getChildId());
			fi.retrieve();
			
			buildTree(fi);
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		treeString.append("</ul>\n");
		treeString.append("</li>\n");
		treeString.append("</ul>\n");
		
		return treeString.toString();
	}
	
	public void buildTree(FileInfo fileInfo){
		
		String isFolder = fileInfo.getFolder();

		if(isFolder != null && isFolder.equals("Y")){
			treeString.append("<li id=\"node"+fileInfo.getId()+"\"><a href=\"#\" onclick=\"setUpload("+fileInfo.getId()+",'"+fileInfo.getName()+"');\">"
					+fileInfo.getName()+"</a>\n");
			treeString.append("<ul>\n");
		} else {
			treeString.append("<li id=\"node"+fileInfo.getId()+"\""+" noChildren=\"true\" isFolder=\"false\"><a href=\"#\" onclick=\"ajaxRetrieve("+fileInfo.getId()+");\">"
					+fileInfo.getName()+"</a></li>\n");
		}
		
		System.out.println("childs.size() ====== ");

		List<FileInfo> childs  = getChildList(fileInfo);
		if (childs.size() > 0) {
			for (int i = 0; i < childs.size(); i++) {
				buildTree(childs.get(i));
			}
		}
		
		if(isFolder != null && isFolder.equals("Y")){
			treeString.append("</ul>\n");
			treeString.append("</li>\n");
		}
	}
	
	/*
	public static User getParent(User node) {
		User parent = null;
		try {
			parent = new User();
			parent.setId(node.getParentId());
			
			parent.retrieve();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return parent;
	}
	
	public static List<Object> getChilds(int userId) {
		List<Object> users = null;
		try {
			User user = new User();
			user.setParentId(userId);
			users = user.searchAndRetrieveList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}
	
	public static List<Object> getChilds(User node,List<Object> allChilds) {
		try {
			if(allChilds==null) allChilds = new ArrayList();
			
			User user = new User();
			user.setParentId(node.getId());
			List<Object> childs = user.searchAndRetrieveList();
			
			allChilds.addAll(childs);
			
			System.out.println("childs:"+childs);
			System.out.println("childs size:"+childs.size());

			if(childs!=null){
				for(Object bean:childs){
					User child = (User)bean;
					System.out.println(child.getName()+":"+child.getId());
					getChilds(child,allChilds);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return allChilds;
	}

	public static String getChildValues(User node){
		StringBuffer buffer = new StringBuffer();
		try {
			List<Object> childs = getChilds(node,null);
			
			boolean isHead = true;
			User child;
			
			buffer.append(node.getId());
			isHead = false;
			
			for(Object obj:childs){
				if(isHead) {
					isHead = false;
				}else{
					buffer.append(",");
				}
				
				child = (User)obj;
				buffer.append(child.getId());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return buffer.toString();
	}

	public static String getChildValues(int sessionId){
		User node = null;
		try {
			node = new User();
			node.setId(sessionId);
			node.retrieve();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return getChildValues(node);
	}
	*/
}
