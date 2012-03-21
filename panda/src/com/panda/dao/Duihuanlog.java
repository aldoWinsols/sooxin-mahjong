package com.panda.dao;

import java.sql.Timestamp;

/**
 * Duihuanlog entity. @author MyEclipse Persistence Tools
 */

public class Duihuanlog implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String playerName;
	private Timestamp duihuanTime;
	private String itemName;
	private Double duihuanMoney;
	private Double lastHaveMoney;
	private Double nowHaveMoney;
	private String contactName;
	private String contactTel;
	private String contactAddress;
	private Integer state;

	// Constructors

	/** default constructor */
	public Duihuanlog() {
	}

	/** full constructor */
	public Duihuanlog(String playerName, Timestamp duihuanTime,
			String itemName, Double duihuanMoney, Double lastHaveMoney,
			Double nowHaveMoney, String contactName, String contactTel,
			String contactAddress, Integer state) {
		this.playerName = playerName;
		this.duihuanTime = duihuanTime;
		this.itemName = itemName;
		this.duihuanMoney = duihuanMoney;
		this.lastHaveMoney = lastHaveMoney;
		this.nowHaveMoney = nowHaveMoney;
		this.contactName = contactName;
		this.contactTel = contactTel;
		this.contactAddress = contactAddress;
		this.state = state;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Timestamp getTimestamp() {
		return this.timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

	public String getPlayerName() {
		return this.playerName;
	}

	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}

	public Timestamp getDuihuanTime() {
		return this.duihuanTime;
	}

	public void setDuihuanTime(Timestamp duihuanTime) {
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

	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

}