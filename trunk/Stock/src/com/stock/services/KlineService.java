package com.stock.services;

import java.util.List;

import com.stock.dao.KlineDAO;

public class KlineService {
	private KlineDAO klineDao;

	public KlineDAO getKlineDao() {
		return klineDao;
	}

	public void setKlineDao(KlineDAO klineDao) {
		this.klineDao = klineDao;
	}
	
	public List getKlinesByStockCode(String stockCode){
		return klineDao.findByStockCode(stockCode);
	}
	

}
