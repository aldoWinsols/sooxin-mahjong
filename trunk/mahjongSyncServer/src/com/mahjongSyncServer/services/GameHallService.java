package com.mahjongSyncServer.services;

import java.util.ArrayList;
import java.util.Date;
import java.util.Timer;

import org.red5.server.api.service.IServiceCapableConnection;
import org.slf4j.Logger;

import com.mahjongSyncServer.dataServices.RemoteService;
import com.mahjongSyncServer.model.GameHall;
import com.mahjongSyncServer.sockets.RtmpClientNew;
import com.mahjongSyncServer.util.ServiceConnection;
import com.mahjongSyncServer.util.TimerTaskServer;
import com.mahjongSyncServer.util.Util;
import com.mahjongSyncServer.util.UtilProperties;

/**
 * 大厅操作类
 * @author Administrator
 * 2012-1-6 16:33 gmr end mod 判断房间里用户够不够4个用户，如果不够，就把玩家的onlineState状态改为1(等待状态)
 * 2012-2-20 12:11 gmr start 玩家掉线时，停止房间的暂停检测
 * 2012-2-21 9:56 gmr start 修改玩家游戏状态
 * 2012-3-5 11:34 gmr start 玩家进入游戏就扣除最大输赢金额
 * 2012-3-5 14:42 gmr start 修改玩家是否结算
 */
public class GameHallService {

	private GameHall gameHall = null;									//大厅实体类
	private int timerNum = 0;											//控制timer时钟的逻辑变量
	private ArrayList<PlayerService> waitPlayers = null;				//等待用户集合
	private Logger log = null;
	private RemoteService remoteService = null;
	public boolean isIpEqual = true;
	public boolean isAgencyEqual = true;
	private RtmpClientNew rtmpClientNew = null;
	
	public GameHallService(){
		log = UtilProperties.instance.getLogger(GameHallService.class);
		gameHall = new GameHall();
		waitPlayers = new ArrayList<PlayerService>();
		remoteService = new RemoteService();

		Util.getInsance();

		getGameProperty();
		
		connectServer();
		
		rtmpClientNew = new RtmpClientNew();
		//初始化时钟对象
		Timer timer = new Timer();
		TimerTaskServer timerTaskServer = new TimerTaskServer(this);
		timer.schedule(timerTaskServer, 1000, 1000);
		
//		rtmpClientNew.sendRoomNum(UtilProperties.instance.getRoomNo(), gameHall.getPlayerServices().size());
	}
	
	public ArrayList<PlayerService> getWaitPlayers() {
		return waitPlayers;
	}

	/**
	 * 获得RMI服务
	 * @return
	 */
	public RemoteService getRemoteService(){
		return remoteService;
	}
	
	public void connectServer(){ 
		for (int i = 1; i < 4; i++) {
			
			String playerName = "";
			if(i < 10){
				playerName = "m00" + i;
			}else if(i >= 10 && i < 100){
				playerName = "m0" + i;
			}else if(i >= 100){
				playerName = "m" + i;
			}
			PlayerService playerService = new PlayerService(playerName);
			playerService.getPlayer().setOnlineState(1);
			playerService.setPlayerType(3);
			playerService.getPlayer().setIServer(new ServiceConnection());
			addPlayerService(playerService);
		}
	}
	
	/**
	 * 获得大厅实体类
	 * @return
	 */
	public GameHall getGameHall(){
		return gameHall;
	}
	
	/**
	 * 获得房间的属性
	 * @return
	 */
	private void getGameProperty(){
		gameHall.setLimitMoney(UtilProperties.instance.getLimitMoney());
		gameHall.setWaitTimer(UtilProperties.instance.getAndroidWaitTimer());
		gameHall.setAndroidStartNum(UtilProperties.instance.getAndroidStartNum());
	}
	
	/**
	 * 添加玩家
	 * @param actionService
	 */
	public void addPlayerService(String playerName,String password, String userIp, IServiceCapableConnection iserver){
		if(getPlayerServiceByPlayerName(playerName) == null){
//			if(getUserAcct(playerName, password) != null){
				PlayerService playerService = new PlayerService(playerName);
				playerService.getPlayer().setOnlineState(1);
				playerService.getPlayer().setIServer(iserver);
				playerService.getPlayer().setUserIp(userIp);
				playerService.getPlayer().setPassword(password);
				playerService.setPlayerType(1);
//				remoteService.getUserService().enterGame(playerName, getOnlineStatus());
//				
//				// 2012-3-5 11:34 gmr start 玩家进入游戏就扣除最大输赢金额
//				remoteService.getUserService().deductMoney(playerName, gameHall.getLimitMoney());
				// 2012-3-5 11:34 gmr end
				
				gameHall.getPlayerServices().add(playerService);
				
				rtmpClientNew.sendRoomNum(UtilProperties.instance.getRoomNo(), gameHall.getPlayerServices().size());
//			}else{
//				iserver.close();
//			}
		}else{
			iserver.close();
		}
		
	}
	/**
	 * 获得玩家所有在的游戏
	 * @return
	 */
	private int getOnlineStatus(){
		int status = 0;
//		switch(UtilProperties.instance.getRoomNo()){
//			case 1:
//				status = AbstractGameClass.ChessGameClass.MAHJONG_1;
//				break;
//			case 5:
//				status = AbstractGameClass.ChessGameClass.MAHJONG_5;
//				break;
//			case 10:
//				status = AbstractGameClass.ChessGameClass.MAHJONG_10;
//				break;
//			case 20:
//				status = AbstractGameClass.ChessGameClass.MAHJONG_20;
//				break;
//			case 50:
//				status = AbstractGameClass.ChessGameClass.MAHJONG_50;
//				break;
//		}
		return status;
	}
	
