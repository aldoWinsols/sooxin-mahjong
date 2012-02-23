package com.hundredHappySyncServer.model
{
	import com.hundredHappySyncServer.services.PlayerService;

	public class SubRoom
	{
		public var playerServices:Vector.<PlayerService> = null;
		public function SubRoom()
		{
			playerServices = new Vector.<PlayerService>();
		}
	}
}