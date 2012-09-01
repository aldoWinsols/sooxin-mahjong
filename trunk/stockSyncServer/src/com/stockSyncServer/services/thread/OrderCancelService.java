package com.stockSyncServer.services.thread;

import java.util.ArrayList;

import com.stock.inter.IStockService;
import com.stockSyncServer.services.ConfigService;

public class OrderCancelService extends Thread implements Runnable {

	public ArrayList<String> orderCancelTasks = new ArrayList<String>();
	public static OrderCancelService instance;
	private IStockService stockService;

	public OrderCancelService() {
		stockService = (IStockService) ConfigService.getInstance().getContext()
				.getBean("stockService");
		this.start();
	}

	public static OrderCancelService getInstance() {
		if (instance == null) {
			instance = new OrderCancelService();
		}
		return instance;
	}

	private String orderNum;
	public void run() {
		while (true) {
			while (orderCancelTasks.isEmpty()) {
				try {
					this.sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			synchronized (orderCancelTasks) {
				orderNum = orderCancelTasks.remove(0);
				stockService.cancel(orderNum);
			}
		}

	}
}
