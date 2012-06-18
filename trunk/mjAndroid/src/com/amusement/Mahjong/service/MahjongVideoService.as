package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongInfoControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.model.MahjongMessage;
	import com.control.HomeControl;
	import com.mahjongSyncServer.services.RoomService;
	import com.model.Alert;

	public class MahjongVideoService
	{
		private var _mahjongMessageService:MahjongMessageService;
		
		public function MahjongVideoService()
		{
			this._mahjongMessageService = new MahjongMessageService();
		}
		
		public function btnClickHandler(btnId:String):String{
			var str:String = "";
			
			switch(btnId){
				case "slowBtn":
					this._mahjongMessageService.slowTimer();
					break;
				case "playOrPauseBtn":
					this._mahjongMessageService.playOrpauseTimer();
					break;
				case "fastBtn":
					this._mahjongMessageService.fastTimer();
					break;
				case "exitBtn":
					MahjongRoomControl.instance.clearTabletop();
					MahjongRoomControl.instance.isVideo = false;
//					HomeControl.instance.home.operation.visible = true;
					HomeControl.instance.home.visible = true;
					break;
			}
			
			var speed:Number = this._mahjongMessageService.getSpeed();
			if(isNaN(speed)){
				str = "暫停播放";
			}else if(speed == Number.NEGATIVE_INFINITY){
				str = "停止播放";
			}else if(speed == 0){
				str = "正常播放";
			}else if(speed > 0){
				str = "快速播放  " + speed + "倍";
			}else if(speed < 0){
				str = "慢速播放  " + (-speed) + "倍";
			}
			
			return str;
		}
		
		private function alertCloseHandler(detail:uint):void{
			switch(detail){
				case Alert.YES:
					MahjongRoomControl.instance.clearTabletop();
					MahjongRoomControl.instance.isVideo = false;
//					HomeControl.instance.home.operation.visible = true;
					HomeControl.instance.home.visible = true;
					//退出錄像播放
//					MahjongVideo.insance.exitVideo();
					break;
			}
		}
		/*private function alertCloseHandler(event:CloseEvent):void{
			switch(event.detail){
				case Alert.YES:
					MahjongRoomControl.instance.clearTabletop();
					//退出錄像播放
					MahjongVideo.insance.exitVideo();
					break;
			}
		}*/
		
		/**
		 * 开始播放 
		 * 
		 */
		public function startVideo():void{
			this._mahjongMessageService.startTimer();
		}
		
		/**
		 * 停止播放 
		 * 
		 */
		public function stopVideo():void{
			this._mahjongMessageService.stopTimer();
			this._mahjongMessageService.clearMesseges();
		}
		
		public function playBeginGame():void{
			this._mahjongMessageService.executeMessage();
		}
		
		/**
		 * 构建录像 数据
		 * @param content
		 * 
		 */
		public function constructVideo(content:String, money:Number):void{
			if(content && content.length > 0){
				var contents:Array = content.split(";");
				contents.pop();//数据结尾处有 ";"号，最后一个为空，删除
				
				var players:Array = constructPlayers(contents.splice(0, 4));
				
				var mahjongMessage:MahjongMessage;
				var methodData:Array;
				for each(var str:String in contents){
					mahjongMessage = null;
					methodData = str.split(",");
					switch(methodData.shift()){
						case "beg":
							mahjongMessage = beginGameM(methodData, players);
							break;
						case "over":
							mahjongMessage = GameOverM(methodData, players);
							break;
						case "din":
							mahjongMessage = dingzhangM(methodData);
							break;
						case "get":
							mahjongMessage = getOneMahjongM(methodData);
							break;
						case "put":
							mahjongMessage = putOneMahjongM(methodData);
							break;
						case "pen":
							mahjongMessage = pengM(methodData);
							break;
						case "gan":
							mahjongMessage = gangM(methodData);
							break;
						case "huI":
							mahjongMessage = huM(methodData);
							break;
						case "sd":
							mahjongMessage = showDingzhangM(methodData);
							break;
						case "so":
							mahjongMessage = showOperationM(methodData);
							break;
					}
					
					if(mahjongMessage){
						this._mahjongMessageService.addMessage(mahjongMessage);
					}
				}
				
				MahjongInfoControl.instance.setPlayerMoney(money);
			}
		}
		
		/**
		 * 构建玩家初始数据 
		 * @param contents
		 * @return 
		 * 
		 */
		private function constructPlayers(contents:Array):Array{
			var players:Array = [];
			var arr:Array;
			var player:Object;
			for(var i:int = 0; i < contents.length; i ++){
				arr = contents[i].split("!");
				
				player = {};
				player.playerName = arr[0];
				player.mahjongValues = arr[2].split(".").splice(0, 13);
				
				players[arr[1]] = player;
			}
			return players;
		}
		
		/**
		 * 开始 
		 * @param content
		 * @param players
		 * @return 
		 * 
		 */
		private function beginGameM(content:Array, players:Array):MahjongMessage{
			var arg:Object = {};
			arg.roomNo = content[0];
			arg.diceNum = content[1];
			arg.roomType = content[2];
			arg.playerAzimuth = getPlayerAzimuth(players);
			arg.playerMahjongValues = getPlayerMahjongValues(players);
			
			return new MahjongMessage(MahjongRoomControl.instance.playVideo, arg);
		}
		
		/**
		 * 结束 
		 * @param content
		 * @param players
		 * @return 
		 * 
		 */
		private function GameOverM(content:Array, players:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerNames = getPlayerNames(players);
			arg.result = [];
			
//			var contents:Array = content[0].split(",");
			var arr:Array;
			var result:Object;
			for each(var str:String in content){
				arr = str.split(":");
				
				if(arr.length == 5){
					result = {};
					result.balanceName = arr[0];
					result.azimuth1 = Number(arr[1]);
					result.azimuth2 = Number(arr[2]);
					result.azimuth3 = Number(arr[3]);
					result.azimuth4 = Number(arr[4]);
					
					arg.result.push(result);
				}
			}
			
			return new MahjongMessage(MahjongRoomControl.instance.endGame, arg);
		}
		
		/**
		 * 定章 
		 * @param content
		 * @return 
		 * 
		 */
		private function dingzhangM(content:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerAzimuthR = content[0];
			arg.dingzhangValue = content[1];
			
			return new MahjongMessage(MahjongRoomControl.instance.dingzhang, arg);
		}
		
		/**
		 * 摸牌 
		 * @param content
		 * @return 
		 * 
		 */
		private function getOneMahjongM(content:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerAzimuthR = content[0];
			arg.getOneMahjongValue = content[1];
			
			return new MahjongMessage(MahjongRoomControl.instance.getOneMahjong, arg);
		}
		
		/**
		 * 打牌 
		 * @param content
		 * @return 
		 * 
		 */
		private function putOneMahjongM(content:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerAzimuthR = content[0];
			arg.putOneMahjongValue = content[1];
			arg.isPutDingzhang = int(content[2]);
			
			return new MahjongMessage(MahjongRoomControl.instance.putOneMahjong, arg);
		}
		
		/**
		 * 碰 
		 * @param content
		 * @return 
		 * 
		 */
		private function pengM(content:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerAzimuthR = content[0];
			arg.pengValue = content[1];
			
			return new MahjongMessage(MahjongRoomControl.instance.peng, arg);
		}
		
		/**
		 * 杠 
		 * @param content
		 * @return 
		 * 
		 */
		private function gangM(content:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerAzimuthR = content[0];
			arg.gangValue = content[1];
			arg.isZigang = int(content[2]);
			
			return new MahjongMessage(MahjongRoomControl.instance.gang, arg);
		}
		
		/**
		 * 胡 
		 * @param content
		 * @return 
		 * 
		 */
		private function huM(content:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerAzimuthR = content[0];
			arg.huValue = content[1];
			arg.huType = content[2];
			arg.isAfterGang = int(content[5]);
			arg.haveHuCount = content[3];
			arg.qiangGangAzimuth = content[4];
			
			return new MahjongMessage(MahjongRoomControl.instance.hu, arg);
		}
		
		/**
		 * 显示请定章 
		 * @param content
		 * @return 
		 * 
		 */
		private function showDingzhangM(content:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerAzimuthR = content[0];
			
			return new MahjongMessage(MahjongRoomControl.instance.showDingzhang, arg);
		}
		
		/**
		 * 显示操作 
		 * @param content
		 * @return 
		 * 
		 */
		private function showOperationM(content:Array):MahjongMessage{
			var arg:Object = {};
			arg.playerAzimuthR = content.shift();
			arg.isPeng = false;
			arg.isGang = false;
			arg.isHu = false;
			arg.isZimo = false;
			arg.isZigang = false;
			for(var i:int = 0; i < content.length; i ++){
				switch(content[i]){
					case "peng":
						arg.isPeng = true;
						break;
					case "gang":
						arg.isGang = true;
						break;
					case "hu":
						arg.isHu = true;
						break;
					case "zihu":
						arg.isHu = true;
						arg.isZimo = true;
						break;
					case "zigang":
						arg.isGang = true;
						arg.isZigang = true;
						break;
				}
			}
			
			return new MahjongMessage(MahjongRoomControl.instance.showOperation, arg);
		}
		
		//----------------------------------------------------------------------------------
		/**
		 * 获取当前玩家的座位号 
		 * @param players
		 * @return 
		 * 
		 */
		private function getPlayerAzimuth(players:Array):int{
			var playerAzimuth:int;
			for(var i:int = 1; i < players.length; i ++){
				if(players[i].playerName == RoomService.instance.userName){
					playerAzimuth = i;
					break;
				}
			}
			return playerAzimuth;
		}
		
		/**
		 * 获取所有玩家的名字 
		 * @param players
		 * @return 
		 * 
		 */
		private function getPlayerNames(players:Array):Array{
			var playerNames:Array = [];
			for(var i:int = 1; i < players.length; i ++){
				playerNames[i - 1] = players[i].playerName;
			}
			return playerNames;
		}
		
		/**
		 * 获取所有玩家初始手牌 
		 * @param players
		 * @return 
		 * 
		 */
		private function getPlayerMahjongValues(players:Array):Array{
			var playerMahjongValues:Array = [];
			for(var i:int = 1; i < players.length; i ++){
				playerMahjongValues[i] = players[i].mahjongValues;
			}
			return playerMahjongValues;
		}
	}
}