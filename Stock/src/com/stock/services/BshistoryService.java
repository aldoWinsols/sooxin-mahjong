package com.stock.services;

import java.util.List;

import com.stock.dao.Bshistory;
import com.stock.dao.BshistoryDAO;

public class BshistoryService {
	private BshistoryDAO bshistoryDao;

	public BshistoryDAO getBshistoryDao() {
		return bshistoryDao;
	}

	public void setBshistoryDao(BshistoryDAO bshistoryDao) {
		this.bshistoryDao = bshistoryDao;
	}

	public void saveBshistory(Bshistory bshistory){
		bshistoryDao.save(bshistory);
	}
	
	public List getBshistoryByPlayerName(String playerName){
		return bshistoryDao.findByPlayerName(playerName);
	}
}
