package com.stockSyncServer.services.thread;

import org.slf4j.Logger;
import com.stock.inter.IStockService;
import com.stockSyncServer.model.BalanceTask;
import com.stockSyncServer.services.ConfigService;

public class Balance extends Thread implements Runnable {

	public BalanceTask balanceTask;

	private Logger log = null;
	private IStockService stockService = (IStockService) ConfigService.getInstance().getContext()
	.getBean("stockService");

	public void run() {
		stockService.blance(balanceTask.stockNum, balanceTask.buyPlayerName,balanceTask.buyOrderNum,
				balanceTask.salePlayerName,balanceTask.saleOrderNum, balanceTask.cjSort,
				balanceTask.cjNum, balanceTask.cjPrice, balanceTask.cjTime);
	}
}
