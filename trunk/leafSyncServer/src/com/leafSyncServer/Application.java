package com.leafSyncServer;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IServiceCapableConnection;

import com.leafSyncServer.model.Cjhistory;
import com.leafSyncServer.model.Order;
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
			ArrayList<Cjhistory> msgCjhistoryS) {
		MainService.instance.updateJiaoyi(stockCode, topPrice, bottomPrice,
				nowPrice, nowCjNum, buyOrders, saleOrders, msgCjhistoryS);
	}

	public void initLeaf(String stockCode,String stockName, int allStockNum,
			int liutongStockNum,double jinzhi, double shouyi,int lastDayCjshou, double PE,
			double lastDayEndPrice,double xinxinLv, double todayStartPrice, double topPrice,
			double bottomPrice, double nowPrice, double nowCjNum,
			ArrayList<Cjhistory> cjhistorys, ArrayList<Order> buyOrders,
			ArrayList<Order> saleOrders) {

		MainService.instance.init(stockCode, stockName,allStockNum, liutongStockNum,
				jinzhi, shouyi,lastDayCjshou, PE, lastDayEndPrice, todayStartPrice, topPrice,
				bottomPrice, nowPrice, nowCjNum, cjhistorys, buyOrders,
				saleOrders);

	}
	
	public void dealStock(String playerName, String stockCode){
		MainService.instance.dealStock(playerName, stockCode);
	}
			
	public void updateFenshi(String timeStr,String stockCode,double topPrice,double bottomwPrice,double nowPrice,double nowCjNum){
		MainService.instance.updateFenshi(timeStr, stockCode, topPrice, bottomwPrice, nowPrice, nowCjNum);
	}
	
	public void broadcastMline(String stockCode,double price,double turnover,String buildDate){
		MainService.instance.broadcastMline(stockCode, price, turnover,buildDate);
	}
	
	public void cancel(String stockCode, String orderNum){
		RemoteService.instance.cancel(stockCode,orderNum);
	}

	public void update() {
		System.out.println("updateupdateupdateupdate");
	}

}
