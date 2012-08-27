package com.mainSyncServer;

import java.util.Iterator;
import java.util.Map;

import org.red5.logging.Red5LoggerFactory;
import org.red5.server.adapter.ApplicationAdapter;
import org.red5.server.api.IConnection;
import org.red5.server.api.IScope;
import org.red5.server.api.service.IServiceCapableConnection;
import org.slf4j.Logger;

import com.mainSyncServer.model.Message;
import com.mainSyncServer.service.ConfigService;
import com.mainSyncServer.service.JobService;
import com.mainSyncServer.service.MainService;
import com.mainSyncServer.service.MessageService;
import com.mainSyncServer.util.ReadConfig;

public class Application extends ApplicationAdapter {

	private MainService mainService;
	private Logger log = Red5LoggerFactory
	.getLogger(Application.class, "mainSyncServer"); 
	
	private ReadConfig readConfig = null;
	
	@Override
	public boolean appConnect(IConnection conn, Object[] params) {
		// TODO Auto-generated method stub 
		
		String name = (String) params[0];
		
		log.info(name +"登录服务器了");
		if(name.equals("superAdmin") && conn.getRemoteAddress().equals("127.0.0.1")){
			return true;
		}
		
//		if(!checkConn(conn)){
//			log.info(name +" 玩家连接的域名有异常");
//			return false;
//		}
		
		if(name.equals("superAdmin")){
			return true;
		}

		mainService.connection(name, (IServiceCapableConnection)conn);
		initRoomNum();
		
		return true;
	}

	@Override
	public void appDisconnect(IConnection conn) {
		mainService.exitServer((IServiceCapableConnection)conn);
		// TODO Auto-generated method stub
		
	}

	@Override
	public synchronized boolean start(IScope scope) {
		// TODO Auto-generated method stub
		ConfigService.getInstance();
		mainService = MainService.getInstance();
		MessageService.getInstance();
		readConfig = new ReadConfig();
		log.info("服务器启动了");
		
		String id = addScheduledJob(10000, new JobService());
		scope.setAttribute("Myjob", id);
		
		return super.start(scope);
	}

	public boolean checkConn(IConnection conn) {
		Map<String, Object> map = conn.getConnectParams();
		if (map.get("swfUrl") != null) {
			for (int i = 0; i < readConfig.serverArr.size(); i++) {
				if(readConfig.serverArr.get(i).equals("*")){
					return true;
				}
				if (map.get("swfUrl").toString().toLowerCase().contains(
						readConfig.serverArr.get(i))) {
					return true;
				}
			}

		}
		return false;
	}
	
	@Override
	public synchronized void stop(IScope scope) {
		// TODO Auto-generated method stub
		String id = (String) scope.getAttribute("Myjob");
		removeScheduledJob(id);
		
		super.stop(scope);
	}
	
	/**
	 * 广播消息
	 * @param managerName
	 * @param content
	 */
	public void managerSendAllPlayer(String managerName, String content){
		Message message = new Message();
		message.setHead("managerAllPlayerI");
		message.setContent(content);
		mainService.sendAllPlayer(message);
	}
	/**
	 * 
	 * @param roomType
	 * @param roomNum
	 */
	public void sendRoomNum(String roomType, int roomNum){
		int initNum = 0;
		for(int i=0; i<mainService.roomNums.size(); i++){
			if(mainService.roomNums.get(i).roomNum.equals(roomType)){
				initNum = mainService.roomNums.get(i).initNum;
				mainService.roomNums.get(i).onlineNum = initNum+roomNum;
			}
		}
		mainService.sendRoomNum(roomType, initNum+roomNum);
		log.info("当前房间：" + roomType + "  当前人数： " + roomNum);
	}
	
	public void initRoomNum(){
		for(int i=0; i<mainService.roomNums.size(); i++){
			 mainService.sendRoomNum(mainService.roomNums.get(i).roomNum, mainService.roomNums.get(i).onlineNum);
		}
	}
	
	public boolean updateRoomNum(String roomType, int initNum){
		for(int i=0; i<mainService.roomNums.size(); i++){
			if(mainService.roomNums.get(i).roomNum.equals(roomType)){
				mainService.roomNums.get(i).initNum = initNum;
				mainService.sendRoomNum(roomType, initNum+mainService.roomNums.get(i).onlineNum);
				System.out.println(roomType+""+(initNum+mainService.roomNums.get(i).onlineNum));
				return true;
			}
		}
		return true;
	}
	
	/**
	 * 开始维护
	 * @param num
	 * @param content
	 */
	public boolean startWeiHu(int num, String content){
		mainService.startWeihu(num, content);
		return true;
	}
	/**
	 * 获取网络质量
	 * @return
	 */
	public boolean getConnState(){
		return true;
	}
	
}
