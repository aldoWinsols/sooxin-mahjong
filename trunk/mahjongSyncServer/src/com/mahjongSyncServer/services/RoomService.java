package com.mahjongSyncServer.services;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import org.slf4j.Logger;

import com.mahjongSyncServer.model.Message;
import com.mahjongSyncServer.model.Player;
import com.mahjongSyncServer.model.Room;
import com.mahjongSyncServer.util.UtilProperties;

/**
 * 房间操作类
 * 
 * @author Administrator
 * 
 */
public class RoomService{
	private Logger log = null;

	private Room room = null; // 房间实体类
	
	private LogicService logicService;
	private ArrayList<String> _args = new ArrayList<String>();

	public RoomService() {
		log = UtilProperties.instance.getLogger(RoomService.class);
		room = new Room(); // 房间实例化
		room.setRoomNo(String.valueOf(System.currentTimeMillis()));
		logicService = new LogicService(this);
	}
	/**
	 * 获得房间实体类
	 * @return
	 */
	public Room getRoom() {
		return room;
	}
	/**
	 * 设置房间实体类
	 * @param room
	 */
	public void setRoom(Room room) {
		this.room = room;
	}
	/**
	 * 获得逻辑操作类
	 * @return
	 */
	public LogicService getLogicService() {
		return logicService;
	}
	/**
	 * 设置逻辑操作类
	 * @param logicService
	 */
	public void setLogicService(LogicService logicService) {
		this.logicService = logicService;
	}
	
	//--------------------------------------------------------------
	private int timeNum = 0;
	public synchronized void dealTimer() {
		// 有四个人的时候就开始游戏
		if (timeNum == 1) {
			this.beginGame();
		}
		
		try {
			logicService.dealTimer();
		} catch (Exception e) {
			// TODO: handle exception
			log.error(e.toString());
		}
		
		for (int i = 0; i < room.getPlayerServices().size(); i++) {
			room.getPlayerServices().get(i).dealTimer();
		}
		
		timeNum++;
	}
	/**
	 * 摸牌删除牌堆一张牌
	 * @return
	 */
	public int readyMahjong(){
		int value = 0;
		
		//如果没牌了标志游戏结束
		if(room.getMahjongList().size() ==0){
			return value;
		}
		
		value = this.room.getMahjongList().get(0);
		this.room.getMahjongList().remove(0);
		
		return value;
	}
	/**
	 * 摸牌删除牌堆一张牌
	 * @return
	 */
	public int readyMahjong(int value){
		
		//如果没牌了标志游戏结束
		if(room.getMahjongList().size() ==0){
			return value;
		}
		for (int i = 0; i < room.getMahjongList().size(); i++) {
			if(value == room.getMahjongList().get(i)){
				room.getMahjongList().remove(i);
				break;
			}
		}
		
		return value;
	}

	/**
	 * 开始游戏
	 */
	public void beginGame() {
		getCrapsCountOut();
		giveMahjong(); // 发牌

		for (int i = 0; i < 4; i++) {
			room.getPlayerServices().get(i).beginGame();
		}
		
		this.logicService.beginGame();
	}
	
