package com.amusement.HundredHappy.model
{
	[Bindable]
	public class HundredHappyPlayer
	{
		private var _acctName:String = "";//12-02-02 玩家帳號，用於玩家的查找。
		private var _playerName:String = "";
		private var _authz:Number = 0;
		
		private var _zhuangduiT:Number = 0;
		private var _xianduiT:Number = 0;
		private var _zhuangT:Number = 0;
		private var _xianT:Number = 0;
		private var _heT:Number = 0;
		
		private var _zhuangduiC:Number = 0;
		private var _xianduiC:Number = 0;
		private var _zhuangC:Number = 0;
		private var _xianC:Number = 0;
		private var _heC:Number = 0;
		
		private var _currentPoint:Number = 0;
		
		public function HundredHappyPlayer()
		{
		}
		
		public function get acctName():String
		{
			return _acctName;
		}
		
		public function set acctName(value:String):void
		{
			_acctName = value;
		}
		
		public function get playerName():String
		{
			return _playerName;
		}
		
		public function set playerName(value:String):void
		{
			_playerName = value;
		}

		public function get authz():Number
		{
			return _authz;
		}

		public function set authz(value:Number):void
		{
			_authz = value;
		}

		public function get heT():Number
		{
			return _heT;
		}

		public function set heT(value:Number):void
		{
			_heT = value;
		}

		public function get xianT():Number
		{
			return _xianT;
		}

		public function set xianT(value:Number):void
		{
			_xianT = value;
		}

		public function get zhuangT():Number
		{
			return _zhuangT;
		}

		public function set zhuangT(value:Number):void
		{
			_zhuangT = value;
		}

		public function get xianduiT():Number
		{
			return _xianduiT;
		}

		public function set xianduiT(value:Number):void
		{
			_xianduiT = value;
		}

		public function get zhuangduiT():Number
		{
			return _zhuangduiT;
		}

		public function set zhuangduiT(value:Number):void
		{
			_zhuangduiT = value;
		}

		public function get zhuangduiC():Number
		{
			return _zhuangduiC;
		}

		public function set zhuangduiC(value:Number):void
		{
			_zhuangduiC = value;
		}

		public function get xianduiC():Number
		{
			return _xianduiC;
		}

		public function set xianduiC(value:Number):void
		{
			_xianduiC = value;
		}

		public function get zhuangC():Number
		{
			return _zhuangC;
		}

		public function set zhuangC(value:Number):void
		{
			_zhuangC = value;
		}

		public function get xianC():Number
		{
			return _xianC;
		}

		public function set xianC(value:Number):void
		{
			_xianC = value;
		}

		public function get heC():Number
		{
			return _heC;
		}

		public function set heC(value:Number):void
		{
			_heC = value;
		}

		public function get currentPoint():Number
		{
			return _currentPoint;
		}

		public function set currentPoint(value:Number):void
		{
			_currentPoint = value;
		}

	}
}