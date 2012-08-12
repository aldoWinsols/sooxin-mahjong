package com.stockSyncServer.services.thread;

import org.slf4j.Logger;

import com.stock.inter.IStockService;
import com.stockSyncServer.model.OrderTask;
import com.stockSyncServer.services.ConfigService;
import com.stockSyncServer.services.MainService;

public class OrderData extends Thread implements Runnable {
	
	public OrderTask orderTask;
	private Logger log = null;
	private IStockService stockService = (IStockService) ConfigService
			.getInstance().getContext().getBean("stockService");

	private boolean isRunning = true;
	OrderDataService orderDataService;
	
	public OrderData(OrderDataService orderDataService){
		this.orderDataService = orderDataService;
		this.start();
	}

	public void run() {
		while (isRunning) {
			synchronized (this) {
				while (orderTask == null) {
					try {
						/* 任务队列为空，则等待有新任务加入从而被唤醒 */
						
						wait(20);
					} catch (InterruptedException ie) {

					}
				}
			}
			if (orderTask != null) {
				
				if (orderTask.orderSort.equals("buy")) {
					Object bool = stockService.buy(orderTask.stockCode,
							orderTask.playerName, orderTask.orderNum,
							orderTask.wtPrice, orderTask.wtNum);
					if (bool.toString().equals("true")) {
						for (int i = 0; i < MainService.instance.stockServices
								.size(); i++) {
							if (MainService.instance.stockServices.get(i).stock.stockCode
									.equals(orderTask.stockCode)) {
								MainService.instance.stockServices.get(i).buy(
										orderTask.playerName,orderTask.orderNum,
										orderTask.wtPrice, orderTask.wtNum);
								break;
							}
						}
					}
				} else {
					Object bool = stockService.sale(orderTask.stockCode,
							orderTask.playerName, orderTask.orderNum,
							orderTask.wtPrice, orderTask.wtNum);
					
					if (bool.toString().equals("true")) {
						for (int i = 0; i < MainService.instance.stockServices
								.size(); i++) {
							if (MainService.instance.stockServices.get(i).stock.stockCode
									.equals(orderTask.stockCode)) {
								MainService.instance.stockServices.get(i).sale(
										orderTask.playerName,orderTask.orderNum,
										orderTask.wtPrice, orderTask.wtNum);
								break;
							}
						}
					}
				}
				orderTask = null;
			}
		}
	}

}
