package com.service
{
	public final class PlayerService
	{
		[Bindable]
		public var playerName:String = "";
		private var _haveMoney:Number = 0;
		private static var _instance:PlayerService = null;
		
		public function PlayerService(){}
		
		[Bindable]
		public function get haveMoney():Number
		{
			return _haveMoney;
		}

		public function set haveMoney(value:Number):void
		{
			_haveMoney = value;
		}

		public static function get instance():PlayerService{
			if(_instance == null){
				_instance = new PlayerService();
			}
			return _instance;
		}
	}
}