package com.hundredHappySyncServer.model
{
	public class Player
	{
		public var playerName:String = null;							//玩家用户名
		public var haveMoney:Number = 0;								//玩家账户金额
		public var betMoney:Number = 0;									//下注总金额
		public var winOrlose:int = 0;								//当局的输赢结果   g 2011-5-24  11:40  
		public var zdT:int = 0;
		public var xdT:int = 0;
		public var zT:int = 0;
		public var xT:int = 0;
		public var hT:int = 0;
	
		public var playerType:int = 0;
		
		public static var ANDROID:int = 0;
		public static var ONLINE:int = 1;
		
		public var authz:int = 0;									//座位编号
		public var game:Boolean = false;
		public function Player()
		{
		}
	}
}