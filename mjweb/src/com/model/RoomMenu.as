package com.model
{
	[Bindable]
	[RemoteClass(alias="com.panda.dao.Room")]
	public class RoomMenu
	{
		public var id:Number;
		public var roomName:String = "";
		public var fanNum:Number = 0;
		public var maxFanNum:Number = 0;
		public var joinNum:Number = 0;
		public var onlineNum:Number = 0;
		public var connUrl:String = "";
		public var isView:Boolean = false;
		public var state:String = "";;
	}
}