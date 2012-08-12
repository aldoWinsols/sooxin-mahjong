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
import com.stockSyncServer.services.thread.Balance;
import com.stockSyncServer.services.thread.BalanceService;
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
	private ArrayList<Cjhistory> msgCjhistoryS = new ArrayList<Cjhistory>();

	public synchronized void balance() {
		if (stock.buyOrders.size() > 0 && stock.saleOrders.size() > 0) {
			if (stock.buyOrders.get(0).getWtPrice() >= stock.saleOrders.get(0)
					.getWtPrice()) {
				if (stock.buyOrders.get(0).getWtNum() == stock.saleOrders
						.get(0).getWtNum()) {

					Cjhistory cjhistory = new Cjhistory();
					cjhistory.setCjTime(new Timestamp(new Date().getTime()));
					cjhistory.setCjNum(stock.buyOrders.get(0).getWtNum());
					cjhistory.setCjPrice(stock.saleOrders.get(0).getWtPrice());
					cjhistory.setCjPrice(NumberFomart.for2(cjhistory
							.getCjPrice()));
					cjhistory.setCjSort(cjSort);
					// stock.cjhistorys.add(cjhistory);

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

					// --------------------------------------------------------------------
					// 添加结算写数据任务
					BalanceService.instance.addTask(stock.stockCode, stock.buyOrders
							.get(0).getPlayerName(), stock.buyOrders.get(0)
							.getOrderNum(), stock.saleOrders.get(0)
							.getPlayerName(), stock.saleOrders.get(0)
							.getOrderNum(), cjSort, cjhistory.getCjNum(),
							cjhistory.getCjPrice(), cjhistory.getCjTime());

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
					cjhistory.setCjNum(stock.saleOrders.get(0).getWtNum());

					if (cjSort.equals("B")) {
						cjhistory.setCjPrice(stock.saleOrders.get(0)
								.getWtPrice());
					} else {
						cjhistory.setCjPrice(stock.buyOrders.get(0)
								.getWtPrice());
					}

					cjhistory.setCjPrice(NumberFomart.for2(cjhistory
							.getCjPrice()));
					cjhistory.setCjSort(cjSort);
					// stock.cjhistorys.add(cjhistory);

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

					// --------------------------------------------------------------------
					// 添加结算写数据任务
					BalanceService.instance.addTask(stock.stockCode, stock.buyOrders
							.get(0).getPlayerName(), stock.buyOrders.get(0)
							.getOrderNum(), stock.saleOrders.get(0)
							.getPlayerName(), stock.saleOrders.get(0)
							.getOrderNum(), cjSort, cjhistory.getCjNum(),
							cjhistory.getCjPrice(), cjhistory.getCjTime());

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
					cjhistory.setCjNum(stock.buyOrders.get(0).getWtNum());

					if (cjSort.equals("B")) {
						cjhistory.setCjPrice(stock.saleOrders.get(0)
								.getWtPrice());
					} else {
						cjhistory.setCjPrice(stock.buyOrders.get(0)
								.getWtPrice());
					}
					cjhistory.setCjPrice(NumberFomart.for2(cjhistory
							.getCjPrice()));
					cjhistory.setCjSort(cjSort);
					// stock.cjhistorys.add(cjhistory);

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

					// --------------------------------------------------------------------
					// 添加结算写数据任务
					BalanceService.instance.addTask(stock.stockCode, stock.buyOrders
							.get(0).getPlayerName(), stock.buyOrders.get(0)
							.getOrderNum(), stock.saleOrders.get(0)
							.getPlayerName(), stock.saleOrders.get(0)
							.getOrderNum(), cjSort, cjhistory.getCjNum(),
							cjhistory.getCjPrice(), cjhistory.getCjTime());

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
				if (thisCjhistoryS.size() > 0) {
					msgCjhistoryS.add(new Cjhistory());

					msgCjhistoryS.get(0).setCjTime(
							new Timestamp(new Date().getTime()));
					for (int i = 0; i < thisCjhistoryS.size(); i++) {
						msgCjhistoryS.get(0).setCjNum(
								msgCjhistoryS.get(0).getCjNum()
										+ thisCjhistoryS.get(i).getCjNum());
						msgCjhistoryS.get(0).setCjPrice(
								thisCjhistoryS.get(i).getCjPrice());
						msgCjhistoryS.get(0).setCjSort(cjSort);
					}

					stock.cjhistorys.add(msgCjhistoryS.get(0));
					thisCjhistoryS.removeAll(thisCjhistoryS);
				}

				MessageService.instance.broadcastJiaoyi(new Object[] {
						stock.stockCode, stock.getTopPrice(),
						stock.getBottomPrice(), stock.getNowPrice(),
						stock.getNowCjNum(),
						JSONArray.fromObject(stock.buyOrders),
						JSONArray.fromObject(stock.saleOrders),
						JSONArray.fromObject(msgCjhistoryS) });

				msgCjhistoryS.removeAll(msgCjhistoryS);
			}
		} else {
			if (thisCjhistoryS.size() > 0) {
				msgCjhistoryS.add(new Cjhistory());

				msgCjhistoryS.get(0).setCjTime(
						new Timestamp(new Date().getTime()));
				for (int i = 0; i < thisCjhistoryS.size(); i++) {
					msgCjhistoryS.get(0).setCjNum(
							msgCjhistoryS.get(0).getCjNum()
									+ thisCjhistoryS.get(i).getCjNum());
					msgCjhistoryS.get(0).setCjPrice(
							thisCjhistoryS.get(i).getCjPrice());
					msgCjhistoryS.get(0).setCjSort(cjSort);
				}

				stock.cjhistorys.add(msgCjhistoryS.get(0));
				thisCjhistoryS.removeAll(thisCjhistoryS);
			}

			MessageService.instance.broadcastJiaoyi(new Object[] {
					stock.stockCode, stock.getTopPrice(),
					stock.getBottomPrice(), stock.getNowPrice(),
					stock.getNowCjNum(), JSONArray.fromObject(stock.buyOrders),
					JSONArray.fromObject(stock.saleOrders),
					JSONArray.fromObject(msgCjhistoryS) });

			msgCjhistoryS.removeAll(msgCjhistoryS);
		}
	}

	public synchronized void buy(String playerName,String orderNum, double wtPrice, int wtNum) {
		cjSort = "B";

		Order order = new Order();
		order.setPlayerName(playerName);
		order.setOrderNum(orderNum);
		order.setWtPrice(wtPrice);
		order.setWtNum(wtNum);
		stock.buyOrders.add(order);

		Collections.sort(stock.buyOrders, comparatorAsc);
		balance();
	}

	public synchronized void sale(String playerName,String orderNum, double wtPrice, int wtNum) {
		cjSort = "S";

		Order order = new Order();
		order.setPlayerName(playerName);
		order.setOrderNum(orderNum);
		order.setWtPrice(wtPrice);
		order.setWtNum(wtNum);
		stock.saleOrders.add(order);

		Collections.sort(stock.saleOrders, comparatorDesc);
		balance();
	}
}
