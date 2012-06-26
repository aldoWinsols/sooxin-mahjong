package com.panda.dao;

/**
 * Config entity. @author MyEclipse Persistence Tools
 */

public class Config implements java.io.Serializable {

	// Fields

	private Integer id;
	private String mainConnUrl;
	private Boolean hideJiangpin;

	// Constructors

	/** default constructor */
	public Config() {
	}

	/** full constructor */
	public Config(String mainConnUrl, Boolean hideJiangpin) {
		this.mainConnUrl = mainConnUrl;
		this.hideJiangpin = hideJiangpin;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMainConnUrl() {
		return this.mainConnUrl;
	}

	public void setMainConnUrl(String mainConnUrl) {
		this.mainConnUrl = mainConnUrl;
	}

	public Boolean getHideJiangpin() {
		return this.hideJiangpin;
	}

	public void setHideJiangpin(Boolean hideJiangpin) {
		this.hideJiangpin = hideJiangpin;
	}

}