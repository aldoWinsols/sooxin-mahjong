package com.stockSyncServer.services.thread;

import java.util.ArrayList;

import com.stock.inter.ICjhistoryService;
import com.stockSyncServer.model.Cjhistory;
import com.stockSyncServer.services.ConfigService;

public class CjhistoryDataService extends Thread implements Runnable {
	public static CjhistoryDataService instance;
	ArrayList<Cjhistory> cjhistoryTasks;
	private ICjhistoryService cjhistoryService;

	public CjhistoryDataService() {
		cjhistoryTasks = new ArrayList<Cjhistory>();
		cjhistoryService = (ICjhistoryService) ConfigService.getInstance()
				.getContext().getBean("cjhistoryService");
		this.start();
	}

	public static CjhistoryDataService getInstance() {
		if (instance == null) {
			instance = new CjhistoryDataService();
		}
		return instance;
	}

	public void addTask(Cjhistory cjhistory) {
		cjhistoryTasks.add(cjhistory);
	}

	private Cjhistory cjhistory;

	public void run() {
		while (true) {
			while (cjhistoryTasks.isEmpty()) {
				try {
					sleep(1000);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

			synchronized (cjhistoryTasks) {
				cjhistory = cjhistoryTasks.get(0);

				try {
					cjhistoryService.saveCjhistory(cjhistory.getStockCode(),
							cjhistory.getCjSort(), cjhistory.getCjNum(),
							cjhistory.getCjPrice(), cjhistory.getCjTime());
					cjhistoryTasks.remove(0);
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}

			}
		}
	}
}
