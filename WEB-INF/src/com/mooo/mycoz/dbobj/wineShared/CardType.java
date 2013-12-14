package com.mooo.mycoz.dbobj.wineShared;

import com.mooo.mycoz.db.DBObject;

public class CardType extends DBObject  {
	private Integer id;
	private String cardTypeKey;
	private String cardTypeName;
	private String description;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCardTypeKey() {
		return cardTypeKey;
	}
	public void setCardTypeKey(String cardTypeKey) {
		this.cardTypeKey = cardTypeKey;
	}
	public String getCardTypeName() {
		return cardTypeName;
	}
	public void setCardTypeName(String cardTypeName) {
		this.cardTypeName = cardTypeName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}