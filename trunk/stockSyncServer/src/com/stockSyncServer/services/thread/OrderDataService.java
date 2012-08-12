package com.stockSyncServer.services.thread;

import java.util.ArrayList;

import org.slf4j.Logger;

import com.stock.inter.IStockService;
import com.stockSyncServer.model.OrderTask;
import com.stockSyncServer.services.ConfigService;
import com.stockSyncServer.services.MainService;

public class OrderDataService {

	private int num = 2;
	ArrayList<OrderData> orderDatas = new ArrayList<OrderData>();
	ArrayList<OrderTask> orderTasks;
	public static OrderDataService instance;
	
	public OrderDataService(){
		orderTasks = new ArrayList<OrderTask>();
	}
	
	public void init(){
		synchronized(orderTasks){
			for(int i=0; i<num; i++){
				orderDatas.add(new OrderData(this));
			}
		}
		
	}
	
	public static OrderDataService getInstance(){
		if(instance == null){
			instance = new OrderDataService();
		}
		
		return instance;
	}
	
	public synchronized void addTask(String orderSort, String stockCode, String playerName, String orderNum,
			double wtPrice, int wtNum){
		OrderTask orderTask = new OrderTask();
		orderTask.orderSort=orderSort;
		orderTask.stockCode=stockCode;
		orderTask.playerName = playerName;
		orderTask.orderNum = orderNum;
		orderTask.wtPrice = wtPrice;
		orderTask.wtNum = wtNum;
		orderTasks.add(orderTask);
		
		for(int i=0; i<num; i++){
			if(orderDatas.get(i).orderTask == null){
				orderDatas.get(i).orderTask = orderTask;
				break;
			}
		}
		
		synchronized(orderDatas){
			orderDatas.notifyAll();
		}		
		
	}
}