package com.stock.services;

import java.util.List;

import com.stock.dao.Bag;
import com.stock.dao.BagDAO;
import com.stock.dao.Ipo;
import com.stock.dao.IpoDAO;
import com.stock.dao.Player;
import com.stock.dao.PlayerDAO;
import com.stock.inter.IIpoService;

public class IpoService implements IIpoService {

	private IpoDAO ipoDao;
	private PlayerDAO playerDao;
	private BagDAO bagDao;
	
	public IpoDAO getIpoDao() {
		return ipoDao;
	}

	public void setIpoDao(IpoDAO ipoDao) {
		this.ipoDao = ipoDao;
	}
	
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

	public Ipo getIpo() {
		// TODO Auto-generated method stub
		List list = ipoDao.findAll();
		
		if(!list.isEmpty()){
			return (Ipo) ipoDao.findAll().get(0);
		}
		
		return null;
		
	}
	
	public Object buy(String playerName, int num){
		List list = ipoDao.findAll();
		if(list.isEmpty()){
			return "没有可申购的股票！";
		}
		
		Ipo ipo = (Ipo) list.get(0);
		if((ipo.getHaveBuyNum()+num) > ipo.getBusNum()){
			return "此股票数量不够您申购，请调整数量再尝试！";
		}
		
		Player player = (Player) playerDao.findByPlayerName(playerName).get(0);
		
		if((player.getHaveMoney()-player.getClockMoney()) < (ipo.getPrice()*num)){
			return "您的资金不足申够此数量股票！";
		}

		Bag bag = new Bag();
		bag.setPlayerName(playerName);
		bag.setClockNum(0);
		bag.setElPrice(ipo.getPrice());
		bag.setHaveNum(num);
		bag.setStockNum(ipo.getStockCode());
		
		ipo.setHaveBuyNum(ipo.getHaveBuyNum()+num);
		player.setHaveMoney(player.getHaveMoney() - (ipo.getPrice()*num));
		
		bagDao.save(bag);
		playerDao.merge(player);
		ipoDao.merge(ipo);
		
		return player;
		
		
	}

}
