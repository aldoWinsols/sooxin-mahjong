package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.view.MahjongInfo;

	public class MahjongInfoControl
	{
		private static var _instance:MahjongInfoControl;
		
		private var _mahjongInfo:MahjongInfo;
		
		public function MahjongInfoControl(mahjongInfo:MahjongInfo)
		{
			_instance = this;
			
			this._mahjongInfo = mahjongInfo;
		}
		
		public function setRoomNum(roomNum:Number):void{
			this._mahjongInfo.roomNum.text = roomNum.toString();
		}
		
		public function setRoomType(roomType:int):void{
			this._mahjongInfo.roomType.text = roomType + "點/臺";
		}
		
		public function setPlayerMoney(playerMoney:Number):void{
			this._mahjongInfo.playerMoneyTxt.text = playerMoney.toFixed(2);
		}

		public static function get instance():MahjongInfoControl
		{
			return _instance;
		}

	}
}