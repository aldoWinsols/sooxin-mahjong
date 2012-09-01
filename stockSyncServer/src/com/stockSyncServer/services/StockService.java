package com.stockSyncServer.services;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

import net.sf.json.JSONArray;

import com.stock.inter.IStockService;
import com.stockSyncServer.model.Cjhistory;
import com.stockSyncServer.model.Order;
import com.stockSyncServer.model.StockLocal;
import com.stockSyncServer.services.thread.BalanceJingjiaService;
import com.stockSyncServer.services.thread.BalanceService;
import com.stockSyncServer.services.thread.CjhistoryDataService;
import com.stockSyncServer.services.thread.OrderCancelService;
import com.stockSyncServer.util.ComparatorAsc;
import com.stockSyncServer.util.ComparatorDesc;
import com.stockSyncServer.util.NumberFomart;

public class StockService {

	public StockLocal stock;

	private ComparatorAsc comparatorAsc = new ComparatorAsc(); // 升序
	private ComparatorDesc comparatorDesc = new ComparatorDesc(); // 降序
	
	public IStockService stockService;

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	public StockService() {
		stock = new StockLocal();
	}

	private String cjSort = "";

	private ArrayList<Cjhistory> thisCjhistoryS = new ArrayList<Cjhistory>();
	private ArrayList<Cjhistory> msgCjhistoryS = new ArrayList<Cjhistory>();
	
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.sss");
	
	//竞价结束，开始交易
	public void statJiaoyi(){
		stock.todayStartPrice = stock.nowPrice;
		stock.topPrice = stock.nowPrice;
		stock.bottomPrice = stock.nowPrice;
	}
	
