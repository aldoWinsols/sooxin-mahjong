package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.Interface.IMahjongSyncService;
	import com.amusement.Mahjong.control.MahjongApplictionControl;
	import com.amusement.Mahjong.control.MahjongPlayerControlD;
	import com.amusement.Mahjong.control.MahjongPlayerControlL;
	import com.amusement.Mahjong.control.MahjongPlayerControlR;
	import com.amusement.Mahjong.control.MahjongPlayerControlU;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.control.MainControl;
	import com.mahjongSyncServer.services.RoomService;
	
	import flash.display.Stage;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	
	import mx.events.CloseEvent;
	import mx.rpc.events.ResultEvent;

	public class MahjongSyncService
	{
		private static var _instance:MahjongSyncService;

		private var _isResult:Boolean = true;
		public var playHandSpeed:int = 1;
		public var level:int = 0; //机器人智能水平
		public var isNetwork:Boolean = false;
		
		public function MahjongSyncService()
		{
			
		}
		
		public static function get instance():MahjongSyncService
		{
			if(_instance == null){
				_instance = new MahjongSyncService();
			}
			return _instance;
		}
		
		public function connServer(){
			
		}
		public function beginGameI(roomNo:Number,diceNum:Number,playerAzimuth:int,playerMahjongValues:Array):void
		{
			MahjongRoomControl.instance.beginGame(roomNo,diceNum,playerAzimuth,playerMahjongValues);
		}
		
		public function gameOverI(playerNames:Array,playerMahjongValues:Array,result:Array, videoContent:String):void{

			var msgObj:Object = {};
			msgObj.playerNames = playerNames;
			msgObj.playerMahjongValues = playerMahjongValues;
			msgObj.result = result;
			msgObj.videoContent = videoContent;//测试
			
			MahjongRoomControl.instance.endGame(msgObj);
		}
		
		public function dingzhangI(playerAzimuthR:int, dingzhangValue:int):void{
			var msgObj:Object = {};
			msgObj.playerAzimuthR = playerAzimuthR;
			msgObj.dingzhangValue = dingzhangValue;
			
			MahjongRoomControl.instance.dingzhang(msgObj);
		}
		
		public function getOneMahjongI(playerAzimuthR:int, getOneMahjongValue:int):void{
			var msgObj:Object ={};
			msgObj.playerAzimuthR = playerAzimuthR;
			msgObj.getOneMahjongValue = getOneMahjongValue;
			
			MahjongRoomControl.instance.getOneMahjong(msgObj);
		}
		
		public function putOneMahjongI(playerAzimuthR:int, putOneMahjongValue:int, isPutDingzhang:Boolean):void{
			
			var msgObj:Object = {};
			msgObj.playerAzimuthR = playerAzimuthR;
			msgObj.putOneMahjongValue = putOneMahjongValue;
			msgObj.isPutDingzhang = isPutDingzhang;
			
			MahjongRoomControl.instance.putOneMahjong(msgObj);
			
		}
		
		public function pengI(playerAzimuthR:int, pengValue:int):void{
			var msgObj:Object = {};
			msgObj.playerAzimuthR = playerAzimuthR;
			msgObj.pengValue = pengValue;
			
			MahjongRoomControl.instance.peng(msgObj);
		}
		
		public function gangI(playerAzimuthR:int,gangValue:int,isZigang:Boolean):void{
			var msgObj:Object = {};
			msgObj.playerAzimuthR = playerAzimuthR;
			msgObj.gangValue = gangValue;
			msgObj.isZigang = isZigang;
			
			MahjongRoomControl.instance.gang(msgObj);
		}
		
		public function huI(playerAzimuthR:int, huValue:int, huType:int = 0, isAfterGang:Boolean = false, haveHuCount:int = 1, qiangGangAzimuth:int = 0):void{

			var msgObj:Object = {};
			msgObj.playerAzimuthR = playerAzimuthR;
			msgObj.huValue = huValue;
			msgObj.huType = huType;
			msgObj.isAfterGang = isAfterGang;
			msgObj.haveHuCount = haveHuCount;
			msgObj.qiangGangAzimuth = qiangGangAzimuth;
			
			MahjongRoomControl.instance.hu(msgObj);
		}
		
		public function showDingzhangI(obj:Object):void{
//			var content:Array = obj.content;
			
			var msgObj:Object = {};
//			msgObj.playerAzimuthR = content[0];
			
			MahjongRoomControl.instance.showDingzhang(msgObj);
		}
		
		public function showOperationI(playerAzimuthR:int,operationName:Array):void{
			
			trace("showOperationIshowOperationIshowOperationI"+playerAzimuthR+"--"+operationName.toString());
			
			var msgObj:Object = {};
			msgObj.playerAzimuthR = playerAzimuthR;
			msgObj.isPeng = false;
			msgObj.isGang = false;
			msgObj.isHu = false;
			msgObj.isZimo = false;
			msgObj.isZigang = false;
			for(var i:int = 0; i < operationName.length; i ++){
				switch(operationName[i]){
					case "peng":
						msgObj.isPeng = true;
						break;
					case "gang":
						msgObj.isGang = true;
						break;
					case "hu":
						msgObj.isHu = true;
						break;
					case "zihu":
						msgObj.isHu = true;
						msgObj.isZimo = true;
						break;
					case "zigang":
						msgObj.isGang = true;
						msgObj.isZigang = true;
						break;
				}
			}
			
			MahjongRoomControl.instance.showOperation(msgObj);
		}
		
		//----------------------------------------------------------------------------------------------------------
		
		public function continueGame():void{
			if(isNetwork){
				MahjongSyncNetworkService.instance.continueGame();
			}else{			
				RoomService.instance.continueGame();
			}
		}
		
		public function dealOver():void{
			if(isNetwork){
				MahjongSyncNetworkService.instance.dealOver();
			}else{
				RoomService.instance.dealOver();
				
				if(MainControl.instance.main.applicationDPI != 160){
					MahjongPlayerControlU.instance._mahjongPlayer.pd.visible = false;
					MahjongPlayerControlD.instance._mahjongPlayer.pd.visible = false;
					MahjongPlayerControlL.instance._mahjongPlayer.pd.visible = false;
					MahjongPlayerControlR.instance._mahjongPlayer.pd.visible = false;
				}
			}
		}
		
		public function dingzhang(dingzhangValue:int):void{
			if(isNetwork){
				MahjongSyncNetworkService.instance.dingzhang(dingzhangValue);
			}else{			
				RoomService.instance.dingzhang(MahjongRoomControl.instance.playerAzimuth,dingzhangValue);
			}
		}
		
		public function putOneMahjong(putOneMahjongValue:int, isPutDingzhang:Boolean = false):void{
			if(isNetwork){
				MahjongSyncNetworkService.instance.putOneMahjong(putOneMahjongValue, isPutDingzhang);
			}else{			
				RoomService.instance.putOneMahjong(MahjongRoomControl.instance.playerAzimuth,putOneMahjongValue, isPutDingzhang);
			}
		}
		
		public function peng():void{
			if(isNetwork){
				MahjongSyncNetworkService.instance.peng();
			}else{
				RoomService.instance.peng(MahjongRoomControl.instance.playerAzimuth);
			}
		}
		
		public function gang(gangValue:int, isZigang:Boolean):void{
			if(isNetwork){
				MahjongSyncNetworkService.instance.gang(gangValue, isZigang);
			}else{
				RoomService.instance.gang(MahjongRoomControl.instance.playerAzimuth,gangValue, isZigang);
			}
		}
		
		public function hu(isZimo:Boolean):void{
			if(isNetwork){
				MahjongSyncNetworkService.instance.hu(isZimo);
			}else{
				RoomService.instance.hu(MahjongRoomControl.instance.playerAzimuth,isZimo);
			}
		}
		
		public function xiao(isZimo:Boolean, isZigang:Boolean):void{
			if(isNetwork){
				MahjongSyncNetworkService.instance.xiao(isZimo, isZigang);
			}else{			
				RoomService.instance.xiao(MahjongRoomControl.instance.playerAzimuth,isZimo,isZigang);
			}
		}
	}
}