	/**
	 * 发牌给房间里的用户
	 */
	public void giveMahjong() {
		for (int i = 0; i < 4; i++) {
			for (int j = 0; j < 13; j++) {
				room.getPlayerServices().get(i).getPlayer().getSparr().add(
						room.getMahjongList().get(0));
				room.getMahjongList().remove(0);
			}
		}
	}
	//-------------------------------------------------------------------
	/**
	 * 添加玩家
	 * @param actionService
	 */
	public void addPlayerServices(PlayerService playerService) {
		playerService.setRoomService(this);
		room.getPlayerServices().add(playerService);
	}
	/**
	 * 获得所有玩家的手牌数组
	 * @param azimuth  方位，如果该值为0 ， 把所有玩家的手牌数组保存下来
	 * @return
	 */
	public ArrayList<Object> getAllPlayerSparr(int azimuth){
		ArrayList<Object> resultList = new ArrayList<Object>();
		resultList.add(room.getRoomNo());
		resultList.add(room.getCountOut());
		
		for (int i = 0; i < room.getPlayerServices().size(); i++) {
			ArrayList<Object> list = new ArrayList<Object>();
			list.add(room.getPlayerServices().get(i).getPlayer().getAzimuth());
			if(room.getPlayerServices().get(i).getPlayer().getPlayerType() == 3){
				list.add(room.getPlayerServices().get(i).getPlayer().getRandomPlayerName());
			}else{
				list.add(room.getPlayerServices().get(i).getPlayer().getPlayerName());
			}
			
			if(room.getPlayerServices().get(i).getPlayer().getAzimuth() == azimuth){
				list.add(room.getPlayerServices().get(i).getPlayer().getSparr());
			}else if(azimuth == 0){
				list.add(room.getPlayerServices().get(i).getPlayer().getSparr());
			}
			
			resultList.add(list);
		}
		return resultList;
	}
	/**
	 * 获得游戏开始的骰子点数
	 * @return
	 */
	public int getCrapsCountOut(){
		int countOut = new Random().nextInt(11) + 2;// 骰子随机数
		room.setCountOut(countOut);
		return countOut;
	}
	/**
	 * 删除玩家操作类
	 * @param playerName
	 */
	public boolean removePlayerService(String playerName){
		boolean bool = false;
		for (int i = 0; i < room.getPlayerServices().size(); i++) {
			if(room.getPlayerServices().get(i).getPlayer().getPlayerName().equals(playerName)){
				PlayerService playerService = room.getPlayerServices().remove(i);
				playerService.clearAllData();
				bool = true;
				break;
			}
		}
		return bool;
	}
	/** 
	 * 添加历史记录信息
	 * @param head	执行的操作方法
	 * @param playerService	该操作的玩家类
	 */
	public void addHistoryMessage(String head, Object content){
		
		if(room.getHistoryMessage().size() > 1){
			if(head.equals("putOneMahjongI")){
				Message lastMessage = room.getHistoryMessage().get(room.getHistoryMessage().size() - 1);
				Message lastMessage1 = room.getHistoryMessage().get(room.getHistoryMessage().size() - 2);
				ArrayList<Object> list = (ArrayList<Object>) content;
				ArrayList<Object> list1 = (ArrayList<Object>) lastMessage.getContent();
				ArrayList<Object> list2 = (ArrayList<Object>) lastMessage1.getContent();
				if(head.equals(lastMessage.getHead()) && list.get(0) == list1.get(0)){
					return;
				}else if(head.equals(lastMessage1.getHead()) && list.get(0) == list2.get(0)){
					return;
				}
			}
		}
		
		Message historyMessage = new Message();
		historyMessage.setHead(head);
		historyMessage.setContent(content);
		
		room.addHistoryMessage(historyMessage);
	}
	
	/** 
	 * 添加历史记录信息
	 * @param head	执行的操作方法
	 * @param playerService	该操作的玩家类
	 */
	public void addHistoryMessage(String head, Object content, boolean isHistoryPut){
		
		if(room.getHistoryMessage().size() > 1){
			if(head.equals("putOneMahjongI")){
				ArrayList<Object> list = (ArrayList<Object>) content;
				if(isHistoryPut){
					room.setHistoryPut(false);
					Message historyMessage = new Message();
					historyMessage.setHead(head);
					historyMessage.setContent(content);
					
					room.addHistoryMessage(historyMessage);
				}
				room.setPutNum(room.getPutNum() + 1);
			}
		}
		if(room.getPutNum() == 4){
			room.setHistoryPut(true);
			room.setPutNum(0);
		}
	}
	
	/**
	 * 获得玩家操作类
	 * @param playerName
	 * @return
	 */
	public PlayerService getPlayerServiceByPlayerName(String playerName){
		PlayerService playerService = null;
		
		for (int i = 0; i < room.getPlayerServices().size(); i++) {
			if(room.getPlayerServices().get(i).getPlayer().getPlayerName().equals(playerName)){
				playerService = room.getPlayerServices().get(i);
				break;
			}
		}
		return playerService;
	}
	/**
	 * 1.房间编号
	 * 2.骰子数
	 * 3.最好一个出牌的方位
	 * @return
	 */
	public ArrayList<Object> getBreakPlayerInfo(String playerName, boolean showOperation, String operationName){

		ArrayList<Player> playerList = new ArrayList<Player>();
		Player thisPlayer = null;
		for (int i = 0; i < room.getPlayerServices().size(); i++) {
			if(room.getPlayerServices().get(i).getPlayer().getPlayerName().equals(playerName)){
				thisPlayer = (Player)room.getPlayerServices().get(i).getPlayer().clone();
				if(thisPlayer.getDingzhangValue() % 10 > 0 && !thisPlayer.getHaveDingzhangFanpai()){
					for (int j = 0; j < thisPlayer.getSparr().size(); j++) {
						if(thisPlayer.getSparr().get(j) == thisPlayer.getDingzhangValue()){
							thisPlayer.getSparr().remove(j);
							break;
						}
					}
				}
				playerList.add(thisPlayer);
			}else{
				Player player = (Player)room.getPlayerServices().get(i).getPlayer().clone();
				if(player.getDingzhangValue() % 10 > 0 && !player.getHaveDingzhangFanpai()){
					for (int j = 0; j < player.getSparr().size(); j++) {
						if(player.getSparr().get(j) == player.getDingzhangValue()){
							player.getSparr().remove(j);
							break;
						}
					}
				}
				player.setSparrNum();
				player.setSparr(null);
				playerList.add(player);
			}
		}
		
		ArrayList<Object> list = new ArrayList<Object>();
		list.add(room.getRoomNo());
		list.add(room.getCountOut());
		if(room.getLastPlayerService() == null){
			list.add(0);
		}else{
			list.add(room.getLastPlayerService().getPlayer().getAzimuth());
		}
		list.add(showOperation);
		list.add(playerList);
		list.add(operationName);
		
		return list;
	}
	
