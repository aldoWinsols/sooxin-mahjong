package com.leafSyncServer.util;

import java.util.TimerTask;
import com.leafSyncServer.services.RemoteService;

public class TimerTaskServer extends TimerTask {


	@Override
	public void run() {
		// TODO Auto-generated method stub
		// try{
//		StockService.getInstance().balance();

		// }
		// catch(Exception e){
		// System.out.println("timer错误 : " + e.toString());
		// }
		RemoteService.getInstance().sendRoomNum();
	}

}
