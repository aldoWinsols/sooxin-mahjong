package com.mahjongSyncServer.services;

import java.util.ArrayList;
import java.util.Observable;

import org.slf4j.Logger;

import com.mahjongSyncServer.util.UtilProperties;

/**
 * 
 * @author Administrator
 * 2012-2-20 11:10 gmr start 检测房间暂停情况
 * 2012-2-20 12:11 gmr start 玩家连接时，开启房间暂停检测
 */
public class LogicService extends Observable {
	protected static Logger log = null;

	private RoomService roomService;
	private ArrayList<PlayerService> operations = null;					//所有玩家返回的结果集合
	private long timeNum = 0;					//时钟计时数据
	private boolean logicSwitch = false;			//逻辑启动开关
	private String operationName = "";		//要执行的操作名字
	public String str = "";
	private long operationTimeNum = 0;		//操作需要的时间
	private PlayerService operationPlayerService = null;
	private ArrayList<PlayerService> huPlayerList = null;			//胡牌的用户（点胡）
	private int operationMahjongValue = 0;
	private boolean isHandleOperation = true;					//是否处理操作
	private int handleTime = 0;
	private int handleTimeNum = 0;
	private boolean onOffline = false;							//执行的是否是掉线还是在线 
	private boolean isFirstGetmahjongOver = false;				//是否是第一次摸牌完毕
	private int androidTimerNum = 0;							//执行机器人接入方法的时间
	//2012-2-20 11:10 gmr start
	private int operationSumNum = 0;							//操作累加数量
	private int lastOperationNum = 0;							//上次倒计时完毕之后保存的操作数量
	private int operationSumTimer = 0;							//操作累加数量的时钟控制
	private boolean operationSumBool = true;					//操作累加数量控制
	//2012-2-20 11:10 gmr end

	public LogicService(RoomService roomService) {
		log = UtilProperties.instance.getLogger(LogicService.class);
		this.roomService = roomService;
		operations = new ArrayList<PlayerService>();
	}
	/**
	 * 获得玩家返回结果集合
	 * @return
	 */
	public int getOperationsNum(){
		return operations.size();
	}
	/**
	 * 获得逻辑启动开关
	 * @return
	 */
	public boolean getLogicSwitch(){
		return logicSwitch;
	}
	/**
	 * 设置逻辑启动开关
	 * @param logicSwitch
	 */
	public void setLogicSwitch(boolean logicSwitch){
		this.logicSwitch = logicSwitch;
	}
	/**
	 * 获得操作的时间
	 * @return
	 */
	public long getOperationTimeNum(){
		return operationTimeNum;
	}
	
	/**
	 * 设置操作的时间
	 * @param operationTimeNum
	 */
	public void setOperationTimeNum(long operationTimeNum){
		timeNum = 0;
		this.operationTimeNum = operationTimeNum;
	}
	/**
	 * 设置是否可以操作处理方法(玩家在掉线时用到)
	 * @param isHandleOperation
	 */
	public boolean setHandleOperation(boolean isHandleOperation, int handleTimeNum, boolean onOffline){
		this.isHandleOperation = isHandleOperation;
		
		if(!onOffline){
			int count = 0;
			for (int i = 0; i < roomService.getRoom().getPlayerServices().size(); i++) {
				if((roomService.getRoom().getPlayerServices().get(i).getPlayer().getPlayerType() == 1) && 
						(!roomService.getRoom().getPlayerServices().get(i).getPlayer().getIServer().isConnected())){
					count ++;
				}
			}
			if(count == 0){
				handleTime = 0;
				this.handleTimeNum = handleTimeNum;
				this.onOffline = onOffline;
				
				// 2012-2-20 12:11 gmr start 玩家连接时，开启房间暂停检测
				setOperationSumBool(true);
				// 2012-2-20 12:11 gmr end 
				
				return true;
			}else{
				return false;
			}
		}else{
			handleTime = 0;
			this.handleTimeNum = handleTimeNum;
			this.onOffline = onOffline;
			return true;
		}
	}
	/**
	 * 获得是否可以操作处理方法
	 * @return
	 */
	public boolean getHandleOperation(){
		return isHandleOperation;
	}
	
