package com.panda.dao;

import java.sql.Timestamp;

/**
 * Gamehistory entity. @author MyEclipse Persistence Tools
 */

public class Gamehistory implements java.io.Serializable {

	// Fields

	private Long id;
	private String playerName;
	private Double lastMoney;
	private Double nowMoney;
	private String gameContent;
	private Timestamp timestamp;

	// Constructors

	/** default constructor */
	public Gamehistory() {
	}

	/** full constructor */
	public Gamehistory(String playerName, Double lastMoney, Double nowMoney,
			String gameContent, Timestamp timestamp) {
		this.playerName = playerName;
		this.lastMoney = lastMoney;
		this.nowMoney = nowMoney;
		this.gameContent = gameContent;
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

	public Double getLastMoney() {
		return this.lastMoney;
	}

	public void setLastMoney(Double lastMoney) {
		this.lastMoney = lastMoney;
	}

	public Double getNowMoney() {
		return this.nowMoney;
	}

	public void setNowMoney(Double nowMoney) {
		this.nowMoney = nowMoney;
	}

	public String getGameContent() {
		return this.gameContent;
	}

	public void setGameContent(String gameContent) {
		this.gameContent = gameContent;
	}

	public Timestamp getTimestamp() {
		return this.timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

}