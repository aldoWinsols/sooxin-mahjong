package com.stockSyncServer.services.thread;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.stockSyncServer.model.BalanceTask;

public class BalanceService {
	
	private int num = 2;
	ArrayList<Balance> balances = new ArrayList<Balance>();
	ArrayList<BalanceTask> balanceTasks = new ArrayList<BalanceTask>();
	public static BalanceService instance;
	
	public BalanceService(){
		for(int i=0; i<num; i++){
			balances.add(new Balance());
		}
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
		
		for(int i=0; i<balances.size(); i++){
			if(balances.get(i).balanceTask == null){
				balances.get(i).balanceTask = balanceTask;
				break;
			}
		}
	}
}
