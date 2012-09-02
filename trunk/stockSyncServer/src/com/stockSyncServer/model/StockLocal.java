package com.stockSyncServer.model;

import java.util.ArrayList;

import com.stock.dao.Mline;

public class StockLocal {
	public String stockCode = "";// 股票代码
	public String stockName = "";//股票名称
	public int allStockNum = 0;// 总股本
	public int liutongStockNum = 0;// 流通
	public Double jinzhi; //净资
	public double shouyi = 0.0; // 收益
	public double PE = 0.0;// 市赢率

	public double lastDayEndPrice = 0.0; // 昨日收盘价格
	public int lastDayCjshou = 0; // 昨日成交笔数
	
	public double todayStartPrice = 0.0;// 今日开盘价格
	public double topPrice = 0.0;// 当日最高价格
	public double bottomPrice = 0.0; // 当日最低价
	public double nowPrice = 5.0;// 当前价格
	public double nowCjNum = 0.0;// 当前成交量
	public double allCjNum = 0.0;// 当天总成交量
	
	public double xinxinLv = 0.0;//股票本身向好率

	public ArrayList<Cjhistory> cjhistorys = new ArrayList<Cjhistory>();// 成交笔

	public ArrayList<Order> buyOrders = new ArrayList<Order>();// 买单
	public ArrayList<Order> saleOrders = new ArrayList<Order>();// 卖单
	
	public ArrayList<Mline> mlines = new ArrayList<Mline>();

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

	public double getXinxinLv() {
		return xinxinLv;
	}

	public void setXinxinLv(double xinxinLv) {
		this.xinxinLv = xinxinLv;
	}

	public Double getJinzhi() {
		return jinzhi;
	}

	public void setJinzhi(Double jinzhi) {
		this.jinzhi = jinzhi;
	}

	public int getLastDayCjshou() {
		return lastDayCjshou;
	}

	public void setLastDayCjshou(int lastDayCjshou) {
		this.lastDayCjshou = lastDayCjshou;
	}
	
	

}
