package com.mahjongSyncServer.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Observable;
import java.util.Observer;

import org.slf4j.Logger;

import com.mahjongSyncServer.interfaces.IAction;
import com.mahjongSyncServer.interfaces.IPlayerService;
import com.mahjongSyncServer.model.Balance;
import com.mahjongSyncServer.model.Message;
import com.mahjongSyncServer.model.Player;
import com.mahjongSyncServer.services.action.AndroidAction;
import com.mahjongSyncServer.services.action.OfflineAction;
import com.mahjongSyncServer.services.action.OnlineAction;
import com.mahjongSyncServer.util.HuPai;
import com.mahjongSyncServer.util.ServiceConnection;
import com.mahjongSyncServer.util.Util;
import com.mahjongSyncServer.util.UtilProperties;

public class PlayerService implements IPlayerService, Observer {
	private Logger log = null;

	private Player player;				//用户实体类
	private RoomService roomService;	//房间操作类
	private IAction action;				//用户逻辑接口
	private MessageService messageService = null;	//发送消息类
	private Message message = null;			//封装消息实体类
	private boolean isWangang = false;		//是否弯杠
	private int qiangGangAzimuth = 0;		//被抢杠玩家的方位
	private boolean lastGang = false;		//玩家的最后一个杠(标识用来的检测玩家是否杠上花和杠上炮)
	private boolean isDiangang = false;		//是否是点杠
	private long timeNum = 0;				//总的时间进度
	private long operationTimeNum = 0;		//操作需要的时间
	private boolean logicSwitch = false;	//逻辑启动开关
	private String operationName = "";		//要执行的操作名字
	private int huNum = 0;					//胡牌
	
	private int playerTimerOutNum = 0;	//
	private boolean isExecutePlayerTimerOut = false;
	
	public String str = "";
	
	private int nowOperationMahjongValue = 0; //当前操作的麻将值
	private PlayerService observePlayerService; //被观察的对象
//	变量命名不怕长，关键不看注释最好就知道用途意思
	
