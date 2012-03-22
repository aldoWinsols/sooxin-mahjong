package com.panda.dao;

import java.sql.Timestamp;

/**
 * Playlog entity. @author MyEclipse Persistence Tools
 */

public class Playlog implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String playerName;
	private Integer gameClass;
	private Integer gameSubClass;
	private String gameName;
	private String gameNo;
	private Timestamp gameTime;
	private String gameContent;
	private Double allTouZhuMoney;
	private Double preMoney;
	private Double winLossMoneyBeforeTax;
	private Double gameTaxaction;
	private Double winLossMoneyAfterTax;
	private Double afterMoney;
	private String gameIp;
	private String remarks;

	// Constructors

	/** default constructor */
	public Playlog() {
	}

	/** minimal constructor */
	public Playlog(String playerName, Integer gameClass, Integer gameSubClass,
			String gameName, String gameNo, Timestamp gameTime,
			String gameContent, Double allTouZhuMoney, Double preMoney,
			Double winLossMoneyBeforeTax, Double gameTaxaction,
			Double winLossMoneyAfterTax, Double afterMoney, String gameIp) {
		this.playerName = playerName;
		this.gameClass = gameClass;
		this.gameSubClass = gameSubClass;
		this.gameName = gameName;
		this.gameNo = gameNo;
		this.gameTime = gameTime;
		this.gameContent = gameContent;
		this.allTouZhuMoney = allTouZhuMoney;
		this.preMoney = preMoney;
		this.winLossMoneyBeforeTax = winLossMoneyBeforeTax;
		this.gameTaxaction = gameTaxaction;
		this.winLossMoneyAfterTax = winLossMoneyAfterTax;
		this.afterMoney = afterMoney;
		this.gameIp = gameIp;
	}

	/** full constructor */
	public Playlog(String playerName, Integer gameClass, Integer gameSubClass,
			String gameName, String gameNo, Timestamp gameTime,
			String gameContent, Double allTouZhuMoney, Double preMoney,
			Double winLossMoneyBeforeTax, Double gameTaxaction,
			Double winLossMoneyAfterTax, Double afterMoney, String gameIp,
			String remarks) {
		this.playerName = playerName;
		this.gameClass = gameClass;
		this.gameSubClass = gameSubClass;
		this.gameName = gameName;
		this.gameNo = gameNo;
		this.gameTime = gameTime;
		this.gameContent = gameContent;
		this.allTouZhuMoney = allTouZhuMoney;
		this.preMoney = preMoney;
		this.winLossMoneyBeforeTax = winLossMoneyBeforeTax;
		this.gameTaxaction = gameTaxaction;
		this.winLossMoneyAfterTax = winLossMoneyAfterTax;
		this.afterMoney = afterMoney;
		this.gameIp = gameIp;
		this.remarks = remarks;
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

	public String getPlayerName() {
		return this.playerName;
	}

	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}

	public Integer getGameClass() {
		return this.gameClass;
	}

	public void setGameClass(Integer gameClass) {
		this.gameClass = gameClass;
	}

	public Integer getGameSubClass() {
		return this.gameSubClass;
	}

	public void setGameSubClass(Integer gameSubClass) {
		this.gameSubClass = gameSubClass;
	}

	public String getGameName() {
		return this.gameName;
	}

	public void setGameName(String gameName) {
		this.gameName = gameName;
	}

	public String getGameNo() {
		return this.gameNo;
	}

	public void setGameNo(String gameNo) {
		this.gameNo = gameNo;
	}

	public Timestamp getGameTime() {
		return this.gameTime;
	}

	public void setGameTime(Timestamp gameTime) {
		this.gameTime = gameTime;
	}

	public String getGameContent() {
		return this.gameContent;
	}

	public void setGameContent(String gameContent) {
		this.gameContent = gameContent;
	}

	public Double getAllTouZhuMoney() {
		return this.allTouZhuMoney;
	}

	public void setAllTouZhuMoney(Double allTouZhuMoney) {
		this.allTouZhuMoney = allTouZhuMoney;
	}

	public Double getPreMoney() {
		return this.preMoney;
	}

	public void setPreMoney(Double preMoney) {
		this.preMoney = preMoney;
	}

	public Double getWinLossMoneyBeforeTax() {
		return this.winLossMoneyBeforeTax;
	}

	public void setWinLossMoneyBeforeTax(Double winLossMoneyBeforeTax) {
		this.winLossMoneyBeforeTax = winLossMoneyBeforeTax;
	}

	public Double getGameTaxaction() {
		return this.gameTaxaction;
	}

	public void setGameTaxaction(Double gameTaxaction) {
		this.gameTaxaction = gameTaxaction;
	}

	public Double getWinLossMoneyAfterTax() {
		return this.winLossMoneyAfterTax;
	}

	public void setWinLossMoneyAfterTax(Double winLossMoneyAfterTax) {
		this.winLossMoneyAfterTax = winLossMoneyAfterTax;
	}

	public Double getAfterMoney() {
		return this.afterMoney;
	}

	public void setAfterMoney(Double afterMoney) {
		this.afterMoney = afterMoney;
	}

	public String getGameIp() {
		return this.gameIp;
	}

	public void setGameIp(String gameIp) {
		this.gameIp = gameIp;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}