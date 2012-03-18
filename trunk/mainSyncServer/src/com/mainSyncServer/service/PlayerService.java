package com.mainSyncServer.service;

import java.util.List;
import java.util.Map;

import com.mainSyncServer.model.Message;
import com.mainSyncServer.model.Player;

public class PlayerService {
	private Player player;
	private Message message = null;
	
	public PlayerService(){
		player = new Player();
		message = new Message();
	}

	public Player getPlayer() {
		return player;
	}
	
	public void addMessage(Message message){
		this.player.getMessages().add(message);
	}
	//发送消息
	public void sendMessage(Message message){
		MessageService.instance.send(this.player.getIserver(), message);
	}
	
	public void sendMessage(Message message, boolean bool){
		MessageService.instance.send(this.player.getIserver(), message);
		addMessage(message);
	}
	
	public void sendIP(){
		message.setHead("sendIPI");
		message.setContent(player.getIp());
		MessageService.instance.send(this.player.getIserver(), message);
	}
	/**
	 * 获得玩家能够玩那些游戏  2011-9-7 11:36
	 * @return
	 */
	public void sendUsersGames(){
		RemoteService rs = new RemoteService();
//		List<GameDefinition> list = rs.getUserService().getUsersGames(player.getName());
		
		StringBuffer stringBuffer = new StringBuffer();
		
//		for (int i = 0; i < list.size(); i++) {
//			stringBuffer.append(list.get(i).getGameNo() + ",");
//		}
		
		message.setHead("getUserGameI");
		message.setContent(stringBuffer.toString());
		MessageService.instance.send(this.player.getIserver(), message);
	}
	/**
	 * 发送玩家限制信息
	 */
	public void sendPlayerLimits(){
		message.setHead("playerLimitI");
//		message.setContent(player.getChipGroupItems());
		MessageService.instance.send(player.getIserver(), message);
	}
	/**
	 * 发送玩家修改金额后
	 * @param money
	 */
	public void sendUpdatePlayerMoney(double money){
		message.setHead("updatePlayerMoneyI");
		message.setContent(money);
		MessageService.instance.send(player.getIserver(), message);
	}
	
	/**
	 * 玩家登陆是发送给玩家的房间人数
	 * @param roomNums
	 */
	public void loginPlayer(Map<String, Integer> roomNums){
		message.setHead("loginPlayerI");
		message.setContent(roomNums);
		MessageService.instance.send(player.getIserver(), message);
	}
	/**
	 * 发送麻将房间的人数
	 * @param roomType
	 * @param roomNum
	 */
	public void sendRoomNum(String roomType, int roomNum){
		message.setHead("sendRoomNumI");
		message.setContent(roomType + "," + roomNum);
		MessageService.instance.send(player.getIserver(), message);
	}
	
	/**
	 * 发送断开消息到前天
	 * @param obj
	 */
	public void sendDisConnect(Object obj){
		message.setHead("disConnectPlayerI");
		message.setContent(obj);
		MessageService.instance.send(player.getIserver(), message);
	}
	/**
	 * 发送系统消息
	 * @param message
	 */
	public void sendManagerMessage(Message message){
		MessageService.instance.send(this.player.getIserver(), message);
	}
	/**
	 * 修改玩家在线状态  V1.8
	 * @param onlineStatus
	 */
	public void changeDemoAcctOnlineStatus(int onlineStatus){
		RemoteService rs = new RemoteService();
//		if(onlineStatus == 1){
//			rs.getUserService().enterGame(player.getName(), AbstractGameClass.HALL);
//		}else{
//			rs.getUserService().exitGame(player.getName(), AbstractGameClass.HALL);
//		}
	}
	
}
