package com.stockSyncServer.services;

import java.sql.Timestamp;

import org.slf4j.Logger;

import com.stock.inter.IStockService;
import com.stockSyncServer.dataServices.DataService;
import com.stockSyncServer.util.UtilProperties;

public class BalanceService extends Thread implements Runnable{
	private Logger log = null;
	private IStockService stockService = null;
	
	private String stockNum = "";
	private String cjSort = "";
	private int cjNum =0;
	private Double cjPrice = 0.0;
	private Timestamp cjTime;
	
	private String buyPlayerName = ""; 
	private String salePlayerName = "";
	public BalanceService(String stockNum,String buyPlayerName, String salePlayerName, String cjSort,int cjNum,Double cjPrice,Timestamp cjTime){
		log = UtilProperties.instance.getLogger(DataService.class);
		stockService = (IStockService) ConfigService.getInstance().getContext().getBean("stockService");
		
		this.stockNum = stockNum;
		this.buyPlayerName = buyPlayerName;
		this.salePlayerName = salePlayerName;
		this.cjSort = cjSort;
		this.cjNum = cjNum;
		this.cjPrice = cjPrice;
		this.cjTime = cjTime;
	}
	
	public void run() {
		stockService.blance(stockNum, salePlayerName, salePlayerName, salePlayerName, cjNum, cjPrice, cjTime);
	}
}
