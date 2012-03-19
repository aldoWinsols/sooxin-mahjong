package com.panda.services;

import java.util.List;

import com.panda.dao.GamehistoryDAO;
import com.panda.inter.IGameHistoryService;

public class GameHistoryService implements IGameHistoryService {
	private GamehistoryDAO gamehistoryDao;

	public GamehistoryDAO getGamehistoryDao() {
		return gamehistoryDao;
	}

	public void setGamehistoryDao(GamehistoryDAO gamehistoryDao) {
		this.gamehistoryDao = gamehistoryDao;
	}

	public List findGameHistory(String playerName){
		return getGamehistoryDao().findByPlayerName(playerName);
	}
	

}
