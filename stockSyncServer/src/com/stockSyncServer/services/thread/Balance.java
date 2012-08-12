package com.stockSyncServer.services.thread;

import org.slf4j.Logger;
import com.stock.inter.IStockService;
import com.stockSyncServer.model.BalanceTask;
import com.stockSyncServer.services.ConfigService;

public class Balance extends Thread implements Runnable {

	public BalanceTask balanceTask;
	private boolean isRunning = true;

	private Logger log = null;
	private IStockService stockService = (IStockService) ConfigService
			.getInstance().getContext().getBean("stockService");
	
	public Balance(){
		this.start();
	}

	public void run() {
		while (isRunning) {
			synchronized (this) {
				while (balanceTask == null) {
					try {
						/* 任务队列为空，则等待有新任务加入从而被唤醒 */

						wait(20);
					} catch (InterruptedException ie) {

					}
				}
			}

			stockService.blance(balanceTask.stockNum,
					balanceTask.buyPlayerName, balanceTask.buyOrderNum,
					balanceTask.salePlayerName, balanceTask.saleOrderNum,
					balanceTask.cjSort, balanceTask.cjNum, balanceTask.cjPrice,
					balanceTask.cjTime);

			balanceTask = null;
		}
	}
}
