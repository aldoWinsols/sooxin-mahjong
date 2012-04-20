package com.control
{
	public class MainControl
	{
		public var main:webmj;
		public static var instance:MainControl;
		public function MainControl(main:webmj)
		{
			this.main = main;
			instance = this;
		}
	}
}