	public void balance() {
		if (stock.buyOrders.size() > 0 && stock.saleOrders.size() > 0) {
			if (stock.buyOrders.get(0).getWtPrice() >= stock.saleOrders.get(0)
					.getWtPrice()) {
				if (stock.buyOrders.get(0).getWtNum() == stock.saleOrders
						.get(0).getWtNum()) {

					Cjhistory cjhistory = new Cjhistory();
					cjhistory.setCjTime(dateFormat.format(new Date()));
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
					cjhistory.setCjTime(dateFormat.format(new Date()));
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
					cjhistory.setCjTime(dateFormat.format(new Date()));
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

					msgCjhistoryS.get(0).setStockCode(this.stock.stockCode);
					msgCjhistoryS.get(0).setCjTime(dateFormat.format(new Date()));
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
				
				if(msgCjhistoryS.size()>0){
					CjhistoryDataService.instance.addTask(msgCjhistoryS.get(0));
				}

				msgCjhistoryS.removeAll(msgCjhistoryS);
			}
		} else {
			if (thisCjhistoryS.size() > 0) {
				msgCjhistoryS.add(new Cjhistory());

				msgCjhistoryS.get(0).setStockCode(this.stock.stockCode);
				msgCjhistoryS.get(0).setCjTime(dateFormat.format(new Date()));
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
			
			if(msgCjhistoryS.size()>0){
				CjhistoryDataService.instance.addTask(msgCjhistoryS.get(0));
			}

			msgCjhistoryS.removeAll(msgCjhistoryS);
		}
	}
	
	//产生集合竞价
	public void balanceJingjia() {
		if (stock.buyOrders.size() > 0 && stock.saleOrders.size() > 0) {
			if (stock.buyOrders.get(0).getWtPrice() >= stock.saleOrders.get(0)
					.getWtPrice()) {
				if (stock.buyOrders.get(0).getWtNum() == stock.saleOrders
						.get(0).getWtNum()) {

					Cjhistory cjhistory = new Cjhistory();
					cjhistory.setCjTime(dateFormat.format(new Date()));
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
					BalanceJingjiaService.instance.addTask(stock.stockCode, stock.buyOrders
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

					balanceJingjia();
				} else if (stock.buyOrders.get(0).getWtNum() > stock.saleOrders
						.get(0).getWtNum()) {

					Cjhistory cjhistory = new Cjhistory();
					cjhistory.setCjTime(dateFormat.format(new Date()));
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
					BalanceJingjiaService.instance.addTask(stock.stockCode, stock.buyOrders
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
					balanceJingjia();
				} else {

					Cjhistory cjhistory = new Cjhistory();
					cjhistory.setCjTime(dateFormat.format(new Date()));
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
					BalanceJingjiaService.instance.addTask(stock.stockCode, stock.buyOrders
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
					balanceJingjia();
				}
			} else {
				if (thisCjhistoryS.size() > 0) {
					msgCjhistoryS.add(new Cjhistory());

					msgCjhistoryS.get(0).setStockCode(this.stock.stockCode);
					msgCjhistoryS.get(0).setCjTime(dateFormat.format(new Date()));
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
				
//				BalanceJingjiaService.instance.start();// 结算集合竞价
				
				if(msgCjhistoryS.size()>0){
					CjhistoryDataService.instance.addTask(msgCjhistoryS.get(0));
				}

				msgCjhistoryS.removeAll(msgCjhistoryS);
			}
		} else {
			if (thisCjhistoryS.size() > 0) {
				msgCjhistoryS.add(new Cjhistory());

				msgCjhistoryS.get(0).setStockCode(this.stock.stockCode);
				msgCjhistoryS.get(0).setCjTime(dateFormat.format(new Date()));
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
			
//			BalanceJingjiaService.instance.start();// 结算集合竞价
			
			if(msgCjhistoryS.size()>0){
				CjhistoryDataService.instance.addTask(msgCjhistoryS.get(0));
			}

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
		
		if(!MainService.instance.isJingjia){
			balance();
		}
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
		
		if(!MainService.instance.isJingjia){
			balance();
		}
	}
	
	public synchronized void cancel(String orderNum){
		for(int i=0; i<stock.buyOrders.size();i++){
			if(stock.buyOrders.get(i).getOrderNum().equals(orderNum)){
				stock.buyOrders.remove(i);
				
				//修改数据库
				OrderCancelService.instance.orderCancelTasks.add(orderNum);
				
				MessageService.instance.broadcastJiaoyi(new Object[] {
						stock.stockCode, stock.getTopPrice(),
						stock.getBottomPrice(), stock.getNowPrice(),
						stock.getNowCjNum(), JSONArray.fromObject(stock.buyOrders),
						JSONArray.fromObject(stock.saleOrders),
						JSONArray.fromObject(msgCjhistoryS) });
				
				return;
			}
		}
		
		for(int i=0; i<stock.saleOrders.size();i++){
			if(stock.saleOrders.get(i).getOrderNum().equals(orderNum)){
				stock.saleOrders.remove(i);
				
				//修改数据库
				OrderCancelService.instance.orderCancelTasks.add(orderNum);
				
				MessageService.instance.broadcastJiaoyi(new Object[] {
						stock.stockCode, stock.getTopPrice(),
						stock.getBottomPrice(), stock.getNowPrice(),
						stock.getNowCjNum(), JSONArray.fromObject(stock.buyOrders),
						JSONArray.fromObject(stock.saleOrders),
						JSONArray.fromObject(msgCjhistoryS) });
				
				return;
			}
		}
	}
	
	public void end(){
		String orderNums = null;
		
		for(int i=0; i<stock.buyOrders.size();i++){
			orderNums += stock.buyOrders.get(i).getOrderNum() + ",";
		}
		for(int i=0; i<stock.saleOrders.size();i++){
			orderNums += stock.saleOrders.get(i).getOrderNum() + ",";
		}
		
		stockService.end(orderNums);
		
		stock.buyOrders.clear();
		stock.saleOrders.clear();
		
		MessageService.instance.broadcastJiaoyi(new Object[] {
				stock.stockCode, stock.getTopPrice(),
				stock.getBottomPrice(), stock.getNowPrice(),
				stock.getNowCjNum(), JSONArray.fromObject(stock.buyOrders),
				JSONArray.fromObject(stock.saleOrders),
				JSONArray.fromObject(msgCjhistoryS) });
	}
}
