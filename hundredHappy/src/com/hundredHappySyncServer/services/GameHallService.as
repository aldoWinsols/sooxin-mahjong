package com.hundredHappySyncServer.services
{
	import com.hundredHappySyncServer.model.GameHall;

	public class GameHallService
	{
		public var gameHall:GameHall = null;
		public function GameHallService()
		{
			gameHall = new GameHall();
		}
	}
}