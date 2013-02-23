package com.mooo.mycoz.test;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.TimeZone;
import java.util.UUID;

import com.mooo.mycoz.db.DbBridgingBean;
import com.mooo.mycoz.db.pool.DbConnectionManager;
import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.dbobj.wineShared.FinancialProduct;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
//		long startTime = System.currentTimeMillis();
//		
//		long finishTime = startTime;
//		long hours = 0;
//		long minutes = 0;
//		long seconds = 0;
//		
//		List random = new Test().randomSubset(1000000,100000);
//		for(int i=0;i<random.size();i++){
//			System.out.println(random.get(i));
//		}
//		
//		finishTime = System.currentTimeMillis();
//		hours = (finishTime - startTime) / 1000 / 60 / 60;
//		minutes = (finishTime - startTime) / 1000 / 60 - hours * 60;
//		seconds = (finishTime - startTime) / 1000 - hours * 60 * 60 - minutes * 60;
//		
//		System.out.println("finishTime:   "+(finishTime - startTime));
//		System.out.println("count expends:   " + hours + ":" + minutes + ":" + seconds);
		
		
		Test t = new Test();
//		t.dbTools();
		t.test();
	}

    /** 
     * 随机排序 
     * @param list 要进行随机排序的数据集合 
     * @return 排序结果 
     */  
    public static int[] getList(int[] list){  
        //数组长度  
        int count = list.length;  
        //结果集  
        int[] resultList = new int[count];  
        //用一个LinkedList作为中介  
        LinkedList<Integer> temp = new LinkedList<Integer>();  
        //初始化temp  
        for(int i = 0; i<count; i++){  
            temp.add((Integer)list[i]);
        }  
        //取数
        Random rand = new Random();  
        for(int i = 0;i<count; i++){  
            int num = rand.nextInt(count - i);  
            resultList[i] = (Integer) temp.get(num);  
            temp.remove(num);  
        }  
          
        return resultList;  
    }  
    
	public void romd(){
//		long l = 100000000000L;
		long startTime = System.currentTimeMillis();
		
		long finishTime = startTime;
		long hours = 0;
		long minutes = 0;
		long seconds = 0;
		
		int maxPore = 10000000;
		int maxGrou = 1000000;

		int[] list = new int[maxPore];
		for(int i=0; i<maxPore; i++){  
			list[i]=i;
		}
//		
		int[] result = getList(list);
		
		//2147483647=2^32*2^4 Integer.MAX_VALUE
//		for(int i=0; i<result.length; i++){  
//		    System.out.println("["+result[i]+"] ");  
//		}
		
		for(int i=0; i<1E6; i++){  
			System.out.println("["+Math.abs((long) (Math.random()*1.844674407E+19))+"] ");
		}
		
//		System.out.println("["+Math.abs((long) (Math.random()*1.844674407E+19))+"] ");
//		System.out.println(Long.MAX_VALUE);

//		BigInteger b1 = new BigInteger(1.844674407E+40);
		
//		BigInteger b1 = new BigInteger("1.844674407E40");
//		BigInteger b2 = new BigInteger("1.844674407E80");

//		System.out.println(b1.add(b2));

//		System.out.println();
//		Math.abs((long) (Math.random()*100000000000L));
		
		finishTime = System.currentTimeMillis();
		hours = (finishTime - startTime) / 1000 / 60 / 60;
		minutes = (finishTime - startTime) / 1000 / 60 - hours * 60;
		seconds = (finishTime - startTime) / 1000 - hours * 60 * 60 - minutes * 60;
		
		System.out.println("finishTime:   "+(finishTime - startTime));
		System.out.println("count expends:   " + hours + ":" + minutes + ":" + seconds);

	}
	
	public List randomSubset(int n,int m){
		long startTime = System.currentTimeMillis();
		
		long finishTime = startTime;
		long hours = 0;
		long minutes = 0;
		long seconds = 0;

		List total = new LinkedList();
		List subSet = new ArrayList();
		
		for(int i=0;i<n;i++){
			total.add(i);
		}
		
		int k=0;
		for(int i=0;i<m;i++){
			k = total.size();
			k = (int) Math.abs(Math.random()*(k-1));
			subSet.add(total.get(k));
			total.remove(k);
		}
		
		finishTime = System.currentTimeMillis();
		hours = (finishTime - startTime) / 1000 / 60 / 60;
		minutes = (finishTime - startTime) / 1000 / 60 - hours * 60;
		seconds = (finishTime - startTime) / 1000 - hours * 60 * 60 - minutes * 60;
		
		System.out.println("finishTime:   "+(finishTime - startTime));
		System.out.println("count expends:   " + hours + ":" + minutes + ":" + seconds);
		
		return subSet;
	}
	
	public void uuid(){
		long startTime = System.currentTimeMillis();
		
		long finishTime = startTime;
		long hours = 0;
		long minutes = 0;
		long seconds = 0;
		UUID uuid = UUID.randomUUID();
		
		System.out.println(uuid);

		finishTime = System.currentTimeMillis();
		hours = (finishTime - startTime) / 1000 / 60 / 60;
		minutes = (finishTime - startTime) / 1000 / 60 - hours * 60;
		seconds = (finishTime - startTime) / 1000 - hours * 60 * 60 - minutes * 60;
		
		System.out.println("finishTime:   "+(finishTime - startTime));
		System.out.println("count expends:   " + hours + ":" + minutes + ":" + seconds);

	}
	
	public void db(){
		String[] ids = TimeZone.getAvailableIDs();

		for(int i=0;i<ids.length;i++){
			System.out.println(ids[i]);

		}
		
		System.out.println(TimeZone.getDefault().getID());

//		"Asia/Chongqing"
		
		try {
			Branch branch = new Branch();
//			branch.setId(11);
//			branch.setBranchId(3);
//			branch.delete();
			branch.setWhereIn("id", "14,15,16");
//			branch.setRecord(1,24);
//			branch.addGroupBy("id");
//			branch.addOrderBy("id");
//			
			List<Object> retrieveList = branch.searchAndRetrieveList();
			
			for(Object bean:retrieveList){
				branch = (Branch)bean;
				System.out.println(branch.getDefinition());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void dbTools() {
		DbBridgingBean bd = new DbBridgingBean();
//		bd.dbToBean("wineBranch","StorageAccount");
//		bd.dbToBean("wineBranch","StorageDetail");
//		bd.dbToBean("wineBranch","SampleProduct");
//		bd.dbToBean("wineBranch","SampleItem");
//		bd.dbToBean("wineBranch","SampleTasting");
		//bd.dbToBean("wineBranch","SampleTest");
		
		//bd.dbToBean("payShared","Certificate");
//		bd.dbToBean("payShared","FinancialProduct");
//		bd.dbToBean("payBranch","AddressBook");
//		bd.dbToBean("payBranch","Client");
//		bd.dbToBean("payBranch","ClientJob");
//		bd.dbToBean("payBranch","ClientJobSale");
//		bd.dbToBean("payBranch","StoreProduct");
//		bd.dbToBean("payBranch","StoreUser");

//		bd.dbToBean("payShared","JobCheck");
		bd.dbToBean("payBranch","Bank");

//		bd.dbToBean("payShared","Store");
//		bd.dbToBean("payShared","StoreType");
//		bd.dbToBean("payShared","FinancialProduct");

		
//		bd.dbToBean("payBranch","ClientJobTrack");
		
//		bd.dbToBean("wineBranch","Product");

//		bd.dbToBean("wineBranch","Sale");
//		bd.dbToBean("wineBranch","SaleItem");
//		bd.dbToBean("wineBranch","SaleJob");
		
//		bd.dbToBean("wineShared","WarehouseItem");
//		bd.dbToBean("wineShared","WineJarState");
//		bd.dbToBean("wineShared","WineTaster");
		
//		DbTools dbTools = new DbTools();
//		dbTools.exportDb();
	/*	FinancialProduct bean = new FinancialProduct();
		try {
			Method getMethod = bean.getClass().getMethod("getCreditRate");
			System.out.println(getMethod.getName());
			
			Class<?> cl = getMethod.getReturnType();
			Method setMethod = bean.getClass().getMethod("setCreditRate",new Class[] { cl });

			String value="0.1231";
			
			Method valueOf = cl.getMethod("valueOf",new Class[] { String.class });
			Object valueObj = valueOf.invoke(cl, new Object[] { value });
			setMethod.invoke(bean, new Object[] { valueObj });
			
			Object obj = getMethod.invoke(bean, null);
			System.out.println("obj:"+obj);

//			System.out.println(bean.getClass().getMethods());
//			Method[] ms = bean.getClass().getMethods();
//			for(int i=0;i<ms.length;i++){
//				System.out.println(ms[i].getName()+"/"+ms[i].getReturnType());
//			}
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
*/
	}
	
	public void myJdbc(){
		Connection conn = null;
		Statement stmt = null;
		try {
			conn=DbConnectionManager.getConnection();
			stmt = conn.createStatement();
			
			
			String execSQL = "SELECT * FROM Winery winery, WineryMap wineryMap,User user WHERE wineryMap.wineryId=winery.id AND wineryMap.userId=user.id";

			
			ResultSet result = stmt.executeQuery(execSQL);
			
			List<Map<?, ?>> list = new ArrayList<Map<?, ?>>();
			
			while(result.next()){
				Map<?, ?> row = new HashMap<String,Object>();
				
				list.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
					stmt.close();
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}			
		}
	}
	
	
	public void test(){
		SimpleDateFormat dformat = new SimpleDateFormat("yyyy年MM月dd日");
		System.out.println(dformat.format(new Date()));

	}

}
