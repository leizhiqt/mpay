package com.mooo.mycoz.test;

import java.io.IOException;
import java.util.List;
import java.util.Vector;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.dbobj.wineShared.Branch;

public class DBThreadTest {
	
	private static Log log = LogFactory.getLog(DBThreadTest.class);

//	private static Object initLock = new Object();

	private Vector<Thread> threadPool;
	private int maxConnMSec;
	
	public DBThreadTest(int maxConns,double maxConnTime) throws IOException {

		if(log.isDebugEnabled()) log.debug("服务器启动");
		
		threadPool = new Vector<Thread>(maxConns);

		maxConnMSec = (int) (maxConnTime * 86400000.0); // 86400 sec/day
		if (maxConnMSec < 30000 && maxConnMSec > 0) { // Recycle no less than 30 seconds.
			maxConnMSec = 30000;
		}

		try {
			//主线程进入轮询模式
			boolean forever = true;
			while (forever) {
					if(maxConns > 0 && threadPool.size() == maxConns){
						throw new Exception("线程池满");
					}
					
					//计算连接数
					int runCount = 0;
					for (Thread threadObj : threadPool) {
						if (threadObj.isAlive())
							runCount++;
					}
					if(log.isDebugEnabled())log.debug(">>>>>>>>>>>运行线程数:"+ runCount);
					System.out.println(">>>>>>>>>>>运行线程数:"+ runCount);

//					synchronized (initLock) {
//						wait(1000*10); //10 seconds
//					}
					
					//创建子线程
					Thread thread = new Thread(new SessionThread());
					thread.start();
					
					Thread.sleep(500);//wait 500ms
					threadPool.add(thread);
					
					if(log.isDebugEnabled())log.debug("<<<<<<<<<<<<LOOP Watch======");
			}//Loop End
		} catch (InterruptedException e) {
			e.printStackTrace();
			System.out.println("Exception:" + e.getMessage());
			if(log.isDebugEnabled())log.debug("Exception:" + e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception:" + e.getMessage());
			if(log.isDebugEnabled())log.debug("Exception:" + e.getMessage());
		} finally {

		}
		
	}

	/*
	 * 访问子线程
	 */
	class SessionThread implements Runnable {
		
//		public SessionThread() {
//			
//		}

		public void run() {
			try {
				boolean forever = true;
				while (forever){			
					Branch branch = new Branch();
					branch.setLike("abbreviation","");
					branch.setLike("definition","");
					branch.setRecord(1,24);
					
					List<Object> retrieveList = branch.searchAndRetrieveList();
					
					for(Object bean:retrieveList){
						branch = (Branch)bean;
						System.out.println(branch.getDefinition());
					}
					
//					System.out.println("requestLine:");
					//wait input
					//print.print(">");
				}//end while
				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("客户失去连接...");
			} finally {
				
			}
		}//run end
	}
	
	public static void main(String[] args) throws IOException {
		new DBThreadTest(50,0);
	}
}