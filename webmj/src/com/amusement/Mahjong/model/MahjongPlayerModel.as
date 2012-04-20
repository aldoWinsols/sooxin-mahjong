package com.amusement.Mahjong.model
{
	public class MahjongPlayerModel
	{
		private var _sprr:Array;
		private var _pprr:Array;
		private var _gprr:Array;
		private var _oprr:Array;
		
		private var _dp:Mahjong;
		private var _dpType:int = -1;
		
		private var _hp:Mahjong;
		
		public function MahjongPlayerModel()
		{
			_sprr = [];
			_pprr = [];
			_gprr = [];
			_oprr = [];
		}

		public function get sprr():Array
		{
			return _sprr;
		}

		public function set sprr(value:Array):void
		{
			_sprr = value;
		}

		public function get pprr():Array
		{
			return _pprr;
		}

		public function set pprr(value:Array):void
		{
			_pprr = value;
		}

		public function get gprr():Array
		{
			return _gprr;
		}

		public function set gprr(value:Array):void
		{
			_gprr = value;
		}

		public function get oprr():Array
		{
			return _oprr;
		}

		public function set oprr(value:Array):void
		{
			_oprr = value;
		}

		public function get dp():Mahjong
		{
			return _dp;
		}

		public function set dp(value:Mahjong):void
		{
			_dp = value;
		}

		public function get dpType():int
		{
			return _dpType;
		}

		public function set dpType(value:int):void
		{
			_dpType = Math.floor(value / 10);
		}

		public function get hp():Mahjong
		{
			return _hp;
		}

		public function set hp(value:Mahjong):void
		{
			_hp = value;
		}

	}
}