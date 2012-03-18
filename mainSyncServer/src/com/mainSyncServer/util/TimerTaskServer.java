package com.mainSyncServer.util;

import java.util.TimerTask;

import com.mainSyncServer.service.MainService;

public class TimerTaskServer extends TimerTask {

	private MainService mainService;
	private long timerNum = 0;
	public TimerTaskServer(MainService mainService){
		this.mainService = mainService;
	}
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		
		if(timerNum % 5 == 0){
			mainService.dealTimer();
		}
		
		timerNum ++;
	}

}
