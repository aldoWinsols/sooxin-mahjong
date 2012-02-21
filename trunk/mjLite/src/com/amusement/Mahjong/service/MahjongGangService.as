package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongGangControl;
	import com.amusement.Mahjong.control.MahjongOperationControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.control.MahjongTimerControl;
	import com.amusement.Mahjong.model.Mahjong;

	public class MahjongGangService
	{
		public function MahjongGangService()
		{
		}
		
		public function mahjongClickHandler(mahjong:Mahjong):void{
			if(MahjongGangControl.instance.selectGangMahjong && MahjongGangControl.instance.selectGangMahjong == mahjong){
				MahjongRoomControl.instance.putState = 0;
				MahjongTimerControl.instance.hide();
				//向服务器发送请求
				MahjongSyncService.instance.gang(mahjong.value, true);
				
				MahjongGangControl.instance.hide();
				MahjongOperationControl.instance.hide();
			}else{
				MahjongGangControl.instance.selectGangMahjong = mahjong;
			}
		}
	}
}