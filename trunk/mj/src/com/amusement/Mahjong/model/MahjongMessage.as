package com.amusement.Mahjong.model
{
	public class MahjongMessage
	{
		private var _method:Function;
		private var _arg:Object;
		
		public function MahjongMessage(method:Function, arg:Object)
		{
			this._method = method;
			this._arg = arg;
		}
		
		public function get method():Function
		{
			return _method;
		}
		
		public function get arg():Object
		{
			return _arg;
		}
	}
}