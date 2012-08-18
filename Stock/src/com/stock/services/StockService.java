package com.stock.services;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.stock.dao.Bag;
import com.stock.dao.BagDAO;
import com.stock.dao.Bshistory;
import com.stock.dao.BshistoryDAO;
import com.stock.dao.Cjhistory;
import com.stock.dao.Player;
import com.stock.dao.PlayerDAO;
import com.stock.dao.StockDAO;
import com.stock.inter.IStockService;

public class StockService implements IStockService {
	private StockDAO stockDao;
	private PlayerDAO playerDao;
	private BshistoryDAO bshistoryDao;
	private BagDAO bagDao;

	public StockDAO getStockDao() {
		return stockDao;
	}

	public void setStockDao(StockDAO stockDao) {
		this.stockDao = stockDao;
	}

	public PlayerDAO getPlayerDao() {
		return playerDao;
	}

	public void setPlayerDao(PlayerDAO playerDao) {
		this.playerDao = playerDao;
	}

	public BshistoryDAO getBshistoryDao() {
		return bshistoryDao;
	}

	public void setBshistoryDao(BshistoryDAO bshistoryDao) {
		this.bshistoryDao = bshistoryDao;
	}

	public List getStocks() {
		return stockDao.findAll();
	}

	public BagDAO getBagDao() {
		return bagDao;
	}

	public void setBagDao(BagDAO bagDao) {
		this.bagDao = bagDao;
	}

	public synchronized Object buy(String stockCode, String playerName,
			String orderNum, double wtPrice, int wtNum) {
		List li = playerDao.findByPlayerName(playerName);
		if (li.isEmpty()) {
			return "系统无此用户";
		}

		Player player = (Player) li.get(0);
		li = null;
		
		if ((player.getHaveMoney() - player.getClockMoney()) < (wtPrice * wtNum * 100)) {
			return "资金不足";
		} else {
			player.setClockMoney(player.getClockMoney()
					+ (wtPrice * wtNum * 100));

			Bshistory buyBshistory = new Bshistory();
			buyBshistory.setNum(orderNum);
			buyBshistory.setPlayerName(playerName);
			buyBshistory.setStockNum(stockCode);
			buyBshistory.setBsSort("B");
			buyBshistory.setBsNum(wtNum);
			buyBshistory.setBsWtPrice(wtPrice);
			buyBshistory.setTaxStamp(0.0);
			buyBshistory.setCommision(0.0);
			buyBshistory.setHaveCjNum(0);

			playerDao.merge(player);
			bshistoryDao.save(buyBshistory);
			return true;
		}
	}

	public synchronized Object sale(String stockCode, String playerName,
			String orderNum, double wtPrice, int wtNum) {

		Bag bagExample = new Bag();
		bagExample.setPlayerName(playerName);
		bagExample.setStockNum(stockCode);

		List list = bagDao.findByExample(bagExample);
		if (list.size() < 1) {
			return "您没有可卖的股票！";
		}

		Bag bag = (Bag) list.get(0);
		list = null;

		if ((bag.getHaveNum() - bag.getClockNum()) < wtNum) {
			return "您可卖的股票数不足！";
		} else {
			Bshistory saleBshistory = new Bshistory();
			saleBshistory.setNum(orderNum);
			saleBshistory.setPlayerName(playerName);
			saleBshistory.setStockNum(stockCode);
			saleBshistory.setBsSort("S");
			saleBshistory.setBsNum(wtNum);
			saleBshistory.setBsWtPrice(wtPrice);
			saleBshistory.setTaxStamp(0.0);
			saleBshistory.setCommision(0.0);
			saleBshistory.setHaveCjNum(0);

			bshistoryDao.save(saleBshistory);
			return true;
		}
	}

	public synchronized void blance(String stockNum, String buyPlayerName,
			String buyOrderNum, String salePlayerName, String saleOrderNum,
			String cjSort, int cjNum, Double cjPrice, String cjTime) {
		Player buyPlayer = (Player) playerDao.findByPlayerName(buyPlayerName)
				.get(0);
		Player salePlayer = (Player) playerDao.findByPlayerName(salePlayerName)
				.get(0);
		Double cjMoney = cjPrice * cjNum * 100;

		Bshistory buyBshistory = (Bshistory) bshistoryDao
				.findByNum(buyOrderNum).get(0);
		Bshistory saleBshistory = (Bshistory) bshistoryDao.findByNum(
				saleOrderNum).get(0);

		// --------------------------------------------------------------------------
		buyBshistory.setHaveCjNum(buyBshistory.getHaveCjNum()+cjNum);
		buyBshistory.setBsCjPrice(cjPrice);

		Bag buyBag = null;
		Bag bagBuyExample = new Bag();
		bagBuyExample.setPlayerName(buyPlayerName);
		bagBuyExample.setStockNum(stockNum);

		List list = bagDao.findByExample(bagBuyExample);
		if (list.size() < 1) {
			buyBag = new Bag();
			buyBag.setPlayerName(buyPlayerName);
			buyBag.setStockNum(stockNum);
			buyBag.setHaveNum(cjNum);
			buyBag.setElPrice(cjPrice);
			buyBag.setClockNum(cjNum);
		} else {
			buyBag = (Bag) list.get(0);

			buyBag
					.setElPrice(((buyBag.getHaveNum() * buyBag.getElPrice()) + (cjNum * cjPrice))
							/ (buyBag.getHaveNum() + cjNum));
			buyBag.setHaveNum(buyBag.getHaveNum() + cjNum);
			buyBag.setClockNum(buyBag.getClockNum()+cjNum);
		}
		bagDao.save(buyBag);

		// --------------------------------------------------------------------------

		saleBshistory.setHaveCjNum(saleBshistory.getHaveCjNum()+cjNum);
		saleBshistory.setBsCjPrice(cjPrice);

		Bag saleBag = null;
		Bag bagSaleExample = new Bag();
		bagSaleExample.setPlayerName(salePlayerName);
		bagSaleExample.setStockNum(stockNum);

		saleBag = (Bag) bagDao.findByExample(bagSaleExample).get(0);

		if (saleBag.getHaveNum() == cjNum) {
			saleBag.setElPrice(0.0);
		} else {
			saleBag
					.setElPrice(((saleBag.getHaveNum() * saleBag.getElPrice()) - (cjNum * cjPrice))
							/ (saleBag.getHaveNum() - cjNum));
		}

		saleBag.setHaveNum(saleBag.getHaveNum() - cjNum);

		bagDao.save(saleBag);

		// --------------------------------------------------------------------------

		buyPlayer.setHaveMoney(buyPlayer.getHaveMoney() - cjMoney);
		buyPlayer.setClockMoney(buyPlayer.getClockMoney()
				- buyBshistory.getBsWtPrice() * cjNum * 100);

		salePlayer.setHaveMoney(salePlayer.getHaveMoney() + cjMoney);

		bshistoryDao.save(buyBshistory);
		bshistoryDao.save(saleBshistory);
		playerDao.save(buyPlayer);
		playerDao.save(salePlayer);
	}

}
