package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.view.MahjongSign;
	
	public class MahjongSignControl
	{
		private static var _instance:MahjongSignControl;
		
		private var _mahjongSign:MahjongSign;
		
		public function MahjongSignControl(mahjongSign:MahjongSign)
		{
			_instance = this;
			
			this._mahjongSign = mahjongSign;
		}
		public function show(px:int, py:int):void{
			this._mahjongSign.x = px;
			this._mahjongSign.y = py;
			
			this._mahjongSign.visible = true;
		}
		
		public function hide():void{
			this._mahjongSign.visible = false;
		}
		
		//--------------------------------------------------------------------
		public static function get instance():MahjongSignControl
		{
			return _instance;
		}

	}
}