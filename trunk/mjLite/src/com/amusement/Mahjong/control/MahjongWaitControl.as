package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.view.MahjongWait;

	public class MahjongWaitControl
	{
		private static var _instance:MahjongWaitControl;
		
		private var _mahjongWait:MahjongWait;
		
		public function MahjongWaitControl(mahjongWait:MahjongWait)
		{
			_instance = this;
			
			this._mahjongWait = mahjongWait;
		}
		
		public function show():void{
			this._mahjongWait.visible = false;
		}
		
		public function hide():void{
			this._mahjongWait.visible = false;
		}

		//-------------------------------------------------------------
		public static function get instance():MahjongWaitControl
		{
			return _instance;
		}

	}
}