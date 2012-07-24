package com.stockSyncServer.dataServices;

import com.stock.inter.IStockService;
import com.stockSyncServer.services.ConfigService;

public class RemoteService {
	public RemoteService() {
		
	}

//	public IUserService getUserService() {
//		return (IUserService) ConfigService.getInstance().getContext().getBean("userService");
//	}

	public IStockService getStockService() {
		return (IStockService) ConfigService.getInstance().getContext()
				.getBean("stockService");
	}

//	public IBalanceVideoGameService getBalanceVideoGameService() {
//		return (IBalanceVideoGameService) ConfigService.getInstance().getContext()
//				.getBean("balanceChessGameService");
//	}
}
