package com.stock.dao;

import java.sql.Timestamp;

/**
 * News entity. @author MyEclipse Persistence Tools
 */

public class News implements java.io.Serializable {

	// Fields

	private Long id;
	private String stockCode;
	private String title;
	private String pubPlayer;
	private String content;
	private Timestamp buildTime;

	// Constructors

	/** default constructor */
	public News() {
	}

	/** minimal constructor */
	public News(Timestamp buildTime) {
		this.buildTime = buildTime;
	}

	/** full constructor */
	public News(String stockCode, String title, String pubPlayer,
			String content, Timestamp buildTime) {
		this.stockCode = stockCode;
		this.title = title;
		this.pubPlayer = pubPlayer;
		this.content = content;
		this.buildTime = buildTime;
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

	public String getPubPlayer() {
		return this.pubPlayer;
	}

	public void setPubPlayer(String pubPlayer) {
		this.pubPlayer = pubPlayer;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getBuildTime() {
		return this.buildTime;
	}

	public void setBuildTime(Timestamp buildTime) {
		this.buildTime = buildTime;
	}

}