	public void dealTimer(){
//		if(timeNum>operationTimeNum){
//			log.warn("timeNum:"+timeNum + " operationTimeNum:"+operationTimeNum +" logicSwitch:"+logicSwitch);
//		}
		
		if(logicSwitch){
			//2011-10-2 21：00 s 大于，不然有情况出现跳过逻辑而造成卡死的情况
			if(timeNum >= operationTimeNum){
				logicSwitch = false;
				if(operationName.equals("putOneMahjong")){
					androidPutOneMahong(operationPlayerService);
				}else if(operationName.equals("zihu")){
					int lastAzimuth = zihuOperation(operationPlayerService);
					if(checkPlayerIsHu()){
						gameOverSendMessage(operationPlayerService);
					}else{
						nextGetOneMahjong(lastAzimuth);
					}
				}else if(operationName.equals("dingzhang")){
					offlineOrAndroidRandomTimerDindzhang(operationPlayerService);
				}else if(operationName.equals("fandingzhang")){
					onlinePlayerRandomFandingzhang(operationPlayerService, operationMahjongValue);
				}else if(operationName.equals("hu")){
					huPaiOperation(huPlayerList);
				}else if(operationName.equals("wangang")){
					setChanged();
					notifyObservers(operationPlayerService);
				}
			}
		}
		if(!isHandleOperation){
			if(handleTime >= handleTimeNum){
				handleTime = 0;
				isHandleOperation = true;
				roomService.handleFunction();
				if(onOffline){
					checkPlayerOffline();
					sendOfflineWait(null);
				}
			}
			handleTime ++;
		}else{
//			// 每隔10秒判断是否有玩家掉线的情况（这里是在玩家掉线，服务器没有收到玩家掉线的消息 ）
//			if(androidTimerNum % 10 == 0){
//				checkPlayerOffline();
//			}
//			androidTimerNum ++;
		}
		
		// 2012-2-20 11:10 gmr start
		if(operationSumBool){			
			if(operationSumTimer >= 60){
				operationSumTimer = 0;
				checkRoomStop();
			}
			operationSumTimer ++;
		}
		// 2012-2-20 11:10 gmr end
		
		timeNum ++;
	}
	public void sendOfflineWait(PlayerService playerService){
		if(playerService == null){
			for (int i = 0; i < roomService.getRoom().getPlayerServices().size(); i++) {
				// V1.8 2011-8-26 14:25  把重连时间传到客户端动态显示
				roomService.getRoom().getPlayerServices().get(i).sendOfflineWait(1 + ","+0);
			}
		}else{
			int count = 0;
			for (int i = 0; i < roomService.getRoom().getPlayerServices().size(); i++) {
				if((roomService.getRoom().getPlayerServices().get(i).getPlayer().getPlayerType() == 1) && 
						(!roomService.getRoom().getPlayerServices().get(i).getPlayer().getIServer().isConnected())){
					count ++;
				}
			}
			if(count == 0){
				for (int i = 0; i < roomService.getRoom().getPlayerServices().size(); i++) {
					if(!playerService.getPlayer().getPlayerName().
							equals(roomService.getRoom().getPlayerServices().get(i).getPlayer().getPlayerName())){
						// V1.8 2011-8-26 14:25  把重连时间传到客户端动态显示
						roomService.getRoom().getPlayerServices().get(i).sendOfflineWait(1 + ","+0);
					}
					
				}
			}else{
				playerService.sendOfflineWait(0 + "," + (handleTimeNum - handleTime));
			}
		}
		
	}
	/**
	 * 检测玩家掉线，如果掉线机器人就接入
	 */
	private void checkPlayerOffline(){
		int length = roomService.getRoom().getPlayerServices().size();
		
		for (int i = 0; i < length; i++) {
			PlayerService playerService = roomService.getRoom().getPlayerServices().get(i);
			if(playerService.getPlayer().getPlayerType() == 1 && 
					!playerService.getPlayer().getIServer().isConnected() && 
						!roomService.getRoom().isGameOver()){
				log.warn(playerService.getPlayer().getPlayerName() + " 掉线用户，机器人已经接入， 局号：" + roomService.getRoom().getRoomNo());
				playerService.setPlayerType(2);
				playerService.calOperationName(0, 0, 3);
			}
		}
		
	}
	
