package com.stockSyncServer.services;

import java.util.ArrayList;

import org.red5.server.net.remoting.IRemotingCallback;
import org.red5.server.net.remoting.RemotingClient;

import com.stockSyncServer.model.Cjhistory;
import com.stockSyncServer.model.Order;

public class LeafService{
	public boolean handclasp = false;//握手状态
	public RemotingClient client;
	public String serverUrl;
	public LeafService(String serverUrl){
		this.serverUrl = serverUrl;
		client = new RemotingClient(serverUrl);
	}
	
	public void initLeaf(Object[] obj){
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("initLeaf", obj,callBack);
	}
	
	public void updateStock(ArrayList<Order> buyOrders,ArrayList<Order> saleOrders){
		
	}
	
	public void updateJiaoyi(Object[] obj){
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("updateJiaoyi", obj,callBack);
	}
	
	public void updateFenshi(Object[] obj){
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("updateFenshi", obj,callBack);
	}
	
	public void broadcastMline(Object[] obj){
		IRemotingCallback callBack = new callBackHandler();
		client.invokeMethod("broadcastMline", obj,callBack);
	}
	
	public void update(){
		if(client != null){
			IRemotingCallback callBack = new callBackHandler();
			client.invokeMethod("update", null,callBack);
		}
		
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
