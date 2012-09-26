package com.leafSyncServer.services;

import org.red5.server.net.remoting.IRemotingCallback;
import org.red5.server.net.remoting.RemotingClient;

public class RemoteService {

	public boolean handclasp = false;//握手状态
	
	String localUrl="http://127.0.0.1:5080/leafSyncServer/gateway";
	String url = "http://127.0.0.1:5080/stockSyncServer/gateway";
	RemotingClient client;
	public static RemoteService instance;

	public RemoteService() {
		client = new RemotingClient(url);
		remoteInitConn();
	}

	public static RemoteService getInstance() {
		if (instance == null) {
			instance = new RemoteService();
		}
		return instance;
	}

	public void remoteInitConn() {
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("addLeafService", new Object[]{localUrl},callBack);
	}
	
	public void buy(String stockCode, String playerName, double wtPrice, int wtNum) {
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("buy", new Object[]{stockCode,playerName,wtPrice,wtNum},callBack);
	}

	public void sale(String stockCode, String playerName, double wtPrice, int wtNum) {
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("sale", new Object[]{stockCode, playerName,wtPrice,wtNum},callBack);
	}
	
	public void cancel(String stockCode, String orderNum){
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("cancel", new Object[]{stockCode,orderNum},callBack);
	}
	
	public void sendRoomNum(){
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("sendRoomNum", null,callBack);
	}
}

//==============================================================================

class callBackHandler implements IRemotingCallback{

	@Override
	public void errorReceived(RemotingClient arg0, String arg1, Object[] arg2,
			Throwable arg3) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void resultReceived(RemotingClient arg0, String arg1, Object[] arg2,
			Object arg3) {
		// TODO Auto-generated method stub
		
	}
	
}
