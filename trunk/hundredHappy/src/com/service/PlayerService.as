package com.service
{
	public final class PlayerService
	{
		[Bindable]
		public var playerName:String = "";
		[Bindable]
		public var haveMoney:Number = 0;
		private static var _instance:PlayerService = null;
		
		public function PlayerService(){}
		
		public static function get instance():PlayerService{
			if(_instance == null){
				_instance = new PlayerService();
			}
			return _instance;
		}
	}
}