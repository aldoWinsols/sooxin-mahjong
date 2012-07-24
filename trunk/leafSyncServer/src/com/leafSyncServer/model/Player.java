package com.leafSyncServer.model;

import org.red5.server.api.service.IServiceCapableConnection;

public class Player {
	
	private String playerName = "";
	private IServiceCapableConnection iserver = null;				//玩家连接对象
	private String clientID = "";									//玩家连接对象的ID
	private String nowStockCode = ""; //当前正在交易的股票代码

	public String getPlayerName() {
		return playerName;
	}

	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}

	public IServiceCapableConnection getIserver() {
		return iserver;
	}

	public void setIserver(IServiceCapableConnection iserver) {
		this.iserver = iserver;
	}

	public String getClientID() {
		return clientID;
	}

	public void setClientID(String clientID) {
		this.clientID = clientID;
	}

	public String getNowStockCode() {
		return nowStockCode;
	}

	public void setNowStockCode(String nowStockCode) {
		this.nowStockCode = nowStockCode;
	}

}
