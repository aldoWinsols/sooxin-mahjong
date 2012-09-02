package com.stock.services;

import java.util.List;

import com.stock.dao.Bag;
import com.stock.dao.BagDAO;
import com.stock.dao.Player;
import com.stock.dao.PlayerDAO;
import com.stock.inter.IPlayerService;
import com.stock.util.Util;

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
	
	public Object login(String playerName,String playerPwd){
		Player player = (Player) findPlayerByPlayerName(playerName);
		if(player == null){
			return "用户名或密码错误!";
		}
		
		if(!player.getPlayerPwd().equals(playerPwd)){
			return "用户名或密码错误!";
		}
		
		return player;
	}
	
	public Object regist(String playerName,String playerPwd){
		Player player = null;
		if(Util.isContainChinese(playerName)){
			return "用户名中不能包含中文！";
		}
		if(findPlayerByPlayerName(playerName) == null){
			player = new Player();
			player.setPlayerName(playerName);
			player.setPlayerPwd(playerPwd);
			player.setHaveMoney(1000000.0);
			player.setSort(0);
			playerDao.save(player);
		}else{
			return "此用户名已经被使用!";
		}
		return player;
	}
	
	public Object updatePlayerPwd(String playerName,String oldPlayerPwd,String newPlayerPwd){
		Player player = (Player) findPlayerByPlayerName(playerName);
		if(player == null){
			return "系统查找无此用户！";
		}
		
		if(!player.getPlayerPwd().equals(oldPlayerPwd)){
			return "您输入的旧密码错误！";
		}
		
		player.setPlayerPwd(newPlayerPwd);
		playerDao.merge(player);
		return player;
	}

	public List<Bag> getBagsByPlayerName(String playerName) {
		// TODO Auto-generated method stub
		return bagDao.findByPlayerName(playerName);
	}
	
}
