package com.model
{
	[Bindable]
	[RemoteClass(alias="com.panda.dao.Player")]
	public class MainPlayer
	{
		public var id:int;
		public var playername:String;
		public var playerpwd:String;
		public var haveMoney:Number;
		public function MainPlayer()
		{
		}
	}
}