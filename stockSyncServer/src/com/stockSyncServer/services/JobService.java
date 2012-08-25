package com.stockSyncServer.services;

import java.sql.Timestamp;
import java.util.Date;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

public class JobService implements IScheduledJob {

	
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {
		MainService.instance.todo();

	}
}
