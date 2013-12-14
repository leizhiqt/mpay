package com.mooo.mycoz.dbobj;


import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.common.StringUtils;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.dbobj.wineBranch.Card;
import com.mooo.mycoz.dbobj.wineBranch.CardJob;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineBranch.WineJar;
import com.mooo.mycoz.dbobj.wineBranch.Winery;
import com.mooo.mycoz.dbobj.wineShared.CardType;
import com.mooo.mycoz.dbobj.wineShared.JobType;

public class ReportUtil {
	private static Log log = LogFactory.getLog(ReportUtil.class);

	public static int getTotalWineJar(Integer wineryId,Integer branchId) {
		int count = 0;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(Card.class, "card");
			dbobject.addTable(CardJob.class, "cardJob");
			dbobject.addTable(WineJar.class, "wineJar");
			
			dbobject.setForeignKey("wineJar", "id", "card", "wineJarId");
			dbobject.setForeignKey("cardJob", "cardId", "card", "id");
			dbobject.setForeignKey("winery", "id", "card", "wineryId");
			dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");

			dbobject.setField("winery", "id", wineryId);
			dbobject.setField("winery", "branchId", branchId);

			dbobject.setRetrieveField("wineJar", "id");
			
			dbobject.setGroupBy("wineJar", "id");
			
			count = dbobject.count();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return count;
	}
	
	public static int getTotalCard(Integer wineryId,Integer branchId) {
		int count = 0;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(Card.class, "card");
			
			dbobject.setField("card", "wineryId", wineryId);
			dbobject.setField("card", "branchId", branchId);

			dbobject.setRetrieveField("card", "id");
			
			count = dbobject.count();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return count;
	}
	
	public static int getTotalPatrol(Integer wineryId,Integer branchId,String startDate,String endDate) {
		int count = 0;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(CardJob.class, "cardJob");
			dbobject.addTable(Card.class, "card");
			dbobject.addTable(Winery.class, "winery");
			dbobject.addTable(WineJar.class, "wineJar");
			
			dbobject.setForeignKey("card", "wineJarId", "wineJar", "id");
			dbobject.setForeignKey("card", "wineryId", "wineJar", "wineryId");
			dbobject.setForeignKey("card", "branchId", "wineJar", "branchId");
			
			dbobject.setForeignKey("wineJar", "wineryId", "winery", "id");
			dbobject.setForeignKey("wineJar", "branchId", "winery", "branchId");
			
			dbobject.setForeignKey("cardJob", "cardId", "card", "id");
			dbobject.setForeignKey("cardJob", "branchId", "card", "branchId");
	
			dbobject.setGreaterEqual("cardJob", "jobDate", startDate);
			dbobject.setLessEqual("cardJob", "jobDate", endDate);
			
			dbobject.setField("winery", "id", wineryId);
			dbobject.setField("winery", "branchId", branchId);
			dbobject.setField("cardJob", "jobTypeId",3);
			
			dbobject.setRetrieveField("cardJob", "id");
			dbobject.setGroupBy("cardJob", "id");
			
			count = dbobject.count();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return count;
	}
	
	public static int getDisableCard(Integer wineryId,Integer branchId,String startDate,String endDate) {
		int count = 0;
		try {
			Card card = new Card();
			card.setWineryId(wineryId);
			card.setBranchId(branchId);
			
			List cards = card.searchAndRetrieveList();
			
			for(Object bean:cards){
				card = (Card)bean;
				
				MultiDBObject dbobject = new MultiDBObject();
				dbobject.addTable(Card.class, "card");
				dbobject.addTable(CardJob.class, "cardJob");
				
				dbobject.setForeignKey("card", "id", "cardJob", "cardId");
				dbobject.setForeignKey("card", "branchId","cardJob", "branchId");

				dbobject.setGreaterEqual("cardJob", "jobDate", startDate);
				dbobject.setLessEqual("cardJob", "jobDate", endDate);
				
				dbobject.setField("cardJob", "jobTypeId",3);

				dbobject.setField("card", "id",card.getId());
				dbobject.setField("card", "branchId",card.getBranchId());
				
				dbobject.setRetrieveField("cardJob", "id");
				
				if(dbobject.count()==0) count++;
			}
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return count;
	}
	
	public static int getDisableWineJar(Integer wineryId,Integer branchId,String startDate,String endDate) {
		int count = 0;
		try {
			WineJar wineJar = new WineJar();
			wineJar.setWineryId(wineryId);
			wineJar.setBranchId(branchId);

			List wineJars = wineJar.searchAndRetrieveList();
			
			for(Object bean:wineJars){
				wineJar = (WineJar)bean;
				
				MultiDBObject dbobject = new MultiDBObject();
				dbobject.addTable(Card.class, "card");
				dbobject.addTable(CardJob.class, "cardJob");
				
				dbobject.setForeignKey("card", "id", "cardJob", "cardId");
				dbobject.setForeignKey("card", "branchId", "cardJob", "branchId");

				dbobject.setField("card", "wineryId",wineryId);
				dbobject.setField("card", "wineJarId",wineJar.getId());
				dbobject.setField("card", "branchId",wineJar.getBranchId());

				dbobject.setGreaterEqual("cardJob", "jobDate", startDate);
				dbobject.setLessEqual("cardJob", "jobDate", endDate);
				
				dbobject.setRetrieveField("cardJob", "id");
				
				if(dbobject.count()==0) count++;
			}
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return count;
	}
	
	public static int getTotalCardByJar(Integer wineJarId,String startDate,String endDate) {
		int count = 0;
		try {
			MultiDBObject dbobject = new MultiDBObject();
			
			dbobject.addTable(Card.class, "card");
			dbobject.addTable(CardJob.class, "cardJob");
			dbobject.addTable(WineJar.class, "wineJar");
			
			dbobject.setForeignKey("wineJar", "id", "card", "wineJarId");
			dbobject.setForeignKey("card", "id", "cardJob", "cardId");

			dbobject.setField("wineJar", "id",wineJarId);
			
			dbobject.setGreaterEqual("cardJob", "jobDate", startDate);
			dbobject.setLessEqual("cardJob", "jobDate", endDate);
			
			dbobject.setRetrieveField("wineJar", "id");
			
			dbobject.setGroupBy("cardJob", "id");
			
			count = dbobject.count();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
		}
		return count;
	}
}
