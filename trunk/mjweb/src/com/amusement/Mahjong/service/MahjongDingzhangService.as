package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongDingzhangControl;
	import com.amusement.Mahjong.control.MahjongPlayerControlD;
	import com.amusement.Mahjong.control.MahjongQuemenControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.control.MahjongTimerControl;
	import com.amusement.Mahjong.model.Mahjong;
	
	import flash.display.DisplayObject;

	public class MahjongDingzhangService
	{
		public function MahjongDingzhangService()
		{
		}
		
		public function quemenClickHandler(parent:DisplayObject, px:int, py:int):void{
			var quemenTypes:Array = MahjongPlayerControlD.instance.checkQuemenMine();
			if(quemenTypes.length > 1){
				MahjongQuemenControl.instance.show(quemenTypes, parent, px, py);
				
			}else if(quemenTypes.length == 1){
				MahjongRoomControl.instance.putState = 0;
				
				MahjongTimerControl.instance.hide();
				
				MahjongDingzhangControl.instance.hide();
				
				//向服务器发送请求
				MahjongSyncService.instance.dingzhang(quemenTypes[0]);
			}
		}
	}
}