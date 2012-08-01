package com.stock.services
{
	import com.stock.model.Player;

	public class PlayerService
	{
		public static var instance:PlayerService;
		public var player:Player;
		public function PlayerService()
		{
			player = new Player();
			player.playerName = "sooxin";
		}
		
		public static function getInstance():PlayerService{
			if(instance == null){
				instance = new PlayerService();
			}
			return instance;
		}
	}
}