package com.stock.dao;

/**
 * Profit entity. @author MyEclipse Persistence Tools
 */

public class Profit implements java.io.Serializable {

	// Fields

	private Long id;
	private String stockCode;
	private String title;
	private Double jinLirun;
	private Double jinLirunIncreaseLv;
	private Double jinZhichanShoyiLv;
	private Double zhichanFuzaiLv;
	private Double cachLv;

	// Constructors

	/** default constructor */
	public Profit() {
	}

	/** full constructor */
	public Profit(String stockCode, String title, Double jinLirun,
			Double jinLirunIncreaseLv, Double jinZhichanShoyiLv,
			Double zhichanFuzaiLv, Double cachLv) {
		this.stockCode = stockCode;
		this.title = title;
		this.jinLirun = jinLirun;
		this.jinLirunIncreaseLv = jinLirunIncreaseLv;
		this.jinZhichanShoyiLv = jinZhichanShoyiLv;
		this.zhichanFuzaiLv = zhichanFuzaiLv;
		this.cachLv = cachLv;
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

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Double getJinLirun() {
		return this.jinLirun;
	}

	public void setJinLirun(Double jinLirun) {
		this.jinLirun = jinLirun;
	}

	public Double getJinLirunIncreaseLv() {
		return this.jinLirunIncreaseLv;
	}

	public void setJinLirunIncreaseLv(Double jinLirunIncreaseLv) {
		this.jinLirunIncreaseLv = jinLirunIncreaseLv;
	}

	public Double getJinZhichanShoyiLv() {
		return this.jinZhichanShoyiLv;
	}

	public void setJinZhichanShoyiLv(Double jinZhichanShoyiLv) {
		this.jinZhichanShoyiLv = jinZhichanShoyiLv;
	}

	public Double getZhichanFuzaiLv() {
		return this.zhichanFuzaiLv;
	}

	public void setZhichanFuzaiLv(Double zhichanFuzaiLv) {
		this.zhichanFuzaiLv = zhichanFuzaiLv;
	}

	public Double getCachLv() {
		return this.cachLv;
	}

	public void setCachLv(Double cachLv) {
		this.cachLv = cachLv;
	}

}