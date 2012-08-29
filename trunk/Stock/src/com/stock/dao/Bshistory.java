package com.stock.dao;

import java.sql.Timestamp;

/**
 * Bshistory entity. @author MyEclipse Persistence Tools
 */

public class Bshistory implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String num;
	private String playerName;
	private String stockNum;
	private String bsSort;
	private Integer bsNum;
	private Double bsWtPrice;
	private Double bsCjPrice;
	private Double taxStamp;
	private Double commision;
	private Timestamp bsTime;
	private Integer haveCjNum;
	private Integer state;

	// Constructors

	/** default constructor */
	public Bshistory() {
	}

	/** full constructor */
	public Bshistory(String num, String playerName, String stockNum,
			String bsSort, Integer bsNum, Double bsWtPrice, Double bsCjPrice,
			Double taxStamp, Double commision, Timestamp bsTime,
			Integer haveCjNum, Integer state) {
		this.num = num;
		this.playerName = playerName;
		this.stockNum = stockNum;
		this.bsSort = bsSort;
		this.bsNum = bsNum;
		this.bsWtPrice = bsWtPrice;
		this.bsCjPrice = bsCjPrice;
		this.taxStamp = taxStamp;
		this.commision = commision;
		this.bsTime = bsTime;
		this.haveCjNum = haveCjNum;
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

	public String getNum() {
		return this.num;
	}

	public void setNum(String num) {
		this.num = num;
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

	public String getBsSort() {
		return this.bsSort;
	}

	public void setBsSort(String bsSort) {
		this.bsSort = bsSort;
	}

	public Integer getBsNum() {
		return this.bsNum;
	}

	public void setBsNum(Integer bsNum) {
		this.bsNum = bsNum;
	}

	public Double getBsWtPrice() {
		return this.bsWtPrice;
	}

	public void setBsWtPrice(Double bsWtPrice) {
		this.bsWtPrice = bsWtPrice;
	}

	public Double getBsCjPrice() {
		return this.bsCjPrice;
	}

	public void setBsCjPrice(Double bsCjPrice) {
		this.bsCjPrice = bsCjPrice;
	}

	public Double getTaxStamp() {
		return this.taxStamp;
	}

	public void setTaxStamp(Double taxStamp) {
		this.taxStamp = taxStamp;
	}

	public Double getCommision() {
		return this.commision;
	}

	public void setCommision(Double commision) {
		this.commision = commision;
	}

	public Timestamp getBsTime() {
		return this.bsTime;
	}

	public void setBsTime(Timestamp bsTime) {
		this.bsTime = bsTime;
	}

	public Integer getHaveCjNum() {
		return this.haveCjNum;
	}

	public void setHaveCjNum(Integer haveCjNum) {
		this.haveCjNum = haveCjNum;
	}

	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

}