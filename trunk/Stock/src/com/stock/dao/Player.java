package com.stock.dao;

import java.sql.Timestamp;

/**
 * Player entity. @author MyEclipse Persistence Tools
 */

public class Player implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String playerName;
	private String playerPwd;
	private Double haveMoney;
	private Double clockMoney;
	private Integer sort;
	private Double xinyongLv;

	// Constructors

	/** default constructor */
	public Player() {
	}

	/** full constructor */
	public Player(String playerName, String playerPwd, Double haveMoney,
			Double clockMoney, Integer sort, Double xinyongLv) {
		this.playerName = playerName;
		this.playerPwd = playerPwd;
		this.haveMoney = haveMoney;
		this.clockMoney = clockMoney;
		this.sort = sort;
		this.xinyongLv = xinyongLv;
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

	public String getPlayerPwd() {
		return this.playerPwd;
	}

	public void setPlayerPwd(String playerPwd) {
		this.playerPwd = playerPwd;
	}

	public Double getHaveMoney() {
		return this.haveMoney;
	}

	public void setHaveMoney(Double haveMoney) {
		this.haveMoney = haveMoney;
	}

	public Double getClockMoney() {
		return this.clockMoney;
	}

	public void setClockMoney(Double clockMoney) {
		this.clockMoney = clockMoney;
	}

	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public Double getXinyongLv() {
		return this.xinyongLv;
	}

	public void setXinyongLv(Double xinyongLv) {
		this.xinyongLv = xinyongLv;
	}

}