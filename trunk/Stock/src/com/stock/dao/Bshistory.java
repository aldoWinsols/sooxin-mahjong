package com.stock.dao;

import java.sql.Timestamp;

/**
 * Bshistory entity. @author MyEclipse Persistence Tools
 */

public class Bshistory implements java.io.Serializable {

	// Fields

	private Long id;
	private String playerName;
	private String stockNum;
	private String bsSort;
	private Integer bsNum;
	private Double bsPrice;
	private Double taxStamp;
	private Double commision;
	private Timestamp bsTime;

	// Constructors

	/** default constructor */
	public Bshistory() {
	}

	/** full constructor */
	public Bshistory(String playerName, String stockNum, String bsSort,
			Integer bsNum, Double bsPrice, Double taxStamp, Double commision,
			Timestamp bsTime) {
		this.playerName = playerName;
		this.stockNum = stockNum;
		this.bsSort = bsSort;
		this.bsNum = bsNum;
		this.bsPrice = bsPrice;
		this.taxStamp = taxStamp;
		this.commision = commision;
		this.bsTime = bsTime;
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

	public Double getBsPrice() {
		return this.bsPrice;
	}

	public void setBsPrice(Double bsPrice) {
		this.bsPrice = bsPrice;
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

}