package com.stockSyncServer.services.thread;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.stockSyncServer.model.BalanceTask;

public class BalanceService implements IScheduledJob {
	
	private int num = 100;
	ArrayList<Balance> balances = new ArrayList<Balance>();
	ArrayList<BalanceTask> balanceTasks = new ArrayList<BalanceTask>();
	
	public BalanceService(){
		for(int i=0; i<num; i++){
			balances.add(new Balance());
		}
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
	
	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		if(balanceTasks.size()<1){
			return;
		}
		
		for(int i=0; i<balances.size(); i++){
			if(!balances.get(i).isAlive()){
				balances.get(i).balanceTask = balanceTasks.get(0);
				balances.get(i).start();
				balanceTasks.remove(0);
			}
		}
	}

}
