package com.stock.dao;

/**
 * Bag entity. @author MyEclipse Persistence Tools
 */

public class Bag implements java.io.Serializable {

	// Fields

	private Long id;
	private String playerName;
	private String stockNum;
	private Double haveNum;
	private Double evlPrice;

	// Constructors

	/** default constructor */
	public Bag() {
	}

	/** full constructor */
	public Bag(String playerName, String stockNum, Double haveNum,
			Double evlPrice) {
		this.playerName = playerName;
		this.stockNum = stockNum;
		this.haveNum = haveNum;
		this.evlPrice = evlPrice;
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

	public Double getHaveNum() {
		return this.haveNum;
	}

	public void setHaveNum(Double haveNum) {
		this.haveNum = haveNum;
	}

	public Double getEvlPrice() {
		return this.evlPrice;
	}

	public void setEvlPrice(Double evlPrice) {
		this.evlPrice = evlPrice;
	}

}