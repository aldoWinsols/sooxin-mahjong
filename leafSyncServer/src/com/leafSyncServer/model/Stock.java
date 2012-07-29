package com.leafSyncServer.model;

import java.util.ArrayList;

public class Stock {
	public String stockCode = "";// 股票代码
	public String stockName = "";//股票名称
	public int allStockNum = 0;// 总股本
	public int liutongStockNum = 0;// 流通
	public double shouyi = 0.0; // 收益
	public double PE = 0.0;// 市赢率

	public double lastDayEndPrice = 0.0; // 昨日收盘价格
	public double todayStartPrice = 0.0;// 今日开盘价格
	public double topPrice = 0.0;// 当日最高价格
	public double bottomPrice = 0.0; // 当日最低价
	public double nowPrice = 0.0;// 当前价格
	public double nowCjNum = 0.0;// 当前成交量

	public ArrayList<Cjhistory> cjhistorys = new ArrayList<Cjhistory>();// 成交笔

	public ArrayList<Order> buyOrders = new ArrayList<Order>();// 买单
	public ArrayList<Order> saleOrders = new ArrayList<Order>();// 卖单

	public Stock(){
		
	}
	
	public Stock(String stockCode, int allStockNum, int liutongStockNum,
			double shouyi, double PE, double lastDayEndPrice,
			double todayStartPrice, double topPrice, double bottomPrice,
			double nowPrice, double nowCjNum, ArrayList<Cjhistory> cjhistorys,
			ArrayList<Order> buyOrders, ArrayList<Order> saleOrders) {

		this.stockCode = stockCode;
		this.allStockNum = allStockNum;
		this.liutongStockNum = liutongStockNum;
		this.shouyi = shouyi;
		this.PE = PE;

		this.lastDayEndPrice = lastDayEndPrice;
		this.todayStartPrice = todayStartPrice;
		this.topPrice = topPrice;
		this.bottomPrice = bottomPrice;
		this.nowPrice = nowPrice;
		this.nowCjNum = nowCjNum;

		this.cjhistorys = new ArrayList<Cjhistory>();// 成交笔

		this.buyOrders = new ArrayList<Order>();// 买单
		this.saleOrders = new ArrayList<Order>();// 卖单

	}

	public String getStockCode() {
		return stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public int getAllStockNum() {
		return allStockNum;
	}

	public void setAllStockNum(int allStockNum) {
		this.allStockNum = allStockNum;
	}

	public int getLiutongStockNum() {
		return liutongStockNum;
	}

	public void setLiutongStockNum(int liutongStockNum) {
		this.liutongStockNum = liutongStockNum;
	}

	public double getShouyi() {
		return shouyi;
	}

	public void setShouyi(double shouyi) {
		this.shouyi = shouyi;
	}

	public double getPE() {
		return PE;
	}

	public void setPE(double pE) {
		PE = pE;
	}

	public double getLastDayEndPrice() {
		return lastDayEndPrice;
	}

	public void setLastDayEndPrice(double lastDayEndPrice) {
		this.lastDayEndPrice = lastDayEndPrice;
	}

	public double getTodayStartPrice() {
		return todayStartPrice;
	}

	public void setTodayStartPrice(double todayStartPrice) {
		this.todayStartPrice = todayStartPrice;
	}

	public double getTopPrice() {
		return topPrice;
	}

	public void setTopPrice(double topPrice) {
		this.topPrice = topPrice;
	}

	public double getBottomPrice() {
		return bottomPrice;
	}

	public void setBottomPrice(double bottomPrice) {
		this.bottomPrice = bottomPrice;
	}

	public double getNowPrice() {
		return nowPrice;
	}

	public void setNowPrice(double nowPrice) {
		this.nowPrice = nowPrice;
	}

	public double getNowCjNum() {
		return nowCjNum;
	}

	public void setNowCjNum(double nowCjNum) {
		this.nowCjNum = nowCjNum;
	}

	public ArrayList<Cjhistory> getCjhistorys() {
		return cjhistorys;
	}

	public void setCjhistorys(ArrayList<Cjhistory> cjhistorys) {
		this.cjhistorys = cjhistorys;
	}

	public ArrayList<Order> getBuyOrders() {
		return buyOrders;
	}

	public void setBuyOrders(ArrayList<Order> buyOrders) {
		this.buyOrders = buyOrders;
	}

	public ArrayList<Order> getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(ArrayList<Order> saleOrders) {
		this.saleOrders = saleOrders;
	}

}
