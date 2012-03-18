package com.mainSyncServer.model;

import java.util.ArrayList;

import org.red5.server.api.service.IServiceCapableConnection;

public class Player {
	private String name = ""; 							// 名字
	private ArrayList<Message> messages; 				// 消息记录
	private String ip = "";
	private IServiceCapableConnection iserver = null; 	// 玩家通信连接对象
//	private List<ChipGroupItems> chipGroupItems = null;			//玩家下注限制
	
	public Player(){
		messages = new ArrayList<Message>();
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public ArrayList<Message> getMessages() {
		return messages;
	}
	public IServiceCapableConnection getIserver() {
		return iserver;
	}
	public void setIserver(IServiceCapableConnection iserver) {
		this.iserver = iserver;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}
}
