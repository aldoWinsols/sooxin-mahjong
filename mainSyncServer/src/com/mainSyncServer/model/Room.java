package com.mainSyncServer.model;

public class Room {
	public String roomNum = "";
	public int onlineNum = 0;
	public int initNum = 0;
	
	public Room(String roomNum,int onlineNum){
		this.roomNum = roomNum;
		this.onlineNum = onlineNum+initNum;
	}

}
