package com.mooo.mycoz.test;

public class Watch {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		long totle = Runtime.getRuntime().totalMemory()/1024*1024;
		
		long free = Runtime.getRuntime().freeMemory()/1024*1024;
		
		long max = Runtime.getRuntime().maxMemory()/1024*1024;
		
		int activeCount = Thread.activeCount();
		
		System.out.println("totalMemory:"+totle+"M");
		System.out.println("freeMemory:"+free+"M");
		System.out.println("maxMemory:"+max+"M");
		System.out.println("activeCount:"+activeCount);

	}
}
