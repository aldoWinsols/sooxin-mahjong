package com.stockSyncServer;

import java.util.Timer;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IServiceCapableConnection;

import com.stockSyncServer.services.ConfigService;
import com.stockSyncServer.services.MainService;
import com.stockSyncServer.services.MessageService;
import com.stockSyncServer.services.StockService;
import com.stockSyncServer.util.TimerTaskServer;
import com.stockSyncServer.util.UtilProperties;

public class Application extends ApplicationAdapter{

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
		Timer timer = new Timer();
		TimerTaskServer timerTaskServer = new TimerTaskServer();
		timer.schedule(timerTaskServer, 1000, 1000);
		
		UtilProperties.getInstance("config.properties");
		ConfigService.getInstance();
		MainService.getInstance();
		MessageService.getInstance();
		
		return super.start(scope);
	}

	@Override
	public synchronized void stop(IScope scope) {
		// TODO Auto-generated method stub
		System.out.println("============================================");
		super.stop(scope);
	}
	
	//=====================================================
	public void addLeafService(String url){
		MainService.getInstance().addLeafs(url);
	}
//	
//	public void removeLeafService(String url){
//		StockService.getInstance().removeLeafs(url);
//	}
	
	public void buy(String stockCode,String playerName, double wtPrice, int wtNum) {
		MainService.instance.buy(stockCode,playerName, wtPrice, wtNum);
	}

	public void sale(String stockCode,String playerName, double wtPrice, int wtNum) {
		MainService.instance.sale(stockCode, playerName, wtPrice, wtNum);
	}
	
	public void sendRoomNum(){
//		System.out.println("sendRoomNumsendRoomNumsendRoomNum");
	}

}
