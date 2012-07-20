package com.mahjongSyncServer.model;

import java.util.ArrayList;

import com.mahjongSyncServer.dataServices.DataService;
import com.mahjongSyncServer.services.BalanceService;
import com.mahjongSyncServer.services.PlayerService;
import com.mahjongSyncServer.util.Util;

/**
 * 房间实体类
 * @author Administrator
 *
 */
public class Room {
	
	private String roomNo;											//房间编号 
	private int crapsCount = 0;										//骰子点数
	private ArrayList<Message> historyMessage = null;				//历史记录
	private boolean gameOver = false;								//游戏是否结束
	private PlayerService lastPlayerService = null;					//最后一次出牌的用户操作类
	private BalanceService balanceService = null;					//房间结算
	private int countOut = 0;										//骰子数
	private boolean isStuck = false;								//是否卡死
	
	private ArrayList<PlayerService> playerServices;				//玩家集合
	private ArrayList<Integer> mahjongList;
	private DataService dataService = null;
	private boolean isHistoryPut = true;
	private int putNum = 0;

	private int enterNumber = 0;					//进入点数
	private String roomPassword = "";				//房间密码
	private int maxFanNum = 0;						//最高翻数
	private int roomNum = 0;						//房间点数
	private boolean isBeginGame = false;			//是否开始游戏
	
	public Room(){
		playerServices = new ArrayList<PlayerService>();
		historyMessage = new ArrayList<Message>();					//历史记录实例化
		mahjongList = Util.insance.getRandow(); // 洗牌
		balanceService = new BalanceService();
		dataService = new DataService();
	}
	
	public void clear(){
		gameOver = false;									//游戏是否结束
		countOut = 0;										//骰子数
		crapsCount = 0;										//骰子点数
		putNum = 0;
		isHistoryPut = true;
		mahjongList = Util.insance.getRandow(); 			// 洗牌
		historyMessage.clear();
		balanceService = new BalanceService();
	}
	
	/**
	 * 获得房间编号
	 * @return
	 */
	public String getRoomNo(){
		return roomNo;
	}
	/**
	 * 设置房间编号
	 * @param roomNo
	 */
	public void setRoomNo(String roomNo){
		this.roomNo = roomNo;
	}
	/**
	 * 获得骰子点数
	 * @return
	 */
	public int getCrapsCount(){
		return crapsCount;
	}
	/**
	 * 设置骰子点数
	 * @param crapsCount
	 */
	public void setCrapsCount(int crapsCount){
		this.crapsCount = crapsCount;
	}
	/**
	 * 获得历史记录
	 * @return
	 */
	public ArrayList<Message> getHistoryMessage(){
		return historyMessage;
	}
	/**
	 * 添加历史记录
	 * @param message
	 */
	public void addHistoryMessage(Message message){
		historyMessage.add(message);
	}
	/**
	 * 获得房间玩家集合
	 * @return
	 */
	public ArrayList<PlayerService> getPlayerServices() {
		return playerServices;
	}

	/**
	 * 设置房间玩家集合
	 * @return
	 */
	public void setPlayerServices(ArrayList<PlayerService> playerServices) {
		this.playerServices = playerServices;
	}
	/**
	 * 获得牌堆集合
	 * @return
	 */
	public ArrayList<Integer> getMahjongList() {
		return mahjongList;
	}
	/**
	 * 设置牌堆集合
	 * @param mahjongList
	 */
	public void setMahjongList(ArrayList<Integer> mahjongList) {
		this.mahjongList = mahjongList;
	}
	/**
	 * 获得游戏是否结束
	 * @return
	 */
	public boolean isGameOver() {
		return gameOver;
	}
	/**
	 * 设置游戏是否结束
	 * @param gameOver
	 */
	public void setGameOver(boolean gameOver) {
		this.gameOver = gameOver;
	}
	/**
	 * 获得最后一次出牌的用户操作类
	 * @return
	 */
	public PlayerService getLastPlayerService(){
		return lastPlayerService;
	}
	/**
	 * 设置最后一次出牌的用户操作类
	 * @param lastPlayerService
	 */
	public void setLastPlayerService(PlayerService lastPlayerService){
		this.lastPlayerService = lastPlayerService;
	}
	/**
	 * 获得房间结算
	 * @return
	 */
	public BalanceService getBalanceService(){
		return balanceService;
	}
	/**
	 * 获得骰子数
	 * @return
	 */
	public int getCountOut(){
		return countOut;
	}
	/**
	 * 设置骰子数
	 * @param countOut
	 */
	public void setCountOut(int countOut){
		this.countOut = countOut;
	}
	/**
	 * 获得结算类
	 * @return
	 */
	public DataService getDataService(){
		return dataService;
	}

	public boolean isHistoryPut() {
		return isHistoryPut;
	}

	public void setHistoryPut(boolean isHistoryPut) {
		this.isHistoryPut = isHistoryPut;
	}

	public int getPutNum() {
		return putNum;
	}

	public void setPutNum(int putNum) {
		this.putNum = putNum;
	}

	public boolean isStuck() {
		return isStuck;
	}

	public void setStuck(boolean isStuck) {
		this.isStuck = isStuck;
	}

	// ********************** 玩家自己创建房间的属性 *********************
	public int getEnterNumber() {
		return enterNumber;
	}

	public void setEnterNumber(int enterNumber) {
		this.enterNumber = enterNumber;
	}

	public String getRoomPassword() {
		return roomPassword;
	}

	public void setRoomPassword(String roomPassword) {
		this.roomPassword = roomPassword;
	}

	public int getMaxFanNum() {
		return maxFanNum;
	}

	public void setMaxFanNum(int maxFanNum) {
		this.maxFanNum = maxFanNum;
	}

	public int getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}

	public boolean isBeginGame() {
		return isBeginGame;
	}

	public void setBeginGame(boolean isBeginGame) {
		this.isBeginGame = isBeginGame;
	}
	
}
