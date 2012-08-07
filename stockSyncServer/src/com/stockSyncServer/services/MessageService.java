package com.stockSyncServer.services;

import java.util.ArrayList;

import org.red5.server.api.service.IServiceCapableConnection;

import com.stockSyncServer.model.Message;

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
	public synchronized void broadcastJiaoyi(Object[] obj) {
		for(int i=0; i<MainService.instance.leafServices.size(); i++){
			MainService.instance.leafServices.get(i).updateJiaoyi(obj);
		}
	}
	
	public synchronized void broadcastFenshi(Object[] obj) {
		for(int i=0; i<MainService.instance.leafServices.size(); i++){
			MainService.instance.leafServices.get(i).updateFenshi(obj);
		}
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
	public boolean send(ArrayList<LeafService> leafServices, Message message) {
//		try {
//
//			for (int i = 0; i < leafServices.size(); i++) {
//				leafServices.get(i).getLeaf().getIserver()
//						.invoke(message.getHead(), new Object[] { message });
//			}
//		} catch (RuntimeException e) {
//			System.out.print(e);
//			return false;
//			// log.error("", e);
//		}
		return true;
	}
}
