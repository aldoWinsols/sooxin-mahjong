package com.leafSyncServer.services;
import com.leafSyncServer.model.Message;

public class MessageService {
	public static MessageService instance = null;

	public static MessageService getInstance() {
		if (instance == null) {
			instance = new MessageService();
		}
		return instance;
	}


	/**
	 * 发送消息
	 * 
	 * @param playerServices
	 *            玩家集合
	 * @param message
	 *            消息类
	 * @param sendBackGroundPlayer
	 *            是否发送给后台用户，同时也要发送给普通
	 * @return
	 */
	public void send(String stockCode, Message message) {
		for (int i = 0; i < MainService.instance.playerServices.size(); i++) {
			if(MainService.instance.playerServices.get(i).getPlayer().getNowStockCode().equals(stockCode)){
				MainService.instance.playerServices.get(i).getPlayer().getIserver()
				.invoke(message.getHead(), message.getContent());
			}
		}
	}
	
	public void sendOnly(PlayerService playerService,Message message) {
		playerService.getPlayer().getIserver().invoke(message.getHead(), message.getContent());
	}
}
