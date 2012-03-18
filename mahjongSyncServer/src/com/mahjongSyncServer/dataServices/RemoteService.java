package com.mahjongSyncServer.dataServices;

import com.mahjongSyncServer.services.ConfigService;
import com.panda.inter.IBalanceChessGameService;

public class RemoteService {
	public RemoteService() {
		
	}

//	public IUserService getUserService() {
//		return (IUserService) ConfigService.getInstance().getContext().getBean("userService");
//	}

	public IBalanceChessGameService getBalanceChessGameService() {
		return (IBalanceChessGameService) ConfigService.getInstance().getContext()
				.getBean("balanceChessGameService");
	}

//	public IBalanceVideoGameService getBalanceVideoGameService() {
//		return (IBalanceVideoGameService) ConfigService.getInstance().getContext()
//				.getBean("balanceChessGameService");
//	}
}
