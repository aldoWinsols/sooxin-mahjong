package com.stockSyncServer.services.thread;

import java.util.ArrayList;

import org.slf4j.Logger;

import com.stock.inter.IStockService;
import com.stockSyncServer.model.OrderTask;
import com.stockSyncServer.services.ConfigService;
import com.stockSyncServer.services.MainService;

public class OrderDataService extends Thread implements Runnable {

	ArrayList<OrderTask> orderTasks;
	public static OrderDataService instance;
	private IStockService stockService;

	public OrderDataService() {
		orderTasks = new ArrayList<OrderTask>();
		stockService = (IStockService) ConfigService.getInstance().getContext()
		.getBean("stockService");
		this.start();
	}

	public static OrderDataService getInstance() {
		if (instance == null) {
			instance = new OrderDataService();
		}
		return instance;
	}

	public void addTask(String orderSort, String stockCode, String playerName,
			String orderNum, double wtPrice, int wtNum) {
		OrderTask orderTask = new OrderTask();
		orderTask.orderSort = orderSort;
		orderTask.stockCode = stockCode;
		orderTask.playerName = playerName;
		orderTask.orderNum = orderNum;
		orderTask.wtPrice = wtPrice;
		orderTask.wtNum = wtNum;
		orderTasks.add(orderTask);
	}

	private OrderTask orderTask;

	public void run() {
		while (true) {
			while (orderTasks.isEmpty()) {
				try {
					this.sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			synchronized (orderTasks) {
				orderTask = orderTasks.get(0);
				if (orderTask.orderSort.equals("buy")) {
					Object bool = stockService.buy(orderTask.stockCode,
							orderTask.playerName, orderTask.orderNum,
							orderTask.wtPrice, orderTask.wtNum);
					orderTasks.remove(0);

					if (bool.toString().equals("true")) {
						for (int i = 0; i < MainService.instance.stockServices
								.size(); i++) {
							if (MainService.instance.stockServices.get(i).stock.stockCode
									.equals(orderTask.stockCode)) {
								MainService.instance.stockServices.get(i).buy(
										orderTask.playerName,
										orderTask.orderNum, orderTask.wtPrice,
										orderTask.wtNum);
								break;
							}
						}
					}
				} else {
					Object bool = stockService.sale(orderTask.stockCode,
							orderTask.playerName, orderTask.orderNum,
							orderTask.wtPrice, orderTask.wtNum);
					orderTasks.remove(0);

					if (bool.toString().equals("true")) {
						for (int i = 0; i < MainService.instance.stockServices
								.size(); i++) {
							if (MainService.instance.stockServices.get(i).stock.stockCode
									.equals(orderTask.stockCode)) {
								MainService.instance.stockServices.get(i).sale(
										orderTask.playerName,
										orderTask.orderNum, orderTask.wtPrice,
										orderTask.wtNum);
								break;
							}
						}
					}
				}
			}
		}
	}
}