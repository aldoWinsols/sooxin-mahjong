package com.robertSyncServer.services;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

public class JobService implements IScheduledJob{

	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		MainService.instance.doTimer();
		// TODO Auto-generated method stub
		
	}

}
