package com.service
{
	public final class PlayerService
	{
		[Bindable]
		public var playerName:String = "";
		private var _haveMoney:Number = 0;
		public var betMoney:Number = 0;
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
		
		public function updateHaveMoney(changeMoney:Number):void{
			haveMoney += betMoney;
			haveMoney = haveMoney + changeMoney;
			if(haveMoney <= 1000){
				haveMoney += 10000;
				changeMoney += 10000;
			}
			DataService.instance.afterData(playerName, changeMoney);
			betMoney = 0;
		}
		
		public function updateNowMoney(changeMoney:Number):void{
			haveMoney = haveMoney + changeMoney;
		}
	}
}