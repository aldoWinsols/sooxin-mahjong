package com.panda.services;

import java.util.List;

import com.panda.dao.ChongzhilogDAO;
import com.panda.inter.IChongzhiService;

public class ChongzhiService implements IChongzhiService {
	private ChongzhilogDAO chongzhiDao;

	public ChongzhilogDAO getChongzhiDao() {
		return chongzhiDao;
	}

	public void setChongzhiDao(ChongzhilogDAO chongzhiDao) {
		this.chongzhiDao = chongzhiDao;
	}
	
	public List findChongzhiLog(String playerName){
		return getChongzhiDao().findByPlayerName(playerName);
	}

}
