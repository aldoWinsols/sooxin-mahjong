package com.model
{
	[Bindable]
	[RemoteClass(alias="com.panda.dao.Duihuanlog")]
	public class Duihuanlog
	{
		public var id:Number;
		public var playerName:String;
		public var itemName:String;
		public var duihuanMoney:Number;
		public var lastHaveMoney:Number;
		public var nowHaveMoney:Number;
		public var contactName:String;
		public var contactTel:String;
		public var contactAddress:String;
		public function Duihuanlog()
		{
		}
	}
}