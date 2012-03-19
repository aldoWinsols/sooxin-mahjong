package com.panda.services;

import java.util.List;

import com.panda.dao.DuihuanlogDAO;
import com.panda.inter.IDuihuanService;

public class DuihuanService implements IDuihuanService {
	
	private DuihuanlogDAO duihuanlogDao;

	public DuihuanlogDAO getDuihuanlogDao() {
		return duihuanlogDao;
	}

	public void setDuihuanlogDao(DuihuanlogDAO duihuanlogDao) {
		this.duihuanlogDao = duihuanlogDao;
	}
	
	public List findDuizhuanLog(String playerName){
		return getDuihuanlogDao().findByPlayerName(playerName);
	}

}
