package com.mainSyncServer.service;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

public class JobService implements IScheduledJob {
	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {

		for (int i = 0; i < MainService.getInstance().roomNums.size(); i++) {
			MainService
					.getInstance()
					.sendRoomNum(
							MainService.getInstance().roomNums.get(i).roomNum,
							(MainService.getInstance().roomNums.get(i).onlineNum + (int) Math
									.round(Math.random() * 10)));
		}

	}
}
