package com.stock.dao;

/**
 * Achievement entity. @author MyEclipse Persistence Tools
 */

public class Achievement implements java.io.Serializable {

	// Fields

	private Long id;
	private String stockCode;
	private String title;
	private Double oneShouyi;
	private Double oneZhichan;
	private Double shouyiBi;
	private Double allGuben;
	private Double liutongGu;

	// Constructors

	/** default constructor */
	public Achievement() {
	}

	/** full constructor */
	public Achievement(String stockCode, String title, Double oneShouyi,
			Double oneZhichan, Double shouyiBi, Double allGuben,
			Double liutongGu) {
		this.stockCode = stockCode;
		this.title = title;
		this.oneShouyi = oneShouyi;
		this.oneZhichan = oneZhichan;
		this.shouyiBi = shouyiBi;
		this.allGuben = allGuben;
		this.liutongGu = liutongGu;
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

	public Double getOneShouyi() {
		return this.oneShouyi;
	}

	public void setOneShouyi(Double oneShouyi) {
		this.oneShouyi = oneShouyi;
	}

	public Double getOneZhichan() {
		return this.oneZhichan;
	}

	public void setOneZhichan(Double oneZhichan) {
		this.oneZhichan = oneZhichan;
	}

	public Double getShouyiBi() {
		return this.shouyiBi;
	}

	public void setShouyiBi(Double shouyiBi) {
		this.shouyiBi = shouyiBi;
	}

	public Double getAllGuben() {
		return this.allGuben;
	}

	public void setAllGuben(Double allGuben) {
		this.allGuben = allGuben;
	}

	public Double getLiutongGu() {
		return this.liutongGu;
	}

	public void setLiutongGu(Double liutongGu) {
		this.liutongGu = liutongGu;
	}

}