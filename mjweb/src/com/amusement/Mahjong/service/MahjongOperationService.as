package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongDingzhangControl;
	import com.amusement.Mahjong.control.MahjongGangControl;
	import com.amusement.Mahjong.control.MahjongOperationControl;
	import com.amusement.Mahjong.control.MahjongPlayerControlD;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.control.MahjongTimerControl;
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.view.MahjongDingzhang;
	import com.amusement.Mahjong.view.MahjongOperation;
	
	import flash.display.DisplayObject;

	public class MahjongOperationService
	{
		public function MahjongOperationService()
		{
		}
		
		/**
		 * 点击碰处理函数 
		 * 
		 */
		public function pengClickHandler():void{
			MahjongRoomControl.instance.putState = 0;
			MahjongTimerControl.instance.hide();
			MahjongOperationControl.instance.hide();
			//向服务器发送请求
			MahjongSyncService.instance.peng();
		}
		
		/**
		 * 点击杠处理函数 
		 * 
		 */
		public function gangClickHandler(isZigang:Boolean, parent:DisplayObject, px:int, py:int):void{
			if(isZigang){
				var gangValues:Array = MahjongPlayerControlD.instance.checkGangMine(MahjongRoomControl.instance.mahjongs.length);
				if(gangValues.length > 1){
					MahjongGangControl.instance.show(gangValues, parent, px, py);
				}else if(gangValues.length == 1){
					MahjongRoomControl.instance.putState = 0;
					MahjongTimerControl.instance.hide();
					MahjongOperationControl.instance.hide();
					//向服务器发送请求
					MahjongSyncService.instance.gang(gangValues[0], isZigang);
				}
			}else{
				MahjongRoomControl.instance.putState = 0;
				MahjongTimerControl.instance.hide();
				MahjongOperationControl.instance.hide();
				//向服务器发送请求
				MahjongSyncService.instance.gang(MahjongRoomControl.instance.nowPutMahjong.value, isZigang);
			}
		}
		
		/**
		 * 点击胡处理函数 
		 * 
		 */
		public function huClickHandler(isZimo:Boolean):void{
			MahjongRoomControl.instance.putState = 0;
			MahjongTimerControl.instance.hide();
			MahjongGangControl.instance.hide();
			MahjongOperationControl.instance.hide();
			//向服务器发送请求
			MahjongSyncService.instance.hu(isZimo);
		}
		
		/**
		 * 点击消处理函数 
		 * 
		 */
		public function xiaoClickHandler(isZimo:Boolean, isZigang:Boolean):void{
			MahjongRoomControl.instance.putState = 0;
			MahjongTimerControl.instance.hide();
			MahjongGangControl.instance.hide();
			MahjongOperationControl.instance.hide();
			//向服务器发送请求
			MahjongSyncService.instance.xiao(isZimo, isZigang);
			
			if(isZimo || isZigang){
				/*if(MahjongRoomControl.instance.playerAzimuth == 3 && MahjongPlayerControlD.instance.state == 0){//庄家第一次摸牌后
					MahjongDingzhangControl.instance.show();
				}else*/ if(MahjongPlayerControlD.instance.state == 1){
					MahjongPlayerControlD.instance.replacePutDingzhang();
				}else{
					MahjongRoomControl.instance.putState = 2;
					MahjongTimerControl.instance.show(3, 10);
				}
			}
		}
		
		public function replaceClick(isHu:Boolean, isZimo:Boolean, isZigang:Boolean):void{
			MahjongGangControl.instance.hide();
			MahjongOperationControl.instance.hide();
			if(isHu){
				MahjongSyncService.instance.hu(isZimo);
			}else{
				MahjongSyncService.instance.xiao(isZimo, isZigang);
				
				if(isZigang){
					if(MahjongPlayerControlD.instance.state == 1){
						MahjongPlayerControlD.instance.replacePutDingzhang();
					}else{
//						MahjongPlayerControlD.instance.replacePutMahjong();
						MahjongRoomControl.instance.putState = 2;
						MahjongTimerControl.instance.show(3, 10);
					}
				}
				
			}
		}
	}
}