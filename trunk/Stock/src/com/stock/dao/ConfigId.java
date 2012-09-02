package com.stock.dao;

/**
 * ConfigId entity. @author MyEclipse Persistence Tools
 */

public class ConfigId implements java.io.Serializable {

	// Fields

	private Double dayLoanLv;
	private Double dayDepositLv;

	// Constructors

	/** default constructor */
	public ConfigId() {
	}

	/** full constructor */
	public ConfigId(Double dayLoanLv, Double dayDepositLv) {
		this.dayLoanLv = dayLoanLv;
		this.dayDepositLv = dayDepositLv;
	}

	// Property accessors

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

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof ConfigId))
			return false;
		ConfigId castOther = (ConfigId) other;

		return ((this.getDayLoanLv() == castOther.getDayLoanLv()) || (this
				.getDayLoanLv() != null
				&& castOther.getDayLoanLv() != null && this.getDayLoanLv()
				.equals(castOther.getDayLoanLv())))
				&& ((this.getDayDepositLv() == castOther.getDayDepositLv()) || (this
						.getDayDepositLv() != null
						&& castOther.getDayDepositLv() != null && this
						.getDayDepositLv().equals(castOther.getDayDepositLv())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getDayLoanLv() == null ? 0 : this.getDayLoanLv().hashCode());
		result = 37
				* result
				+ (getDayDepositLv() == null ? 0 : this.getDayDepositLv()
						.hashCode());
		return result;
	}

}