package com.stockSyncServer.services.thread;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.stock.inter.IStockService;
import com.stockSyncServer.dataServices.RemoteService;
import com.stockSyncServer.model.BalanceTask;
import com.stockSyncServer.model.OrderTask;

public class BalanceService extends Thread implements Runnable{
	
	ArrayList<BalanceTask> balanceTasks = new ArrayList<BalanceTask>();
	private IStockService stockService;
	public static BalanceService instance;
	
	public BalanceService(){
		balanceTasks = new ArrayList<BalanceTask>();
		stockService = RemoteService.instance.stockService;
		this.start();
	}
	
	public static BalanceService getInstance(){
		if(instance == null){
			instance = new BalanceService();
		}
		
		return instance;
	}
	
	public void addTask(String stockNum,String buyPlayerName, String buyOrderNum, String salePlayerName,String saleOrderNum, String cjSort,int cjNum,Double cjPrice,Timestamp cjTime){
		BalanceTask balanceTask = new BalanceTask();
		
		balanceTask.stockNum = stockNum;
		balanceTask.buyPlayerName = buyPlayerName;
		balanceTask.buyOrderNum = buyOrderNum;
		balanceTask.salePlayerName = salePlayerName;
		balanceTask.saleOrderNum = saleOrderNum;
		balanceTask.cjSort = cjSort;
		balanceTask.cjNum = cjNum;
		balanceTask.cjPrice = cjPrice;
		balanceTask.cjTime = cjTime;
		
		balanceTasks.add(balanceTask);
	}
	
	BalanceTask balanceTask;
	public void run() {
		while (true) {
			synchronized (balanceTasks) {
				while (balanceTasks.isEmpty()) {
				}
			}

			balanceTask = balanceTasks.get(0);
			stockService.blance(balanceTask.stockNum,
					balanceTask.buyPlayerName, balanceTask.buyOrderNum,
					balanceTask.salePlayerName, balanceTask.saleOrderNum,
					balanceTask.cjSort, balanceTask.cjNum, balanceTask.cjPrice,
					balanceTask.cjTime);

			balanceTasks.remove(0);
		}
	}
}
