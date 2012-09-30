package com.stock.services;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.stock.dao.Bag;
import com.stock.dao.BagDAO;
import com.stock.dao.Chongzhilog;
import com.stock.dao.ChongzhilogDAO;
import com.stock.dao.Player;
import com.stock.dao.PlayerDAO;
import com.stock.dao.Stock;
import com.stock.dao.StockDAO;
import com.stock.inter.IPlayerService;
import com.stock.util.ComparatorDesc;
import com.stock.util.Util;

public class PlayerService implements IPlayerService {
	
	private PlayerDAO playerDao;
	private BagDAO bagDao;
	
	private ChongzhilogDAO chongzhilogDao;
	private StockDAO stockDao;

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

	public ChongzhilogDAO getChongzhilogDao() {
		return chongzhilogDao;
	}

	public void setChongzhilogDao(ChongzhilogDAO chongzhilogDao) {
		this.chongzhilogDao = chongzhilogDao;
	}

	public StockDAO getStockDao() {
		return stockDao;
	}

	public void setStockDao(StockDAO stockDao) {
		this.stockDao = stockDao;
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
	
	public void buildPaihang() {
		// TODO Auto-generated method stub
		ArrayList<Player> players = (ArrayList<Player>) playerDao.findAll();
		for (Player player : players) {
			double zichan = 0.0;
			List<Bag> bags =  bagDao.findByPlayerName(player.getPlayerName());
			for (Bag bag : bags) {
				Stock stock = (Stock) stockDao.findByStockCode(bag.getStockNum());
				zichan += bag.getHaveNum()*stock.getLastDayEndPrice();
			}
			
			List<Chongzhilog> chongzhilogs = chongzhilogDao.findByPlayerName(player.getPlayerName());
			for (Chongzhilog chongzhilog : chongzhilogs) {
				zichan -= chongzhilog.getChongzhiMoney();
			}
			
			player.setRealMoney(zichan+player.getHaveMoney());
			playerDao.merge(player);
		}
	}

	ComparatorDesc comparatorDesc = new ComparatorDesc(); // 降序
	@SuppressWarnings("unchecked")
	public List getPaihang() {
		// TODO Auto-generated method stub
		List list = playerDao.findAll();	
		Collections.sort(list, comparatorDesc);
		
		ArrayList<Object> listR = new ArrayList<Object>();
		for (int i = 0; i < 100; i++) {
			listR.add(list.get(i));
		}
		return listR;
	}
	
}
