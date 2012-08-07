package com.stockSyncServer.dataServices;

import org.slf4j.Logger;

import com.stock.inter.IStockService;
import com.stockSyncServer.services.ConfigService;
import com.stockSyncServer.util.UtilProperties;


/**
 * 
 * @author Administrator
 * 2012-3-5 14:09 gmr start 保存玩家扣除的金额
 */
public class DataService extends Thread implements Runnable{
	private Logger log = null;
	private IStockService stockService = null;
	public DataService(){
		log = UtilProperties.instance.getLogger(DataService.class);
		stockService = (IStockService) ConfigService.getInstance().getContext().getBean("stockService");
	}
	
	public void run() {
		
	}
	
}
