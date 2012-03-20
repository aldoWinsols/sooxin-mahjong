package com.panda.dao;

import java.sql.Timestamp;
import java.util.Date;

/**
 * Duihuanlog entity. @author MyEclipse Persistence Tools
 */

public class Duihuanlog implements java.io.Serializable {

	// Fields

	private Long id;
	private String playerName;
	private Date duihuanTime;
	private String itemName;
	private Double duihuanMoney;
	private Double lastHaveMoney;
	private Double nowHaveMoney;
	private String contactName;
	private String contactTel;
	private String contactAddress;
	private Timestamp timestamp;

	// Constructors

	/** default constructor */
	public Duihuanlog() {
	}

	/** full constructor */
	public Duihuanlog(String playerName, Date duihuanTime, String itemName,
			Double duihuanMoney, Double lastHaveMoney, Double nowHaveMoney,
			String contactName, String contactTel, String contactAddress,
			Timestamp timestamp) {
		this.playerName = playerName;
		this.duihuanTime = duihuanTime;
		this.itemName = itemName;
		this.duihuanMoney = duihuanMoney;
		this.lastHaveMoney = lastHaveMoney;
		this.nowHaveMoney = nowHaveMoney;
		this.contactName = contactName;
		this.contactTel = contactTel;
		this.contactAddress = contactAddress;
		this.timestamp = timestamp;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPlayerName() {
		return this.playerName;
	}

	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}

	public Date getDuihuanTime() {
		return this.duihuanTime;
	}

	public void setDuihuanTime(Date duihuanTime) {
		this.duihuanTime = duihuanTime;
	}

	public String getItemName() {
		return this.itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Double getDuihuanMoney() {
		return this.duihuanMoney;
	}

	public void setDuihuanMoney(Double duihuanMoney) {
		this.duihuanMoney = duihuanMoney;
	}

	public Double getLastHaveMoney() {
		return this.lastHaveMoney;
	}

	public void setLastHaveMoney(Double lastHaveMoney) {
		this.lastHaveMoney = lastHaveMoney;
	}

	public Double getNowHaveMoney() {
		return this.nowHaveMoney;
	}

	public void setNowHaveMoney(Double nowHaveMoney) {
		this.nowHaveMoney = nowHaveMoney;
	}

	public String getContactName() {
		return this.contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getContactTel() {
		return this.contactTel;
	}

	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}

	public String getContactAddress() {
		return this.contactAddress;
	}

	public void setContactAddress(String contactAddress) {
		this.contactAddress = contactAddress;
	}

	public Timestamp getTimestamp() {
		return this.timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

}