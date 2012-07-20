package com.mahjongSyncServer.services
{
	import com.amusement.Mahjong.control.MahjongApplictionControl;
	import com.amusement.Mahjong.control.MahjongPlayerControlD;
	import com.amusement.Mahjong.control.MahjongPlayerControlL;
	import com.amusement.Mahjong.control.MahjongPlayerControlR;
	import com.amusement.Mahjong.control.MahjongPlayerControlU;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.service.MahjongSoundService;
	import com.amusement.Mahjong.service.MahjongSyncService;
	import com.mahjongSyncServer.model.Balance;
	import com.mahjongSyncServer.model.Message;
	import com.mahjongSyncServer.model.Room;
	import com.mahjongSyncServer.util.FanpaiTypeEnum;
	import com.mahjongSyncServer.util.PlayerTypeEnum;
	import com.mahjongSyncServer.util.Util;
	import com.services.DataService;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.binding.utils.BindingUtils;
	
	public class RoomService
	{
		private static var _instance:RoomService;
		public var room:Room;
		public var playerServices:Vector.<PlayerService> = new Vector.<PlayerService>();
		public var logicService:LogicService = null;
		public var str:String = "";
		public var timer:Timer = null;
		public var userName:String = null;
		private var haveMoney:Number = 0;
		private var playerAuthz:int = 0;
		private var roomNo:String = "";
		private var dataService:DataService = new DataService();
		public function RoomService()
		{
			room = new Room();
			str = "player1!1!1.1.1.1.2.2.2.2.3.3.3.3.4.;player2!2!4.4.4.5.5.5.5.6.6.6.6.7.7.;player3!3!7.7.8.8.8.8.9.9.9.9.17.11.11.;player4!4!11.12.12.12.12.13.13.13.13.14.14.14.14.;beg,125,6,5;get,3,15;sd,1;sd,2;sd,4;din,4,0;din,1,20;din,2,20;din,3,20;put,3,7,0;so,2,hu,peng;huI,2,7,0,1,0,0;get,3,15;so,3,zigang,zigang;gan,3,8,1;get,3,15;so,3,zigang,zigang;gan,3,9,1;get,3,15;so,3,zigang,zigang;gan,3,15,1;get,3,16;put,3,7,0;get,4,16;so,4,zigang;gan,4,12,1;get,4,16;so,4,zigang;gan,4,13,1;get,4,16;so,4,zigang;gan,4,14,1;get,4,11;so,4,zihu;huI,4,11,1,0,0,0;get,1,17;so,1,zigang;gan,1,1,1;get,1,17;so,1,zigang,zihu;gan,1,2,1;get,1,17;so,1,zigang;gan,1,3,1;get,1,18;put,1,4,0;get,3,18;so,3,zihu;huI,3,18,1,0,0,0;";
			playerServices.push(new PlayerService(this,PlayerTypeEnum.ANDROID, 1,"幺妹儿"));
			playerServices.push(new PlayerService(this,PlayerTypeEnum.ANDROID, 2, "三姐"));
			playerServices.push(new PlayerService(this,PlayerTypeEnum.ONLINE, 3,""));
			playerServices.push(new PlayerService(this,PlayerTypeEnum.ANDROID, 4, "胖娃子"));
			
			timer = new Timer(100);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			logicService = new LogicService(playerServices, this);
		}
		
		public static function get instance():RoomService
		{
			if(_instance == null){
				_instance = new RoomService();
			}
			
			return _instance;
		}
		
		public static function set instance(value:RoomService):void
		{
			_instance = value;
		}
		
		private function onTimer(e:TimerEvent):void{
			for(var i:int=0; i<4; i++){
				playerServices[i].onTimer();
			}
		}
		
		public function beginGame(userName:String, haveMoney:Number):void{
			MahjongPlayerControlU.instance._mahjongPlayer.pd.visible = true;
			MahjongPlayerControlD.instance._mahjongPlayer.pd.visible = true;
			MahjongPlayerControlL.instance._mahjongPlayer.pd.visible = true;
			MahjongPlayerControlR.instance._mahjongPlayer.pd.visible = true;
			
			findPlayerService().player.playerName = userName;
			findPlayerService().player.haveMoney = haveMoney;
			this.userName = userName;
			this.haveMoney = haveMoney;
			
			for(var i:int=0; i<4; i++){
				this.playerServices[i].player.clearAllData();
				this.playerServices[i].action.init();
				BalanceService.instance.balanceList = new Vector.<Balance>();
			}
			
			//获得洗牌的数组
			this.room.mahjongs = Util.instance.getRandowMahjongs();
			this.room.historyMessage = new Vector.<Message>();
			getRandowPlayerServices();
			
			for(var i:int=0; i<4; i++){
				playerServices[i].player.sparr = this.room.mahjongs.splice(0,13);
				
				if(playerServices[i].player.playerType == PlayerTypeEnum.ONLINE){
					playerAuthz = i+1;
				}
				
				for(var j:int = 0;j < playerServices[i].player.sparr.length;j ++){
					playerServices[i].player.sparrStr += playerServices[i].player.sparr[j] + ".";
				}
			}
			
			var date:Date = new Date();
			var roomNo:Number = Number(date.fullYear*100000000 + date.month*1000000 + date.day*10000 +date.hours*100 +date.minutes);
			var shaizi:Number = 2+int(Math.random()*11);
			var obj:Array = new Array();
			obj.push(roomNo);
			obj.push(shaizi);
			this.roomNo = roomNo.toString();
			addHistoryMessage("beginGameI", obj);
			trace(Util.changeVectoryToArray(findPlayerService().player.sparr));
			
			MahjongSyncService.instance.beginGameI(roomNo,shaizi,findPlayerService().player.azimuth,Util.changeVectoryToArray(findPlayerService().player.sparr));
			timer.start();
		}
		
		public function findPlayerService():PlayerService{
			for(var i:int=0; i<4; i++){
				if(playerServices[i].player.playerType == PlayerTypeEnum.ONLINE){
					return playerServices[i];
				}
			}
			
			return null;
		}
		
		public function getRandowPlayerServices():void{
			var randow1:int = 0;
			var randow2:int = 0;
			var t:PlayerService;
			
			for(var i:int=0; i<4; i++){
				randow1 = int(Math.random()*playerServices.length);
				randow2 = int(Math.random()*playerServices.length)
				t = playerServices[randow1];
				playerServices[randow1] = playerServices[randow2];
				playerServices[randow2] = t;
			}
			
			for(var i:int=0; i<4; i++){
				playerServices[i].player.azimuth = i+1;
			}
		}    
		
		public function endGame():void{
			var playerNames:Array = new Array();
			var playerMahjongValues:Array = new Array();
			for(var i:int=0;i<4;i++){
				playerNames.push(this.playerServices[i].player.playerName);
				playerMahjongValues[i + 1] = Util.changeVectoryToArray(this.playerServices[i].player.sparr);
			}
			str = DataService.instance.getHistoryMessage(room.historyMessage, playerServices);
			
			var winningLosing:Number = getPlayerChangeMoney(playerAuthz,BalanceService.instance.balanceList);
			var preMoney:Number = haveMoney;
			var afterMoney:Number = preMoney + winningLosing;
			haveMoney = preMoney + winningLosing;
			findPlayerService().player.haveMoney = haveMoney;
			DataService.instance.afterData(userName,winningLosing, str, roomNo, getBeforeOneDate(), preMoney, winningLosing, afterMoney);

			MahjongSyncService.instance.gameOverI(playerNames,playerMahjongValues,Util.changeBalanceVectoryToArray(BalanceService.instance.balanceList), str);
			
		}
		private function getBeforeOneDate():String{
			var date:Date = new Date();
			var dateStr:String = date.fullYear + "-" + (date.month + 1) + "-" + date.date + " " + date.hours + ":" + date.minutes + ":" + date.seconds;
			return dateStr;
		}
		
		public function getPlayerChangeMoney(playerAuthz:int,arr:Vector.<Balance>):Number{
			var changeMoney:Number = 0;
			for(var i:int=0;i<arr.length;i++){
				if(playerAuthz == 1){
					changeMoney += arr[i].azimuth1;
				}
				if(playerAuthz == 2){
					changeMoney += arr[i].azimuth2;
				}
				if(playerAuthz == 3){
					changeMoney += arr[i].azimuth3;
				}
				if(playerAuthz == 4){
					changeMoney += arr[i].azimuth4;
				}
			}
			return changeMoney;
		}
		
		public function playerVideo(str:String):void{
			this.str = str;
			MahjongRoomControl.instance.clearTabletop();
			MahjongApplictionControl.instance.playVideo(str, 0);
		}
		/** 
		 * 添加历史记录信息
		 * @param head	执行的操作方法
		 * @param playerService	该操作的玩家类
		 */
		public function addHistoryMessage(head:String, content:Object):void{
			
			var historyMessage:Message = new Message();
			historyMessage.head = head;
			historyMessage.content = content;
			
			room.historyMessage.push(historyMessage);
		}
		
		//----------------------------------------------------------------------
		public function continueGame():void{
			for(var i:int=0; i<4; i++){
				this.playerServices[i].player.clearAllData();
				this.playerServices[i].action.init();
				BalanceService.instance.balanceList = new Vector.<Balance>();
			}
			
			beginGame(userName, haveMoney);
				
		}
		
		// 客户端发牌完毕收到的消息
		public function dealOver():void{
			this.logicService.send(null);
		}
		
		public function dingzhang(playerAzimuth:int,dingzhangValue:int):void{
			playerServices[playerAzimuth-1].player.dingzhangValue = dingzhangValue;
			playerServices[playerAzimuth-1].player.needOperationName = "dingzhang";
			
			
			playerServices[playerAzimuth-1].player.isDingzhang = true;
			playerServices[playerAzimuth-1].player.dingzhangValue = dingzhangValue;
			
			var obj:Array = new Array();
			obj.push(playerAzimuth);
			obj.push(dingzhangValue);
			addHistoryMessage("dingzhangI", obj);
			MahjongSyncService.instance.dingzhangI(playerAzimuth,dingzhangValue);
			
			
			playerServices[playerAzimuth-1].player.needOperationName = "";
			playerServices[playerAzimuth-1].player.lastNeedOperationName = "dingzhang";
			//
			
			this.logicService.send(playerServices[playerAzimuth-1]);
		}
		
		public function putOneMahjong(playerAzimuth:int, putOneMahjongValue:int, isPutDingzhang:Boolean = false):void{
			playerServices[playerAzimuth-1].player.dingzhangFanpai = FanpaiTypeEnum.YES_FANPAI;
			playerServices[playerAzimuth-1].player.isPutDingzhang = isPutDingzhang;
			playerServices[playerAzimuth-1].player.nowOperationMahjongValue = putOneMahjongValue;
			
			playerServices[playerAzimuth-1].player.needOperationName = "";
			playerServices[playerAzimuth-1].player.lastNeedOperationName = "putOneMahjong";
			var obj:Array = new Array();
			obj.push(playerAzimuth);
			obj.push(putOneMahjongValue);
			obj.push(isPutDingzhang?1:0);
			addHistoryMessage("putOneMahjongI", obj);
			playerServices[playerAzimuth-1].player.huCount = 0;
			playerServices[playerAzimuth-1].putOneMahjong(putOneMahjongValue);
			MahjongSyncService.instance.putOneMahjongI(playerAzimuth, putOneMahjongValue, isPutDingzhang);
			//清楚其他玩家有操作的情况，只保留自己的操作
			logicService.clearAllOperationName(playerAzimuth);
			logicService.opertions.splice(0, 4);
			this.logicService.send(playerServices[playerAzimuth-1]);
		}
		
		public function peng(playerAzimuth:int):void{
			playerServices[playerAzimuth-1].player.needOperationName = "";
			playerServices[playerAzimuth-1].player.lastNeedOperationName = "peng";
			var value:int = playerServices[playerAzimuth-1].peng(playerServices[playerAzimuth-1].player.needOperationPlayerService);
			
			MahjongSyncService.instance.pengI(playerServices[playerAzimuth-1].player.azimuth,value);
			var obj:Array = new Array();
			obj.push(playerAzimuth);
			obj.push(value);
			addHistoryMessage("pengI", obj);
		}
		
		public function gang(playerAzimuth:int, gangValue:int, isZigang:Boolean):void{
			var operationName:String = isZigang ? "zigang" : "gang";
			playerServices[playerAzimuth-1].player.needOperationName = operationName;
			playerServices[playerAzimuth-1].player.lastNeedOperationName = operationName;
			playerServices[playerAzimuth-1].player.nowOperationMahjongValue = gangValue;
			
			//清楚其他玩家有操作的情况，只保留自己的操作
			logicService.clearAllOperationName(playerAzimuth);
			logicService.opertions.splice(0, 4);
			playerServices[playerAzimuth-1].decOperationName();
		}
		
		public function hu(playerAzimuth:int, isZimo:Boolean):void{
			var operationName:String = isZimo ? "zihu" : "hu";
			playerServices[playerAzimuth-1].player.needOperationName = operationName;
			playerServices[playerAzimuth-1].player.lastNeedOperationName = operationName;
			if(!isZimo){
				PlayerService.huCount ++;
			}
			//----------------------------------------------------------------------
			//清楚其他玩家有操作的情况，只保留自己的操作
			logicService.clearAllOperationName(playerAzimuth);
			logicService.opertions.splice(0, 4);
			//----------------------------------------------------------------------
			playerServices[playerAzimuth-1].decOperationName();
		}
		
		public function xiao(playerAzimuth:int, isZimo:Boolean, isZigang:Boolean):void{
			playerServices[playerAzimuth-1].player.needOperationName = "";
			playerServices[playerAzimuth-1].player.lastNeedOperationName = "xiao";
			if(isZimo || isZigang){
				playerServices[playerAzimuth-1].player.xiaoIsZihu = true;
			}
			playerServices[playerAzimuth-1].player.couldOperationNames = [];
			//清楚其他玩家有操作的情况，只保留自己的操作
			logicService.clearAllOperationName(playerAzimuth);
			logicService.opertions.splice(0, 4);
			logicService.send(playerServices[playerAzimuth-1].player.needOperationPlayerService);
		}
	}
}