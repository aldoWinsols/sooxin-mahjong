package com.model
{
	[Bindable]
	[RemoteClass(alias="com.panda.dao.Config")]
	public class Config
	{
		public var id:Number;
		public var mainConnUrl:String = "";
		public var hideJiangpin:Boolean = true;
		
		
		public function Config()
		{
		}
	}
}