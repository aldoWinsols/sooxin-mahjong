package com.stock.services;

import java.util.List;

import com.stock.dao.TenplayerDAO;
import com.stock.inter.ITenPlayerService;

public class TenPlayerService implements ITenPlayerService{
	private TenplayerDAO tenplayerDao;

	public TenplayerDAO getTenplayerDao() {
		return tenplayerDao;
	}

	public void setTenplayerDao(TenplayerDAO tenplayerDao) {
		this.tenplayerDao = tenplayerDao;
	}
	
	public List getTenPlayers(String stockCode){
		return tenplayerDao.findByStockCode(stockCode);
	}
}
