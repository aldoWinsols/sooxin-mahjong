package com.robertSyncServer;

import java.util.ArrayList;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;

import com.robertSyncServer.model.Cjhistory;
import com.robertSyncServer.model.Order;
import com.robertSyncServer.services.ConfigService;
import com.robertSyncServer.services.JobService;
import com.robertSyncServer.services.MainService;
import com.robertSyncServer.services.RemoteService;
import com.robertSyncServer.util.UtilProperties;

public class Application extends ApplicationAdapter {

	@Override
	public synchronized boolean connect(IConnection conn, IScope scope,
			Object[] params) {
		// TODO Auto-generated method stub
		return super.connect(conn, scope, params);
	}

	@Override
	public synchronized void disconnect(IConnection conn, IScope scope) {
		// TODO Auto-generated method stub
		super.disconnect(conn, scope);
	}

	@Override
	public synchronized boolean start(IScope scope) {
		// TODO Auto-generated method stub
		UtilProperties.getInstance("config.properties");
		ConfigService.getInstance();
		
		MainService.getInstance();
		RemoteService.getInstance();
		
		String id = addScheduledJobAfterDelay(10000, new JobService(),1000);
		scope.setAttribute("Myjob", id);
		
		return super.start(scope);
	}

	@Override
	public synchronized void stop(IScope scope) {
		// TODO Auto-generated method stub
		String id = (String) scope.getAttribute("Myjob");
		removeScheduledJob(id);
		super.stop(scope);
	}
	
	public void initLeaf(String stockCode,String stockName, int allStockNum,
			int liutongStockNum,double jinzhi, double shouyi,int lastDayCjshou, double PE,
			double lastDayEndPrice,double xinxinLv, double todayStartPrice, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Cjhistory> cjhistorys, ArrayList<Order> buyOrders,
			ArrayList<Order> saleOrders) {

		MainService.instance.init(stockCode, stockName,allStockNum, liutongStockNum,
				shouyi, PE, lastDayEndPrice,xinxinLv, todayStartPrice, topPrice,
				bottomPrice, nowPrice, nowCjNum, cjhistorys, buyOrders,
				saleOrders);

	}
	
	public void updateJiaoyi(String stockCode, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Order> buyOrders, ArrayList<Order> saleOrders,
			ArrayList<Cjhistory> thisCjhistoryS) {
		MainService.instance.updateJiaoyi(stockCode, topPrice, bottomPrice,
				nowPrice, nowCjNum, buyOrders, saleOrders, thisCjhistoryS);
	}
	
	public void updateFenshi(String timeStr,String stockCode,double topPrice,double bottomwPrice,double nowPrice,double nowCjNum){
//		MainService.instance.updateFenshi(timeStr, stockCode, topPrice, bottomwPrice, nowPrice, nowCjNum);
	}

}
