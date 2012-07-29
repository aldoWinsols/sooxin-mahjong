package com.robertSyncServer.model;

public class Order {
	private String playerName = ""; //
	private double wtPrice= 0.0; //
	private int wtNum = 0; //
	
	
	public Order(){
	}
	
	public Order(String playerName, double wtPrice, int wtNum){
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
	
	

}