	/**
	 * 获得用户数据库类型，
	 * @param playerName
	 * @param password
	 * @return
	 */
//	private UserAcct getUserAcct(String playerName, String password){
//		Object obj = remoteService.getUserService().login(playerName, password);
//		UserAcct userAcct = null;
//		if(obj != null && obj instanceof UserAcct){
//			userAcct = (UserAcct) obj;
//		}else{
//			log.info(playerName + " 此帐号异常， 验证用户名和密码未通过！");
//		}
//		return userAcct;
//	}
	/**
	 * 添加玩家
	 * @param playerService
	 */
	private void addPlayerService(PlayerService playerService){
		gameHall.getPlayerServices().add(playerService);
	}
	/**
	 * 删除用户操作类
	 * @param iserver
	 */
	public void removePlayerService(IServiceCapableConnection iserver){
		
		PlayerService playerService = null;
		boolean isTheGame = false;
		for (int i = 0; i < gameHall.getPlayerServices().size(); i++) {
			if(gameHall.getPlayerServices().get(i).getPlayer().getClientID().equals(iserver.getClient().getId())){
				playerService = gameHall.getPlayerServices().get(i);
				gameHall.getPlayerServices().remove(i);
				break;
			}
		}
		
		if(playerService != null){
			for (int i = 0; i < waitPlayers.size(); i++) {
				if(waitPlayers.get(i).getPlayer().getPlayerName().equals(playerService.getPlayer().getPlayerName())){
					waitPlayers.remove(i);
					break;
				}
			}
			
			for (int i = 0; i < gameHall.getRoomServices().size(); i++) {
				if(gameHall.getRoomServices().get(i).getRoom().isGameOver()){
					if(gameHall.getRoomServices().get(i).removePlayerService(playerService.getPlayer().getPlayerName())){
						setWhereFallline(playerService.getPlayer().getPlayerName(), 0);
//						remoteService.getUserService().exitGame(playerService.getPlayer().getPlayerName(), getOnlineStatus());
						isTheGame = true;
						break;
					}
				}else{
					if(gameHall.getRoomServices().get(i).getRoom().getRoomNo().equals(playerService.getPlayer().getRoomNo())){
						log.warn("正在游戏中的玩家  " + playerService.getPlayer().getPlayerName() + " 掉线了！  局号 ： " + gameHall.getRoomServices().get(i).getRoom().getRoomNo());
						isTheGame = true;
						// 2011-9-20 14:11 保存历史记录
						log.warn(playerService.getPlayer().getPlayerName() + "玩家掉线时的历史记录：" + Util.getInsance().getHistoryMessage(gameHall.getRoomServices().get(i).getRoom().getHistoryMessage(), gameHall.getRoomServices().get(i).getRoom().getPlayerServices()));
						
						// 2012-2-20 12:11 gmr start 玩家掉线时，停止房间的暂停检测
						gameHall.getRoomServices().get(i).getLogicService().setOperationSumBool(false);
						// 2012-2-20 12:11 gmr end 
						
						sendOfflineWaitToAll(gameHall.getRoomServices().get(i), true , gameHall.getReunionTimer());
						setWhereFallline(playerService.getPlayer().getPlayerName(), 1);
						break;
					}
				}
			}
			
			if(!isTheGame){
				rtmpClientNew.sendRoomNum(UtilProperties.instance.getRoomNo(), gameHall.getPlayerServices().size());
//				remoteService.getUserService().exitGame(playerService.getPlayer().getPlayerName(), getOnlineStatus());
//				
//				// 2012-3-5 11:34 gmr start 玩家账号发生异常，退换扣除的金额
//				if(!playerService.getPlayer().isBalance()){					
//					remoteService.getUserService().deductMoney(playerService.getPlayer().getPlayerName(), -gameHall.getLimitMoney());
//				}
				// 2012-3-5 11:34 gmr end
				
			}
		}
		
	}
	
