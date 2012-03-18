package com.mahjongSyncServer.model;

import java.util.ArrayList;

import com.mahjongSyncServer.services.MessageService;
import com.mahjongSyncServer.services.PlayerService;
import com.mahjongSyncServer.services.RoomService;

/**
 * 大厅实体类
 * @author Administrator
 *
 */
public class GameHall {

	private ArrayList<RoomService> roomServices = null;									//房间集合
	private ArrayList<PlayerService> playerServices = null;								//所有玩家列表
	private MessageService messageService = null;										//消息发送类
	private int androidStartNum = 0;													//机器人起始数
	private int limitMoney = 0;															//房间限制进入的金额
	private int waitTimer = 0;															//机器人等待进入的时间
	private int reunionTimer = 120;														//重连时间
	
	public GameHall(){
		//实例化
		roomServices = new ArrayList<RoomService>();
		playerServices = new ArrayList<PlayerService>();
		messageService = MessageService.getInstance();
	}
	/**
	 * 获得房间集合
	 * @return
	 */
	public ArrayList<RoomService> getRoomServices(){
		return roomServices;
	}
	/**
	 * 获得所有玩家集合
	 * @return
	 */
	public ArrayList<PlayerService> getPlayerServices(){
		return playerServices;
	}
	/**
	 * 获得消息发送类
	 * @return
	 */
	public MessageService getMessageService(){
		return messageService;
	}
	/**
	 * 获得机器人起始数
	 * @return
	 */
	public int getAndroidStartNum() {
		return androidStartNum;
	}
	/**
	 * 设置机器人起始数
	 * @param androidStartNum
	 */
	public void setAndroidStartNum(int androidStartNum) {
		this.androidStartNum = androidStartNum;
	}
	/**
	 * 获得房间限制进入金额
	 * @return
	 */
	public int getLimitMoney() {
		return limitMoney;
	}
	/**
	 * 设置房间限制进入金额
	 * @param limitMoney
	 */
	public void setLimitMoney(int limitMoney) {
		this.limitMoney = limitMoney;
	}
	/**
	 * 获得机器人进入房间的时间
	 * @return
	 */
	public int getWaitTimer() {
		return waitTimer;
	}
	/**
	 * 设置机器人进入房间的时间
	 * @param waitTimer
	 */
	public void setWaitTimer(int waitTimer) {
		this.waitTimer = waitTimer;
	}
	/**
	 * 获得重连时间
	 * @return
	 */
	public int getReunionTimer() {
		return reunionTimer;
	}
	/**
	 * 设置重连时间
	 * @param reunionTimer
	 */
	public void setReunionTimer(int reunionTimer) {
		if(reunionTimer < 10){
			return;
		}
		this.reunionTimer = reunionTimer;
	}
	
}