	/**
	 * 游戏结束  集合数据  准备发送到客户端
	 * @return
	 */
	public ArrayList<Object> gameOverData(){
		ArrayList<Object> list = new ArrayList<Object>();
		ArrayList<Object> allarr = getAllPlayerSparr(0);
		allarr.remove(0);		//删除房间编号
		allarr.remove(0);		//删除筛子数
		list.add(allarr);
		list.add(room.getBalanceService().balanceList);
		list.add(logicService.str);
		
		return list;
	}
	/**
	 * 数据结算
	 */
	public void dataBalance(){
		try {
			room.getDataService().balance(room.getPlayerServices(), room.getBalanceService(), room.getHistoryMessage());
		} catch (Exception e) {
			// TODO: handle exception
			log.info("结算出错， 局号： " + room.getRoomNo() + " ,  异常信息：" + e.toString());
		}
	}
	
	/**
	 * 清除所有数据
	 */
	public void clearAllData(){
		room.getHistoryMessage().clear();
		room.setLastPlayerService(null);
		logicService.clearAllData();
	}
	
	//------------------------------------------------------------------
	
	/**
	 * 玩家打牌操作方法
	 */
	public void putOneMahjong(String arg){
		if(!logicService.getHandleOperation()){
			String _arg = "putOneMahjong=" + arg;
			_args.add(_arg);
			return;
		}
		String[] args = arg.split(";");
		logicService.putOneMahjong(Integer.valueOf(args[1]), Integer.valueOf(args[2]), Integer.valueOf(args[3]));
	}
	
	/**
	 * 玩家碰牌操作方法
	 * @param arg
	 */
	public void peng(String arg){
		if(!logicService.getHandleOperation()){
			String _arg = "peng=" + arg;
			_args.add(_arg);
			return;
		}
		String[] args = arg.split(";");
		logicService.peng(Integer.valueOf(args[1]));
	}
	
	/**
	 * 玩家杠牌操作方法
	 * @param arg
	 */
	public void gang(String arg){
		if(!logicService.getHandleOperation()){
			String _arg = "gang=" + arg;
			_args.add(_arg);
			return;
		}
		String[] args = arg.split(";");
		logicService.gang(Integer.valueOf(args[1]), Integer.valueOf(args[2]), Integer.valueOf(args[3]));
	}
	/**
	 * 玩家胡牌操作方法
	 * @param arg
	 */
	public void hu(String arg){
		if(!logicService.getHandleOperation()){
			String _arg = "hu=" + arg;
			_args.add(_arg);
			return;
		}
		String[] args = arg.split(";");
		logicService.hu(Integer.valueOf(args[1]), Integer.valueOf(args[2]));
	}
	/**
	 * 玩家发牌完毕操作方法
	 * @param arg
	 */
	public void dealOver(String arg){
		if(!logicService.getHandleOperation()){
			String _arg = "dealOver=" + arg;
			_args.add(_arg);
			return;
		}
		String[] args = arg.split(";");
		logicService.dealOver(Integer.valueOf(args[1]));
	}
	/**
	 * 玩家定章操作方法
	 * @param arg
	 */
	public void dingzhang(String arg){
		if(!logicService.getHandleOperation()){
			String _arg = "dingzhang=" + arg;
			_args.add(_arg);
			return;
		}
		String[] args = arg.split(";");
		logicService.dingzhang(Integer.valueOf(args[1]), Integer.valueOf(args[2]));
	}
	/**
	 * 玩家取消操作方法
	 * @param arg
	 */
	public void quxiao(String arg){
		if(!logicService.getHandleOperation()){
			String _arg = "quxiao=" + arg;
			_args.add(_arg);
			return;
		}
		String[] args = arg.split(";");
		logicService.quxiao(Integer.valueOf(args[1]), Integer.valueOf(args[2]),Integer.valueOf(args[3]));
	}
	
	public void handleFunction(){
		
		for (int i = 0; i < _args.size(); i++) {
			String[] args = _args.get(i).split("=");
			if(args[0].equals("putOneMahjong")){
				putOneMahjong(args[1]);
			}else if(args[0].equals("peng")){
				peng(args[1]);
			}else if(args[0].equals("gang")){
				gang(args[1]);
			}else if(args[0].equals("hu")){
				hu(args[1]);
			}else if(args[0].equals("dealOver")){
				dealOver(args[1]);
			}else if(args[0].equals("dingzhang")){
				dingzhang(args[1]);
			}else if(args[0].equals("quxiao")){
				quxiao(args[1]);
			}
		}
		
		_args.clear();
	}
}
