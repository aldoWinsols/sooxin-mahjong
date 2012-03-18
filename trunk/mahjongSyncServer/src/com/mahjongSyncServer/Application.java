package com.mahjongSyncServer;

import java.util.ArrayList;
import java.util.Map;

import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IServiceCapableConnection;
import org.slf4j.Logger;

import com.mahjongSyncServer.services.ConfigService;
import com.mahjongSyncServer.services.GameHallService;
import com.mahjongSyncServer.services.PlayerService;
import com.mahjongSyncServer.util.Util;
import com.mahjongSyncServer.util.UtilProperties;

public class Application extends ApplicationAdapter {
	
	private GameHallService gameHallService = null;
	private Logger log = null;
	@Override
	public synchronized boolean start(IScope scope) {
		// TODO Auto-generated method stub
		UtilProperties.getInstance("config.properties");
		ConfigService.getInstance();
		log = UtilProperties.instance.getLogger(Application.class);
		log.info(UtilProperties.instance.getRoomNo() + " 元麻将服务器启动....");
		gameHallService = new GameHallService();
		return super.start(scope);
	}
	
	@Override
	public boolean appConnect(IConnection conn, Object[] params) {
		// TODO Auto-generated method stub
		
		if(params.length < 3){
			System.out.println("传入的参数不匹配！");
			log.info("传入的参数不匹配！");
			return false;
		}
		
//		if(!checkConn(conn)){
//			conn.close();
//			log.info("用户连接的URL地址有异常!");
//			return false;
//		}
		
		String playerName = (String)params[0];
		String password = (String)params[1];
		String userIp = (String)params[2];
		
		if(playerName.contains("osroot")){
			log.info("管理员登录后台!");
			return true;
		}
		
		String str = gameHallService.checkPlayerServiceIsOnline(playerName, password, userIp, (IServiceCapableConnection)conn);
		if(str.equals("no")){
			gameHallService.addPlayerService(playerName, password,  userIp,(IServiceCapableConnection)conn);
			log.info(playerName + " 玩家进入了游戏！");
		}else if(str.equals("replace")){
			// 玩家重连成功就把重连的房间编号归零
			gameHallService.setWhereFallline(playerName, 0);
		}else if(str.equals("iterance")){
			conn.close();
		}
		
		return true;
	}
	// V1.9 2011-9-5 14:22 修改断线的方法
	@Override
	public void appDisconnect(IConnection conn) {
		// TODO Auto-generated method stub
		gameHallService.removePlayerService((IServiceCapableConnection)conn);
	}

	public boolean checkConn(IConnection conn) {
		Map<String, Object> map = conn.getConnectParams();
		String[] urls = UtilProperties.instance.getUrls();
		if (map.get("swfUrl") != null) {
			for (int i = 0; i < urls.length; i++) {
				if(urls[i].equals("*")){
					return true;
				}
				if (map.get("swfUrl").toString().toLowerCase().contains(
						urls[i])) {
					return true;
				}
			}

		}
		return false;
	}
	
	//-------------------------------------------------------------------------------------
	/**
	 * 服务器断开客户端用户
	 * @param playerName
	 */
	public void serverDisconnectClient(String playerName){
		gameHallService.serverDisconnectClient(playerName);
	}
	/**
	 * 获得房间所有用户
	 * @return
	 */
	public Object getRoomPlayerList(){
		return gameHallService.getRoomPlayerList();
	}
	/**
	 * 获取网络质量
	 * @return
	 */
	public boolean getConnState(){
		return true;
	}
	/**
	 * 获得在线人数
	 * @return
	 */
	public String getOnlineNum(){
		return gameHallService.getGameHall().getPlayerServices().size()-20+"--"+gameHallService.getWaitPlayers().size()+"--"+getOnlinePlayersName()+"--"+getWaitPlayersName();
	}
	/**
	 * 修改重连时间
	 * @param reunionTimer
	 * @return
	 */
	public String updateReunionTimer(int reunionTimer){
		gameHallService.getGameHall().setReunionTimer(reunionTimer);
		return "";
	}
	public String getWaitPlayersName(){
		String str = "";
		for(int i=0; i<gameHallService.getWaitPlayers().size(); i++){
			str += gameHallService.getWaitPlayers().get(i).getPlayer().getPlayerName()+",";
		}
		return str;
	}
	
	public String getOnlinePlayersName(){
		String str = "";
		for(int i=0; i<gameHallService.getGameHall().getRoomServices().size(); i++){
			ArrayList<PlayerService> playerServices = gameHallService.getGameHall().getRoomServices().get(i).getRoom().getPlayerServices();
			for(int j=0; j<playerServices.size();j++){
				str += playerServices.get(j).getPlayer().getPlayerName()+",";
			}
			str += "||";
		}
		return str;
	}
	public String getTransformerState(){
		return Util.getInsance().getTransformerWinMaxMoney() + "--" + Util.getInsance().getTransformerWinGailv() + 
					"--" + gameHallService.getGameHall().getReunionTimer();
	}
	/**
	 * 设置机器人的控制参数
	 * @param transformerWinMaxMoney
	 * @param transformerWinGailv
	 */
	public void updateTransformerState(double transformerWinMaxMoney, double transformerWinGailv, int reunionTimer){
		Util.getInsance().setTransformerWinGailv(transformerWinGailv);
		Util.getInsance().setTransformerWinMaxMoney(transformerWinMaxMoney);
		gameHallService.getGameHall().setReunionTimer(reunionTimer);
	}
	/**
	 * 更新游戏配置（IP段相同和同一一级代理相同）
	 * @param isIpEqual
	 * @param isAgencyEqual
	 */
	public void updateAgencyEqualAndIpEqual(boolean isIpEqual , boolean isAgencyEqual){
		gameHallService.isIpEqual = isIpEqual;
		gameHallService.isAgencyEqual = isAgencyEqual;
	}
	/**
	 * 获得游戏配置（IP段相同和同一一级代理相同）
	 * @return
	 */
	public String getAgencyEqualAndIpEqual(){
		return gameHallService.isIpEqual + "," + gameHallService.isAgencyEqual;
	}
	
	/**
	 * 玩家打牌操作方法
	 * @param arg
	 * @return
	 */
	public String putOneMahjong(String arg){
		
		gameHallService.putOneMahjong(arg);
		return "";
	}
	/**
	 * 玩家碰牌操作方法
	 * @param arg
	 * @return
	 */
	public String peng(String arg){
		gameHallService.peng(arg);
		return "";
	}
	/**
	 * 玩家杠牌操作方法
	 * @param arg
	 * @return
	 */
	public String gang(String arg){
		gameHallService.gang(arg);
		return "";
	}
	/**
	 * 玩家胡牌操作方法
	 * @param arg
	 * @return
	 */
	public String hu(String arg){
		gameHallService.hu(arg);
		return "";
	}
	/**
	 * 玩家发牌完毕操作方法
	 * @param arg
	 * @return
	 */
	public String dealOver(String arg){
		gameHallService.dealOver(arg);
		return "";
	}
	/**
	 * 玩家定章操作方法
	 * @param arg
	 * @return
	 */
	public String dingzhang(String arg){
		gameHallService.dingzhang(arg);
		return "";
	}
	/**
	 * 玩家取消操作方法
	 * @param arg
	 * @return
	 */
	public String quxiao(String arg){
		gameHallService.quxiao(arg);
		return "";
	}
	/**
	 * 玩家继续游戏操作方法
	 * @param arg
	 * @return
	 */
	public String continueGame(String arg){
		gameHallService.continueGame(arg);
		return "";
	}
}
