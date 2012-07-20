package com.mahjongSyncServer.util;

import java.util.TimerTask;
import com.mahjongSyncServer.services.GameHallService;

/**
 * 控制所有需要时钟的地方
 * @author Administrator
 *
 */
public class TimerTaskServer extends TimerTask {

	private GameHallService gameHallService = null;
	
	public TimerTaskServer(GameHallService gameHallService){
		this.gameHallService = gameHallService;
	}
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
//		try{
			gameHallService.dealTimer();
			
			
//		}
//		catch(Exception e){
//			System.out.println("timer错误 : " + e.toString());
//		}
	}

}
