package com.stock.services;

import java.util.List;

import com.stock.dao.StockDAO;
import com.stock.inter.IStockService;

public class StockService implements IStockService {
	private StockDAO stockDao;
	
	public StockDAO getStockDao() {
		return stockDao;
	}

	public void setStockDao(StockDAO stockDao) {
		this.stockDao = stockDao;
	}

	public List getStocks(){
		return stockDao.findAll();
	}

}
