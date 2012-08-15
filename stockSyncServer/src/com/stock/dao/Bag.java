package com.stock.dao;

import java.sql.Timestamp;

/**
 * Bag entity. @author MyEclipse Persistence Tools
 */

public class Bag implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String playerName;
	private String stockNum;
	private Integer haveNum;
	private Double elPrice;
	private Integer clockNum;

	// Constructors

	/** default constructor */
	public Bag() {
	}

	/** full constructor */
	public Bag(String playerName, String stockNum, Integer haveNum,
			Double elPrice, Integer clockNum) {
		this.playerName = playerName;
		this.stockNum = stockNum;
		this.haveNum = haveNum;
		this.elPrice = elPrice;
		this.clockNum = clockNum;
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

	public String getStockNum() {
		return this.stockNum;
	}

	public void setStockNum(String stockNum) {
		this.stockNum = stockNum;
	}

	public Integer getHaveNum() {
		return this.haveNum;
	}

	public void setHaveNum(Integer haveNum) {
		this.haveNum = haveNum;
	}

	public Double getElPrice() {
		return this.elPrice;
	}

	public void setElPrice(Double elPrice) {
		this.elPrice = elPrice;
	}

	public Integer getClockNum() {
		return this.clockNum;
	}

	public void setClockNum(Integer clockNum) {
		this.clockNum = clockNum;
	}

}