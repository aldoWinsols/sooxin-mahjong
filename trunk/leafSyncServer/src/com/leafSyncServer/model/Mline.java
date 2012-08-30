package com.leafSyncServer.model;

public class Mline{

	private String stockCode;
	private String buildDate;
	private Double price;
	private Double turnover;

	// Constructors

	/** default constructor */
	public Mline() {
	}
	
	public String getStockCode() {
		return this.stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public String getBuildDate() {
		return this.buildDate;
	}

	public void setBuildDate(String buildDate) {
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