	public void beginGame() {
		addObserver();
		
		roomService.addHistoryMessage("beginGameI", roomService.getAllPlayerSparr(0));
	}
	/**
	 * 操作对象
	 * @param playerService
	 */
	public void addOperations(PlayerService playerService){
		operations.add(playerService);
	}
	/**
	 * 添加观察者
	 */
	private void addObserver(){
		for (int i = 0; i < 4; i++) {
			addObserver(roomService.getRoom().getPlayerServices().get(i));
		}
		
	}
	/**
	 * 所有玩家操作方法
	 * @param devil
	 */
	public void dealLogic(PlayerService devil){
		
		//检测该玩家是否添加到operations集合里，如果有就不再添加，因为operations里面必须是4个不同的用户
		for (int i = 0; i < operations.size(); i++) {
			if(operations.get(i).getPlayer().getAzimuth() == devil.getPlayer().getAzimuth()){
				return;
			}
		}
		
		operations.add(devil);
		
		if(operations.size() == 4){

			PlayerService playerService = null;
			
			boolean haveHu = false;
			int azimuth = 0;
			if(roomService.getRoom().getLastPlayerService() != null){			//获得最后一个打牌的方位
				azimuth = roomService.getRoom().getLastPlayerService().getPlayer().getAzimuth();
			}
			int lastAzimuth = 0;			//最后一个胡牌的方位
			int huCount = 0;
			int huSum = 0;					
			boolean isDelay = true;
			
			ArrayList<PlayerService> huPlayers = null;
			
			// 胡牌的个数
			for (int i = 0; i < operations.size(); i++) {
				if(azimuth > 0 && operations.get(i).getPlayer().getNeedOperationName().equals("hu")){
					huSum ++;
					// 如果有在线玩家胡牌，就不需要延迟执行
					if(operations.get(i).getPlayer().getPlayerType() == 1){
						isDelay = false;
					}
				}
			}
			
			if(huSum > 0){
				huPlayers = new ArrayList<PlayerService>();
			}
			
			for (int i = 0; i < operations.size(); i++) {
				playerService = roomService.getRoom().getPlayerServices().get(azimuth == 4 ? 0 : azimuth);
				if(playerService == null){
					break;
				}
				
				if(azimuth > 0 && playerService.getPlayer().getNeedOperationName().equals("hu")){
					haveHu = true;
					if(isDelay){		// 延迟执行就添加用户
						huPlayers.add(playerService);
					}else{
						huCount ++;
						
						playerService.hu(roomService.getRoom().getLastPlayerService(), false);
						playerService.setLastGang(roomService.getRoom().getLastPlayerService().getLastGang());
						playerService.setNowOperationMahjongValue(roomService.getRoom().getLastPlayerService().getNowOperationMahjongValue());
						playerService.getPlayer().setNeedOperationName1("hu");
						playerService.setHunum(huSum);
						playerService.getPlayer().setHuCount(huCount);
						setChanged();
						notifyObservers(playerService);
						
						lastAzimuth = playerService.getPlayer().getAzimuth();
					}
					
				}else if(operations.get(i).getPlayer().getNeedOperationName().equals("zihu")){
					haveHu = true;
					setTimerOperation(3, "zihu", operations.get(i));
					break;
				}
				
				azimuth ++;
				if(azimuth == 5){
					azimuth = 1;
				}
			}
			
			if(haveHu){		//如果有人操作胡牌，直接判断下一位摸牌
				operations.clear();
				if(isDelay && huPlayers != null && huPlayers.size() > 0){	//延迟执行的
					huPlayerList = huPlayers;
					setTimerOperation(3, "hu", playerService);
				}else if(!isDelay){				//正常执行
					if(checkPlayerIsHu()){
						gameOverSendMessage(playerService);
					}else{
						nextGetOneMahjong(lastAzimuth);
					}
				}
				
			}else{
				int value = 0;
				playerService = null;
				for (int i = 0; i < operations.size(); i++) {
					if(operations.get(i).getPlayer().getNeedOperationName().equals("peng")){
						playerService = operations.get(i);
						
						playerService.peng(roomService.getRoom().getLastPlayerService().getPlayer());
						playerService.setNowOperationMahjongValue(roomService.getRoom().getLastPlayerService().getNowOperationMahjongValue());
						playerService.getPlayer().setNeedOperationName1("peng");
						break;
					}else if(operations.get(i).getPlayer().getNeedOperationName().equals("gang")){
						playerService = operations.get(i);
						playerService.setLastGang(true);
						playerService.setIsDiangang(true);
						playerService.gang(roomService.getRoom().getLastPlayerService().getPlayer());
						playerService.setNowOperationMahjongValue(roomService.getRoom().getLastPlayerService().getNowOperationMahjongValue());
						playerService.getPlayer().setNeedOperationName1("gang");
						break;
					}else if(operations.get(i).getPlayer().getNeedOperationName().equals("zigang")){
						playerService = operations.get(i);
						playerService.setLastGang(true);
						playerService.setNowOperationMahjongValue(playerService.getPlayer().getZigangValue());
						if(!checkWanGangOrHu(playerService)){			//检测是否是弯杠
							playerService.gang();
							playerService.getPlayer().setNeedOperationName1("zigang");
						}else{
							roomService.getRoom().setLastPlayerService(playerService);
							
							// 如果是机器人弯杠，就停止继续往下面执行。
							operations.clear();
							setTimerOperation(2, "wangang", playerService);
							return;
						}
						break;
					}else if(operations.get(i).getPlayer().getNeedOperationName().equals("wangang")){
						playerService = operations.get(i);
						if(playerService.getIsWangang()){			//如果是弯杠就直接改为摸牌
							playerService.getPlayer().setNeedOperationName("getOneMahjong");
							playerService.setIsWangang(false);
							playerService.gang();
							// 确认在这里添加弯杠的记录
							playerService.gangSettlement(3);
							playerService.getPlayer().setNeedOperationName1("zigang");
						}
						break;
					}else if(operations.get(i).getPlayer().getNeedOperationName().equals("putOneMahjong")){
						playerService = null;
						int random = 0;
						// V1.8 2011-8-29 10:29  如果机器人定章牌还没有打完，就固定1秒出牌
						if(operations.get(i).getAction().checkDingzhangIsOver() / 10 
								== operations.get(i).getPlayer().getDingzhangValue() / 10){
							// V2.2 机器人打定章牌随机1 到 2秒之间 2011-10-31 14:29
							random = (int)(Math.random() * 2) + 1;
						}else{
							random = randomPutOneMahjongTime();
						}
						setTimerOperation(random, "putOneMahjong", operations.get(i));
						break;
					}else if(operations.get(i).getPlayer().getNeedOperationName().equals("dingzhang")){
						if(operations.get(i).getPlayer().getAzimuth() == 3){
							if(checkPlayerDingzhangNum()){
								dingzhang(operations.get(i).getPlayer().getAzimuth(), operations.get(i).dingzhang());
							}
						}else{
							dingzhang(operations.get(i).getPlayer().getAzimuth(), operations.get(i).dingzhang());
						}
						
					}else if(operations.get(i).getPlayer().getNeedOperationName().equals("gameOver")){
						playerService = operations.get(i);
						playerService.getPlayer().setNeedOperationName1("gameOver");
					}else if(operations.get(i).getPlayer().getNeedOperationName().equals("getOneMahjong")){
						playerService = operations.get(i);
						continue;
					}
				}
				operations.clear();
				
				if(playerService != null){
					boolean bool = true;
					if(playerService.getPlayer().getNeedOperationName().equals("getOneMahjong")){
						if(playerService.getPlayer().getNeedOperationName1().equals("gang") || 
								playerService.getPlayer().getNeedOperationName1().equals("zigang")){
							value = playerService.getOneMahjong();
							playerService.getPlayer().setNeedOperationName1("getOneMahjong");
							playerService.setNowOperationMahjongValue(value);
						}else{
							bool = false;
							nextGetOneMahjong(playerService.getPlayer().getAzimuth());
						}
					}else if(playerService.getPlayer().getNeedOperationName().equals("gameOver")){
						if(!checkPlayerIsHu()){
							roomService.getRoom().getBalanceService().balancePeiHu(roomService.getRoom().getPlayerServices());
						}
						roomService.dataBalance();
					}
					if(bool){
						setChanged();
						notifyObservers(playerService);
						
						if(playerService.getPlayer().getNeedOperationName().equals("gameOver")){
							roomService.getRoom().setGameOver(true);
						}
					}
					
				}
				
			}
			
		}
	}
	/**
	 * 获得机器人出牌的时间
	 * @return
	 */
	private int randomPutOneMahjongTime(){
		int random = (int)(Math.random() * 10);
		
		if(random > 8){
			random = (int)(Math.random() * 5) + 9;
		}else{
			random = (int)(Math.random() * 4) + 2;
		}
		return random;
	}
	/**
	 * 根据方位获得该方位的下一家用户
	 * @param azimuth
	 * @return
	 */
	private PlayerService nextPlayerServiceByAzimuth(int azimuth){
		
		PlayerService playerService = null;
		for (int i = 0; i < 3; i++) {
			playerService = roomService.getRoom().getPlayerServices().get(azimuth == 4 ? 0 : azimuth);
			if(!playerService.getPlayer().getIshu()){
				return playerService;
			}
			azimuth ++;
			if(azimuth >= 5){
				azimuth = 1;
			}
		}
		return null;
	}
	
