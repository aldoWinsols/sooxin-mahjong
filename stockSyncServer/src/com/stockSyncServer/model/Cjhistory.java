package com.stockSyncServer.model;

import java.sql.Timestamp;

public class Cjhistory {
	private Timestamp cjTime;
	private double cjPrice;
	private int cjNum;
	private String cjSort;
	public Timestamp getCjTime() {
		return cjTime;
	}
	public void setCjTime(Timestamp cjTime) {
		this.cjTime = cjTime;
	}
	public double getCjPrice() {
		return cjPrice;
	}
	public void setCjPrice(double cjPrice) {
		this.cjPrice = cjPrice;
	}
	public int getCjNum() {
		return cjNum;
	}
	public void setCjNum(int cjNum) {
		this.cjNum = cjNum;
	}
	public String getCjSort() {
		return cjSort;
	}
	public void setCjSort(String cjSort) {
		this.cjSort = cjSort;
	}
	
	

}
