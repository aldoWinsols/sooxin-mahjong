package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.Interface.IMahjongSyncService;
	import com.amusement.Mahjong.control.MahjongApplictionControl;
	import com.amusement.Mahjong.control.MahjongPlayerControlD;
	import com.amusement.Mahjong.control.MahjongPlayerControlL;
	import com.amusement.Mahjong.control.MahjongPlayerControlR;
	import com.amusement.Mahjong.control.MahjongPlayerControlU;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.control.LianwangHomeControl;
	import com.control.MainControl;
	import com.control.MainSenceControl;
	import com.mahjongSyncServer.services.RoomService;
	import com.model.Alert;
	
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
	
	public class MahjongSyncNetworkService
	{
		private static var _instance:MahjongSyncNetworkService;
		
		private var _conn:NetConnection;
		private var _isResult:Boolean = true;
		public var playHandSpeed:int = 1;
		public var level:int = 0; //机器人智能水平
		public var playerName:String = "";
		
		public function MahjongSyncNetworkService()
		{
			_conn=new NetConnection();
			_conn.client = this;
		}
		
		public static function get instance():MahjongSyncNetworkService
		{
			if(_instance == null){
				_instance = new MahjongSyncNetworkService();
			}
			return _instance;
		}
		
		/**
		 * 连接服务 
		 * 
		 */
		public function connServer(playerName:String, connUrl:String):void
		{
			MahjongSyncService.instance.isNetwork = true;
//			MahjongApplictionControl.instance._mahjongAppliction.lianwangHome.visible = false;
//			MahjongApplictionControl.instance._mahjongAppliction.mahjongRoom.visible = true;
			this.playerName = playerName;
			
			_conn.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler, false, 0, true);
			_conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler, false, 0, true);
			_conn.connect(connUrl, this.playerName, "e10adc3949ba59abbe56e057f20f883e", "127.0.0.1");
		}
		
		private function netStatusHandler(event:NetStatusEvent):void
		{
			if(event.info.code != "NetConnection.Connect.Success"){
//				MainSenceControl.instance.mainSence.currentState = "lianwangHome";
				
				if(LianwangHomeControl.instance.lianwangHome.currentState == "main"){
					Alert.show("同步服务连接失败！请检查网络或联系客服！");
				}
				
			}
		}
		
		private function asyncErrorHandler(e:AsyncErrorEvent):void{
			//			Alert.okLabel = "確定";
			//			//			Alert.show(e.error + "\n" + e.text, "提示", Alert.OK);
						Alert.show("網絡連接異常，請嘗試重新連接", "提示", Alert.OK);
		}
		
		//---------------------------------------------------------------------------
		public function restartGameI(obj:Object):void{
			var content:Array = obj.content;
			
			var msgObj:Object = {};
			msgObj.roomNo = content[0];
			msgObj.diceNum = content[1];
			msgObj.nowPutPlayerAzimuth = content[2];
			msgObj.isShowOperation = content[3];
			msgObj.operationContent = content.pop();
			var players:Array = content[4];
			msgObj.players = [];
			var player:Object;
			for(var i:int = 0; i < players.length; i ++){
				player = {};
				player.pprrValues = players[i].pparr;
				player.gprrValues = players[i].gparr;
				player.oprrValues = players[i].outarr;
				player.dingzhangValue = players[i].dingzhangValue;
				player.isPutDingzhang = players[i].haveDingzhangFanpai;
				player.huValue = players[i].huMahjongValue;
				//				player.isZimo = content[i][10];
				player.playerAzimuthR = players[i].dianhuAzimuth;
				player.haveHuCount = players[i].huCount;
				
				if(players[i].playerName == this.playerName){
					msgObj.playerAzimuth = players[i].azimuth;
					player.sprrValues = players[i].sparr;
					player.sprrLength = player.sprrValues.length;
				}else{
					player.sprrValues = [];
					player.sprrLength = players[i].sparrNum;
				}
				
				msgObj.players[players[i].azimuth] = player;
			}
			
			MahjongApplictionControl.instance._mahjongAppliction.mahjongRoom.visible = true;
			MainSenceControl.instance.mainSence.currentState = "gameing";
			MainSenceControl.instance.mainSence.waitInfo.visible = false;
			MahjongRoomControl.instance.restartGame(msgObj);
		}
		
		
		public function beginGameI(obj:Object):void
		{
			var content:Array = obj.content;
			
			var msgObj:Object = {};
			msgObj.roomNo = content.shift();
			msgObj.diceNum = content.shift();
			for(var i:int = 0; i < content.length; i ++){
				if(content[i][1] == playerName){
					msgObj.playerAzimuth = content[i][0];
					msgObj.playerMahjongValues = content[i][2];
				}
			}
			
			MahjongApplictionControl.instance._mahjongAppliction.mahjongRoom.visible = true;
			MainSenceControl.instance.mainSence.currentState = "gameing";
			MainSenceControl.instance.mainSence.waitInfo.visible = false;
			MahjongRoomControl.instance.beginGame(msgObj.roomNo,msgObj.diceNum,msgObj.playerAzimuth,msgObj.playerMahjongValues);
		}
		
		public function gameOverI(obj:Object):void{
			var content:Array = obj.content[0];
			
			var players:Array = content[0];
			
			var msgObj:Object = {};
			msgObj.playerNames = [];
			msgObj.playerMahjongValues = [];
			for(var i:int = 0; i < players.length; i ++){
				msgObj.playerNames[players[i][0]] = players[i][1];
				msgObj.playerMahjongValues[players[i][0]] = players[i][2];
			}
			msgObj.result = content[1];
			msgObj.videoContent = content[2];//测试
			
			MahjongRoomControl.instance.endGame(msgObj);
		}
		
		public function dingzhangI(obj:Object):void{
			var content:Array = obj.content;
			
			var msgObj:Object = {};
			msgObj.playerAzimuthR = content[0];
			msgObj.dingzhangValue = content[1];
			
			MahjongRoomControl.instance.dingzhang(msgObj);
		}
		
		public function getOneMahjongI(obj:Object):void{
			var content:Array = obj.content;
			
			var msgObj:Object ={};
			msgObj.playerAzimuthR = content[0];
			msgObj.mahjongList = content[1];
			msgObj.getOneMahjongValue = content[2];
			
			MahjongRoomControl.instance._mahjongRoom.mahjongsNum.text = "剩:" + msgObj.mahjongList;
			
			MahjongRoomControl.instance.getOneMahjong(msgObj);
		}
		
		public function putOneMahjongI(obj:Object):void{
			var content:Array = obj.content;
			
			var msgObj:Object = {};
			msgObj.playerAzimuthR = content[0];
			msgObj.putOneMahjongValue = content[1];
			msgObj.isPutDingzhang = content[2];
			
			MahjongRoomControl.instance.putOneMahjong(msgObj);
			
		}
		
		public function pengI(obj:Object):void{
			var content:Array = obj.content;
			
			var msgObj:Object = {};
			msgObj.playerAzimuthR = content[0];
			msgObj.pengValue = content[1];
			
			MahjongRoomControl.instance.peng(msgObj);
		}
		
		public function gangI(obj:Object):void{
			var content:Array = obj.content;
			
			var msgObj:Object = {};
			msgObj.playerAzimuthR = content[0];
			msgObj.gangValue = content[1];
			msgObj.isZigang = content[2];
			
			MahjongRoomControl.instance.gang(msgObj);
		}
		
		public function huI(obj:Object):void{
			var content:Array = obj.content;
			
			var msgObj:Object = {};
			msgObj.playerAzimuthR = content[0];
			msgObj.huValue = content[1];
			msgObj.huType = content[2];
			msgObj.isAfterGang = content[5];
			msgObj.haveHuCount = content[3];
			msgObj.qiangGangAzimuth = content[4];
			
			MahjongRoomControl.instance.hu(msgObj);
		}
		
		public function showDingzhangI(obj:Object):void{
			//			var content:Array = obj.content;
			
			var msgObj:Object = {};
			//			msgObj.playerAzimuthR = content[0];
			
			MahjongRoomControl.instance.showDingzhang(msgObj);
		}
		
		public function showOperationI(obj:Object):void{
			var content:Array = obj.content;
			//			trace("showOperationIshowOperationIshowOperationI"+playerAzimuthR+"--"+operationName.toString());
			
			var msgObj:Object = {};
			msgObj.playerAzimuthR = content.shift();
			msgObj.isPeng = false;
			msgObj.isGang = false;
			msgObj.isHu = false;
			msgObj.isZimo = false;
			msgObj.isZigang = false;
			for(var i:int = 0; i < content.length; i ++){
				switch(content[i]){
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
			//			RoomService.instance.continueGame();
			var content:String = MahjongRoomControl.instance.roomNo.toString() + ";" + playerName;
			_conn.call("continueGame", new Responder(resultHandler, statusHandler), content);
		}
		
		public function dealOver():void{
			//			RoomService.instance.dealOver();
			var content:String = MahjongRoomControl.instance.roomNo.toString() + ";" + MahjongRoomControl.instance.playerAzimuth.toString();
			_conn.call("dealOver", new Responder(resultHandler, statusHandler), content);
			
			if(MainControl.instance.main.applicationDPI != 160){
				MahjongPlayerControlU.instance._mahjongPlayer.pd.visible = false;
				MahjongPlayerControlD.instance._mahjongPlayer.pd.visible = false;
				MahjongPlayerControlL.instance._mahjongPlayer.pd.visible = false;
				MahjongPlayerControlR.instance._mahjongPlayer.pd.visible = false;
			}
			
		}
		
		/**
		 * 其他玩家掉线通知 
		 * @param str
		 * 
		 */
		public function offlineWait(obj:Object):void{
			var content:String = obj.content;
			
			var contents:Array = content.split(",");
//			MahjongRoomControl.instance.offline(Boolean(int(contents[0])), contents[1]);
		}
		
		public function dingzhang(dingzhangValue:int):void{
			//			RoomService.instance.dingzhang(MahjongRoomControl.instance.playerAzimuth,dingzhangValue);
			var content:String = MahjongRoomControl.instance.roomNo.toString() + ";" + MahjongRoomControl.instance.playerAzimuth.toString() + ";" + dingzhangValue.toString();
			_conn.call("dingzhang", new Responder(resultHandler, statusHandler), content);
		}
		
		public function putOneMahjong(putOneMahjongValue:int, isPutDingzhang:Boolean = false):void{
			//			RoomService.instance.putOneMahjong(MahjongRoomControl.instance.playerAzimuth,putOneMahjongValue, isPutDingzhang);
			var content:String = MahjongRoomControl.instance.roomNo.toString() + ";" + MahjongRoomControl.instance.playerAzimuth.toString() + ";" + putOneMahjongValue.toString() + ";" + int(isPutDingzhang).toString();
			_conn.call("putOneMahjong", new Responder(resultHandler, statusHandler), content);
		}
		
		public function peng():void{
			//			RoomService.instance.peng(MahjongRoomControl.instance.playerAzimuth);
			var content:String = MahjongRoomControl.instance.roomNo.toString() + ";" + MahjongRoomControl.instance.playerAzimuth.toString();
			_conn.call("peng", new Responder(resultHandler, statusHandler), content);
		}
		
		public function gang(gangValue:int, isZigang:Boolean):void{
			//			RoomService.instance.gang(MahjongRoomControl.instance.playerAzimuth,gangValue, isZigang);
			var content:String = MahjongRoomControl.instance.roomNo.toString() + ";" + MahjongRoomControl.instance.playerAzimuth.toString() + ";" + gangValue.toString() + ";" + int(isZigang).toString();
			_conn.call("gang", new Responder(resultHandler, statusHandler), content);
		}
		
		public function hu(isZimo:Boolean):void{
			//			RoomService.instance.hu(MahjongRoomControl.instance.playerAzimuth,isZimo);
			var content:String = MahjongRoomControl.instance.roomNo.toString() + ";" + MahjongRoomControl.instance.playerAzimuth.toString() + ";" + int(isZimo).toString();
			_conn.call("hu", new Responder(resultHandler, statusHandler), content);
		}
		
		public function xiao(isZimo:Boolean, isZigang:Boolean):void{
			//			RoomService.instance.xiao(MahjongRoomControl.instance.playerAzimuth,isZimo,isZigang);
			var content:String = MahjongRoomControl.instance.roomNo.toString() + ";" + MahjongRoomControl.instance.playerAzimuth.toString() + ";" + int(isZimo).toString() + ";" + int(isZigang).toString();
			_conn.call("quxiao", new Responder(resultHandler, statusHandler), content);
		}
		
		//-----------------------------------------------------------------------------------------------------------
		private function resultHandler(obj:Object):void{
			trace("result_handler:" + obj);
		}
		
		private function statusHandler(obj:Object):void{
			trace("status_handler:" + obj);
		}
	}
}