	//----------------------------------------------------------------------------
	/**
	 * 设置时钟的操作
	 * @param operationTimeNum
	 * @param operationName
	 */
	public void setTimerOperation(int operationTimeNum, String operationName, PlayerService playerService){
		logicSwitch = true;
		timeNum = 0;
		this.operationName = operationName;
		this.operationTimeNum = operationTimeNum;
		operationPlayerService = playerService;
	}
	/**
	 * 客户端发来的打牌消息
	 */
	public void putOneMahjong(int azimuth, int mahjongValue, int haveFandingzhang){
		operations.clear();
		PlayerService playerService = roomService.getRoom().getPlayerServices().get(azimuth - 1);
		playerService.setIsExecutePlayerTimerOut(false);
		if(haveFandingzhang == 1){
			mahjongValue = playerService.getPlayer().getDingzhangValue();
			playerService.getPlayer().setDingzhangFanpai(1);
			operationMahjongValue = mahjongValue;
			setTimerOperation(2, "fandingzhang", playerService);
		}else{
			playerService.getPlayer().setDingzhangFanpai(0);
			onlinePlayerRandomFandingzhang(playerService, mahjongValue);
		}
	}
	
	private void onlinePlayerRandomFandingzhang(PlayerService playerService, int mahjongValue){
		mahjongValue = playerService.putOneMahjong(mahjongValue);
		if(mahjongValue == 0){
			log.info(playerService.getPlayer().getPlayerName() + " 打的牌 " + mahjongValue + " 在手牌数组找不到!");
//			mahjongValue = playerService.getAction().checkDingzhangIsOver();
		}
		playerService.getPlayer().setHaveDingzhangFanpai(true);
		playerService.setNowOperationMahjongValue(mahjongValue);
		playerService.getPlayer().setNeedOperationName1("putOneMahjong");
		if(mahjongValue > 0){
			roomService.getRoom().setLastPlayerService(playerService);
		}
		setChanged();
		notifyObservers(playerService);
	}
	
