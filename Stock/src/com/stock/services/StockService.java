package com.stock.services;

import java.sql.Timestamp;
import java.util.List;

import com.stock.dao.Bshistory;
import com.stock.dao.BshistoryDAO;
import com.stock.dao.Cjhistory;
import com.stock.dao.Player;
import com.stock.dao.PlayerDAO;
import com.stock.dao.StockDAO;
import com.stock.inter.IStockService;

public class StockService implements IStockService {
	private StockDAO stockDao;
	private PlayerDAO playerDao;
	private BshistoryDAO bshistoryDao;
	
	public StockDAO getStockDao() {
		return stockDao;
	}

	public void setStockDao(StockDAO stockDao) {
		this.stockDao = stockDao;
	}

	public PlayerDAO getPlayerDao() {
		return playerDao;
	}

	public void setPlayerDao(PlayerDAO playerDao) {
		this.playerDao = playerDao;
	}

	public BshistoryDAO getBshistoryDao() {
		return bshistoryDao;
	}

	public void setBshistoryDao(BshistoryDAO bshistoryDao) {
		this.bshistoryDao = bshistoryDao;
	}

	public List getStocks(){
		return stockDao.findAll();
	}
	
	public void blance(String stockNum,String buyPlayerName, String salePlayerName, String cjSort,int cjNum,Double cjPrice,Timestamp cjTime){
		Player buyPlayer = (Player) playerDao.findByPlayerName(buyPlayerName).get(0);
		Player salePlayer = (Player) playerDao.findByPlayerName(salePlayerName).get(0);
		Double cjMoney = cjPrice*cjNum;
		
		Bshistory buyBshistory = new Bshistory();
		Bshistory saleBshistory = new Bshistory();
		
		buyBshistory.setPlayerName(buyPlayerName);
		buyBshistory.setStockNum(stockNum);
		buyBshistory.setBsSort("B");
		buyBshistory.setBsNum(cjNum);
		buyBshistory.setBsPrice(cjPrice);
		buyBshistory.setTaxStamp(0.0);
		buyBshistory.setCommision(0.0);
		
		saleBshistory.setPlayerName(salePlayerName);
		saleBshistory.setStockNum(stockNum);
		saleBshistory.setBsSort("S");
		saleBshistory.setBsNum(cjNum);
		saleBshistory.setBsPrice(cjPrice);
		saleBshistory.setTaxStamp(0.0);
		saleBshistory.setCommision(0.0);
		
		bshistoryDao.save(buyBshistory);
		bshistoryDao.save(saleBshistory);
		
		buyPlayer.setHaveMoney(buyPlayer.getHaveMoney()-cjMoney);
		salePlayer.setHaveMoney(salePlayer.getHaveMoney()+cjMoney);
	}

}
