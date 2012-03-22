package com.panda.dao;

/**
 * Config entity. @author MyEclipse Persistence Tools
 */

public class Config implements java.io.Serializable {

	// Fields

	private Integer id;
	private String connectStr;
	private String connectType;

	// Constructors

	/** default constructor */
	public Config() {
	}

	/** full constructor */
	public Config(String connectStr, String connectType) {
		this.connectStr = connectStr;
		this.connectType = connectType;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getConnectStr() {
		return this.connectStr;
	}

	public void setConnectStr(String connectStr) {
		this.connectStr = connectStr;
	}

	public String getConnectType() {
		return this.connectType;
	}

	public void setConnectType(String connectType) {
		this.connectType = connectType;
	}

}