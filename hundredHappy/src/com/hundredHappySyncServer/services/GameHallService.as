package com.hundredHappySyncServer.services
{
	import com.hundredHappySyncServer.model.GameHall;
	import com.hundredHappySyncServer.model.Player;
	import com.hundredHappySyncServer.model.Record;
	import com.hundredHappySyncServer.util.Util;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class GameHallService
	{
		public var gameHall:GameHall = null;
		private static var _instance:GameHallService;
		public var timer:Timer = null;
		public function GameHallService()
		{
			gameHall = new GameHall();
			timer = new Timer(1000, 0);
			
			// ---------------------------------------------------------------
			var i:int = 0;
			for (i = 0; i < 4; i++) {
				var roomService:RoomService = new RoomService("00" + (i + 1));
				//			roomService.room.hundredHappDeskDefinition(getHundredHappyDeskDefinitionByName(roomService.getRoom().getRoomNo()));
				//			addRoomService(roomService);
				gameHall.roomServices.push(roomService);
			}
			addAndroidService();
			timer.addEventListener(TimerEvent.TIMER, dealTimer);
			timer.start();
		}
		
		public static function get instance():GameHallService{
			if(_instance == null){
				_instance = new GameHallService();
			}
			return _instance;
		}
		
		public function dealTimer(event:TimerEvent):void{
			
			gameHall.timerNum = gameHall.timerNum + 1;
			
			var i:int = 0;
			for(i = 0; i < gameHall.roomServices.length; i++){
				gameHall.roomServices[i].dealTimer();
			}
		}
		
		/**
		 * 添加机器人
		 * 
		 * */
		private function addAndroidService():void{
			var androidNames:Vector.<String> = Util.instance.getRandomName();
			var i:int = 0;
			for(i=0; i<androidNames.length; i++){
				var androidService:AndroidService = new AndroidService();
				androidService.player.playerName = androidNames[i];
				androidService.player.playerType = Player.ANDROID;
				gameHall.playerServices.push(androidService);
				enterRoom("00"+(int(Math.random()*4)+1), androidNames[i], 10000, 500);
			}
		}
		/**
		 * 玩家初次连接游戏
		 * 
		 * @param playerName
		 * @param iserver
		 */
		public function enterGame(playerName:String):void {
			var playerService:PlayerService = new PlayerService();
			playerService.player.playerName = playerName;
			playerService.player.playerType = Player.ONLINE;
			
			this.gameHall.playerServices.push(playerService);
			playerService.enterGame(); //玩家进入游戏
		}
		
		/**
		 * 退出房间
		 * @param roomNo
		 * @param playerName
		 */
		public function exitRoom(roomNo:String, playerName:String):void {
			var roomService:RoomService = getRoomServiceByRoomNo(roomNo);
			if(roomService != null){
				if(roomService.exitRoom(playerName)){
					var playerService:PlayerService = getPlayerServiceByPlayerName(playerName);
					playerService.player.game = false;
					playerService.exitRoom(playerName);
				}
			}
		}
		
		/**
		 * 删除大厅里面的用户
		 * @param playerName
		 */
		public function removePlayerServiceByPlayerName(playerName:String):void {
			var i:int = 0;
			for(i=0; i<gameHall.playerServices.length; i++){
				if(gameHall.playerServices[i].player.playerName == playerName){
					gameHall.playerServices.splice(i, 1);
					break;
				}
			}
			
		}
		
		/**
		 * 玩家连接发送所有房间的历史记录给玩家
		 * 
		 * @return
		 */
		private var li:Vector.<String> = null;
		public function getRooms():Vector.<String> {
			li = new Vector.<String>();
			var i:int = 0;
			for (i = 0; i < gameHall.roomServices.length; i++) {
				li.push(gameHall.roomServices[i].room.roomNo + ","
					+ gameHall.roomServices[i].room.roomType + ","
					+ Util.instance.changeArrToString(gameHall.roomServices[i].room.historyRecord));
			}
			return li;
		}
		
		/**
		 * 玩家进入台桌
		 * 
		 * @param roomNo
		 * @param playerName
		 */
		public function enterRoom(roomNo:String, playerName:String, maxBetMoney:int, minBetMoney:int):void {
			var playerService:PlayerService = getPlayerServiceByPlayerName(playerName);
			var roomService:RoomService = getRoomServiceByRoomNo(roomNo);
				
			if(roomService != null && playerService != null){
				var max:int = maxBetMoney;
				var min:int = minBetMoney;
//				if(playerService.checkLimitIsBeing(max, min)){		//检测玩家选择上限和下限在数据库是否存在
					roomService.enterRoom(playerService);
//				}
			}
			
		}
		
		/**
		 * 更换台桌
		 * @param roomNo		当前所在的台桌
		 * @param playerName	用户名
		 * @param changeRoomNo	要更换的台桌
		 */
		public function changeRoom(roomNo:String, playerName:String, changeRoomNo:String):void {
			var playerService:PlayerService = getPlayerServiceByPlayerName(playerName);
			
			var roomService:RoomService = getRoomServiceByRoomNo(roomNo);
			if(roomService.exitRoom(playerName)){
				roomService = getRoomServiceByRoomNo(changeRoomNo);
				playerService.exitRoom(playerName);
				playerService.player.game = false;
				if(roomService != null){
					roomService.enterRoom(playerService);
				}
			}
			
		}
		
		/**
		 * 根据用户名查找用户
		 * 
		 * @return
		 */
		private function getPlayerServiceByPlayerName(playerName:String):PlayerService {
			
			var playerService:PlayerService = null;
			var i:int = 0;
			for (i = 0; i < gameHall.playerServices.length; i++) {
				if (gameHall.playerServices[i].player.playerName == playerName) {
					playerService = gameHall.playerServices[i];
					break;
				}
			}
			
			return playerService;
			
		}
		
		/**
		 * 玩家更新下注
		 * @param playerName
		 * @param betTypeContent
		 */
		public function updatePlayerBet(roomNo:String, playerName:String, zdT:int, xdT:int, zT:int, xT:int, hT:int):void {
			
			var roomService:RoomService = getRoomServiceByRoomNo(roomNo);
			if(roomService != null){
				if(roomService.room.roomType == 1){			//只有房间为下注状态才能下注
					var subRoomService:SubRoomService = roomService.getSubRoomServiceByPlayerName(playerName);
					if(subRoomService != null){
						subRoomService.playerBetting(playerName, zdT, xdT, zT, xT, hT);
					}
					roomService.allPlayerBetting();
				}
			}
		}
		
		/**
		 * 根据房间编号获得房间
		 * 
		 * @param roomNo
		 * @return
		 */
		public function getRoomServiceByRoomNo(roomNo:String):RoomService{
			var roomService:RoomService = null;
			var i:int = 0;
			for (i = 0; i < gameHall.roomServices.length; i++) {
				if (gameHall.roomServices[i].room.roomNo == roomNo) {
					roomService = gameHall.roomServices[i];
					break;
				}
			}
			
			return roomService;
		}
		
		public function sendRoomTimerNum(roomNo:String, timer:int):void{
			var i:int = 0;
			for (i = 0; i < gameHall.playerServices.length; i++) {
				gameHall.playerServices[i].roomTimer(roomNo, timer);
			}
		}
		
		public function hallGameResult(roomNo:String, record:Record):void{
			var i:int = 0;
			for (i = 0; i < gameHall.playerServices.length; i++) {
				if(gameHall.playerServices[i].player.playerType == Player.ONLINE){
					this.gameHall.playerServices[i].hallGameResult(roomNo, record);
				}
			}
		}
		
		/**
		 * 房间洗牌发送给所有用户
		 * @param roomNo	房间编号
		 * @param type		0：不在洗牌中  1： 在洗牌中
		 */
		public function gameHallState(roomNo:String, type:int):void{
			var i:int = 0;
			for (i = 0; i < gameHall.playerServices.length; i++) {
				if(gameHall.playerServices[i].player.playerType == Player.ONLINE){
					this.gameHall.playerServices[i].gameHallState(roomNo, type);
				}
			}
		}
	}
}