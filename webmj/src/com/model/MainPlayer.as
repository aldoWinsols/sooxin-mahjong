package com.model
{
	[Bindable]
	[RemoteClass(alias="com.panda.dao.Player")]
	public class MainPlayer
	{
		public var id:Number;
		public var playerName:String = "";
		public var playerPwd:String = "";
		public var haveMoney:Number = 0;;
		public var birthday:int = 0;;
		public var birthMonth:int = 0;;
		public var birthYear:int = 0;;
		public var cityCode:String = "";
		public var countryCode:String = "";
		public var edu:String = "";
		public var email:String = "";
		public var fansNum:int = 0;;
		public var head:String = "";
		public var idolNum:int = 0;;
		public var introduction:String = "";
		public var isent:Boolean;
		public var isrealName:Boolean;
		public var isvip:Boolean;
		public var location:String = "";
		public var nick:String = "";
		public var openid:String = "";
		public var provinceCode:String = "";
		public var sex:int = 0;;
		public var tag:String = "";
		public var tweetnum:int = 0;;
		public var verifyinfo:String = "";
		public var offlineGameNo:int = 0;;

		public function MainPlayer()
		{
		}
	}
}