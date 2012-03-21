package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.service.MahjongSyncServer100;
	import com.amusement.Mahjong.service.MahjongSyncServer10;
	import com.amusement.Mahjong.service.MahjongSyncServer20;
	import com.amusement.Mahjong.service.MahjongSyncServer5;
	import com.amusement.Mahjong.service.MahjongSyncServer50;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class TimerControl
	{
		public var timer : Timer = new Timer(5000,0);
		
		public function TimerControl()
		{
			timer.addEventListener(TimerEvent.TIMER,timerHandler);
			
			timer.start();
		}
		
		public function stopTimer():void{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			timer = null;
		}
		
		private function timerHandler(e:TimerEvent):void{
			MahjongSyncServer10.getInstance().getOnlineNum();
			MahjongSyncServer20.getInstance().getOnlineNum();
			MahjongSyncServer50.getInstance().getOnlineNum();
			MahjongSyncServer5.getInstance().getOnlineNum();
			MahjongSyncServer100.getInstance().getOnlineNum();
			MahjongSettingControl.instance.clearPlayerList();
			MahjongSyncServer100.getInstance().getRoomPlayerList();
			MahjongSyncServer5.getInstance().getRoomPlayerList();
			MahjongSyncServer10.getInstance().getRoomPlayerList();
			MahjongSyncServer20.getInstance().getRoomPlayerList();
			MahjongSyncServer50.getInstance().getRoomPlayerList();
		}
	}
}