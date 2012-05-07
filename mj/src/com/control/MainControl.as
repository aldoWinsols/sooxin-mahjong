package com.control
{
	public class MainControl
	{
		public var main:Main;
		public static var instance:MainControl;
		public function MainControl(main:Main)
		{
			this.main = main;
			instance = this;
		}
		
		public function dd(s:String):void{
			this.main.yy.text = s;
		}
	}
}