	/**
	 * 胡牌的玩家延迟执行
	 * @param operations
	 */
	private void huPaiOperation(ArrayList<PlayerService> operations){
		int huCount = 0;
		int huSum = operations.size();	
		int lastAzimuth = 0;
		PlayerService playerService = null;
		for (int j = 0; j < operations.size(); j++) {
			huCount ++;
			playerService = operations.get(j);
			playerService.hu(roomService.getRoom().getLastPlayerService(), false);
			playerService.setLastGang(roomService.getRoom().getLastPlayerService().getLastGang());
			playerService.setNowOperationMahjongValue(roomService.getRoom().getLastPlayerService().getNowOperationMahjongValue());
			playerService.getPlayer().setNeedOperationName1("hu");
			playerService.setHunum(huSum);
			playerService.getPlayer().setHuCount(huCount);
			setChanged();
			notifyObservers(playerService);
			
			lastAzimuth = playerService.getPlayer().getAzimuth();
		}
		
		if(checkPlayerIsHu()){
			gameOverSendMessage(playerService);
		}else{
			nextGetOneMahjong(lastAzimuth);
		}
	}
	
	/**
	 * 机器人打牌
	 * @param playerService
	 */
	private void androidPutOneMahong(PlayerService playerService){
		operations.clear();
		int value = 0;
		if(!playerService.getPlayer().getHaveDingzhangFanpai() &&
				(playerService.getPlayer().getDingzhangValue() != 0) && 
				(playerService.getPlayer().getDingzhangValue() != 10) &&
				(playerService.getPlayer().getDingzhangValue() != 20)){
			value = playerService.putOneMahjong(playerService.getPlayer().getDingzhangValue());
			playerService.getPlayer().setHaveDingzhangFanpai(true);
			playerService.getPlayer().setDingzhangFanpai(1);
		}else{
			value = playerService.putOneMahjong(0);
			playerService.getPlayer().setDingzhangFanpai(0);
		}
		if(value == 0){
			System.out.println("麻将牌值为0");
			log.info(playerService.getPlayer().getPlayerName() + " 打的麻将值为0!");
		}
		playerService.setNowOperationMahjongValue(value);
		playerService.getPlayer().setNeedOperationName1("putOneMahjong");
		if(value > 0){
			roomService.getRoom().setLastPlayerService(playerService);
		}
		setChanged();
		notifyObservers(playerService);
		
	}
	/**
	 * 客户端发来的碰牌消息
	 * @param azimuth
	 * @param mahjongValue
	 */
	public void peng(int azimuth){
		PlayerService playerService = roomService.getRoom().getPlayerServices().get(azimuth - 1);
		playerService.setIsExecutePlayerTimerOut(false);
		playerService.getPlayer().setNeedOperationName("peng");
		playerService.setNowOperationMahjongValue(roomService.getRoom().getLastPlayerService().getNowOperationMahjongValue());
		
		dealLogic(playerService);
	}
	/**
	 * 客户端发来的杠牌消息
	 * @param azimuth
	 * @param mahjongValue
	 * @param haveZigang
	 */
	public void gang(int azimuth, int mahjongValue, int haveZigang){
		PlayerService playerService = roomService.getRoom().getPlayerServices().get(azimuth - 1);
		playerService.setIsExecutePlayerTimerOut(false);
		playerService.setNowOperationMahjongValue(mahjongValue);
		playerService.setLastGang(true);
		if(haveZigang == 1){
			operations.clear();
			playerService.getPlayer().setZigangValue(mahjongValue);
			
			if(checkWanGangOrHu(playerService)){			//检测是否是弯杠
				//当成最后一个打牌的消息
				roomService.getRoom().setLastPlayerService(playerService);		//把弯杠的玩家保存到最后一个打牌的变量
				setChanged();    //如果是就直接发送消息，暂时不执行杠的操作
				notifyObservers(playerService);
			}else{
				playerService.gang();
				playerService.getPlayer().setNeedOperationName1("zigang");

				setChanged();
				notifyObservers(playerService);
			}
			
		}else{
			playerService.getPlayer().setNeedOperationName("gang");
			
			dealLogic(playerService);
		}
		
	}
	/**
	 * 检测玩家是否弯杠
	 * @param playerService
	 * @return
	 */
	private boolean checkWanGangOrHu(PlayerService playerService){
		
		if(playerService.getAction().checkWanGang(playerService.getPlayer().getZigangValue())){
			playerService.getPlayer().setNeedOperationName1("wangang");
			playerService.setIsWangang(true);
			return true;
		}
		
		return false;
	}
	/**
	 * 客户端发来的胡牌消息
	 * @param azimuth
	 * @param huType
	 */
	public void hu(int azimuth, int huType){
		PlayerService playerService = roomService.getRoom().getPlayerServices().get(azimuth - 1);
		playerService.setIsExecutePlayerTimerOut(false);
		if(huType == 0){
			playerService.getPlayer().setNeedOperationName("hu");
			playerService.setLastGang(roomService.getRoom().getLastPlayerService().getLastGang());
			playerService.setNowOperationMahjongValue(roomService.getRoom().getLastPlayerService().getNowOperationMahjongValue());
			
			dealLogic(playerService);
		}else if(huType == 1){
			operations.clear();
			zihuOperation(playerService);
			
			if(checkPlayerIsHu()){
				gameOverSendMessage(playerService);
				return;
			}else{
				nextGetOneMahjong(azimuth);
			}
		}
		
		
	}
	