	/**
	 *  在游戏未结束的情况，玩家断线了，设置玩家掉线的房间号
	 * @param playerName
	 */
	public void setWhereFallline(String playerName, int type){
		int roomNo = type == 1 ? UtilProperties.instance.getRoomNo() : 0;
//		remoteService.getUserService().setWhereFallline(playerName, roomNo);
		remoteService.getBalanceChessGameService().setPlayerOfflineGameNo(playerName, roomNo);
	}
	
	
	/**
	 * 发送玩家离线消息到客户端
	 * @param roomService
	 * @param onOffline  true 为掉线，  false 为在线
	 * @param waitTime   其他玩家等待的时间
	 */
	private void sendOfflineWaitToAll(RoomService roomService, boolean onOffline, int waitTime){
		int length = roomService.getRoom().getPlayerServices().size();
		boolean bool = roomService.getLogicService().setHandleOperation(false, waitTime, onOffline);
		for (int i = 0; i < length; i++) {
			PlayerService playerService = roomService.getRoom().getPlayerServices().get(i);
			if(playerService.getPlayer().getPlayerType() == 1 && onOffline){
				// V1.8 2011-8-26 14:25  把重连时间传到客户端动态显示
				playerService.sendOfflineWait(0+","+waitTime);
				playerService.setIsExecutePlayerTimerOut(false);
			}else if(playerService.getPlayer().getPlayerType() > 1){
				if(roomService.getLogicService().getLogicSwitch()){
					if(bool){//V1.8 2011-8-26 14:25  掉线一个用户就把有操作的时间设置为重连时间
						roomService.getLogicService().setOperationTimeNum(waitTime);
					}
				}
				if(playerService.getLogicSwitch()){
					if(bool){//V1.8 2011-8-26 14:25  掉线一个用户就把有操作的时间设置为重连时间
						playerService.setOperationTimeNum(waitTime);
					}
				}
			}
		}
	}
	
