package com.panda.dao;

import java.sql.Timestamp;

/**
 * Shangpin entity. @author MyEclipse Persistence Tools
 */

public class Shangpin implements java.io.Serializable {

	// Fields

	private Long id;
	private String shangpinName;
	private Double price;
	private String introdunce;
	private String imgurl;
	private Timestamp timestamp;

	// Constructors

	/** default constructor */
	public Shangpin() {
	}

	/** full constructor */
	public Shangpin(String shangpinName, Double price, String introdunce,
			String imgurl, Timestamp timestamp) {
		this.shangpinName = shangpinName;
		this.price = price;
		this.introdunce = introdunce;
		this.imgurl = imgurl;
		this.timestamp = timestamp;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getShangpinName() {
		return this.shangpinName;
	}

	public void setShangpinName(String shangpinName) {
		this.shangpinName = shangpinName;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public String getIntrodunce() {
		return this.introdunce;
	}

	public void setIntrodunce(String introdunce) {
		this.introdunce = introdunce;
	}

	public String getImgurl() {
		return this.imgurl;
	}

	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}

	public Timestamp getTimestamp() {
		return this.timestamp;
	}

	public void setTimestamp(Timestamp timestamp) {
		this.timestamp = timestamp;
	}

}