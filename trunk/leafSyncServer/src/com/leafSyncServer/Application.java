package com.leafSyncServer;

import java.util.ArrayList;
import java.util.List;
import java.util.Timer;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IServiceCapableConnection;

import com.leafSyncServer.model.Cjhistory;
import com.leafSyncServer.model.Order;
import com.leafSyncServer.services.JobService;
import com.leafSyncServer.services.MainService;
import com.leafSyncServer.services.MessageService;
import com.leafSyncServer.services.RemoteService;
import com.leafSyncServer.util.TimerTaskServer;
import com.leafSyncServer.util.UtilProperties;

public class Application extends ApplicationAdapter {

	@Override
	public synchronized boolean connect(IConnection conn, IScope scope,
			Object[] params) {
		// TODO Auto-generated method stub
		MainService.getInstance().addPlayerService((String) params[0],
				(IServiceCapableConnection) conn);
		return super.connect(conn, scope, params);
	}

	@Override
	public synchronized void disconnect(IConnection conn, IScope scope) {
		// TODO Auto-generated method stub
		MainService.getInstance().removePlayerService(
				(IServiceCapableConnection) conn);
		super.disconnect(conn, scope);
	}

	@Override
	public synchronized boolean start(IScope scope) {
		// TODO Auto-generated method stub

		String id = addScheduledJob(6000, new JobService());
		scope.setAttribute("Myjob", id);

		MainService.getInstance();
		UtilProperties.getInstance("config.properties");
		// RtmpService.getInstance();

		Timer timer = new Timer();
		TimerTaskServer timerTaskServer = new TimerTaskServer();
		timer.schedule(timerTaskServer, 6000, 6000);

		MainService.getInstance();
		RemoteService.getInstance();
		MessageService.getInstance();

		return super.start(scope);
	}

	public void addJob() {

	}

	@Override
	public synchronized void stop(IScope scope) {
		// TODO Auto-generated method stub
		String id = (String) scope.getAttribute("Myjob");
		removeScheduledJob(id);

		super.stop(scope);
	}

	// ========================================================

	public void buy(String stockCode, String playerName, double wtPrice,
			int wtNum) {
		RemoteService.instance.buy(stockCode, playerName, wtPrice, wtNum);
	}

	public void sale(String stockCode, String playerName, double wtPrice,
			int wtNum) {
		RemoteService.instance.sale(stockCode, playerName, wtPrice, wtNum);
	}

	public void updateJiaoyi(String stockCode, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Order> buyOrders, ArrayList<Order> saleOrders,
			ArrayList<Cjhistory> thisCjhistoryS) {
		MainService.instance.updateJiaoyi(stockCode, topPrice, bottomPrice,
				nowPrice, nowCjNum, buyOrders, saleOrders, thisCjhistoryS);
	}

	public void initLeaf(String stockCode,String stockName, int allStockNum,
			int liutongStockNum, double shouyi, double PE,
			double lastDayEndPrice, double todayStartPrice, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Cjhistory> cjhistorys, ArrayList<Order> buyOrders,
			ArrayList<Order> saleOrders) {

		MainService.instance.init(stockCode, stockName,allStockNum, liutongStockNum,
				shouyi, PE, lastDayEndPrice, todayStartPrice, topPrice,
				bottomPrice, nowPrice, nowCjNum, cjhistorys, buyOrders,
				saleOrders);

	}
	
	public void dealStock(String playerName, String stockCode){
		MainService.instance.dealStock(playerName, stockCode);
	}

	public void update() {
		System.out.println("updateupdateupdateupdate");
	}

}
