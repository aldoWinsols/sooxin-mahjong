package com.amusement.Mahjong.service
{
	public class MahjongQuemenService
	{
		public function MahjongQuemenService()
		{
		}
		
		public function wangClickHandler():void{
			//向服务器发送请求
			MahjongSyncService.instance.dingzhang(0);
		}
		
		public function tongClickHandler():void{
			//向服务器发送请求
			MahjongSyncService.instance.dingzhang(10);
		}
		
		public function tiaoClickHandler():void{
			//向服务器发送请求
			MahjongSyncService.instance.dingzhang(20);
		}
	}
}