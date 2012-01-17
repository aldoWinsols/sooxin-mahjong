package com.control
{
	public class MainControl
	{
		public static var instance:MainControl;
		public var main:mahjongWeb;
		public function MainControl(main:mahjongWeb)
		{
			this.main = main;
			instance = this;
		}
	}
}