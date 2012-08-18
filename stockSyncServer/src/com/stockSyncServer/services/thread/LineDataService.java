package com.stockSyncServer.services.thread;

import java.util.ArrayList;

import com.stock.dao.Dline;
import com.stock.dao.Hline;
import com.stock.dao.Kline;
import com.stock.dao.Mline;
import com.stock.dao.Wline;
import com.stock.inter.ICjhistoryService;
import com.stock.inter.ILineService;
import com.stockSyncServer.model.Cjhistory;
import com.stockSyncServer.services.ConfigService;

public class LineDataService extends Thread implements Runnable {
	public static LineDataService instance;
	
	ArrayList<Mline> mlines;
	ArrayList<Hline> hlines;
	ArrayList<Dline> dlines;
	ArrayList<Wline> wlines;
	
	private ILineService lineService;

	public LineDataService() {
		mlines = new ArrayList<Mline>();
		hlines = new ArrayList<Hline>();
		dlines = new ArrayList<Dline>();
		wlines = new ArrayList<Wline>();
		
		lineService = (ILineService) ConfigService.getInstance().getContext()
		.getBean("lineService");
		
		this.start();
	}

	public static LineDataService getInstance() {
		if (instance == null) {
			instance = new LineDataService();
		}
		return instance;
	}

	public void addMTask(Mline mline) {
		mlines.add(mline);
	}
	public void addHTask(Hline hline) {
		hlines.add(hline);
	}
	public void addDTask(Dline dline) {
		dlines.add(dline);
	}
	public void addWTask(Wline wline) {
		wlines.add(wline);
	}
		
	public void run() {
		while (true) {
			synchronized (this) {
				while (mlines.isEmpty() && hlines.isEmpty() && dlines.isEmpty() && wlines.isEmpty()) {
					try {
						sleep(1000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}

				try {
					if(!mlines.isEmpty()){
						lineService.addMline(mlines.remove(0));
					}
					
					if(!hlines.isEmpty()){
						lineService.addHline(hlines.remove(0));
					}
					
					if(!dlines.isEmpty()){
						lineService.addDline(dlines.remove(0));
					}
					if(!wlines.isEmpty()){
						lineService.addWline(wlines.remove(0));
					}
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			}
		}
	}
}
