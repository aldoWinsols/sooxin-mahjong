package com.robertSyncServer.services;

import java.text.DecimalFormat;

import com.robertSyncServer.model.Robert;
import com.robertSyncServer.util.NumberFomart;
import com.stock.dao.Bag;

public class RobertService {
	public Robert robert;
	public int n = 1;

	public RobertService() {
		robert = new Robert();
	}

	public synchronized void todo() {
		n++;
		if (n % robert.operationNum == 0) {

			//信心指数判断买卖操作
			if (Math.random() > robert.xinxinLv) {
				for (int i = 0; i < robert.bags.size(); i++) {
					Bag bag = robert.bags.get(i);

					if (bag.getHaveNum() - bag.getClockNum() == 0) {
						break;
					}

					StockService stockService = MainService.instance
							.findStockServiceByStockCode(bag.getStockNum());
					
					//判断股票本身向好率
					if(Math.random() < stockService.stock.getXinxinLv()){
						break;
					}

					if (stockService.stock.nowPrice > bag.getElPrice()) {
						if ((stockService.stock.nowPrice - bag.getElPrice())
								/ bag.getElPrice() > robert.winLv) {
							RemoteService.instance.sale(
									stockService.stock.stockCode,
									robert.robertName,
									getRandowPrice(stockService),
									bag.getHaveNum() - bag.getClockNum());

							robert.bags.remove(i);
							i--;

							return;
						}
					} else {
						if ((stockService.stock.nowPrice - bag.getElPrice())
								/ bag.getElPrice() < robert.lossLv) {
							RemoteService.instance.sale(
									stockService.stock.stockCode,
									robert.robertName,
									getRandowPrice(stockService),
									bag.getHaveNum() - bag.getClockNum());

							robert.bags.remove(i);
							i--;

							return;
						}
					}
				}
			} else {
				if (robert.chichang == 0) {
					StockService stockService = MainService.instance.stockServices
							.get((int) (Math.random() * MainService.instance.stockServices
									.size()));

					int buyNum = (int) (robert.haveMoney * robert.chichangLv / stockService.stock
							.getNowPrice());

					if (buyNum > 100) {
						buyNum = buyNum / 100;
						double buyPrice = getRandowPrice(stockService);
						RemoteService.instance.buy(
								stockService.stock.stockCode,
								robert.robertName, buyPrice, buyNum);

						robert.haveMoney -= buyPrice * buyNum * 100;
						robert.chichang += buyPrice * buyNum * 100;
						return;
					}

				} else if ((robert.chichang
						/ (robert.chichang + robert.haveMoney)) < robert.chichangLv) {
					StockService stockService = MainService.instance.stockServices
							.get((int) (Math.random() * MainService.instance.stockServices
									.size()));
					int buyNum = (int) (((robert.haveMoney * robert.chichangLv / (1 - robert.chichangLv)) - robert.chichang) / stockService.stock
							.getNowPrice());

					if (buyNum > 100) {
						buyNum = buyNum / 100;
						double buyPrice = getRandowPrice(stockService);
						RemoteService.instance.buy(
								stockService.stock.stockCode,
								robert.robertName, buyPrice, buyNum);

						robert.haveMoney -= buyPrice * buyNum * 100;
						robert.chichang += buyPrice * buyNum * 100;
					}
				}
			}
		}
	}

	public double getRandowPrice(StockService stockService) {
		double price = 0.0;

		if (stockService.stock.getNowPrice() < 10) {
			price = stockService.stock.getNowPrice() + 0.01
					* Math.round(Math.random() * Math.random() * 7)
					* (Math.random() > 0.5 ? 1 : -1);
		} else if ((stockService.stock.getNowPrice() > 10)
				&& (stockService.stock.getNowPrice() < 100)) {
			price = stockService.stock.getNowPrice() + 0.1
					* Math.round(Math.random() * Math.random() * 7)
					* (Math.random() > 0.5 ? 1 : -1);
		} else {
			price = stockService.stock.getNowPrice() + 1
					* Math.round(Math.random() * Math.random() * 7)
					* (Math.random() > 0.5 ? 1 : -1);
		}

		return NumberFomart.for2(stockService.stock.getNowPrice());
	}

}
