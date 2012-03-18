package com.mahjongSyncServer.services;

import java.util.ArrayList;

import org.red5.server.api.service.IServiceCapableConnection;

import com.mahjongSyncServer.model.Message;

public class MessageService {
	
	public static MessageService instance = null;
	
	private MessageService(){}
	public static MessageService getInstance(){
		if(instance == null){
			instance = new MessageService();
		}
		return instance;
	}
	
	/**
	 * 发送消息
	 * @param iservice						单个用户的连接对象
	 * @param message						消息类
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
	 * @param playerServices				玩家集合
	 * @param message						消息类
	 * @param sendBackGroundPlayer			是否发送给后台用户，同时也要发送给普通
	 * @return
	 */
	public boolean send(ArrayList<PlayerService> playerServices, Message message, boolean sendBackGroundPlayer) {
		try {
			
			for (int i = 0; i < playerServices.size(); i++) {
				if(sendBackGroundPlayer){
					playerServices.get(i).getPlayer().getIServer().invoke(message.getHead(), new Object[] { message });
				}else{
					if(playerServices.get(i).getPlayer().getPlayerType() == 0){
						playerServices.get(i).getPlayer().getIServer().invoke(message.getHead(), new Object[] { message });
					}
				}
				
			}			
		} catch (RuntimeException e) {
			System.out.print(e);
			return false;
			// log.error("", e);
		}
		return true;
	}
	/**
	 * 发送消息
	 * @param playerServices		玩家集合
	 * @param message				消息类
	 * @param sendPlayerType		用户类型(0：普通用户, 1：后台用户)
	 * @return
	 */
	public boolean send(ArrayList<PlayerService> playerServices, Message message, int sendPlayerType) {
		try {
			
			for (int i = 0; i < playerServices.size(); i++) {
				if(playerServices.get(i).getPlayer().getPlayerType() == sendPlayerType){
					playerServices.get(i).getPlayer().getIServer().invoke(message.getHead(), new Object[] { message });
				}
			}			
		} catch (RuntimeException e) {
			System.out.print(e);
			return false;
			// log.error("", e);
		}
		return true;
	}
	
}
