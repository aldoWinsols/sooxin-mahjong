package com.stock.services;

import java.util.List;

import com.stock.dao.BagDAO;

public class BagService {
	private BagDAO bagDao;

	public BagDAO getBagDao() {
		return bagDao;
	}

	public void setBagDao(BagDAO bagDao) {
		this.bagDao = bagDao;
	}

	public List getBagsByPlayerName(String playerName) {
		return bagDao.findByPlayerName(playerName);
	}

}