	/**
	 * 删除用户，通过用户名删除
	 * @param playerName
	 */
	private void removePlayerService(String playerName){
		for (int i = 0; i < gameHall.getPlayerServices().size(); i++) {
			if(gameHall.getPlayerServices().get(i).getPlayer().getPlayerName().equals(playerName)){
				gameHall.getPlayerServices().remove(i);
				break;
			}
		}
		for (int i = 0; i < gameHall.getRoomServices().size(); i++) {
			if(gameHall.getRoomServices().get(i).getRoom().isGameOver()){
				if(gameHall.getRoomServices().get(i).removePlayerService(playerName)){
					break;
				}
			}
		}
	}
	/**
	 * 服务器断开客户端用户
	 * @param playerName
	 */
	public void serverDisconnectClient(String playerName){
		for (int i = 0; i < gameHall.getPlayerServices().size(); i++) {
			if(gameHall.getPlayerServices().get(i).getPlayer().getPlayerName().equals(playerName)){
				log.info("服务器手动断开  " + playerName + "  用户");
				setWhereFallline(playerName, 0);
				PlayerService playerService = gameHall.getPlayerServices().remove(i);
				playerService.getPlayer().getIServer().close();
				
				for (int j = 0; j < gameHall.getRoomServices().size(); j++) {
					if(gameHall.getRoomServices().get(j).getPlayerServiceByPlayerName(playerName) != null){
						gameHall.getRoomServices().get(j).getRoom().setStuck(true);
						gameHall.getRoomServices().get(j).removePlayerService(playerName);
						break;
					}
				}
				break;
			}
		}
	}
	/**
	 * 添加房间
	 * @param roomService
	 */
	private void addRoomService(RoomService roomService){
		gameHall.getRoomServices().add(roomService);
	}
	/**
	 * 获得用户操作类(根据用户名来作为条件)
	 * @param playerName
	 * @return
	 */
	private PlayerService getPlayerServiceByPlayerName(String playerName){
		PlayerService playerService = null;
		for (int i = 0; i < gameHall.getPlayerServices().size(); i++) {
			if(gameHall.getPlayerServices().get(i).getPlayer().getPlayerName().equals(playerName)){
				playerService = gameHall.getPlayerServices().get(i);
			}
		}
		return playerService;
	}
	/**
	 * 检测房间是否用户是否退出完毕
	 */
	private synchronized void checkRoomGameOver(){
		
		for (int i = 0; i < gameHall.getRoomServices().size(); i++) {
			RoomService roomService = gameHall.getRoomServices().get(i);
			if(roomService.getRoom().getPlayerServices().size() == 0){
				gameHall.getRoomServices().remove(i);
				roomService.clearAllData();
				i --;
			}
			if(roomService.getRoom().isStuck() && roomService.getRoom().getPlayerServices().size() < 4){
				for (int j = 0; j < roomService.getRoom().getPlayerServices().size(); j++) {
					PlayerService playerService = roomService.getRoom().getPlayerServices().get(j);
					if(playerService.getPlayer().getPlayerType() < 3){
						playerService.getPlayer().getIServer().close();
						setWhereFallline(playerService.getPlayer().getPlayerName(), 0);
					}
				}
				gameHall.getRoomServices().remove(i);
				roomService.clearAllData();
			}
		}
	}
	/**
	 * 清除断线用户
	 */
	private synchronized void checkRoomPlayerClose(){
		
		for (int i = 0; i < gameHall.getPlayerServices().size(); i++) {
			if(!gameHall.getPlayerServices().get(i).getPlayer().getIServer().isConnected() && 
					gameHall.getPlayerServices().get(i).getPlayer().getPlayerType() <= 2){
				removePlayerService(gameHall.getPlayerServices().get(i).getPlayer().getIServer());
			}
		}
		
		for (int i = 0; i < waitPlayers.size(); i++) {
			if(!waitPlayers.get(i).getPlayer().getIServer().isConnected()){
				waitPlayers.remove(i);
				i --;
			}
		}
		
		for (int i = 0; i < gameHall.getRoomServices().size(); i++) {
			if(gameHall.getRoomServices().get(i).getRoom().isGameOver()){
				for (int j = 0; j < gameHall.getRoomServices().get(i).getRoom().getPlayerServices().size(); j++) {
					if(gameHall.getRoomServices().get(i).getRoom().getPlayerServices().get(j).getPlayer().getPlayerType() == 3){
						// V2.0 机器人清空数据的方法已经在游戏时清理过了，这里不需要清理，只需要修改onlineState为1就可以了 2011-9-30 10:22
//						gameHall.getRoomServices().get(i).getRoom().getPlayerServices().get(j).clearAllData();
						gameHall.getRoomServices().get(i).getRoom().getPlayerServices().get(j).getPlayer().setOnlineState(1);
						log.info(gameHall.getRoomServices().get(i).getRoom().getPlayerServices().get(j).getPlayer().getPlayerName() + " 删除机器人!!");
						gameHall.getRoomServices().get(i).getRoom().getPlayerServices().remove(j);
						j --;
					}else{
						PlayerService playerService = gameHall.getRoomServices().get(i).getRoom().getPlayerServices().remove(j);
						j --;
						setWhereFallline(playerService.getPlayer().getPlayerName(), 0);
//						remoteService.getUserService().exitGame(playerService.getPlayer().getPlayerName(), getOnlineStatus());
					}
				}
			}else{
				int isOfflineNum = 0;
				for (int j = 0; j < gameHall.getRoomServices().get(i).getRoom().getPlayerServices().size(); j++) {
					if(gameHall.getRoomServices().get(i).getRoom().getPlayerServices().get(j).getPlayer().getPlayerType() == 2){
						isOfflineNum ++;
					}
				}
				if(isOfflineNum > 3){
					RoomService roomService = gameHall.getRoomServices().remove(i);
					roomService.clearAllData();
					return;
				}
			}
		}
		
	}
	/**
	 * 检查机器人是否在游戏中，如果在游戏中并且onlineState属性显示为不在游戏中，就把机器人的所有属性重置
	 */
	private synchronized void checkAndroidIsGame(){
		
		for (int i = 0; i < gameHall.getPlayerServices().size(); i++) {
			PlayerService playerService = gameHall.getPlayerServices().get(i);
			if(playerService.getPlayer().getPlayerType() == 3){
				
				if(playerService.getPlayer().getOnlineState() == 2){
					boolean bool = false;
					for (int j = 0; j < gameHall.getRoomServices().size(); j++) {
						PlayerService playerService1 = gameHall.getRoomServices().get(j).getPlayerServiceByPlayerName(playerService.getPlayer().getPlayerName());

						if(playerService1 != null){
							bool = true;
						}
					}
					if(!bool){
						playerService.getPlayer().clearAllData();
						log.info(playerService.getPlayer().getPlayerName() + " 机器人归零!!");
					}
				}
				
			}
		}
		
	}
	
