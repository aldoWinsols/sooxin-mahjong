package com.panda.dao;

import java.sql.Timestamp;

/**
 * Player entity. @author MyEclipse Persistence Tools
 */

public class Player implements java.io.Serializable {

	// Fields

	private Long id;
	private String playername;
	private String playerpwd;
	private Double haveMoney;
	private Integer offlineGameNo;
	private Timestamp timestamp;

	// Constructors

	/** default constructor */
	public Player() {
	}

	/** full constructor */
	public Player(String playername, String playerpwd, Double haveMoney,
			Integer offlineGameNo, Timestamp timestamp) {
		this.playername = playername;
		this.playerpwd = playerpwd;
		this.haveMoney = haveMoney;
		this.offlineGameNo = offlineGameNo;
		this.timestamp = timestamp;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getPlayername() {
		return this.playername;
	}

	public void setPlayername(String playername) {
		this.playername = playername;
	}

	public String getPlayerpwd() {
		return this.playerpwd;
	}

	public void setPlayerpwd(String playerpwd) {
		this.playerpwd = playerpwd;
	}

	public Double getHaveMoney() {
		return this.haveMoney;
	}

	public void setHaveMoney(Double haveMoney) {
		this.haveMoney = haveMoney;
	}

	public Integer getOfflineGameNo() {
		return this.offlineGameNo;
	}

	public void setOfflineGameNo(Integer offlineGameNo) {
		this.offlineGameNo = offlineGameNo;
	}

	public Timestamp getTimestamp() {
		return this.timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

}