package com.stock.dao;

import java.sql.Timestamp;

/**
 * Mline entity. @author MyEclipse Persistence Tools
 */

public class Mline implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String stockCode;
	private Timestamp buildDate;
	private Double price;
	private Double turnover;

	// Constructors

	/** default constructor */
	public Mline() {
	}

	/** full constructor */
	public Mline(String stockCode, Timestamp buildDate, Double price,
			Double turnover) {
		this.stockCode = stockCode;
		this.buildDate = buildDate;
		this.price = price;
		this.turnover = turnover;
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

	public String getStockCode() {
		return this.stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public Timestamp getBuildDate() {
		return this.buildDate;
	}

	public void setBuildDate(Timestamp buildDate) {
		this.buildDate = buildDate;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getTurnover() {
		return this.turnover;
	}

	public void setTurnover(Double turnover) {
		this.turnover = turnover;
	}

}