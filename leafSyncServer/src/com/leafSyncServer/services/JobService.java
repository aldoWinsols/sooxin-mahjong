package com.leafSyncServer.services;

import org.red5.server.api.scheduling.IScheduledJob;
import org.red5.server.api.scheduling.ISchedulingService;

import com.leafSyncServer.model.Message;

public class JobService implements IScheduledJob {

	@Override
	public void execute(ISchedulingService arg0)
			throws CloneNotSupportedException {

		System.out.println("=======================");
		for (int i = 0; i < MainService.instance.stockServices.size(); i++) {
			for (int j = 0; j < MainService.instance.playerServices.size(); j++) {
				if (MainService.instance.stockServices.get(i).stock
						.getStockCode().equals(
								MainService.instance.playerServices.get(j)
										.getPlayer().getNowStockCode())) {
					Message message = new Message();
					message.setHead("updateI");
					message.setContent(new Object[] {
							MainService.instance.stockServices.get(i).stock
									.getTopPrice(),
							MainService.instance.stockServices.get(i).stock
									.getBottomPrice(),
							MainService.instance.stockServices.get(i).stock
									.getNowPrice(),
							MainService.instance.stockServices.get(i).stock
									.getNowCjNum() });

					MainService.instance.playerServices.get(j).getPlayer()
							.getIserver()
							.invoke(message.getHead(), message.getContent());
				}
			}
		}
	}

}
