package com.stock.dao;

/**
 * Tenplayer entity. @author MyEclipse Persistence Tools
 */

public class Tenplayer implements java.io.Serializable {

	// Fields

	private Long id;
	private String stockCode;
	private String playerName;
	private Integer haveNum;
	private Double zhanbi;
	private String remark;

	// Constructors

	/** default constructor */
	public Tenplayer() {
	}

	/** full constructor */
	public Tenplayer(String stockCode, String playerName, Integer haveNum,
			Double zhanbi, String remark) {
		this.stockCode = stockCode;
		this.playerName = playerName;
		this.haveNum = haveNum;
		this.zhanbi = zhanbi;
		this.remark = remark;
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

	public String getPlayerName() {
		return this.playerName;
	}

	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}

	public Integer getHaveNum() {
		return this.haveNum;
	}

	public void setHaveNum(Integer haveNum) {
		this.haveNum = haveNum;
	}

	public Double getZhanbi() {
		return this.zhanbi;
	}

	public void setZhanbi(Double zhanbi) {
		this.zhanbi = zhanbi;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}