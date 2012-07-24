package com.stock.dao;

import java.sql.Timestamp;

/**
 * Stockpricehistory entity. @author MyEclipse Persistence Tools
 */

public class Stockpricehistory implements java.io.Serializable {

	// Fields

	private Long id;
	private String stockNum;
	private Double price;
	private Timestamp priceTime;

	// Constructors

	/** default constructor */
	public Stockpricehistory() {
	}

	/** full constructor */
	public Stockpricehistory(String stockNum, Double price, Timestamp priceTime) {
		this.stockNum = stockNum;
		this.price = price;
		this.priceTime = priceTime;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getStockNum() {
		return this.stockNum;
	}

	public void setStockNum(String stockNum) {
		this.stockNum = stockNum;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Timestamp getPriceTime() {
		return this.priceTime;
	}

	public void setPriceTime(Timestamp priceTime) {
		this.priceTime = priceTime;
	}

}