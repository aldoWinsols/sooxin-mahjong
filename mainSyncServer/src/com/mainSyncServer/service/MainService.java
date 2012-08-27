package com.mainSyncServer.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Timer;

import org.red5.logging.Red5LoggerFactory;
import org.red5.server.api.service.IServiceCapableConnection;
import org.slf4j.Logger;

import com.mainSyncServer.model.Message;
import com.mainSyncServer.model.Room;
import com.mainSyncServer.util.TimerTaskServer;

/**
 * 
 * @author Administrator
 * 2012-1-30 10:57 gmr start 修改发送玩家IP的前后顺序
 */
public class MainService {

	private ArrayList<PlayerService> playerServices;
	private Timer timer = null;
	private TimerTaskServer timerTaskServer;
	private static MainService instance = null;
	private RemoteService remoteService = null;
	private Logger log = Red5LoggerFactory
	.getLogger(MainService.class, "mainSyncServer"); 
	public static ArrayList<Room> roomNums = null;

	public MainService(){
		
		try {
			playerServices = new ArrayList<PlayerService>();
			timer = new Timer();
			timerTaskServer = new TimerTaskServer(this);
			timer.schedule(timerTaskServer, 1, 1000); 
//			remoteService = new RemoteService();
			
			
			roomNums = new ArrayList<Room>();
			roomNums.add(new Room("10", 0));
			roomNums.add(new Room("20", 0));
			roomNums.add(new Room("50", 0));
			roomNums.add(new Room("100", 0));
			roomNums.add(new Room("200", 0));
			roomNums.add(new Room("500", 0));
			roomNums.add(new Room("1000", 0));
			
//			red5MainAppStart();
		} catch (Exception e) {
			// TODO: handle exception
			log.info("异常：", e);
		}
	} 
	public static MainService getInstance(){
		if(instance == null){
			instance = new MainService();
		}
		return instance;
	}
	/**
	 * 重置试玩账号的数据库属性
	 */
	private void red5MainAppStart(){
//		remoteService.getSystemService().red5MainAppStart();
	}

	public ArrayList<PlayerService> getPlayerServices() {
		return playerServices;
	}

	public void dealTimer(){
		for (int i = 0; i < playerServices.size(); i++) {
			if(!playerServices.get(i).getPlayer().getIserver().isConnected()){
				log.info("处理一个掉线用户： " + playerServices.get(i).getPlayer().getName());
				// V1.8 修改数据库字段
				playerServices.get(i).changeDemoAcctOnlineStatus(0);
				playerServices.remove(i);
				i --;
			}
		}
	}
	
	/**
	 * 用人连接进入
	 * @param name
	 */
	public void connection(String name, IServiceCapableConnection iserver){
		playerJoin(name, iserver);
	}
	/**
	 * 数据服务器断开用户
	 */
	public void dataServiceDisconnectPlayer(String playerName){
		PlayerService playerService = findPlayerServiceByName(playerName);
		
		if(playerService != null){
//			log.info("数据服务修改了 " + playerName + " 为锁定状态!");
//			boolean islock = remoteService.getUserService().islock(playerName);
//			if(islock){				
				playerService.sendDisConnect("管理员断开你的连接!");
				log.info("管理员断开了 " + playerName + " 的连接!");
				playerService.getPlayer().getIserver().close();
				exitServer(playerService.getPlayer().getIserver());
//			}else{
//				log.info(playerName + " 没有被锁定");
//			}
		}
	}
	/**
	 * 更新玩家金额
	 * @param playerName
	 * @param money
	 */
	public void updatePlayerMoney(String playerName, double money){
		PlayerService playerService = findPlayerServiceByName(playerName);
		if(playerService != null){
			playerService.sendUpdatePlayerMoney(money);
		}
	}
	
	/**
	 * 添加玩家
	 * @param name
	 * @param iserver
	 */
	private void playerJoin(String name, IServiceCapableConnection iserver) {
		if(findPlayerServiceByName(name) == null){	
			PlayerService playerService = new PlayerService();
			playerService.getPlayer().setName(name);
			playerService.getPlayer().setIserver(iserver);
			playerService.getPlayer().setIp(iserver.getRemoteAddress());
//			playerService.getPlayer().setChipGroupItems(remoteService.getUserService().getChipGroupItems(name));
			
//			playerService.loginPlayer(roomNums);
			
			// 2012-1-30 10:57 gmr end
			this.playerServices.add(playerService);
		}else{
			Message message = new Message();
			message.setHead("stopMessageI");
			message.setContent("已经有用户登录了！");
			MessageService.getInstance().send(iserver, message);
		}
		
	}
	public PlayerService findPlayerServiceByName(String name) {
		PlayerService ps = null;
		for (int i = 0; i < this.playerServices.size(); i++) { 
			if (this.playerServices.get(i).getPlayer().getName().equals(name)) {
				ps = this.playerServices.get(i);
				break;
			}
		}
		return ps;
	}
	
	public PlayerService removePlayerServiceByID(String id){
		PlayerService ps = null;
		for (int i = 0; i < this.playerServices.size(); i++) { 
			if (this.playerServices.get(i).getPlayer().getIserver().getClient().getId().equals(id)) {
				ps = this.playerServices.get(i);
				playerServices.remove(i);
				break;
			}
		}
		return ps;
	}
	/**
	 * 发送系统消息给所有用户
	 * @param message
	 */
	public void sendAllPlayer(Message message){
		for (int i = 0; i < playerServices.size(); i++) {
			playerServices.get(i).sendManagerMessage(message);
		}
	}
	/**
	 * 开始维护
	 * @param num
	 * @param content
	 */
	public void startWeihu(int num, String content){
		System.out.println("==" + content);
		Message message  = new Message();
		message.setHead("startWeihuI");
		message.setContent(num + "=" + content);
		for (int i = 0; i < playerServices.size(); i++) {
			playerServices.get(i).sendManagerMessage(message);
		}
	}

	/**
	 * 退出客服聊天
	 * @param iserver
	 */
	public void exitServer(IServiceCapableConnection iserver){
		PlayerService playerService = removePlayerServiceByID(iserver.getClient().getId());
		if(playerService != null){
			log.info(playerService.getPlayer().getName() +" 退出了服务器");
			// V1.8 修改数据库字段
			playerService.changeDemoAcctOnlineStatus(0);
		}
	}
	
	/**
	 * 发送麻将房间的人数
	 * @param roomType
	 * @param roomNum
	 */
	public void sendRoomNum(String roomType, int roomNum){
		for (int i = 0; i < playerServices.size(); i++) {
			playerServices.get(i).sendRoomNum(roomType, roomNum);
		}
	}
}
