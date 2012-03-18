package com.mainSyncServer.service;

import java.util.ArrayList;
import org.red5.server.api.service.IServiceCapableConnection;

import com.mainSyncServer.model.Message;

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
	 * @param iservice
	 *            单个用户的连接对象
	 * @param message
	 *            消息类
	 * @return
	 */
	public boolean send(IServiceCapableConnection iservice, Message message) {
		try {
			iservice.invoke(message.getHead(), new Object[] { message });
		} catch (RuntimeException e) {
			System.out.print(e);
			return false;
			// log.error("", e);
		}
		return true;
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
	public boolean send(ArrayList<PlayerService> playerServices, Message message) {
		try {
			for (int i = 0; i < playerServices.size(); i++) {
				playerServices.get(i).getPlayer().getIserver().invoke(
						message.getHead(), new Object[] { message });
			}
		} catch (RuntimeException e) {
			System.out.print(e);
			return false;
		}
		return true;
	}

}