	public PlayerService(String playerName){
		log = UtilProperties.instance.getLogger(PlayerService.class);
		player = new Player();
		messageService = MessageService.getInstance();
		message = new Message();
		player.setPlayerName(playerName);
	}
	/**
	 * 设置用户类型
	 * @param playerType
	 */
	public void setPlayerType(int playerType){
		player.setPlayerType(playerType);
		
		if(player.getPlayerType() == 1){
			action = new OnlineAction();
			if(roomService != null){
				setActionPlayerOrRoom();
			}
			
		}else if(player.getPlayerType() == 2){
			action = new OfflineAction();
			setActionPlayerOrRoom();
		}else if(player.getPlayerType() == 3){
			action = new AndroidAction();
			player.setIServer(new ServiceConnection());
		}
	}
	/**
	 * 获得当前操作的麻将值
	 * @return
	 */
	public int getNowOperationMahjongValue() {
		return nowOperationMahjongValue;
	}
	/**
	 * 设置当前操作的麻将值
	 * @param nowOperationMahjongValue
	 */
	public void setNowOperationMahjongValue(int nowOperationMahjongValue) {
		this.nowOperationMahjongValue = nowOperationMahjongValue;
	}
	/**
	 * 设置玩家是否是弯杠 
	 * @param isWanGang
	 */
	public void setIsWangang(boolean isWangang){
		this.isWangang = isWangang;
	}
	/**
	 * 获得玩家是否弯杠
	 * @return
	 */
	public boolean getIsWangang(){
		return isWangang;
	}
	/**
	 * 获得用户实体类
	 * @return
	 */
	public Player getPlayer() {
		return player;
	}
	/**
	 * 设置用户实体类
	 * @param player
	 */
	public void setPlayer(Player player) {
		this.player = player;
	}
	/**
	 * 设置胡牌的人数
	 * @param huNum
	 */
	public void setHunum(int huNum){
		this.huNum = huNum;
	}
	/**
	 * 获得玩家最后一个杠牌标识
	 * @return
	 */
	public boolean getLastGang(){
		return lastGang;
	}
	/**
	 * 设置玩家最后一个杠牌标识
	 * @param lastGang
	 */
	public void setLastGang(boolean lastGang){
		this.lastGang = lastGang;
	}
	/**
	 * 设置玩家是否点杠
	 * @param isDiangang
	 */
	public void setIsDiangang(boolean isDiangang){
		this.isDiangang = isDiangang;
	}
	/**
	 * 获得房间操作类
	 * @return
	 */
	public RoomService getRoomService() {
		return roomService;
	}
	/**
	 * 设置房间操作类
	 * @param roomService
	 */
	public void setRoomService(RoomService roomService) {
		if(player.getPlayerType() == 3){
			player.setRandomPlayerName(Util.insance.getRandomStr());
		}
		player.setRoomNo(roomService.getRoom().getRoomNo());
		this.roomService = roomService;
	}
	/**
	 * 获得用户逻辑接口
	 * @return
	 */
	public IAction getAction() {
		return action;
	}
	/**
	 * 设置逻辑类的用户实体类和房间实体类
	 */
	public void setActionPlayerOrRoom(){
		action.setPlayer(player);
		action.setRoom(roomService.getRoom());
	}
	/**
	 * V2.3设置是否执行玩家连接超时的情况
	 * @param playerTimerOutTimerNum
	 */
	public void setIsExecutePlayerTimerOut(boolean isExecutePlayerTimerOut){
		this.isExecutePlayerTimerOut = isExecutePlayerTimerOut;
		playerTimerOutNum = 0;
	}
	//-------------------------------------------------------------
	public boolean beginGame() {
		if(player.getPlayerType() == 3){
			player.setIsDealOver(true);
		}
		setActionPlayerOrRoom();
		playerSparrStr();
		// 2011-12-28 15:55 提前获得机器人的牌型
		action.huoDePaiXing();
		sendMessage("beginGameI", roomService.getAllPlayerSparr(player.getAzimuth()));
		return true;
	}
	/**
	 * 把玩家手牌数组组合为字符串
	 */
	private void playerSparrStr(){
		String sparrStr = "";
		for (int i = 0; i < player.getSparr().size(); i++) {
			sparrStr += player.getSparr().get(i) + ".";
		}
		player.setSparrStr(sparrStr);
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
	
	@Override
	public int dingzhang(){
		return action.checkLessMahjongType();
	}
	public void dealTimer(){
		if(logicSwitch){
			if(timeNum >= operationTimeNum){
				logicSwitch = false;
				operationTimeNum = 0;
				if(operationName.equals("dingzhangAndroid")){
					log.info("PlayerService ===== " + player.getPlayerName() + " 执行了定章房间编号： " + roomService.getRoom().getRoomNo());
					roomService.getLogicService().dingzhang(player.getAzimuth(), this.dingzhang());
				}else if(operationName.equals("zigang")){
					operationZigang();
				}else if(operationName.equals("gang")){
					operationGang();
				}else if(operationName.equals("peng")){
					operationPeng();
				}else if(operationName.equals("dealOver")){
					roomService.getLogicService().dealOver(player.getAzimuth());
				}
			}
		}
		// V2.3 消息发送到前台之后就启动计时器，一直到前台返回信息再停止计时器 2011-11-14 14:00
		if(isExecutePlayerTimerOut){
			if(playerTimerOutNum >= 60){
				isExecutePlayerTimerOut = false;
				player.getIServer().close();
				log.info(player.getPlayerName() + " 用户执行操作超时，断开此用户!");
			}
			playerTimerOutNum ++;
		}
		timeNum ++;
	}
	/**
	 * 获得当前可以操作的名字
	 * @param value
	 */
	public void calOperationName(int azimuth, int value, int valueType){
		// TODO Auto-generated method stub
		if(!player.getIshu()){
			player.setCouldOperationNames(this.action.getOperationName(azimuth, value, valueType));
		}else{
			if(player.getPlayerType() == 1){
				sendRestartGame(false);
			}
		}
		if(player.getPlayerType() == 3){//机器人
			if(player.getCouldOperationNames().size() > 0 &&
					!player.getCouldOperationNames().contains("getOneMahjong") && 
					!player.getCouldOperationNames().contains("putOneMahjong")){	//玩家操作集合里面没有摸牌和打牌消息，就提示显示操作面板
				ArrayList<String> list = new ArrayList<String>(player.getCouldOperationNames());
				list.add(0, String.valueOf(player.getAzimuth()));
				//显示操作面板添加到历史记录
				roomService.addHistoryMessage("showOperationI", list);
			}
			
			updateGangOperatioin(azimuth);
			decOperationName();
		}else if(player.getPlayerType() == 1){
			if(player.getCouldOperationNames().size() > 0 &&		
					!player.getCouldOperationNames().contains("getOneMahjong") && 
					!player.getCouldOperationNames().contains("putOneMahjong")){	//玩家操作集合里面没有摸牌和打牌消息，就提示显示操作面板
				
				ArrayList<String> list = new ArrayList<String>(player.getCouldOperationNames());
				
				String operationName = "";			// 组合字符串， 只有peng,gang ,hu三种方能组合
				if(player.isReconnection() && valueType == 0){
					for (int i = 0; i < list.size(); i++) {
						if(list.get(i).contains("peng") || list.get(i).contains("gang") || list.get(i).contains("hu")){
							operationName += i == list.size() - 1 ? list.get(i) : list.get(i) + ",";
						}
					}
				}
				
				list.add(0, String.valueOf(player.getAzimuth()));
				
				//显示操作面板添加到历史记录-
				roomService.addHistoryMessage("showOperationI", list);
				sendMessage("showOperationI", list);  //往前台发送显示面板消息
				
				// 发送断线重连的消息
				if(operationName.equals("")){
					sendRestartGame(false);
				}else{
					sendRestartGame(true, operationName);
				}
			}else{
				updateGangOperatioin(azimuth);
				if(!player.getCouldOperationNames().contains("putOneMahjong")){		//玩家当前的操作不是出牌消息
					decOperationName();
				}else{
					// 发送断线重连的消息
					sendRestartGame(false);
				}  
			} 
		}else if(player.getPlayerType() == 2){			//用户离线
			if(player.getCouldOperationNames().contains("dealOver")){			//如果操作方法名字包含有发牌完毕的字样
				roomService.getLogicService().dealOver(player.getAzimuth());
			}else if(player.getCouldOperationNames().contains("dingzhang")){ 
				if(player.getAzimuth() == 3){		//如果离线方位是三，并且其他玩家定章完毕，就该三方位定章
					if(roomService.getLogicService().checkPlayerDingzhangNum()){
						roomService.getLogicService().offlineOrAndroidRandomTimerDindzhang(this);
					}
				}else{
					roomService.getLogicService().dingzhang(player.getAzimuth(), dingzhang());
				}
			}
//			else if(player.getCouldOperationNames().contains("putOneMahjong") && 
//					roomService.getLogicService().getOperationsNum() == 0){
//				roomService.getLogicService().putOneMahjong(player.getAzimuth(), action.checkDingzhangIsOver(), 0);
//			}
			else{
				if(valueType != 3){
					if(player.getCouldOperationNames().size() > 0 &&
							!player.getCouldOperationNames().contains("getOneMahjong") && 
							!player.getCouldOperationNames().contains("putOneMahjong")){	//玩家操作集合里面没有摸牌和打牌消息，就提示显示操作面板
						ArrayList<String> list = new ArrayList<String>(player.getCouldOperationNames());
						list.add(0, String.valueOf(player.getAzimuth()));
						//显示操作面板添加到历史记录
						roomService.addHistoryMessage("showOperationI", list);
					}
				}
				
				updateGangOperatioin(azimuth);
				decOperationName();
			}
		}
		
	}
	/**
	 * 玩家进入游戏，判断当前是不是该自己操作，如果是就重连， 如果不是就另外判断是否有碰，杠，胡的操作，有就重连
	 */
	public void playerRestartGame(){
		if(player.getSparr().size() == 2 || player.getSparr().size() == 5 || 		// 如果玩家手上牌是出牌状态就重连
				player.getSparr().size() == 8 || player.getSparr().size() == 11 || 
				player.getSparr().size() == 14){
			sendRestartGame(false);
		}else{
			PlayerService lastPlayerService = roomService.getRoom().getLastPlayerService();
			if(lastPlayerService != null){
				int historyLength = roomService.getRoom().getHistoryMessage().size();
				Message lastMessage = roomService.getRoom().getHistoryMessage().get(historyLength - 1);
				
				// 判断历史记录最后一个是否是打牌消息，而且是否与最后一个打牌的玩家的方位是否相同
				if(lastMessage.getHead().equals("putOneMahjongI")){
					ArrayList<Object> contents = (ArrayList<Object>) lastMessage.getContent();
					if(Integer.valueOf(contents.get(0).toString()) == lastPlayerService.getPlayer().getAzimuth()){
						
						ArrayList<String> list = action.getOperationName(lastPlayerService.getPlayer().getAzimuth(), lastPlayerService.getNowOperationMahjongValue(), 0);
						String operationName = "";
						for (int i = 0; i < list.size(); i++) {
							if(list.get(i).contains("peng") || list.get(i).contains("gang") || list.get(i).contains("hu")){
								operationName += i == list.size() - 1 ? list.get(i) : list.get(i) + ",";
							}
						}
						if(!operationName.equals("")){
							// 如果玩家不是出牌状态，但是有碰，杠，胡的操作就重连
							sendRestartGame(true, operationName);
						}
					}
				}else if(lastMessage.getHead().equals("showOperationI")){
					ArrayList<Object> contents = (ArrayList<Object>) lastMessage.getContent();
					if(Integer.valueOf(contents.get(0).toString()) == player.getAzimuth()){
						
						String operationName = "";
						for (int i = 0; i < contents.size(); i++) {
							if(contents.get(i).toString().contains("peng") || contents.get(i).toString().contains("gang") || contents.get(i).toString().contains("hu")){
								operationName += i == contents.size() - 1 ? contents.get(i) : contents.get(i) + ",";
							}
						}
						if(!operationName.equals("")){
							// 如果玩家不是出牌状态，但是有碰，杠，胡的操作就重连
							sendRestartGame(true, operationName);
						}
					}
				}
				
			}else{
				if(player.getDingzhangValue() == -1){ // 如果玩家没有定章的情况下就重连
					sendRestartGame(false);
					if(!player.getIsDealOver()){
						roomService.getLogicService().dealOver(player.getAzimuth());
					}
				}
			}
		}
	}
	
	/**
	 * 断线重新连接，发送消息到客户端
	 * @param isShowOperation	是否显示操作面板
	 */
	private void sendRestartGame(boolean isShowOperation){
		if(player.isReconnection()){
			player.setIsReconnection(false);
			log.warn(player.getPlayerName() + " 接收重连消息！局号：" + roomService.getRoom().getRoomNo());
			sendMessage("restartGameI", roomService.getBreakPlayerInfo(player.getPlayerName(), isShowOperation, ""));
		}
	}
	
	private void sendRestartGame(boolean isShowOperation, String operationName){
		if(player.isReconnection()){
			player.setIsReconnection(false);
			log.warn(player.getPlayerName() + " 接收重连消息！局号：" + roomService.getRoom().getRoomNo());
			sendMessage("restartGameI", roomService.getBreakPlayerInfo(player.getPlayerName(), isShowOperation, operationName));
		}
	}
	/**
	 * 修改杠的操作(弯杠)
	 */
	private void updateGangOperatioin(int azimuth){
		if(isWangang && player.getAzimuth() == azimuth){
			player.getCouldOperationNames().clear();
			player.getCouldOperationNames().add("wangang");
		}
	}
	/**
	 * 决定自己应该做什么操作，然后向桌面发送申请自己的操作
	 */
	public void decOperationName(){ 
		if(player.getCouldOperationNames().size()>0){
			player.setNeedOperationName(player.getCouldOperationNames().get(0));
		}else{
			player.setNeedOperationName("");
		}
		
		if(roomService.getLogicService().checkPlayerIsHu()){
			player.setNeedOperationName("gameOver");
		}else if(player.getNeedOperationName().equals("getOneMahjong") && 
				roomService.getRoom().getMahjongList().size() == 0){
			player.setNeedOperationName("gameOver");
		}
		//向桌面发送申请自己的操作
		this.roomService.getLogicService().dealLogic(this);
	}

	public int getOneMahjong() {
		int value = 0;
		if(player.getSparr().size() == 1 || player.getSparr().size() == 4 || 
				player.getSparr().size() == 7 || player.getSparr().size() == 10 || player.getSparr().size() == 13){
				
			if(player.getPlayerType() == 3){
				if((Math.random()*100 >Util.insance.getTransformerWinGailv())){
					int valueMP = action.huoDeMP();
					if(valueMP != 0){
						value = this.roomService.readyMahjong(valueMP);
					}else{
						value = this.roomService.readyMahjong();
					}
				}else{
					value = this.roomService.readyMahjong();
				}
				
			}else{
				value = this.roomService.readyMahjong();
			}
			if(value == 0){
				return value;
			}
			player.getSparr().add(value);
			player.setLastValue(value);
			player.setLastFangFanNum(0);
			player.setFangTuiDa(false);
		
			return value;
		}else{
			return 0;
		}
	}

	public int putOneMahjong(int mahjongValue) {
		if(player.getSparr().size() == 2 || player.getSparr().size() == 5 ||
				player.getSparr().size() == 8 || player.getSparr().size() == 11 || player.getSparr().size() == 14){
			
			if(mahjongValue == 0){
				if(player.getPlayerType() == 3){
					action.huoDePaiXing();
					mahjongValue = action.officialTransformerPutOneMahjong();
					if(mahjongValue == 0){
						mahjongValue = player.getLastValue();
					}
				}else if(player.getPlayerType() == 2){
					mahjongValue = action.checkDingzhangIsOver();
				}
			}
			//判断该打的牌是否和定章一个类型，如果不是一个类型并且定章还没打完，就先把定章打完
			int dzValue = action.checkDingzhangIsOver();
			if(dzValue / 10 == player.getDingzhangValue() / 10 && 
					mahjongValue / 10 != dzValue / 10){
				mahjongValue = dzValue;
			}
			
			boolean bool = false;
			for(int i=0;i<this.player.getSparr().size();i++){
				if(this.player.getSparr().get(i) == mahjongValue){
					bool = true;
					this.player.getSparr().remove(i);
					player.getOutarr().add(mahjongValue);
					break;
				}
			}
			if(!bool){
				String type = player.getPlayerType() == 1 ? "在线" : "离线" ;
				log.info("[" + type + "]" + player.getPlayerName() + " 要出的牌   [" + mahjongValue + "] 在手牌数组中没有找到!");
				mahjongValue = 0;
			}
			
			return mahjongValue;
			
		}else{
			String type = player.getPlayerType() == 1 ? "在线" : "离线" ;
			log.info("[" + type + "]不该 " + player.getPlayerName() + " 打牌，但是他这里执行了出牌消息!");
			return 0;
		}
	}

	public int peng(Player devil) {
		int t = 0;
		int len = devil.getOutarr().size() - 1;
		int value = devil.getOutarr().get(len);
		
		for (int i = 0; i < player.getSparr().size(); i++) {
			if (player.getSparr().get(i) == value) {
				t++;

				player.getPparr().add(player.getSparr().get(i));
				player.getSparr().remove(i);
				i --;
				
				// 本身可以杠只选择了杠
				if (t == 2) {
					break;
				}

			}
		}

		player.getPparr().add(value);
		devil.getOutarr().remove(len);
		
		// 2011-08-12 16:38 g
		//如果可以碰，又可以胡，如果玩家执行了碰的操作，就存一个放牛的翻数，则未过手前不能再胡
		if(HuPai.checkHu(player.getSparr())){
			player.setFangTuiDa(true);
			String[] strr = HuPai.getHuResult(player.getSparr(), player.getPparr(), player.getGparr());
			player.setLastFangFanNum(Integer.valueOf(strr[1]));
		}
		
		return 0;
	}

	public boolean gang(Player devil) {
		int len = devil.getOutarr().size() - 1;
		int value = devil.getOutarr().get(len);
		for (int i = 0; i < player.getSparr().size(); i++) {
			if (player.getSparr().get(i) == value) {
				player.getGparr().add(player.getSparr().get(i));
				player.getSparr().remove(i);
				i --;
			}
		}

		player.getGparr().add(value);
		devil.getOutarr().remove(len);
		return true;
	}
	
	public boolean gang() {
		
		int valueNum = 0;
		
		for (int i = 0; i < player.getPparr().size(); i++) {
			if(player.getPparr().get(i) == player.getZigangValue()){
				valueNum ++;
			}
		}
		
		if(valueNum == 3){
			for (int i = 0; i < player.getPparr().size(); i++) {
				if(player.getPparr().get(i) == player.getZigangValue()){
					player.getGparr().add(player.getPparr().get(i));
					player.getPparr().remove(i);
					i --;
				}
			}
			for (int i = 0; i < player.getSparr().size(); i++) {
				if(player.getSparr().get(i) == player.getZigangValue()){
					player.getGparr().add(player.getSparr().get(i));
					player.getSparr().remove(i);
					break;
				}
			}
		}else{
			valueNum = 0;
			for (int i = 0; i < player.getSparr().size(); i++) {
				if(player.getSparr().get(i) == player.getZigangValue()){
					valueNum ++;
				}
			}
			if(valueNum == 4){
				for (int i = 0; i < player.getSparr().size(); i++) {
					if(player.getSparr().get(i) == player.getZigangValue()){
						player.getGparr().add(player.getSparr().get(i));
						player.getSparr().remove(i);
						i --;
					}
				}
			}
		}
		
		return true;
	}

	public boolean hu(PlayerService devil, boolean isZihu) {
		if(!isZihu){			
			int len = devil.getPlayer().getOutarr().size() - 1;
			if(len > -1){
				int value = devil.getPlayer().getOutarr().get(len);
				if(value == devil.getNowOperationMahjongValue()){
					devil.getPlayer().getOutarr().remove(len);
				}
			}
			player.setHuMahjongValue(devil.getNowOperationMahjongValue());
		}else{
			for (int i = 0; i < player.getSparr().size(); i++) {
				if(player.getSparr().get(i) == player.getLastValue()){
					player.getSparr().remove(i);
					break;
				}
			}
			player.setHuMahjongValue(player.getLastValue());
		}
		player.setIshu(true);
		return true;
	}
	/**
	 * 弯杠之后删除手上的牌
	 * @param mahjongValue
	 */
	private void wangangDeleteSparr(int mahjongValue){
		
		for (int i = 0; i < player.getSparr().size(); i++) {
			if(player.getSparr().get(i) == mahjongValue){
				player.getSparr().remove(i);
				break;
			}
		}
		
	}
	//-----------------------------------------------------------------------
	
	
	public void update(Observable o, Object arg) {
		observePlayerService = (PlayerService) arg;
		
		player.getCouldOperationNames().clear();
		
		if(observePlayerService.getPlayer().getNeedOperationName1().equals("getOneMahjong")){
			ArrayList<Object> list = new ArrayList<Object>(); 
			list.add(observePlayerService.getPlayer().getAzimuth());			//只给自己保存摸牌值
			// 发送当前剩余牌的个数
			list.add(roomService.getRoom().getMahjongList().size());
			if(observePlayerService.getPlayer().getAzimuth() == player.getAzimuth()){
				list.add(observePlayerService.getNowOperationMahjongValue());	
				cumulativeOperationNum(observePlayerService.player);
			}else{
				lastGang = false;
				isDiangang = false;
			}
			sendMessage("getOneMahjongI", list);
			
			qiangGangAzimuth = 0;				//把抢杠方位归零
			
			if(player.getDingzhangValue() > -1){
				calOperationName(observePlayerService.getPlayer().getAzimuth(), observePlayerService.getNowOperationMahjongValue(), 1);
			}
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("putOneMahjong")){
			Util.sort(this.player.getSparr());
			if(observePlayerService.getPlayer().getAzimuth() != player.getAzimuth()){
				lastGang = false;
				isDiangang = false;
			}else{
				cumulativeOperationNum(observePlayerService.player);
			}
			operationPutOneMahjong();
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("peng")){
			cumulativeOperationNum(observePlayerService.player);
			
			if(observePlayerService.getPlayer().getPlayerType() == 1){
				operationPeng();
			}else{
				setTimerOperation(2, "peng");
			}
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("gang")){
			cumulativeOperationNum(observePlayerService.player);
			gangSettlement(1);
			
			if(observePlayerService.getPlayer().getPlayerType() == 1){
				operationGang();
			}else{
				setTimerOperation(2, "gang");
			}
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("zigang")){
			cumulativeOperationNum(observePlayerService.player);
			gangSettlement(2);
			if(observePlayerService.getPlayer().getPlayerType() == 1){
				operationZigang();
			}else{
				setTimerOperation(2, "zigang");
			}
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("wangang")){
			//gangSettlement(3);不在这里添加记录的原因，弯杠的同时有可能被别人抢杠，那么这里添加的记录就是多余，修改到确认是弯杠的地方才添加记录
			cumulativeOperationNum(observePlayerService.player);
			operationWangang();
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("hu")){
			operationHu();
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("zihu")){
			operationZihu();
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("gameOver")){
			sendRestartGame(false);			//玩家在进入游戏登录时，游戏结束，先发送重连消息，然后再发送游戏结束消息
			addArrayListData("gameOverI", roomService.gameOverData());
//			// V2.0 添加清空数据方法 2011-9-30 10:22
//			clearAllData();
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("showDingzhang")){
			if(player.getAzimuth() != 3){
				ArrayList<Object> list = new ArrayList<Object>(); 
				list.add(player.getAzimuth());
				list.add(getNowOperationMahjongValue());
				roomService.addHistoryMessage("showDingzhangI", list);			//添加历史记录
				
				if(player.getPlayerType() == 1){
//					sendRestartGame(false);
					addArrayListData("showDingzhangI", observePlayerService);
				}else if(player.getPlayerType() > 1){		//如果是机器人， 就直接执行定章
					int random = (int)(Math.random() * 3);
					setTimerOperation(random, "dingzhangAndroid");
				}
			}
			
		}else if(observePlayerService.getPlayer().getNeedOperationName1().equals("dingzhang")){
			addArrayListData("dingzhangI", observePlayerService);
		}
		
	}
	/**
	 * 打牌操作方法
	 */
	private void operationPutOneMahjong(){
		if(observePlayerService.getNowOperationMahjongValue() > 0){
			if(observePlayerService.getPlayer().getDingzhangFanpai() == 1){
				addArrayListData("putOneMahjongI", observePlayerService, 1);
			}else{
				addArrayListData("putOneMahjongI", observePlayerService, 0);
			}
		}else{
			log.info(observePlayerService.getPlayer().getPlayerName() + " 打的一张牌值为0!");
		}
		calOperationName(observePlayerService.getPlayer().getAzimuth(), observePlayerService.getNowOperationMahjongValue(), 0);
	}
	/**
	 * 碰牌操作方法
	 */
	private void operationPeng(){
		addArrayListData("pengI", observePlayerService);
		
		calOperationName(observePlayerService.getPlayer().getAzimuth(), observePlayerService.getNowOperationMahjongValue(), 2);
	}
	/**
	 * 点杠操作方法
	 */
	private void operationGang(){
		addArrayListData("gangI", observePlayerService, 0);
		
		calOperationName(observePlayerService.getPlayer().getAzimuth(), observePlayerService.getNowOperationMahjongValue(), 2);
	}
	/**
	 * 自杠操作方法
	 */
	private void operationZigang(){
		addArrayListData("gangI", observePlayerService, 1);
		
		calOperationName(observePlayerService.getPlayer().getAzimuth(), observePlayerService.getNowOperationMahjongValue(), 2);
	}
	/**
	 * 弯杠操作方法
	 */
	private void operationWangang(){
		addArrayListData("gangI", observePlayerService, 1);
		//这里出现弯杠，但是有一定的机率出现强杠，暂时把弯杠的值保存下来
		qiangGangAzimuth = observePlayerService.getPlayer().getAzimuth();
		
		calOperationName(observePlayerService.getPlayer().getAzimuth(), observePlayerService.getNowOperationMahjongValue(), 0);
	}
	/**
	 * 点胡操作方法
	 */
	private void operationHu(){
		int type = 0;
		
		if(qiangGangAzimuth > 0){		//如果抢杠方位大于0了，表示弯杠方位
			type = 2;
			wangangDeleteSparr(observePlayerService.getNowOperationMahjongValue());
			isWangang = false;
		}
		
		huSettlement(type);
		if(observePlayerService.getLastGang() && type == 0){
			// 如果胡牌的玩家有两个， 并且是最后一下胡牌，就修改lastGang属性
			if(observePlayerService.huNum > 1 && 
					observePlayerService.huNum == observePlayerService.getPlayer().getHuCount()){
				roomService.getRoom().getLastPlayerService().setLastGang(false);
			}else if(observePlayerService.huNum < 2){
				roomService.getRoom().getLastPlayerService().setLastGang(false);
			}
			addArrayListData("huI", observePlayerService, type, observePlayerService.getPlayer().getHuCount(), qiangGangAzimuth, 1);
		}else{
			addArrayListData("huI", observePlayerService, type, observePlayerService.getPlayer().getHuCount(), qiangGangAzimuth, 0);
		}
		if(observePlayerService.getPlayer().getAzimuth() != player.getAzimuth()){
			
			// 如果胡牌的玩家有两个， 并且是最后一下胡牌，就修改lastGang属性
			if(observePlayerService.huNum > 1 && 
					observePlayerService.huNum == observePlayerService.getPlayer().getHuCount()){
				lastGang = false;
			}else if(observePlayerService.huNum < 2){
				lastGang = false;
			}
			isDiangang = false;
		}else{
			player.setDianhuAzimuth(roomService.getRoom().getLastPlayerService().getPlayer().getAzimuth());
		}
		qiangGangAzimuth = 0;
	}
	/**
	 * 自胡操作方法
	 */
	private void operationZihu(){
		huSettlement(1);
		if(observePlayerService.getLastGang()){			//杠上花
			addArrayListData("huI", observePlayerService, 1, 0, 0, 1);
		}else{
			addArrayListData("huI", observePlayerService, 1, 0, 0, 0);
		}
	}
	/**
	 * 累加操作次数
	 */
	private void cumulativeOperationNum(Player playerObj){
		if(playerObj.getAzimuth() == player.getAzimuth()){
			player.setOperationMahjongNum(player.getOperationMahjongNum() + 1);
		}
	}
	/**
	 * 设置时钟的操作
	 * @param operationTimeNum
	 * @param operationName
	 */
	private void setTimerOperation(int operationTimeNum, String operationName){
		logicSwitch = true;
		timeNum = 0;
		this.operationName = operationName;
		this.operationTimeNum = operationTimeNum;
	}
	/**
	 * 杠牌结算
	 * @param gangType 杠牌类型 (1： 点杠  2：自杠  3： 弯杠)
	 */
	public void gangSettlement(int gangType){
		if(observePlayerService.getPlayer().getAzimuth() == player.getAzimuth()){
			if(gangType == 1){
				int lastPlayerAzimuth = roomService.getRoom().getLastPlayerService().getPlayer().getAzimuth();
				roomService.getRoom().getBalanceService().balanceGang(lastPlayerAzimuth, player.getAzimuth(), 
												roomService.getRoom().getPlayerServices(), false);
			}else if(gangType == 2){
				roomService.getRoom().getBalanceService().balanceGang(player.getAzimuth(), player.getAzimuth(), 
						roomService.getRoom().getPlayerServices(), false);
			}else if(gangType == 3){
				roomService.getRoom().getBalanceService().balanceGang(player.getAzimuth(), player.getAzimuth(), 
						roomService.getRoom().getPlayerServices(), true);
			}
		}
		
	}
	/**
	 * 胡牌结算
	 * @param huType		胡牌类型(0 : 点胡 1： 自胡  2： 抢杠)
	 */
	private void huSettlement(int huType){
		
		//操作是本方位
		if(observePlayerService.getPlayer().getAzimuth() == player.getAzimuth()){
			
			ArrayList<Integer> newSparr = new ArrayList<Integer>(player.getSparr());
			newSparr.add(player.getHuMahjongValue());
			Util.sort(newSparr);
			String[] huResults = HuPai.getHuResult(newSparr, new ArrayList<Integer>(player.getPparr()), 
													new ArrayList<Integer>(player.getGparr()));
			
			boolean haveGangHua = false;
			boolean haveGangPao = false;
			
			
			int lastPlayerAzimuth = 0;
			if(huType == 1){
				lastPlayerAzimuth = player.getAzimuth();
			}else{
				lastPlayerAzimuth = roomService.getRoom().getLastPlayerService().getPlayer().getAzimuth();
			}
			
			if(observePlayerService.getLastGang()){
				if(huType == 0){
					haveGangPao = true;
					gangPaoMove(player.getAzimuth(), lastPlayerAzimuth);
					huResults[1] = Integer.valueOf(huResults[1]) * 2 + "";
				}else if(huType == 1){
					haveGangHua = true;
					if(isDiangang){
						lastPlayerAzimuth = roomService.getRoom().getLastPlayerService().getPlayer().getAzimuth();
					}
					huResults[1] = Integer.valueOf(huResults[1]) * 2 + "";
				}
			}
			if(huType == 2){
				huResults[1] = Integer.valueOf(huResults[1]) * 2 + "";
			}
			if(huType == 1 && player.getAzimuth() == 3 && player.getOperationMahjongNum() == 1){
				huResults[0] += "\n天胡  ";
				huResults[1] = Integer.valueOf(huResults[1]) * 16 + "";
			}else if(huType == 1 && player.getAzimuth() != 3 && player.getOperationMahjongNum() == 1){
				huResults[0] += "\n地胡  ";
				huResults[1] = Integer.valueOf(huResults[1]) * 4 + "";
			}else if((huType == 0 || huType == 2) && player.getAzimuth() != 3 && player.getOperationMahjongNum() == 0){
				huResults[0] += "\n地胡  ";
				huResults[1] = Integer.valueOf(huResults[1]) * 4 + "";
			}
			
			roomService.getRoom().getBalanceService().balanceHu(lastPlayerAzimuth, player.getAzimuth(), 
					huResults[0], Integer.valueOf(huResults[1]), roomService.getRoom().getPlayerServices(), 
									haveGangHua, haveGangPao);
		}
		
	}
	/**
	 * 如果是杠上炮，就把杠牌转移给胡牌用户
	 * @param huAzimuth				胡牌用户
	 * @param dianhuAzimuth			杠上炮用户
	 */
	private void gangPaoMove(int huAzimuth, int dianhuAzimuth){
		List<Balance> balances = roomService.getRoom().getBalanceService().balanceList;
		for (int i = balances.size() - 1; i >= 0 ; i--) {
			if(balances.get(i).playerAzimuth == dianhuAzimuth){ 
				
				if(balances.get(i).balanceName.equals("下雨")){
					Balance balacne = roomService.getRoom().getBalanceService().balanceMove(dianhuAzimuth, huAzimuth);
					if(huNum > 1){
						balacne.azimuth1 = Util.insance.fixed(balacne.azimuth1 / huNum);
						balacne.azimuth2 = Util.insance.fixed(balacne.azimuth2 / huNum);
						balacne.azimuth3 = Util.insance.fixed(balacne.azimuth3 / huNum);
						balacne.azimuth4 = Util.insance.fixed(balacne.azimuth4 / huNum);
					}
				}else if(balances.get(i).balanceName.equals("刮风")){
					if(balances.get(i).haveWanGang){
						Balance balacne = roomService.getRoom().getBalanceService().balanceMove(dianhuAzimuth, huAzimuth);
						if(huNum > 1){
							balacne.azimuth1 = Util.insance.fixed(balacne.azimuth1 / huNum);
							balacne.azimuth2 = Util.insance.fixed(balacne.azimuth2 / huNum);
							balacne.azimuth3 = Util.insance.fixed(balacne.azimuth3 / huNum);
							balacne.azimuth4 = Util.insance.fixed(balacne.azimuth4 / huNum);
						}
						
					}else{
						Balance balacne = roomService.getRoom().getBalanceService().balanceMove(dianhuAzimuth, huAzimuth);
						if(huNum > 1){
							balacne.azimuth1 = Util.insance.fixed(balacne.azimuth1 / huNum);
							balacne.azimuth2 = Util.insance.fixed(balacne.azimuth2 / huNum);
							balacne.azimuth3 = Util.insance.fixed(balacne.azimuth3 / huNum);
							balacne.azimuth4 = Util.insance.fixed(balacne.azimuth4 / huNum);
						}
					}
				}
				break;	
			}
		}
		
	}
	/**
	 * 发送消息
	 * @param head
	 * @param content
	 */
	private void sendMessage(String head, Object content){
		if(!player.isReconnection()){
			message.setHead(head);
			message.setContent(content);
			messageService.send(player.getIServer(), message);
		}
		
		if(!head.equals("beginGameI") && !head.equals("showOperationI") && !head.equals("restartGameI")){
			if(head.equals("putOneMahjongI")){
				roomService.addHistoryMessage(head, content, roomService.getRoom().isHistoryPut());
			}else if(observePlayerService.getPlayer().getAzimuth() == player.getAzimuth()){
				roomService.addHistoryMessage(head, content);
			}
		}
		// V2.3 消息发送到前台之后就启动计时器，一直到前台返回信息再停止计时器 2011-11-14 14:00
		if(player.getPlayerType() == 1){			
			if((head.equals("getOneMahjongI") && (observePlayerService.player.getAzimuth() == player.getAzimuth())) 
					|| head.equals("showOperationI") || head.equals("showDingzhangI")){
				setIsExecutePlayerTimerOut(true);
			}
		}
	}
	/**
	 * 发送服务器异常到客户端
	 * @param content
	 */
	public void sendServerExceptionMessage(Object content){
		message.setHead("serverExcpetion");
		message.setContent(content);
		messageService.send(player.getIServer(), message);
	}
	/**
	 * 发送离线等待消息到客户端
	 * @param content
	 */
	public void sendOfflineWait(Object content){
		message.setHead("offlineWait");
		message.setContent(content);
		messageService.send(player.getIServer(), message);
	}
	/**
	 * 发送的数据结合
	 * @param head
	 * @param playerService
	 */
	public void addArrayListData(String head, PlayerService playerService){
		ArrayList<Object> list = new ArrayList<Object>(); 
		list.add(playerService.getPlayer().getAzimuth());
		list.add(playerService.getNowOperationMahjongValue());
		sendMessage(head, list);
	}
	/**
	 * 发送的数据结合
	 * @param head
	 * @param playerService
	 * @param type
	 */
	private void addArrayListData(String head, PlayerService playerService, int type){
		ArrayList<Object> list = new ArrayList<Object>(); 
		list.add(playerService.getPlayer().getAzimuth());
		list.add(playerService.getNowOperationMahjongValue());
		list.add(type);
		sendMessage(head, list);
	}
	/**
	 * 发送的数据组合
	 * @param head
	 * @param playerService
	 * @param object			
	 */
	private void addArrayListData(String head, ArrayList<Object> overArr){
		ArrayList<Object> list = new ArrayList<Object>(); 
		list.add(overArr);
		sendMessage(head, list);
	}
	/**
	 * 发送的数据结合
	 * @param head
	 * @param playerService
	 * @param type					胡牌的类型			(0：点胡,1：自摸,2： 抢杠)
	 * @param huCount					同时多家胡牌的顺序编号
	 * @param qiangGangAzimuth					抢杠的方位
	 * @param isGanghuaOrGangpao				//是否是杠上花或者杠上炮
	 */
	private void addArrayListData(String head, PlayerService playerService, int type, int huCount, int qiangGangAzimuth, int isGanghuaOrGangpao){
		ArrayList<Object> list = new ArrayList<Object>(); 
		list.add(playerService.getPlayer().getAzimuth());
		list.add(playerService.getNowOperationMahjongValue());
		list.add(type);
		list.add(huCount);
		list.add(qiangGangAzimuth);
		list.add(isGanghuaOrGangpao);
		sendMessage(head, list);
	}
	/**
	 * 清除所有数据
	 */
	public void clearAllData(){
		player.clearAllData();
		isWangang = false;
		qiangGangAzimuth = 0;
		lastGang = false;
		isDiangang = false;
		operationTimeNum = 0;
		logicSwitch = false;
		operationName = "";
		action.setRoom(null);
		nowOperationMahjongValue = 0;
		observePlayerService = null;
		roomService = null;
	}
}
