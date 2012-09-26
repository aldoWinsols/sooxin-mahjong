package com.stock.dao;

import java.sql.Timestamp;

/**
 * Stock entity. @author MyEclipse Persistence Tools
 */

public class Stock implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6472701910397751162L;
	// Fields

	private Long id;
	private Timestamp timestamp;
	private String stockCode;
	private String stockName;
	private Integer allNum;
	private Integer busNum;
	private Double jinzhi;
	private Double shouyi;
	private Double pe;
	private Double lastDayEndPrice;
	private Integer lastDayCjshou;
	private Double xinxinLv;

	// Constructors

	/** default constructor */
	public Stock() {
	}

	/** full constructor */
	public Stock(String stockCode, String stockName, Integer allNum,
			Integer busNum, Double jinzhi, Double shouyi, Double pe,
			Double lastDayEndPrice, Integer lastDayCjshou, Double xinxinLv) {
		this.stockCode = stockCode;
		this.stockName = stockName;
		this.allNum = allNum;
		this.busNum = busNum;
		this.jinzhi = jinzhi;
		this.shouyi = shouyi;
		this.pe = pe;
		this.lastDayEndPrice = lastDayEndPrice;
		this.lastDayCjshou = lastDayCjshou;
		this.xinxinLv = xinxinLv;
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

	public Double getPe() {
		return this.pe;
	}

	public void setPe(Double pe) {
		this.pe = pe;
	}

	public Double getLastDayEndPrice() {
		return this.lastDayEndPrice;
	}

	public void setLastDayEndPrice(Double lastDayEndPrice) {
		this.lastDayEndPrice = lastDayEndPrice;
	}

	public Integer getLastDayCjshou() {
		return this.lastDayCjshou;
	}

	public void setLastDayCjshou(Integer lastDayCjshou) {
		this.lastDayCjshou = lastDayCjshou;
	}

	public Double getXinxinLv() {
		return this.xinxinLv;
	}

	public void setXinxinLv(Double xinxinLv) {
		this.xinxinLv = xinxinLv;
	}

}