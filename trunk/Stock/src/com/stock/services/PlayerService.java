package com.stock.services;

import java.util.List;

import com.stock.dao.Player;
import com.stock.dao.PlayerDAO;

public class PlayerService {
	private PlayerDAO playerDao;

	public PlayerDAO getPlayerDao() {
		return playerDao;
	}

	public void setPlayerDao(PlayerDAO playerDao) {
		this.playerDao = playerDao;
	}
	
	public Player findPlayerByPlayerName(String playerName){
		List li = playerDao.findByPlayerName(playerName);
		if(li.size()>0){
			return (Player) li.get(0);
		}
		
		return null;
	}
}
