package com.stock.dao;

import java.sql.Timestamp;

/**
 * Bank entity. @author MyEclipse Persistence Tools
 */

public class Bank implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String playerName;
	private String sort;
	private Double money;
	private Double lv;
	private Integer days;
	private Double changeMoney;
	private Integer state;

	// Constructors

	/** default constructor */
	public Bank() {
	}

	/** full constructor */
	public Bank(String playerName, String sort, Double money, Double lv,
			Integer days, Double changeMoney, Integer state) {
		this.playerName = playerName;
		this.sort = sort;
		this.money = money;
		this.lv = lv;
		this.days = days;
		this.changeMoney = changeMoney;
		this.state = state;
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

	public String getSort() {
		return this.sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public Double getMoney() {
		return this.money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public Double getLv() {
		return this.lv;
	}

	public void setLv(Double lv) {
		this.lv = lv;
	}

	public Integer getDays() {
		return this.days;
	}

	public void setDays(Integer days) {
		this.days = days;
	}

	public Double getChangeMoney() {
		return this.changeMoney;
	}

	public void setChangeMoney(Double changeMoney) {
		this.changeMoney = changeMoney;
	}

	public Integer getState() {
		return this.state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

}