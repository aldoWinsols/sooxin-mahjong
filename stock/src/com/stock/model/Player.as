package com.stock.model
{
	[Bindable]
	[RemoteClass(alias="com.stock.dao.Player")]
	public class Player
	{

		public var playerName:String = "";
		public var haveMoney:Number= 0;
		private var clockMoney:Number= 0;

		public function Player()
		{
		}
	}
}