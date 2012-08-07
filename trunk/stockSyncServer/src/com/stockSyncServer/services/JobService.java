package com.stockSyncServer.services;

import java.util.Date;

import net.sf.json.JSONArray;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.stockSyncServer.model.Stock;

public class JobService implements IScheduledJob {

	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		
		Date date = new Date();
		String timestr = date.getHours() + ":" + date.getMinutes();
		
		for (int i = 0; i < MainService.instance.stockServices.size(); i++) {
			Stock stock = MainService.instance.stockServices.get(i).stock;

			MessageService.instance.broadcastFenshi(new Object[] { timestr,
					stock.getStockCode(),stock.topPrice,stock.bottomPrice, stock.getNowPrice(),
					stock.getNowCjNum() });
		}
	}
}
