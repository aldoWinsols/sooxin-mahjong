package com.panda.dao;

import java.sql.Timestamp;

/**
 * Chongzhilog entity. @author MyEclipse Persistence Tools
 */

public class Chongzhilog implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String playerName;
	private Timestamp chongzhiTime;
	private Double chongzhiMoney;
	private Double lastHaveMoney;
	private Double nowHaveMoney;

	// Constructors

	/** default constructor */
	public Chongzhilog() {
	}

	/** full constructor */
	public Chongzhilog(String playerName, Timestamp chongzhiTime,
			Double chongzhiMoney, Double lastHaveMoney, Double nowHaveMoney) {
		this.playerName = playerName;
		this.chongzhiTime = chongzhiTime;
		this.chongzhiMoney = chongzhiMoney;
		this.lastHaveMoney = lastHaveMoney;
		this.nowHaveMoney = nowHaveMoney;
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

	public Timestamp getChongzhiTime() {
		return this.chongzhiTime;
	}

	public void setChongzhiTime(Timestamp chongzhiTime) {
		this.chongzhiTime = chongzhiTime;
	}

	public Double getChongzhiMoney() {
		return this.chongzhiMoney;
	}

	public void setChongzhiMoney(Double chongzhiMoney) {
		this.chongzhiMoney = chongzhiMoney;
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

}