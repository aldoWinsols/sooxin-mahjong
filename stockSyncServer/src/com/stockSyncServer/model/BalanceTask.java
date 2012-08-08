package com.stockSyncServer.model;

import java.sql.Timestamp;

public class BalanceTask {
	public String stockNum = "";
	public String buyPlayerName = "";
	public String buyOrderNum = "";
	public String salePlayerName = "";
	public String saleOrderNum = "";
	public String cjSort = "";
	public int cjNum = 0;
	public Double cjPrice = 0.0;
	public Timestamp cjTime;

}
