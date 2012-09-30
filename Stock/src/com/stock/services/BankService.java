package com.stock.services;

import java.util.ArrayList;
import java.util.List;

import com.stock.dao.Bag;
import com.stock.dao.BagDAO;
import com.stock.dao.Bank;
import com.stock.dao.BankDAO;
import com.stock.dao.Config;
import com.stock.dao.ConfigDAO;
import com.stock.dao.Player;
import com.stock.dao.PlayerDAO;
import com.stock.dao.Stock;
import com.stock.dao.StockDAO;
import com.stock.inter.IBankService;

public class BankService implements IBankService{
	
	private PlayerDAO playerDao;
	private BankDAO bankDao;
	private ConfigDAO configDao;
	private StockDAO stockDao;
	private BagDAO bagDao;
	
	public PlayerDAO getPlayerDao() {
		return playerDao;
	}

	public void setPlayerDao(PlayerDAO playerDao) {
		this.playerDao = playerDao;
	}

	public BankDAO getBankDao() {
		return bankDao;
	}

	public void setBankDao(BankDAO bankDao) {
		this.bankDao = bankDao;
	}

	public ConfigDAO getConfigDao() {
		return configDao;
	}

	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}

	public StockDAO getStockDao() {
		return stockDao;
	}

	public void setStockDao(StockDAO stockDao) {
		this.stockDao = stockDao;
	}

	public BagDAO getBagDao() {
		return bagDao;
	}

	public void setBagDao(BagDAO bagDao) {
		this.bagDao = bagDao;
	}

	public Object loan(String playerName, double money, int days) {
		// TODO Auto-generated method stub
		Bank eg = new Bank();
		eg.setPlayerName(playerName);
		eg.setSort("loan");
		eg.setState(0);
		
		ArrayList<Bank> banks = (ArrayList<Bank>) bankDao.findByExample(eg);
		double haveLoanMoney = 0.0;
		
		for (Bank bank : banks) {
			haveLoanMoney += bank.getMoney();
		}
		
		double allZhichan = 0.0;
		Player player  = (Player) playerDao.findByPlayerName(playerName).get(0);
		allZhichan = player.getHaveMoney();
		
		ArrayList<Bag> bags = (ArrayList<Bag>) bagDao.findByPlayerName(playerName);
		
		for (Bag bag : bags) {
			Stock stock = (Stock) stockDao.findByStockCode(bag.getStockNum()).get(0);
			allZhichan += bag.getHaveNum()* stock.getLastDayEndPrice();
		}
		
		if((allZhichan-haveLoanMoney)*player.getXinyongLv() < money){
			return "您不能再贷更多资金！";
		}
		
		Config config = (Config) configDao.findAll().get(0);
		
		Bank bank = new Bank();
		bank.setSort("loan");
		bank.setPlayerName(playerName);
		bank.setMoney(money);
		bank.setDays(days);
		bank.setLv(config.getDayLoanLv());
		
		player.setHaveMoney(player.getHaveMoney()+money);
		
		bankDao.save(bank);
		playerDao.merge(player);
		
		return player;
		
	}
	
	public Object deposit(String playerName, double money, int days) {
		// TODO Auto-generated method stub
		Player player = (Player) playerDao.findByPlayerName(playerName).get(0);
		
		if((player.getHaveMoney()-player.getClockMoney())<money){
			return "您的资金不足！";
		}
		
		Config config = (Config) configDao.findAll().get(0);
		
		Bank bank = new Bank();
		bank.setPlayerName(playerName);
		bank.setMoney(money);
		bank.setDays(days);
		bank.setLv(config.getDayDepositLv());
		
		player.setHaveMoney(player.getHaveMoney()-money);
		
		bankDao.save(bank);
		playerDao.merge(player);
		
		return player;
		
	}

	public List getBanks(String playerName) {
		// TODO Auto-generated method stub
		return bankDao.findByPlayerName(playerName);
	}

	

	public void undeposit(String id) {
		// TODO Auto-generated method stub
		
	}

	public void unloan(String id) {
		// TODO Auto-generated method stub
		
	}

}
