package com.stock.model
{
	[Bindable]
	[RemoteClass(alias="com.stock.dao.Player")]
	public class Player
	{

		public var playerName:String = "";
		public var zhichan:Number = 0;//资产
		public var haveMoney:Number= 0;
		public var clockMoney:Number= 0;
		public var useMoney:Number= 0;

		public function Player()
		{
		}
	}
}