	/**
	 * timer执行的方法
	 */
	public synchronized void dealTimer(){
		try {
			mateDesk();
			
			if(timerNum % 5 ==0){
				checkRoomGameOver();
				checkRoomPlayerClose();
			}
			
			if(timerNum % 600 == 0){
				checkAndroidIsGame();
			}
			
			//把心跳跑传递给桌子
			for (int i = 0; i < this.gameHall.getRoomServices().size(); i++) {
				this.gameHall.getRoomServices().get(i).dealTimer();
			}
			
			
			timerNum ++;
		} catch (Exception e) {
			// TODO: handle exception
			log.error("异常： " , e);
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 给玩家配桌
	 */
	private synchronized void mateDesk(){
		
		int waitnum = 0;
		for (int i = 0; i < gameHall.getPlayerServices().size(); i++) {
			if(gameHall.getPlayerServices().get(i).getPlayer().getOnlineState() == 1){
				
				if(waitPlayers.size() > 0 && waitPlayers.get(0).getPlayer().getPlayerType() == 3){
					waitPlayers.remove(0);
					continue;
				}
				 
				// V2.0 陪桌前判断用户的连接情况，如果有掉线就按掉线处理 2011-9-21 17:05 g
				if(gameHall.getPlayerServices().get(i).getPlayer().getPlayerType() < 3 && 
						!gameHall.getPlayerServices().get(i).getPlayer().getIServer().isConnected()){
					checkRoomPlayerClose();
					continue;
				}
				
				if(gameHall.getPlayerServices().get(i).getPlayer().getPlayerType() == 3){
					// 机器人等待多少时间
					if(timerNum % gameHall.getWaitTimer() != 0 || waitPlayers.size() == 0){
						continue;
					}
				}
				
				// 2012-3-5 14:42 gmr start 修改玩家是否结算
				gameHall.getPlayerServices().get(i).getPlayer().setBalance(false);
				// 2012-3-5 14:42 gmr end
				
				if(!connectionSqlServer(gameHall.getPlayerServices().get(i))){
					continue;
				}
				
				// V2.0 2011-10-12 9:33 当i大于等于玩家的总数就跳出循环
				if(i >= gameHall.getPlayerServices().size()){
					break;
				}
				//  V2.0  2011-9-27 15:20 s
				if(checkPlayerIsRoom(gameHall.getPlayerServices().get(i).getPlayer().getPlayerName())){
					continue;
				}
				
				//判断是否有同一IP段的用户
				if(isIpEqual){					
					if(!checkHaveAlikeIpPhase(gameHall.getPlayerServices().get(i))){
						continue;
					}
				}
				
				checkOfficialTransformerJion(gameHall.getPlayerServices().get(i));
				
				waitnum++;								//等待的顺序
				// V2.0 在玩家参加配桌之前就清空一次数据信息
				gameHall.getPlayerServices().get(i).clearAllData();
				
				if(isAgencyEqual){					
					if(waitPlayers.size() > 0){
						if(gameHall.getPlayerServices().get(i).getPlayer().getPlayerType() == 3){
							waitPlayers.add(gameHall.getPlayerServices().get(i));
							gameHall.getPlayerServices().get(i).getPlayer().setOnlineState(2);
						}else{
							boolean isMate = true;
							for(int k=0; k<waitPlayers.size(); k++){
								if(!checkMate(gameHall.getPlayerServices().get(i).getPlayer().getPlayerName(),waitPlayers.get(k).getPlayer().getPlayerName())){
									isMate = false;
								}
							}
							if(isMate){
								waitPlayers.add(gameHall.getPlayerServices().get(i));
								gameHall.getPlayerServices().get(i).getPlayer().setOnlineState(2);
							}
						}
					}else{
						waitPlayers.add(gameHall.getPlayerServices().get(i));
						gameHall.getPlayerServices().get(i).getPlayer().setOnlineState(2);
					}
				}else{
					waitPlayers.add(gameHall.getPlayerServices().get(i));
					gameHall.getPlayerServices().get(i).getPlayer().setOnlineState(2);
				}
				
				if(waitPlayers.size() == 4){
					
					waitPlayers = getRandowWaitplayersPaixu(waitPlayers);
					
					RoomService roomService = new RoomService();
					
					StringBuffer stringBuffer = new StringBuffer();
					stringBuffer.append("，玩家： " );
					
					for (int j = 0; j < waitPlayers.size(); j++) {
						waitPlayers.get(j).getPlayer().setAzimuth(j+1);//设定方位
						waitPlayers.get(j).getPlayer().setOnlineState(2);//设定游戏状态
						roomService.addPlayerServices(waitPlayers.get(j));
						
						stringBuffer.append(waitPlayers.get(j).getPlayer().getPlayerName() + ",");
					}
					
					log.info("配桌成功，局号为：  " + roomService.getRoom().getRoomNo() + stringBuffer.toString());
					
					// 2012-1-6 16:33 gmr start 判断房间里用户够不够4个用户，如果不够，就把玩家的onlineState状态改为1(等待状态)
					if(roomService.getRoom().getPlayerServices().size() < 4){
						for (int j = 0; j < waitPlayers.size(); j++) {
							waitPlayers.get(j).getPlayer().setOnlineState(1);//设定游戏状态
						}
						
					}else{						
						addRoomService(roomService);
						for (int j = 0; j < roomService.getRoom().getPlayerServices().size(); j++) {
							if(roomService.getRoom().getPlayerServices().get(j).getPlayer().getPlayerType() < 3){
//								remoteService.getUserService().enterGame(roomService.getRoom().getPlayerServices().get(j).getPlayer().getPlayerName(), getOnlineStatus());
							}
						}
					}
					// 2012-1-6 16:33 gmr end
					
					waitPlayers.clear();
					break;
				}
			}
		}
	}
	/**
	 * 检查用户是否在游戏中     2011-9-27 15:20 s
	 * 为了保障起见，同一个用户不能同时开始两次游戏
	 * @param playerName
	 * @return
	 */
	private boolean checkPlayerIsRoom(String playerName){
		for (int i = 0; i < gameHall.getRoomServices().size(); i++) {
			PlayerService playerService = gameHall.getRoomServices().get(i).getPlayerServiceByPlayerName(playerName);
			if(playerService != null){
				return true;
			}
		}
		return false;
	}
	
	/**
	 *  把玩家进入的先后顺序打乱 2010-10-18 17:16 s
	 */
	private ArrayList<PlayerService> getRandowWaitplayersPaixu(ArrayList<PlayerService> playerServices) {
		ArrayList<PlayerService> list = new ArrayList<PlayerService>();
		for (int i = 4; i > 0; i--) {
			int index = (int) (Math.random() * i);
			list.add(playerServices.get(index));
			playerServices.remove(index);
		}	
		
		return list;
	}
	/**
	 * 判断用户的1代理是否相同
	 * @param playerName1
	 * @param playerName2
	 * @return
	 */
	public boolean checkMate(String playerName1, String playerName2){
//		return !(huodeLevelName(remoteService.getUserService().get234LvParentName(playerName1)).equals(huodeLevelName(remoteService.getUserService().get234LvParentName(playerName2))));
		return true;
	}
	
	public String huodeLevelName(String parentName){
		String[] names = parentName.split(",",-1);
		System.out.println("玩家上级代理 " + parentName);
		if(names.length>0){
			return names[0];
		}

		return "";
		
	}
	/**
	 * 检测用户账号是否被锁，或者所赢的点数已达到上限
	 * @param playerService
	 * @return
	 */
	private boolean connectionSqlServer(PlayerService playerService){
		try {
			if(playerService.getPlayer().getPlayerName() == null){
				return false;
			}
//			if(remoteService.getUserService().islock(playerService.getPlayer().getPlayerName())){
//				playerService.sendServerExceptionMessage("你的账号已被锁定");
//				log.info(playerService.getPlayer().getPlayerName() + " 的账号已被锁定");
//				if(playerService.getPlayer().getPlayerType() < 3){		// 如果不是机器人则删除
//					// 2012-2-21 9:56 gmr start 修改玩家游戏状态
////					remoteService.getUserService().exitGame(playerService.getPlayer().getPlayerName(), getOnlineStatus());
//					// 2012-2-21 9:56 gmr end
//					
////					 2012-3-5 11:34 gmr start 玩家账号发生异常，退换扣除的金额
////					remoteService.getUserService().deductMoney(playerService.getPlayer().getPlayerName(), -gameHall.getLimitMoney());
//					// 2012-3-5 11:34 gmr end
//					
//					gameHall.getPlayerServices().remove(playerService);
//					removePlayerService(playerService.getPlayer().getPlayerName());
//				}
//				return false;
//			}
//			if(remoteService.getUserService().isReachMaxWinloss(playerService.getPlayer().getPlayerName())){
//				playerService.sendServerExceptionMessage("你所赢点数已达到上限");
//				log.info(playerService.getPlayer().getPlayerName() + " 的所赢点数已达到上限");
//				if(playerService.getPlayer().getPlayerType() < 3){		// 如果不是机器人则删除
//					// 2012-2-21 9:56 gmr start 修改玩家游戏状态
//					remoteService.getUserService().exitGame(playerService.getPlayer().getPlayerName(), getOnlineStatus());
//					// 2012-2-21 9:56 gmr end
//					
//					// 2012-3-5 11:34 gmr start 玩家账号发生异常，退换扣除的金额
//					remoteService.getUserService().deductMoney(playerService.getPlayer().getPlayerName(), -gameHall.getLimitMoney());
//					// 2012-3-5 11:34 gmr end
//					
//					gameHall.getPlayerServices().remove(playerService);
//					removePlayerService(playerService.getPlayer().getPlayerName());
//				}
//				return false;
//			}
			
//			if(playerService.getPlayer().getPlayerType() == 1){
//				UserAcct useracct = getUserAcct(playerService.getPlayer().getPlayerName(), playerService.getPlayer().getPassword());
//				if(useracct != null && useracct.getAcctMoney() < gameHall.getLimitMoney()){
//					// 2012-2-21 9:56 gmr start 修改玩家游戏状态
//					remoteService.getUserService().exitGame(playerService.getPlayer().getPlayerName(), getOnlineStatus());
//					// 2012-2-21 9:56 gmr end
//					
//					// 2012-3-5 11:34 gmr start 玩家账号发生异常，退换扣除的金额
//					remoteService.getUserService().deductMoney(playerService.getPlayer().getPlayerName(), -gameHall.getLimitMoney());
//					// 2012-3-5 11:34 gmr end
//					
//					playerService.sendServerExceptionMessage("你现有的余额不足，不能进入该房间");
//					log.info(playerService.getPlayer().getPlayerName() + " 的金额不足，不能进入该房间");
//					return false;
//				}
//			}
			
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			log.info("异常错误", e);
			return false;
		}
	}
	
	/**
	 *  判断是否有同一段Ip段的用户
	 * @param player
	 * @return
	 */
	private boolean checkHaveAlikeIpPhase(PlayerService playerService){
		//如果是官方机器人，则不判断
		if(playerService.getPlayer().getPlayerType() == 3){
			return true;
		}
		String newIp = playerService.getPlayer().getUserIp()
						.substring(0, playerService.getPlayer().getUserIp().lastIndexOf("."));

		for (int i = 0; i < waitPlayers.size(); i++) {
			// V1.9 2011-9-5 16:01 添加判断，玩家判断IP不和自己判断
			if(!waitPlayers.get(i).getPlayer().getPlayerName().equals(playerService.getPlayer().getPlayerName())){				
				if(waitPlayers.get(i).getPlayer().getUserIp().contains(".")){
					String waitIp = waitPlayers.get(i).getPlayer().getUserIp()
					.substring(0, waitPlayers.get(i).getPlayer().getUserIp().lastIndexOf("."));;
					if(newIp.equals(waitIp)){
						log.info(playerService.getPlayer().getPlayerName() + " 玩家的IP与" + 
								waitPlayers.get(i).getPlayer().getPlayerName() + "的玩家的IP在同一IP段！");
						return false;
					}
				}
			}
		}
		
		return true;
	}
	
	//
	private boolean checkOfficialTransformerJion(PlayerService playerService){
		
		if(playerService.getPlayer().getPlayerType() == 3){
			Date date = new Date();
			int dNum = date.getMonth() * 30 + date.getDay();
			
			if(dNum > playerService.getPlayer().getLastSetTransformersWinMoneyDayNum()){	
				playerService.getPlayer().setLastSetTransformersWinMoneyDayNum(dNum);
				playerService.getPlayer().setTransformersWinMoney(0);
			}
		}
		return true;
	}
	
	/**
	 * 获得房间操作类(根据房间编号)
	 * @param roomNo 房间编号
	 * @return
	 */
	public RoomService getRoomServiceByRoomNo(String roomNo){
		RoomService roomService = null;
		
		for (int i = 0; i < gameHall.getRoomServices().size(); i++) {
			if(gameHall.getRoomServices().get(i).getRoom().getRoomNo().equals(roomNo)){
				roomService = gameHall.getRoomServices().get(i);
				break;
			}
		}
		return roomService;
	}
	
	//----------------------------------------------------------------------
	/**
	 * 玩家打牌操作方法
	 */
	public void putOneMahjong(String arg){
		String[] args = arg.split(";");
		
		RoomService roomService = getRoomServiceByRoomNo(args[0]);
		roomService.putOneMahjong(arg);
	}
	/**
	 * 玩家碰牌操作方法
	 * @param arg
	 */
	public void peng(String arg){
		String[] args = arg.split(";");
		RoomService roomService = getRoomServiceByRoomNo(args[0]);
		roomService.peng(arg);
	}
	/**
	 * 玩家杠牌操作方法
	 * @param arg
	 */
	public void gang(String arg){
		String[] args = arg.split(";");
		RoomService roomService = getRoomServiceByRoomNo(args[0]);
		roomService.gang(arg);
	}
	/**
	 * 玩家胡牌操作方法
	 * @param arg
	 */
	public void hu(String arg){
		String[] args = arg.split(";");
		
		RoomService roomService = getRoomServiceByRoomNo(args[0]);
		roomService.hu(arg);
	}
	/**
	 * 玩家发牌完毕操作方法
	 * @param arg
	 */
	public void dealOver(String arg){
		String[] args = arg.split(";");
		RoomService roomService = getRoomServiceByRoomNo(args[0]);
		roomService.dealOver(arg);
	}
	/**
	 * 玩家定章操作方法
	 * @param arg
	 */
	public void dingzhang(String arg){
		String[] args = arg.split(";");
		RoomService roomService = getRoomServiceByRoomNo(args[0]);
		roomService.dingzhang(arg);
	}
	/**
	 * 玩家取消操作方法
	 * @param arg
	 */
	public void quxiao(String arg){
		String[] args = arg.split(";");
		
		RoomService roomService = getRoomServiceByRoomNo(args[0]);
		roomService.quxiao(arg);
	}
	/**
	 * 玩家继续游戏
	 * @param arg
	 */
	public void continueGame(String arg){
		String[] args = arg.split(";");
		
		RoomService roomService = getRoomServiceByRoomNo(args[0]);
		String playerName = args[1];
		
		if(roomService != null){
			roomService.removePlayerService(playerName);
			roomService.clearAllData();
		}
		
		PlayerService playerService = getPlayerServiceByPlayerName(playerName);
		if(playerService != null){
			// V2.0 这里不考虑清理， 2011-9-30 10:26
//			playerService.clearAllData();
			// V2.0 添加一个修改onlineState属性为1 2011-9-30 10:26
			playerService.getPlayer().setOnlineState(1);
//			remoteService.getUserService().enterGame(playerName, getOnlineStatus());
//			
//			// 2012-3-5 11:34 gmr start 玩家进入游戏就扣除最大输赢金额
//			remoteService.getUserService().deductMoney(playerName, gameHall.getLimitMoney());
			// 2012-3-5 11:34 gmr end
		}
	}
	/**
	 * 检测用户是否在线
	 */
	public String checkPlayerServiceIsOnline(String playerName,String password, String userIp, IServiceCapableConnection iserver){
		PlayerService playerService = null;
		
		for (int i = 0; i < gameHall.getRoomServices().size(); i++) {
			playerService = gameHall.getRoomServices().get(i).getPlayerServiceByPlayerName(playerName);
			// V1.9 2011-9-5 15:50 添加断线重连只有连接对象断开的状态才能重连，否则不予重连
			if(playerService != null && !playerService.getPlayer().getIServer().isConnected() 
					&& !gameHall.getRoomServices().get(i).getRoom().isGameOver()){
//				if(getUserAcct(playerName, password) != null){
					playerService.getPlayer().setIServer(iserver); 
					playerService.getPlayer().setIsReconnection(true);
					playerService.getPlayer().setUserIp(userIp);
					if(playerService.getPlayer().getPlayerType() == 2){
						log.warn(playerName + " 重连进入游戏（超过延迟时间重连）！局号： " + gameHall.getRoomServices().get(i).getRoom().getRoomNo());
					}else{
						log.warn(playerName + " 重连进入游戏（在延迟时间内）！局号： " + gameHall.getRoomServices().get(i).getRoom().getRoomNo());
					}
					
					playerService.setPlayerType(1);
					playerService.playerRestartGame();
					
					RoomService roomService = gameHall.getRoomServices().get(i);
					sendOfflineWaitToAll(roomService, false, 5);
					
					if(!playerService.getRoomService().getLogicService().getHandleOperation()){
						gameHall.getRoomServices().get(i).getLogicService().sendOfflineWait(playerService);
					}
					
					PlayerService playerService1 = getPlayerServiceByPlayerName(playerName);
					if(playerService1 == null){
						addPlayerService(playerService);
					}
					
					return "replace";
//				}else{
//					iserver.close();
//				}
			}
		}
		
		playerService = getPlayerServiceByPlayerName(playerName);
		if(playerService != null){
			log.info(playerName + " 已经在游戏中了!");
			return "iterance";
		}
		
		return "no";
	}
	
	/**
	 * 获得房间所有用户
	 * @return
	 */
	public ArrayList<String> getRoomPlayerList(){
		
		ArrayList<String> list = new ArrayList<String>();
		
		for (int i = 0; i < gameHall.getRoomServices().size(); i++) {
			ArrayList<PlayerService> playerServices = gameHall.getRoomServices().get(i).getRoom().getPlayerServices();
			for (int j = 0; j < playerServices.size(); j++) {
				if(playerServices.get(j).getPlayer().getPlayerType() < 3){
					int type = 0;
					
					// 添加一个状态  2011-10-8 16:41 V2.0
					if(playerServices.get(j).getPlayer().getIServer().isConnected()){
						type = 0;  //在线状态
					}else if(!playerServices.get(j).getPlayer().getIServer().isConnected() && 
							playerServices.get(j).getPlayer().getPlayerType() == 1){
						type = 1;  //掉线状态但机器人未接入
					}else if(!playerServices.get(j).getPlayer().getIServer().isConnected() && 
							playerServices.get(j).getPlayer().getPlayerType() == 2){
						type = 2;  //掉线状态但机器人已经托管
					}
					
					String str = playerServices.get(j).getPlayer().getPlayerName() + "," + 
								type + "," + UtilProperties.instance.getRoomNo() + "," + gameHall.getRoomServices().get(i).getRoom().getRoomNo();
					list.add(str);
				}
			}
		}
		
		for (int i = 0; i < waitPlayers.size(); i++) {
			if(waitPlayers.get(i).getPlayer().getPlayerType() < 3){
				String str = waitPlayers.get(i).getPlayer().getPlayerName() + "," + 3 + "," + UtilProperties.instance.getRoomNo() + ",0";
				list.add(str);
			}
		}
		
		return list;
	}
	
	public void sendRoomNum(){
		rtmpClientNew.sendRoomNum(UtilProperties.instance.getRoomNo(), Util.insance.getOnlineNum() + gameHall.getPlayerServices().size());
	}
}