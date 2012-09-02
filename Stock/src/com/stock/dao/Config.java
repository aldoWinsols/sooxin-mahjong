package com.stock.dao;

/**
 * Config entity. @author MyEclipse Persistence Tools
 */

public class Config implements java.io.Serializable {

	// Fields

	private Long id;
	private Double dayLoanLv;
	private Double dayDepositLv;

	// Constructors

	/** default constructor */
	public Config() {
	}

	/** full constructor */
	public Config(Double dayLoanLv, Double dayDepositLv) {
		this.dayLoanLv = dayLoanLv;
		this.dayDepositLv = dayDepositLv;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Double getDayLoanLv() {
		return this.dayLoanLv;
	}

	public void setDayLoanLv(Double dayLoanLv) {
		this.dayLoanLv = dayLoanLv;
	}

	public Double getDayDepositLv() {
		return this.dayDepositLv;
	}

	public void setDayDepositLv(Double dayDepositLv) {
		this.dayDepositLv = dayDepositLv;
	}

}