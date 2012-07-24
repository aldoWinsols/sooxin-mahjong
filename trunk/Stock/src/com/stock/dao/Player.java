package com.stock.dao;

import java.sql.Timestamp;

/**
 * Player entity. @author MyEclipse Persistence Tools
 */

public class Player implements java.io.Serializable {

	// Fields

	private Long id;
	private String playerName;
	private String playerPwd;
	private Double haveMoney;
	private Integer sort;
	private Timestamp timestamp;

	// Constructors

	/** default constructor */
	public Player() {
	}

	/** full constructor */
	public Player(String playerName, String playerPwd, Double haveMoney,
			Integer sort, Timestamp timestamp) {
		this.playerName = playerName;
		this.playerPwd = playerPwd;
		this.haveMoney = haveMoney;
		this.sort = sort;
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

	public Integer getSort() {
		return this.sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public Timestamp getTimestamp() {
		return this.timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

}