	/**
	 * 游戏结束发送结束消息到客户端
	 * @param playerService
	 */
	private void gameOverSendMessage(PlayerService playerService){
		
		roomService.dataBalance();
		playerService.getPlayer().setNeedOperationName1("gameOver");
		setChanged();
		notifyObservers(playerService);
		roomService.getRoom().setGameOver(true);
		
	}
	
	/**
	 * 自胡操作类
	 * @param playerService
	 * @return
	 */
	private int zihuOperation(PlayerService playerService){
		playerService.hu(playerService, true);
		playerService.setNowOperationMahjongValue(playerService.getPlayer().getLastValue());
		playerService.getPlayer().setNeedOperationName1("zihu");
		
		setChanged();
		notifyObservers(playerService);
		
		return playerService.getPlayer().getAzimuth();
	}
	/**
	 * 下一家摸牌
	 * @param azimuth
	 */
	private void nextGetOneMahjong(int azimuth){
		PlayerService playerService = nextPlayerServiceByAzimuth(azimuth);
		int value = playerService.getOneMahjong();
		if(value == 0){
			value = playerService.getPlayer().getLastValue();
		}
		playerService.getPlayer().setNeedOperationName1("getOneMahjong");
		playerService.setNowOperationMahjongValue(value);
		
		setChanged();
		notifyObservers(playerService);
	}
	/**
	 * 客户端发牌完毕传来的晓得
	 * @param azimuth
	 */
	public void dealOver(int azimuth){

		PlayerService playerService = roomService.getRoom().getPlayerServices().get(azimuth - 1);
		
		playerService.getPlayer().setIsDealOver(true);
		
		int count = 0;
		for (int i = 0; i < roomService.getRoom().getPlayerServices().size(); i++) {
			if(roomService.getRoom().getPlayerServices().get(i).getPlayer().getIsDealOver()){
				count ++;
			}
		}
		if(count == 4 && !isFirstGetmahjongOver){ 
			isFirstGetmahjongOver = true;
			
			playerService = roomService.getRoom().getPlayerServices().get(2);
			
			int value = playerService.getOneMahjong();// 3的方位多摸一张牌
			playerService.getPlayer().setNeedOperationName1("getOneMahjong");
			playerService.setNowOperationMahjongValue(value);
			setChanged();
			notifyObservers(playerService);
			
			playerService.getPlayer().setNeedOperationName1("showDingzhang");
			setChanged();
			notifyObservers(playerService);
		}
	}
	/**
	 * 玩家定章操作方法
	 * @param azimuth
	 * @param mahjongValue
	 */
	public void dingzhang(int azimuth, int mahjongValue){
		PlayerService playerService = roomService.getRoom().getPlayerServices().get(azimuth - 1);
		
//		if(playerService.getPlayer().getPlayerType() == 1){
//			operationPlayerService = playerService;
//			logicSwitch = true;
//			timeNum = 0;
//			operationTimeNum = 2;
//			operationName = "dingzhang";
//			operationMahjong = mahjongValue;
//		}else{
			timeExecDingzhang(playerService, mahjongValue);
//		}
	}
	/**
	 * 检测定章玩家的数量
	 * @return
	 */
	public boolean checkPlayerDingzhangNum(){
		int count = 0;
		
		for (int i = 0; i < roomService.getRoom().getPlayerServices().size(); i++) {
			PlayerService playerService = roomService.getRoom().getPlayerServices().get(i);
			if(playerService.getPlayer().getAzimuth() != 3 &&
				playerService.getPlayer().getDingzhangValue() > -1){
				count ++;
			}
		}
		if(count == 3){
			return true;
		}
		return false;
	}
	/**
	 * 时钟执行的定章方法
	 * @param playerService
	 * @param mahjongValue
	 */
	private void timeExecDingzhang(PlayerService playerService, int mahjongValue){
		// V2.0 2011-10-21 14:22 防止机器人出现两次定章的情况，历史记录里面记录两次定章，
		// 但前台出现了一个错了只有重新连接游戏，游戏能够继续，也能正常结算，但是在看录像是时候就不能观看下去，就是因为历史记录里面有两次定章记录就会报错
		if(playerService.getPlayer().getDingzhangValue() == -1){			
			playerService.setNowOperationMahjongValue(mahjongValue);
			playerService.getPlayer().setDingzhangValue(mahjongValue);
			playerService.getPlayer().setNeedOperationName1("dingzhang");
			log.info("LogicService ===== " + playerService.getPlayer().getPlayerName() + " 执行了定章房间编号： " + roomService.getRoom().getRoomNo() + ", 当前定章的值为： " + mahjongValue + " , 玩家的状态： " + playerService.getPlayer().getPlayerType());
			setChanged();
			notifyObservers(playerService);
			
			if(checkPlayerDingzhangNum() && playerService.getPlayer().getAzimuth() != 3){
				playerService = roomService.getRoom().getPlayerServices().get(2);
				if(playerService.getPlayer().getPlayerType() == 1){		//普通玩家执行的
					playerService.calOperationName(playerService.getPlayer().getAzimuth(), playerService.getPlayer().getLastValue(), 1);
					
					if(playerService.getPlayer().getCouldOperationNames().contains("putOneMahjong")){
						System.out.println("showDingzhangI");
						playerService.addArrayListData("showDingzhangI", playerService);
					}
				}else{		//离线玩家和机器人玩家执行的
					
					//随机一个数，来延迟机器人定章时间（这里包括离线玩家）
					int random = (int)(Math.random() * 2 + 2);
					setTimerOperation(random, "dingzhang", playerService);
				}
			}
		}
	}
	/**
	 * 离线玩家和机器人随机时间定章
	 * @param playerService
	 */
	public void offlineOrAndroidRandomTimerDindzhang(PlayerService playerService){
		ArrayList<Object> list = new ArrayList<Object>();  
		list.add(playerService.getPlayer().getAzimuth());
		list.add(0);
		roomService.addHistoryMessage("showDingzhangI", list);
		playerService.getPlayer().setDingzhangValue(playerService.dingzhang());
		playerService.setNowOperationMahjongValue(playerService.getPlayer().getDingzhangValue());
		playerService.getPlayer().setNeedOperationName1("dingzhang");
		
		setChanged();
		notifyObservers(playerService);
		
		if(playerService.getPlayer().getDingzhangValue() != 0 && 	//如果定章不为缺门就直接把定章的牌打出去
		   playerService.getPlayer().getDingzhangValue() != 10 && 
		   playerService.getPlayer().getDingzhangValue() != 20){
			putOneMahjong(playerService.getPlayer().getAzimuth(), 
					playerService.getPlayer().getDingzhangValue(), 1);
		}else{
			putOneMahjong(playerService.getPlayer().getAzimuth(), 0, 0);	//如果定章为缺门就智能找一张牌打出去
		}
	}
	
