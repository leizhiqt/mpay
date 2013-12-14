package com.mooo.mycoz.framework.util;

import java.io.File;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.TimeZone;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.mooo.mycoz.common.CalendarUtils;
import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.DbConfig;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.pool.DbConnectionManager;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineBranch.WineJar;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineBranch.WineryMap;
import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;

public class IDGenerator {
	private static final String SELECT_MAX_BY_TABLE = "SELECT MAX(ID) maxid FROM ";

	private static final String prefix = null;

	public synchronized static int getNextID(Connection conn, String table) {
		boolean notConn = false;

		PreparedStatement pstmt = null;
		ResultSet result = null;
		int nextId = 0;
		try {
			if (conn == null) {
				notConn = true;
				conn = DbConnectionManager.getConnection();
			}

			pstmt = conn.prepareStatement(SELECT_MAX_BY_TABLE + table);
			result = pstmt.executeQuery();
			while (result.next()) {
				nextId = result.getInt(1);
			}

			nextId++;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (result != null)
					result.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

			try {
				if (pstmt != null)
					pstmt.close();

				if (notConn) {
					if (conn != null)
						conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return nextId;
	} // getNextID(String table)

	public static int getNextID(Connection conn, Class<?> clazz) {
		String catalog = DbConfig.getProperty(clazz.getPackage().getName());
		String table = StringUtils.upperToPrefix(clazz.getSimpleName(), prefix);
		return getNextID(conn, catalog + "." + table);
	}

	public synchronized static String getMaxPrefix(Connection conn,
			String table, String field, String prefix) {
		boolean notConn = false;
		PreparedStatement pstmt = null;
		ResultSet result = null;

		String maxN = "";
		try {
			if (conn == null) {
				notConn = true;
				conn = DbConnectionManager.getConnection();
			}

			pstmt = conn.prepareStatement("SELECT MAX(" + field + ") nowCode FROM " + table + " WHERE " + field + " LIKE ?");
			pstmt.setString(1, prefix + "%");

			result = pstmt.executeQuery();
			while (result.next()) {
				maxN = result.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (result != null)
					result.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

			try {
				if (pstmt != null)
					pstmt.close();

				if (notConn) {
					if (conn != null)
						conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return maxN;
	}

	public synchronized static String getMaxForgeryCode() {
		String maxN = "";

		String prefix = "SCYJPT";

		if (prefix == null || prefix.length() > 6) {
			prefix = "000000";
		} else if (prefix.length() > 0 && prefix.length() < 6) {
			for (int i = prefix.length(); i < 6; i++) {
				prefix += "0";
			}
		}

		String nowDate = CalendarUtils.dformat2(Calendar.getInstance()
				.getTime());

		if (nowDate == null || nowDate.length() != 6)
			nowDate = "000000";

		String tmpS = prefix + nowDate;

		maxN = getMaxPrefix(null, "ForgeryCode", "forgeryCode", tmpS);

		String tmpN = "00001";

		if (maxN != null && maxN.length() == 17) {
			tmpN = maxN.substring(12);

			int number = new Integer(tmpN);

			number++;

			if (number < 10) {
				tmpN = "0000" + number;
			} else if (number < 100) {
				tmpN = "000" + number;
			} else if (number < 1000) {
				tmpN = "00" + number;
			} else if (number < 10000) {
				tmpN = "0" + number;
			} else {
				tmpN = "" + number;
			}
		}

		return tmpS + tmpN;
	}

	public static void generateBarcodeImage(String contents, int width,
			int height, String imgPath) {
		int codeWidth = 3 + // start guard
				(7 * 6) + // left bars
				5 + // middle guard
				(7 * 6) + // right bars
				3; // end guard
		codeWidth = Math.max(codeWidth, width);
		try {
			BitMatrix bitMatrix = new MultiFormatWriter().encode(contents,
					BarcodeFormat.EAN_13, codeWidth, height, null);

			MatrixToImageWriter
					.writeToFile(bitMatrix, "JPEG", new File(imgPath));

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/*
	 * 商品条码的含义：    分为4个部分，从左到右分别为：  
	 * 1-3位：共3位，对应该条码的693，是中国的国家代码之一。（690--695都是中国的代码，由国际上分配）；  
	 * 4-8位：共5位，对应该条码的69838，代表着生产厂商代码，由厂商申请，国家分配；  
	 * 9-12位：共4位，对应该条码的0001，代表着厂内商品代码，由厂商自行确定；  
	 * 第13位：共1位，对应该条码的3，是校验码，依据一定的算法，由前面12位数字计算而得到。 其算法： 
	 * 从代码位置序号2开始，所有偶数位的数字代码求和为a。  将上步中的a乘以3为a。  
	 * 从代码位置序号3开始，所有奇数位的数字代码求和为b。  将a和b相加为c。  取c的个位数d。   用10减去d即为校验位数值。  
	 * 例：234235654652的校验码的计算如下表：          数据码 校验码  
	 * 代码位置序号 13 12 11 10 9 8 7 6 5 4 3 2 1   数字码  2  3  4  2 
	 * 3 5 6 5 4 6 5 2 ？   偶数位  3+ 2 + 5 + 5 + 6 + 2   奇数位 
	 * 2 + 4 + 3 + 5 + 4 + 5    步骤1：3+2+5+5+6+2=23    步骤2：23*3=69   
	 * 步骤3：2+4+3+5+4+5=23    步骤4：69+23=92    步骤5：10-2=8    步骤6：校验码为 8   
	 */
	/**
	 * 
	 * @param countryCode
	 *            共3位，对应该条码的693，是中国的国家代码之一。
	 * @param enterpriseCode
	 *            共5位，对应该条码的69838，代表着生产厂商代码，由厂商申请，国家分配
	 * @param productCode
	 *            共4位，对应该条码的0001，代表着厂内商品代码，由厂商自行确定
	 * @return
	 */
	public synchronized static String getBarcode(String countryCode,
			String enterpriseCode, String productCode) {

		String code = countryCode + enterpriseCode + productCode + "*";

		int c1 = 0;
		int c2 = 0;
		for (int i = 0; i < 12; i += 2) {
			char c = code.charAt(i);
			int n = Integer.valueOf(Character.toString(c));
			c1 += n;
		}
		for (int i = 1; i < 12; i += 2) {
			char c = code.charAt(i);
			int n = Integer.valueOf(Character.toString(c));
			c2 += n;
		}
		int cc = c1 + c2 * 3;
		int check = (10 - cc % 10) % 10;

		return code.replace("*", String.valueOf(check));
	}

	public static long getNextInt(String table) {
		return getNextID(null, table);
	}

	public static int getNextInt(String catalog, String table) {
		return getNextID(null, catalog + "." + table);
	}

	public static int getNextInt(Class<?> clazz) {
		String catalog = DbConfig.getProperty(clazz.getPackage().getName());
		String table = StringUtils.upperToPrefix(clazz.getSimpleName(), prefix);
		return getNextID(null, catalog + "." + table);
	}

	/*
	 * getValues
	 */
	public synchronized static Map<Integer, String> getValues(String catalog,
			String table, String key, String value) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		Map<Integer, String> values = new LinkedHashMap<Integer, String>();
		try {
			String sql = "SELECT ";

			if (StringUtils.isNull(key) || StringUtils.isNull(value)) {
				sql += "id,definition";
			} else {
				sql += key + "," + value;
			}

			if (!StringUtils.isNull(catalog)) {
				sql += " FROM " + catalog + ".";
			}

			if (!StringUtils.isNull(table)) {
				sql += table;
			}

			sql += " ORDER BY id";

			conn = DbConnectionManager.getConnection();
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				values.put(rs.getInt(1), rs.getString(2));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return values;
	}

	/*
	 * getValues
	 */
	public synchronized static String getBranchs(String catalog, String table,
			String key, String value) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		Map<Integer, String> values = new LinkedHashMap<Integer, String>();
		try {
			String sql = "SELECT ";

			if (StringUtils.isNull(key) || StringUtils.isNull(value)) {
				sql += "id,definition";
			} else {
				sql += key + "," + value;
			}

			if (!StringUtils.isNull(catalog)) {
				sql += " FROM " + catalog + ".";
			}

			if (!StringUtils.isNull(table)) {
				sql += table;
			}

			sql += " ORDER BY id";

			conn = DbConnectionManager.getConnection();
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				values.put(rs.getInt(1), rs.getString(2));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return null;
	}

	public synchronized static Map<Integer, String> getValues(Class<?> clazz) {
		return getValues(clazz, "id", "definition");
	}

	public synchronized static Map<Integer, String> getValues(Class<?> clazz,
			String key, String value) {
		String catalog = DbConfig.getProperty(clazz.getPackage().getName());
		String table = StringUtils.upperToPrefix(clazz.getSimpleName(), prefix);
		return getValues(catalog, table, key, value);
	}

	public static List<?> search(Class<?> clazz) {
		List<?> searchList = null;
		try {
			Object obj = clazz.newInstance();
			Method execMethod = clazz.getMethod("searchAndRetrieveList");
			searchList = (List<?>) execMethod.invoke(obj);
		} catch (NullPointerException e) {
			e.printStackTrace();
		} catch (RuntimeException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} catch (Throwable e) {
			e.printStackTrace();
		} finally {
		}
		return searchList;
	}

	public synchronized static String getBranchCategory(int sessionId) {
		String category = null;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(User.class, "user");
			dbobject.addTable(Branch.class, "branch");
			dbobject.addTable(BranchCategory.class, "branchCategory");

			dbobject.setForeignKey("branch", "categoryId", "branchCategory",
					"id");
			dbobject.setForeignKey("user", "branchId", "branch", "id");

			dbobject.setField("user", "id", sessionId);

			dbobject.setRetrieveField("branchCategory", "id");
			dbobject.setRetrieveField("branchCategory", "abbreviation");

			List results = dbobject.searchAndRetrieveList();
			for (Object obj : results) {
				Map row = (Map) obj;
				BranchCategory branchCategory = (BranchCategory) row
						.get("branchCategory");
				category = branchCategory.getAbbreviation();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return category;
	}

	public synchronized static List<?> getWineryValues(int sessionId,
			boolean enable) {
		List<?> retrieveList = null;
		try {
			String category = getBranchCategory(sessionId);

			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(Winery.class, "winery");
			if (enable)
				dbobject.addCustomWhereClause("(winery.stateId=2 OR winery.stateId=4)");
			
			if(StringUtils.isNull(category)) category="";
			
			if (category.equals("Regulators")) {
				dbobject.addTable(WineryMap.class, "wineryMap");
				dbobject.setForeignKey("winery", "id", "wineryMap", "wineryId");

				dbobject.setField("wineryMap", "userId", sessionId);
			} else if ( category.equals("Bank")) {
				dbobject.addTable(WineJar.class, "wineJar");
				dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
				dbobject.setForeignKey("wineJar", "branchId", "winery",
						"branchId");

				dbobject.setField("wineJar", "bankId", sessionId);
				dbobject.setGroupBy("winery", "id");
			}/*else if(category.equals("Tasting")){
				User user = new User();
				user.setId(sessionId);
				user.retrieve();
				
				dbobject.setField("winery", "branchId", user.getBranchId());
			}*/
			dbobject.setOrderBy("winery", "id","DESC");
			
			dbobject.setRetrieveField("winery", "id");
			dbobject.setRetrieveField("winery", "enterpriseName");

			retrieveList = dbobject.searchAndRetrieveList();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return retrieveList;
	}

	public synchronized static List<?> getWineryValues(int sessionId) {
		return getWineryValues(sessionId, false);
	}

	public static Object randomNo(Class<?> clazz) {
		List<?> searchList = search(clazz);
		Random random = new Random();
		int randomId = searchList.size();
		if (randomId > 0) {
			random.nextInt(randomId);
			return searchList.get(randomId);
		} else {
			randomId = 0;
		}
		return 0;
	}

	public static int randomInt(int max) {
		if (max > 0)
			return new Random().nextInt(max);

		return 0;
	}

	public static Object randomNo(List<?> retrieveList) {
		Random random = new Random();
		int randomId = retrieveList.size();
		if (randomId > 0) {
			random.nextInt(randomId);
			return retrieveList.get(randomId);
		} else {
			randomId = 0;
		}
		return 0;
	}

	public static Date randomDate() {
		Date randomDate = new Date();
		Random random = new Random();

		Calendar cal = Calendar.getInstance();
		cal.set(2010, 8, 1);
		long start = cal.getTimeInMillis();
		cal.set(2010, 9, 13);
		long end = cal.getTimeInMillis();
		for (int i = 0; i < 10; i++) {
			randomDate = new Date(start
					+ (long) (random.nextDouble() * (end - start)));
		}

		return randomDate;
	}

	public static String getIdPrifix() {
		TimeZone tz = TimeZone.getDefault();
		Calendar now = Calendar.getInstance(tz);
		String prefix = now.toString();
		int tmp = now.get(Calendar.YEAR);
		prefix = (tmp + "").substring(2, 4);
		tmp = now.get(Calendar.MONTH) + 1;
		if (tmp < 10)
			prefix += "0" + tmp;
		else
			prefix += tmp;

		return prefix;
	}

	public static String getYYMM() {
		return getIdPrifix();
	}

	public static String getYY() {
		TimeZone tz = TimeZone.getDefault();
		Calendar now = Calendar.getInstance(tz);
		String prefix = now.toString();
		int tmp = now.get(Calendar.YEAR);
		prefix = (tmp + "").substring(2, 4);

		return prefix;
	}

	public static Date getDate() {

		TimeZone tz = TimeZone.getDefault();
		Calendar now = Calendar.getInstance(tz);
		Date date = now.getTime();

		return date;
	}

	public static String getNowTime() {
		SimpleDateFormat ft = new SimpleDateFormat("HH:mm");

		return ft.format(getDate());
	}

	public static String getNowYear() {
		SimpleDateFormat ft = new SimpleDateFormat("yyyy");

		return ft.format(getDate());
	}

	public static String getNow() {
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd HH:mm");

		return ft.format(getDate());
	}

	public static String getLastMonthToday() {

		// get default date in yyyy-mm-dd format
		TimeZone tz = TimeZone.getDefault();
		// tz.setID("Asia/Jakarta");
		Calendar now = Calendar.getInstance(tz);
		String prefix;
		int yy = now.get(Calendar.YEAR);
		int tmp = now.get(Calendar.MONTH);
		if (tmp == 0) {
			prefix = (yy - 1) + "";
			tmp = 12;
		} else {
			prefix = yy + "";
		}
		if (tmp < 10)
			prefix += "-0" + tmp;
		else
			prefix += "-" + tmp;

		tmp = now.get(Calendar.DATE);
		if (tmp < 10)
			prefix += "-0" + tmp;
		else
			prefix += "-" + tmp;

		return prefix;
	} /* getLastMonthToday() */

	public static String getToday() {

		// get default date in yyyy-mm-dd format
		TimeZone tz = TimeZone.getDefault();
		Calendar now = Calendar.getInstance(tz);
		String prefix = now.toString();
		int tmp = now.get(Calendar.YEAR);
		prefix = tmp + "";
		tmp = now.get(Calendar.MONTH) + 1;
		if (tmp < 10)
			prefix += "-0" + tmp;
		else
			prefix += "-" + tmp;

		tmp = now.get(Calendar.DATE);
		if (tmp < 10)
			prefix += "-0" + tmp;
		else
			prefix += "-" + tmp;

		return prefix;
	} /* getToday() */

	public static HashMap<String, String> getReportTypes() {

		HashMap<String, String> lMap = new LinkedHashMap<String, String>();
		lMap.put(null, "--select--");
		lMap.put("Debit", "Debit");
		lMap.put("Credit", "Credit");
		lMap.put("Receipt", "Receipt");
		lMap.put("Defrayment", "Defrayment");

		return lMap;
	} // getDCValues()

	public static Map<?, ?> getSexs() {
		HashMap<Object, Object> sexs = new HashMap<Object, Object>();
		sexs.put("Male", "Male");
		sexs.put("Female", "Female");
		return sexs;
	}

	public static Map<?, ?> getEnables() {
		HashMap<Object, Object> sexs = new HashMap<Object, Object>();
		sexs.put("Yes", "Yes");
		sexs.put("No", "No");
		return sexs;
	}

	public static Map<String, String> getJobStates() {
		HashMap<String, String> states = new LinkedHashMap<String, String>();
		states.put("Create", "Create");
		states.put("Working", "Working");
		states.put("Finish", "Finish");
		states.put("Cancel", "Cancel");
		return states;
	}

	public static Map<String, String> getBarcodePoints() {
		HashMap<String, String> states = new LinkedHashMap<String, String>();
		states.put("Create", "Create");
		states.put("Working", "Working");
		states.put("Finish", "Finish");
		states.put("Cancel", "Cancel");
		return states;
	}

	public static Map<String, String> getDcType() {
		HashMap<String, String> types = new LinkedHashMap<String, String>();
		types.put("Debit", "Debit");
		types.put("Credit", "Credit");
		return types;
	}

	public static String getNowSN() {

		String nowDate = CalendarUtils.dformat2(Calendar.getInstance().getTime());
		
		if(nowDate==null || nowDate.length()!=6)
			nowDate="000000";
		
        return nowDate;
	}
	
	public static String getBatchSN(String prefix,int preSize) {

		if(prefix==null || prefix.length()>preSize){
			prefix="000000";
		}else if(prefix.length()>0 && prefix.length()<preSize){
			for(int i=prefix.length();i<preSize;i++){
				prefix +="0";
			}
		}
		
		String nowDate = CalendarUtils.dformat2(Calendar.getInstance().getTime());
		
		if(nowDate==null || nowDate.length()!=6)
			nowDate="000000";
		
		prefix = prefix+nowDate;
        
        return prefix;
	}
	
	public static String getSN(Connection conn,Class<?> clazz,String field,String prefix) {
		return getSN(conn,clazz,field,prefix,16,4);
	}

	public static String getSN(Connection conn,Class<?> clazz,String field,String prefix,int snMax,int snLength) {

		
		String sn = "";
		for(int i=0;i<snLength;i++){
			sn +="0";
		}
		
		DecimalFormat df = new DecimalFormat(sn); 

		String exitsSN = getMaxPrefix(conn,clazz.getSimpleName(), field, prefix);
		
       if(exitsSN!=null && exitsSN.length()==snMax){
			sn = exitsSN.substring(snMax-snLength);
			int number = new Integer(sn);
			
			number++;
			
			sn = df.format(number);
        }else{
			sn = df.format(1);
        }
        
        return prefix+sn;
	}
}
