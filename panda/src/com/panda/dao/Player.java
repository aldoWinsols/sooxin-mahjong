package com.panda.dao;

import java.sql.Timestamp;

/**
 * Player entity. @author MyEclipse Persistence Tools
 */

public class Player implements java.io.Serializable {

	// Fields

	private Long id;
	private Timestamp timestamp;
	private String playerName;
	private String playerPwd;
	private Double haveMoney;
	private Integer birthday;
	private Integer birthMonth;
	private Integer birthYear;
	private String cityCode;
	private String countryCode;
	private String edu;
	private String email;
	private Integer fansNum;
	private String head;
	private Integer idolNum;
	private String introduction;
	private Boolean isent;
	private Boolean isrealName;
	private Boolean isvip;
	private String location;
	private String nick;
	private String openid;
	private String provinceCode;
	private Integer sex;
	private String tag;
	private Integer tweetnum;
	private String verifyinfo;
	private Integer offlineGameNo;

	// Constructors

	/** default constructor */
	public Player() {
	}

	/** full constructor */
	public Player(String playerName, String playerPwd, Double haveMoney,
			Integer birthday, Integer birthMonth, Integer birthYear,
			String cityCode, String countryCode, String edu, String email,
			Integer fansNum, String head, Integer idolNum, String introduction,
			Boolean isent, Boolean isrealName, Boolean isvip, String location,
			String nick, String openid, String provinceCode, Integer sex,
			String tag, Integer tweetnum, String verifyinfo,
			Integer offlineGameNo) {
		this.playerName = playerName;
		this.playerPwd = playerPwd;
		this.haveMoney = haveMoney;
		this.birthday = birthday;
		this.birthMonth = birthMonth;
		this.birthYear = birthYear;
		this.cityCode = cityCode;
		this.countryCode = countryCode;
		this.edu = edu;
		this.email = email;
		this.fansNum = fansNum;
		this.head = head;
		this.idolNum = idolNum;
		this.introduction = introduction;
		this.isent = isent;
		this.isrealName = isrealName;
		this.isvip = isvip;
		this.location = location;
		this.nick = nick;
		this.openid = openid;
		this.provinceCode = provinceCode;
		this.sex = sex;
		this.tag = tag;
		this.tweetnum = tweetnum;
		this.verifyinfo = verifyinfo;
		this.offlineGameNo = offlineGameNo;
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

	public String getPlayerPwd() {
		return this.playerPwd;
	}

	public void setPlayerPwd(String playerPwd) {
		this.playerPwd = playerPwd;
	}

	public Double getHaveMoney() {
		return this.haveMoney;
	}

	public void setHaveMoney(Double haveMoney) {
		this.haveMoney = haveMoney;
	}

	public Integer getBirthday() {
		return this.birthday;
	}

	public void setBirthday(Integer birthday) {
		this.birthday = birthday;
	}

	public Integer getBirthMonth() {
		return this.birthMonth;
	}

	public void setBirthMonth(Integer birthMonth) {
		this.birthMonth = birthMonth;
	}

	public Integer getBirthYear() {
		return this.birthYear;
	}

	public void setBirthYear(Integer birthYear) {
		this.birthYear = birthYear;
	}

	public String getCityCode() {
		return this.cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getCountryCode() {
		return this.countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getEdu() {
		return this.edu;
	}

	public void setEdu(String edu) {
		this.edu = edu;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getFansNum() {
		return this.fansNum;
	}

	public void setFansNum(Integer fansNum) {
		this.fansNum = fansNum;
	}

	public String getHead() {
		return this.head;
	}

	public void setHead(String head) {
		this.head = head;
	}

	public Integer getIdolNum() {
		return this.idolNum;
	}

	public void setIdolNum(Integer idolNum) {
		this.idolNum = idolNum;
	}

	public String getIntroduction() {
		return this.introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public Boolean getIsent() {
		return this.isent;
	}

	public void setIsent(Boolean isent) {
		this.isent = isent;
	}

	public Boolean getIsrealName() {
		return this.isrealName;
	}

	public void setIsrealName(Boolean isrealName) {
		this.isrealName = isrealName;
	}

	public Boolean getIsvip() {
		return this.isvip;
	}

	public void setIsvip(Boolean isvip) {
		this.isvip = isvip;
	}

	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getNick() {
		return this.nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getOpenid() {
		return this.openid;
	}

	public void setOpenid(String openid) {
		this.openid = openid;
	}

	public String getProvinceCode() {
		return this.provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public Integer getSex() {
		return this.sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getTag() {
		return this.tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public Integer getTweetnum() {
		return this.tweetnum;
	}

	public void setTweetnum(Integer tweetnum) {
		this.tweetnum = tweetnum;
	}

	public String getVerifyinfo() {
		return this.verifyinfo;
	}

	public void setVerifyinfo(String verifyinfo) {
		this.verifyinfo = verifyinfo;
	}

	public Integer getOfflineGameNo() {
		return this.offlineGameNo;
	}

	public void setOfflineGameNo(Integer offlineGameNo) {
		this.offlineGameNo = offlineGameNo;
	}

}