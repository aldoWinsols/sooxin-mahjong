package com.stock.dao;

/**
 * Ipo entity. @author MyEclipse Persistence Tools
 */

public class Ipo implements java.io.Serializable {

	// Fields

	private Long id;
	private String stockCode;
	private String stockName;
	private Integer allNum;
	private Integer busNum;
	private Integer haveBuyNum;
	private Double jinzhi;
	private Double shouyi;
	private String startBuy;
	private String startSale;
	private String introdunce;
	private Double price;

	// Constructors

	/** default constructor */
	public Ipo() {
	}

	/** full constructor */
	public Ipo(String stockCode, String stockName, Integer allNum,
			Integer busNum, Integer haveBuyNum, Double jinzhi, Double shouyi,
			String startBuy, String startSale, String introdunce, Double price) {
		this.stockCode = stockCode;
		this.stockName = stockName;
		this.allNum = allNum;
		this.busNum = busNum;
		this.haveBuyNum = haveBuyNum;
		this.jinzhi = jinzhi;
		this.shouyi = shouyi;
		this.startBuy = startBuy;
		this.startSale = startSale;
		this.introdunce = introdunce;
		this.price = price;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getStockCode() {
		return this.stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public String getStockName() {
		return this.stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public Integer getAllNum() {
		return this.allNum;
	}

	public void setAllNum(Integer allNum) {
		this.allNum = allNum;
	}

	public Integer getBusNum() {
		return this.busNum;
	}

	public void setBusNum(Integer busNum) {
		this.busNum = busNum;
	}

	public Integer getHaveBuyNum() {
		return this.haveBuyNum;
	}

	public void setHaveBuyNum(Integer haveBuyNum) {
		this.haveBuyNum = haveBuyNum;
	}

	public Double getJinzhi() {
		return this.jinzhi;
	}

	public void setJinzhi(Double jinzhi) {
		this.jinzhi = jinzhi;
	}

	public Double getShouyi() {
		return this.shouyi;
	}

	public void setShouyi(Double shouyi) {
		this.shouyi = shouyi;
	}

	public String getStartBuy() {
		return this.startBuy;
	}

	public void setStartBuy(String startBuy) {
		this.startBuy = startBuy;
	}

	public String getStartSale() {
		return this.startSale;
	}

	public void setStartSale(String startSale) {
		this.startSale = startSale;
	}

	public String getIntrodunce() {
		return this.introdunce;
	}

	public void setIntrodunce(String introdunce) {
		this.introdunce = introdunce;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

}