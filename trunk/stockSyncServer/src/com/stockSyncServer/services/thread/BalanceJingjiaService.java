package com.stockSyncServer.services.thread;

import java.util.ArrayList;
import com.stock.inter.IStockService;
import com.stockSyncServer.model.BalanceTask;
import com.stockSyncServer.services.ConfigService;

public class BalanceJingjiaService extends Thread implements Runnable{
	
	ArrayList<BalanceTask> balanceTasks = new ArrayList<BalanceTask>();
	private IStockService stockService;
	public static BalanceService instance;
	
	public BalanceJingjiaService(){
		balanceTasks = new ArrayList<BalanceTask>();
		stockService = (IStockService) ConfigService.getInstance().getContext()
		.getBean("stockService");
	}
	
	public static BalanceService getInstance(){
		if(instance == null){
			instance = new BalanceService();
		}
		
		return instance;
	}
	
	public void addTask(String stockNum,String buyPlayerName, String buyOrderNum, String salePlayerName,String saleOrderNum, String cjSort,int cjNum,Double cjPrice,String cjTime){
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
		
		setPrice(cjPrice);
		
		balanceTasks.add(balanceTask);
	}
	
	public void setPrice(double cjPrice){
		for(int i=0; i<balanceTasks.size();i++){
			balanceTasks.get(i).cjPrice = cjPrice;
		}
	}
	
	BalanceTask balanceTask;
	public void run() {
		synchronized (balanceTasks) {
			for(int i=0; i<balanceTasks.size();i++){
				balanceTask = balanceTasks.get(i);
				stockService.blance(balanceTask.stockNum,
						balanceTask.buyPlayerName, balanceTask.buyOrderNum,
						balanceTask.salePlayerName, balanceTask.saleOrderNum,
						balanceTask.cjSort, balanceTask.cjNum, balanceTask.cjPrice,
						balanceTask.cjTime);

				balanceTasks.remove(0);
				i--;
			}
		}
	}

}
