package com.hundredHappySyncServer.model
{
	import com.hundredHappySyncServer.services.PlayerService;
	import com.hundredHappySyncServer.services.RoomService;

	public class GameHall
	{
		public var playerServices:Vector.<PlayerService> = null;
		public var roomServices:Vector.<RoomService> = null;
		
		public var timerNum:Number = 0;
		
		public function GameHall()
		{
			playerServices = new Vector.<PlayerService>();
			roomServices = new Vector.<RoomService>();
		}
	}
}