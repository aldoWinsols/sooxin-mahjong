package com.stockSyncServer.model;

public class Order {
	private String playerName = ""; //
	private String orderNum = ""; // 编码 唯一识别
	private double wtPrice = 0.0; //
	private int wtNum = 0; //

	public Order() {
	}

	public Order(String playerName, double wtPrice, int wtNum) {
		this.playerName = playerName;
		this.wtPrice = wtPrice;
		this.wtNum = wtNum;
	}

	public String getPlayerName() {
		return playerName;
	}

	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}

	public double getWtPrice() {
		return wtPrice;
	}

	public void setWtPrice(double wtPrice) {
		this.wtPrice = wtPrice;
	}

	public int getWtNum() {
		return wtNum;
	}

	public void setWtNum(int wtNum) {
		this.wtNum = wtNum;
	}

	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

}
