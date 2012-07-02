package com.panda.dao;

/**
 * Room entity. @author MyEclipse Persistence Tools
 */

public class Room implements java.io.Serializable {

	// Fields

	private Long id;
	private String roomName;
	private Integer fanNum;
	private Integer maxFanNum;
	private Integer joinNum;
	private Integer onlineNum;
	private String connUrl;
	private Boolean isView;
	private String state;

	// Constructors

	/** default constructor */
	public Room() {
	}

	/** full constructor */
	public Room(String roomName, Integer fanNum, Integer maxFanNum,
			Integer joinNum, Integer onlineNum, String connUrl, Boolean isView,
			String state) {
		this.roomName = roomName;
		this.fanNum = fanNum;
		this.maxFanNum = maxFanNum;
		this.joinNum = joinNum;
		this.onlineNum = onlineNum;
		this.connUrl = connUrl;
		this.isView = isView;
		this.state = state;
	}

	// Property accessors

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRoomName() {
		return this.roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public Integer getFanNum() {
		return this.fanNum;
	}

	public void setFanNum(Integer fanNum) {
		this.fanNum = fanNum;
	}

	public Integer getMaxFanNum() {
		return this.maxFanNum;
	}

	public void setMaxFanNum(Integer maxFanNum) {
		this.maxFanNum = maxFanNum;
	}

	public Integer getJoinNum() {
		return this.joinNum;
	}

	public void setJoinNum(Integer joinNum) {
		this.joinNum = joinNum;
	}

	public Integer getOnlineNum() {
		return this.onlineNum;
	}

	public void setOnlineNum(Integer onlineNum) {
		this.onlineNum = onlineNum;
	}

	public String getConnUrl() {
		return this.connUrl;
	}

	public void setConnUrl(String connUrl) {
		this.connUrl = connUrl;
	}

	public Boolean getIsView() {
		return this.isView;
	}

	public void setIsView(Boolean isView) {
		this.isView = isView;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

}