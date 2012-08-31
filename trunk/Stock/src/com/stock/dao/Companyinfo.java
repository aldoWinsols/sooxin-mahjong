package com.stock.dao;

import java.sql.Timestamp;

/**
 * Companyinfo entity. @author MyEclipse Persistence Tools
 */

public class Companyinfo implements java.io.Serializable {

	// Fields

	private Long id;
	private String stockCode;
	private String companyName;
	private String hangyeSort;
	private Timestamp startTime;
	private String jyContent;
	private String mostJy;
	private String introdunce;

	// Constructors

	/** default constructor */
	public Companyinfo() {
	}

	/** full constructor */
	public Companyinfo(String stockCode, String companyName, String hangyeSort,
			Timestamp startTime, String jyContent, String mostJy,
			String introdunce) {
		this.stockCode = stockCode;
		this.companyName = companyName;
		this.hangyeSort = hangyeSort;
		this.startTime = startTime;
		this.jyContent = jyContent;
		this.mostJy = mostJy;
		this.introdunce = introdunce;
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

	public String getCompanyName() {
		return this.companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getHangyeSort() {
		return this.hangyeSort;
	}

	public void setHangyeSort(String hangyeSort) {
		this.hangyeSort = hangyeSort;
	}

	public Timestamp getStartTime() {
		return this.startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public String getJyContent() {
		return this.jyContent;
	}

	public void setJyContent(String jyContent) {
		this.jyContent = jyContent;
	}

	public String getMostJy() {
		return this.mostJy;
	}

	public void setMostJy(String mostJy) {
		this.mostJy = mostJy;
	}

	public String getIntrodunce() {
		return this.introdunce;
	}

	public void setIntrodunce(String introdunce) {
		this.introdunce = introdunce;
	}

}