package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongDingzhangControl;
	import com.amusement.Mahjong.control.MahjongOperationControl;
	import com.amusement.Mahjong.control.MahjongPlayerControlD;
	import com.amusement.Mahjong.control.MahjongQuemenControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.control.MahjongTimerControl;

	public class MahjongTimerService
	{
		private var _playerState:int;
		
		public function MahjongTimerService()
		{
		}
		
		public function timerHandler(count:int, isOnline:Boolean = true):void{
			if(isOnline && count == 0){
				_playerState = MahjongRoomControl.instance.putState;
				MahjongRoomControl.instance.putState = 0;
			}
		}
		
		public function timerCompleteHandler(isOnline:Boolean = true):void{
			if(isOnline){
				MahjongTimerControl.instance.hide();
				switch(_playerState){
					case 1:
						MahjongQuemenControl.instance.hide();
						MahjongDingzhangControl.instance.hide();
						MahjongPlayerControlD.instance.replaceDingzhang();
						break;
					case 2:
						MahjongPlayerControlD.instance.replacePutMahjong();
						break;
					case 3:
						MahjongOperationControl.instance.timeUp();
						break;
				}
			}
		}
	}
}