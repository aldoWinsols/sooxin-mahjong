package com.stockSyncServer.services;

import java.sql.Array;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.stockSyncServer.model.Cjhistory;
import com.stockSyncServer.model.Order;
import com.stockSyncServer.model.Stock;
import com.stockSyncServer.util.ComparatorAsc;
import com.stockSyncServer.util.ComparatorDesc;
import com.stockSyncServer.util.NumberFomart;

public class StockService {

	public Stock stock;

	private ComparatorAsc comparatorAsc = new ComparatorAsc(); // 升序
	private ComparatorDesc comparatorDesc = new ComparatorDesc(); // 降序

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		StockService stockService = new StockService();
		// stockService.balance();
	}

	public StockService() {
		stock = new Stock();
	}

	private String cjSort = "";

	private ArrayList<Cjhistory> thisCjhistoryS = new ArrayList<Cjhistory>();
	public synchronized void balance() {
		if (stock.buyOrders.size() > 0 && stock.saleOrders.size() > 0) {
			if (stock.buyOrders.get(0).getWtPrice() >= stock.saleOrders.get(0)
					.getWtPrice()) {
				if (stock.buyOrders.get(0).getWtNum() == stock.saleOrders
						.get(0).getWtNum()) {

					Cjhistory cjhistory = new Cjhistory();
					cjhistory.setCjTime(new Timestamp(new Date().getTime()));
					cjhistory.setCjNum(stock.buyOrders.get(0).getWtNum());
					cjhistory
							.setCjPrice((stock.buyOrders.get(0).getWtPrice() + stock.saleOrders
									.get(0).getWtPrice()) / 2);
					cjhistory.setCjPrice(NumberFomart.for2(cjhistory.getCjPrice()));
					cjhistory.setCjSort(cjSort);
					stock.cjhistorys.add(cjhistory);

					// -----------------------------------------------------------------
					stock.setNowPrice(cjhistory.getCjPrice());
					stock.setNowCjNum(stock.getNowCjNum()
							+ cjhistory.getCjNum() * cjhistory.getCjPrice());

					if (stock.getNowPrice() > stock.getTopPrice()) {
						stock.setTopPrice(stock.getNowPrice());
					}
					if (stock.getNowPrice() < stock.getBottomPrice()) {
						stock.setBottomPrice(stock.getNowPrice());
					}
					// ------------------------------------------------------------------

					System.out.println("成交数量："
							+ stock.buyOrders.get(0).getWtNum());
					stock.buyOrders.remove(0);
					stock.saleOrders.remove(0);

					thisCjhistoryS.add(cjhistory);
					balance();
				} else if (stock.buyOrders.get(0).getWtNum() > stock.saleOrders
						.get(0).getWtNum()) {

					Cjhistory cjhistory = new Cjhistory();
					cjhistory.setCjTime(new Timestamp(new Date().getTime()));
					cjhistory.setCjNum(stock.buyOrders.get(0).getWtNum());
					cjhistory
							.setCjPrice((stock.buyOrders.get(0).getWtPrice() + stock.saleOrders
									.get(0).getWtPrice()) / 2);
					cjhistory.setCjPrice(NumberFomart.for2(cjhistory.getCjPrice()));
					cjhistory.setCjSort(cjSort);
					stock.cjhistorys.add(cjhistory);

					// -----------------------------------------------------------------
					stock.setNowPrice(cjhistory.getCjPrice());
					stock.setNowCjNum(stock.getNowCjNum()
							+ cjhistory.getCjNum() * cjhistory.getCjPrice());

					if (stock.getNowPrice() > stock.getTopPrice()) {
						stock.setTopPrice(stock.getNowPrice());
					}
					if (stock.getNowPrice() < stock.getBottomPrice()) {
						stock.setBottomPrice(stock.getNowPrice());
					}
					// ------------------------------------------------------------------

					System.out.println("成交数量："
							+ stock.saleOrders.get(0).getWtNum());

					stock.buyOrders.get(0).setWtNum(
							stock.buyOrders.get(0).getWtNum()
									- stock.saleOrders.get(0).getWtNum());
					stock.saleOrders.remove(0);

					thisCjhistoryS.add(cjhistory);
					balance();
				} else {

					Cjhistory cjhistory = new Cjhistory();
					cjhistory.setCjTime(new Timestamp(new Date().getTime()));
					cjhistory.setCjNum(stock.saleOrders.get(0).getWtNum());
					cjhistory
							.setCjPrice((stock.buyOrders.get(0).getWtPrice() + stock.saleOrders
									.get(0).getWtPrice()) / 2);
					cjhistory.setCjPrice(NumberFomart.for2(cjhistory.getCjPrice()));
					cjhistory.setCjSort(cjSort);
					stock.cjhistorys.add(cjhistory);

					// -----------------------------------------------------------------
					stock.setNowPrice(cjhistory.getCjPrice());
					stock.setNowCjNum(stock.getNowCjNum()
							+ cjhistory.getCjNum() * cjhistory.getCjPrice());

					if (stock.getNowPrice() > stock.getTopPrice()) {
						stock.setTopPrice(stock.getNowPrice());
					}
					if (stock.getNowPrice() < stock.getBottomPrice()) {
						stock.setBottomPrice(stock.getNowPrice());
					}
					// ------------------------------------------------------------------

					System.out.println("成交数量："
							+ stock.buyOrders.get(0).getWtNum());

					stock.saleOrders.get(0).setWtNum(
							stock.saleOrders.get(0).getWtNum()
									- stock.buyOrders.get(0).getWtNum());
					stock.buyOrders.remove(0);

					thisCjhistoryS.add(cjhistory);
					balance();
				}
			} else {
				MessageService.instance
				.broadcast(new Object[] { stock.stockCode,
						stock.getTopPrice(),
						stock.getBottomPrice(),
						stock.getNowPrice(), stock.getNowCjNum(),
						JSONArray.fromObject(stock.buyOrders),
						JSONArray.fromObject(stock.saleOrders),
						JSONArray.fromObject(thisCjhistoryS) });
				thisCjhistoryS.removeAll(thisCjhistoryS);
			}
		} else {
			MessageService.instance
			.broadcast(new Object[] { stock.stockCode,
					stock.getTopPrice(),
					stock.getBottomPrice(),
					stock.getNowPrice(), stock.getNowCjNum(),
					JSONArray.fromObject(stock.buyOrders),
					JSONArray.fromObject(stock.saleOrders),
					JSONArray.fromObject(thisCjhistoryS) });
			thisCjhistoryS.removeAll(thisCjhistoryS);
		}
	}

	
	public synchronized void buy(String playerName, double wtPrice, int wtNum) {
		cjSort = "B";

		Order order = new Order();
		order.setPlayerName(playerName);
		order.setWtPrice(wtPrice);
		order.setWtNum(wtNum);
		stock.buyOrders.add(order);

		Collections.sort(stock.buyOrders, comparatorAsc);
		balance();
	}

	public synchronized void sale(String playerName, double wtPrice, int wtNum) {
		cjSort = "S";

		Order order = new Order();
		order.setPlayerName(playerName);
		order.setWtPrice(wtPrice);
		order.setWtNum(wtNum);
		stock.saleOrders.add(order);

		Collections.sort(stock.saleOrders, comparatorDesc);
		balance();
	}
}