	/**
	 * 玩家取消操作方法
	 * @param azimuth
	 */
	public void quxiao(int azimuth, int haveZihu, int haveZigang){
		PlayerService playerService = null;
		
		if(haveZihu == 0 && haveZigang == 0){			//如果不是自杠并且也不是自胡
			playerService = roomService.getRoom().getPlayerServices().get(azimuth - 1);
			playerService.setIsExecutePlayerTimerOut(false);
			playerService.getPlayer().setNeedOperationName("quxiao");
			
			dealLogic(playerService);
		}else{
			operations.clear();
			playerService = roomService.getRoom().getPlayerServices().get(2);
			playerService.setIsExecutePlayerTimerOut(false);
			if(playerService.getPlayer().getDingzhangValue() == -1){
				playerService.addArrayListData("showDingzhangI", playerService);
			}
		}
		
	}
	/**
	 * 检测一下胡牌人数有几个
	 * @return
	 */
	public boolean checkPlayerIsHu(){
		int huCount = 0;
		for (int i = 0; i < roomService.getRoom().getPlayerServices().size(); i++) {
			if(roomService.getRoom().getPlayerServices().get(i).getPlayer().getIshu()){
				huCount ++;
			}
		}
		if(huCount == 3){
			return true;
		}
		return false;
	}
	/**
	 * 清除所有数据
	 */
	public void clearAllData(){
		deleteObservers();
		if(huPlayerList != null){
			huPlayerList.clear();
		}
		operationSumNum = 0;
		lastOperationNum = 0;
		operationSumTimer = 0;
		operationSumBool = true;
		roomService = null;
		operationPlayerService = null;
		operations.clear();
	}
	//2012-2-20 11:10 gmr start
	/**
	 * 重写父类的方法
	 */
	public void notifyObservers(Object arg){
		operationSumNum ++;
		operationSumBool = true;
		super.notifyObservers(arg);
	}
	
	/**
	 * 检测房间是否停止，并且保存操作累加数量
	 * @return
	 */
	private void checkRoomStop(){
		if(operationSumNum == lastOperationNum){
			setOperationSumBool(false);
			int playersLength = roomService.getRoom().getPlayerServices().size();
			for (int i = 0; i < playersLength; i++) {
				if(roomService.getRoom().getPlayerServices().get(i).getPlayer().getPlayerType() == 1){
					log.error("房间暂停没动，把所有在线的用户手动断掉，用户： " + roomService.getRoom().getPlayerServices().get(i).getPlayer().getPlayerName());
					roomService.getRoom().getPlayerServices().get(i).getPlayer().getIServer().close();
				}
			}
		}else{
			lastOperationNum = operationSumNum;
		}
	}
	
	/**
	 * 设置 操作累加数量 是否可以操作
	 * @param operationSumBool
	 */
	public void setOperationSumBool(boolean operationSumBool){
		this.operationSumBool = operationSumBool;
		operationSumTimer = 0;
	}
	//2012-2-20 11:10 gmr end
}
