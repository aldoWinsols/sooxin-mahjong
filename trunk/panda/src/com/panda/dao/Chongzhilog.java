package com.panda.dao;

import java.sql.Timestamp;

/**
 * Chongzhilog entity. @author MyEclipse Persistence Tools
 */

public class Chongzhilog implements java.io.Serializable {

	// Fields

	private Long id;
	private String playerName;
	private Double chongzhiMoney;
	private Double lastHaveMoney;
	private Double nowHaveMoney;
	private Timestamp timestamp;

	// Constructors

	/** default constructor */
	public Chongzhilog() {
	}

	/** full constructor */
	public Chongzhilog(String playerName, Double chongzhiMoney,
			Double lastHaveMoney, Double nowHaveMoney, Timestamp timestamp) {
		this.playerName = playerName;
		this.chongzhiMoney = chongzhiMoney;
		this.lastHaveMoney = lastHaveMoney;
		this.nowHaveMoney = nowHaveMoney;
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

	public Timestamp getTimestamp() {
		return this.timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

}