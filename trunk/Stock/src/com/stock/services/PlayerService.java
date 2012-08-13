package com.stock.services;

import java.util.List;

import com.stock.dao.Bag;
import com.stock.dao.BagDAO;
import com.stock.dao.Player;
import com.stock.dao.PlayerDAO;
import com.stock.inter.IPlayerService;

public class PlayerService implements IPlayerService {
	private PlayerDAO playerDao;
	private BagDAO bagDao;

	public PlayerDAO getPlayerDao() {
		return playerDao;
	}

	public void setPlayerDao(PlayerDAO playerDao) {
		this.playerDao = playerDao;
	}
	
	public BagDAO getBagDao() {
		return bagDao;
	}

	public void setBagDao(BagDAO bagDao) {
		this.bagDao = bagDao;
	}

	public List getRoberts(){
		return playerDao.findBySort(0);
	}
	
	public Object findPlayerByPlayerName(String playerName){
		List li = playerDao.findByPlayerName(playerName);
		if(li.size()>0){
			return (Player) li.get(0);
		}
		
		return null;
	}
	
	public Object regeist(String playerName,String playerPwd){
		Player player = null;
		if(findPlayerByPlayerName(playerName) == null){
			player = new Player();
			player.setPlayerName(playerName);
			player.setPlayerPwd(playerPwd);
			player.setHaveMoney(1000000.0);
			player.setSort(0);
			playerDao.save(player);
		}
		return player;
	}
	
	public List<Bag> getBagsByPlayerName(String playerName){
		return bagDao.findByPlayerName(playerName);
	}
}
