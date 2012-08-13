package com.stock.dao;

import java.sql.Timestamp;

/**
 * Cjhistory entity. @author MyEclipse Persistence Tools
 */

public class Cjhistory implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String stockNum;
	private String cjSort;
	private Integer cjNum;
	private Double cjPrice;
	private Timestamp cjTime;

	// Constructors

	/** default constructor */
	public Cjhistory() {
	}

	/** full constructor */
	public Cjhistory(String stockNum, String cjSort, Integer cjNum,
			Double cjPrice, Timestamp cjTime) {
		this.stockNum = stockNum;
		this.cjSort = cjSort;
		this.cjNum = cjNum;
		this.cjPrice = cjPrice;
		this.cjTime = cjTime;
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

	public String getStockNum() {
		return this.stockNum;
	}

	public void setStockNum(String stockNum) {
		this.stockNum = stockNum;
	}

	public String getCjSort() {
		return this.cjSort;
	}

	public void setCjSort(String cjSort) {
		this.cjSort = cjSort;
	}

	public Integer getCjNum() {
		return this.cjNum;
	}

	public void setCjNum(Integer cjNum) {
		this.cjNum = cjNum;
	}

	public Double getCjPrice() {
		return this.cjPrice;
	}

	public void setCjPrice(Double cjPrice) {
		this.cjPrice = cjPrice;
	}

	public Timestamp getCjTime() {
		return this.cjTime;
	}

	public void setCjTime(Timestamp cjTime) {
		this.cjTime = cjTime;
	}

}