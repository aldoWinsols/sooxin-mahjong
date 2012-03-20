package com.panda.services;

import java.util.List;

import com.panda.dao.PlaylogDAO;
import com.panda.inter.IPlaylogService;

public class PlaylogService implements IPlaylogService {
	private PlaylogDAO playlogDao;

	public PlaylogDAO getPlaylogDao() {
		return playlogDao;
	}

	public void setPlaylogDao(PlaylogDAO playlogDao) {
		this.playlogDao = playlogDao;
	}
	
	
	public List findPlayLog(String playerName){
		return getPlaylogDao().findByPlayerName(playerName);
	}
	

}
