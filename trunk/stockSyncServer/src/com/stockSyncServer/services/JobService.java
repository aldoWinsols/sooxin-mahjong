package com.stockSyncServer.services;

import java.sql.Timestamp;
import java.util.Date;

import net.sf.json.JSONArray;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.stock.dao.Dline;
import com.stock.dao.Hline;
import com.stock.dao.Kline;
import com.stock.dao.Mline;
import com.stockSyncServer.model.Stock;
import com.stockSyncServer.services.thread.LineDataService;

public class JobService implements IScheduledJob {

	int n = 0;

	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		n++;

		if (n % 6 == 0) {
			Date date = new Date();
			String timestr = date.getHours() + ":" + date.getMinutes();

			for (int i = 0; i < MainService.instance.stockServices.size(); i++) {
				Stock stock = MainService.instance.stockServices.get(i).stock;

				MessageService.instance.broadcastFenshi(new Object[] { timestr,
						stock.getStockCode(), stock.topPrice,
						stock.bottomPrice, stock.getNowPrice(),
						stock.getNowCjNum() });

				if(n%60==0){
					Mline mline = new Mline();
					mline.setStockCode(stock.getStockCode());
					mline.setBuildDate(new Timestamp(new Date().getTime()));
					mline.setPrice(stock.getNowPrice());
					mline.setTurnover(stock.getNowCjNum());
					LineDataService.instance.addMTask(mline);
				}
				
				if(n%3600==0){
					Hline hline = new Hline();
					hline.setStockCode(stock.getStockCode());
					hline.setBuildDate(new Timestamp(new Date().getTime()));
					hline.setPrice(stock.getNowPrice());
					hline.setTurnover(stock.getNowCjNum());
					LineDataService.instance.addHTask(hline);
				}
				
				if(n%3600*4==0){
					Dline dline = new Dline();
					dline.setStockCode(stock.getStockCode());
					dline.setBuildDate(new Timestamp(new Date().getTime()));
					dline.setPrice(stock.getNowPrice());
					dline.setTurnover(stock.getNowCjNum());
					LineDataService.instance.addDTask(dline);
				}
			}
		}
	}
}
