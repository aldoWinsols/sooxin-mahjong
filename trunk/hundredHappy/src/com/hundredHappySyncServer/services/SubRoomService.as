package com.hundredHappySyncServer.services
{
	import com.amusement.HundredHappy.services.MessageService;
	import com.hundredHappySyncServer.model.Player;
	import com.hundredHappySyncServer.model.Poker;
	import com.hundredHappySyncServer.model.Record;
	import com.hundredHappySyncServer.model.SubRoom;

	public class SubRoomService
	{
		public var roomService:RoomService = null;
		public var subRoom:SubRoom = null;
		public function SubRoomService()
		{
			subRoom = new SubRoom();
		}
		/**
		 * 添加玩家
		 * @param playerService
		 */
		public function addPlayerService(playerService:PlayerService):void{
			if(playerService.player.playerType == Player.ANDROID){
				this.subRoom.playerServices.push(playerService);
				playerService.subRoomService = this; 
				
				playerService.player.authz = getSeatNum(); // 获得方位

				playerService.player.game = true;
				return;
			}
			var lastPlayerService:PlayerService = getPlayerServiceByPlayerName(playerService.player.playerName);

			if(playerService.player.game){
				return;
			}
			
			if(lastPlayerService == null){
			
				this.subRoom.playerServices.push(playerService);
				playerService.subRoomService = this; 
				playerService.player.authz = getSeatNum(); // 获得方位
				
				playerService.player.game = true;
				var type:int = roomService.room.timers <= 5 && roomService.room.roomType == 1 ? 0 : roomService.room.roomType; 
				var gameNo:String = new Date().time.toString();
				playerService.enterRoom(getAllPlayerInfo(), roomService.room.historyRecord, roomService.room.roomNo,gameNo , 
					type, 100000, 5, 20000000, "100,200,500,1000,10000,");
				
				roomService.allPlayerBetting();
			}
			
		}
		
		/**
		 * 发送洗牌消息给房间玩家
		 */
		public function gameState():void{
			var i:int = 0;
			for (i = 0; i < subRoom.playerServices.length; i++) {
				if(subRoom.playerServices[i].player.playerType == Player.ONLINE){
					MessageService.instance.stateI(roomService.room.roomType);
					break;
				}
			}
		}
		/**
		 * 清楚房间所有用户的下注金额
		 */
		private function clearAllPlayerBetting():void{
			var i:int = 0;
			for (i = 0; i < subRoom.playerServices.length; i++) {
				subRoom.playerServices[i].clearBetting();
			}
		}
		/**
		 * 退出房间
		 * @param playerName
		 * @return
		 */
		public function exitRoom(playerName:String):Boolean{
			var bool:Boolean = false;
			var isOnlinePlayer:Boolean = false;
			var playername:String = "";
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(subRoom.playerServices[i].player.playerName == playerName){
					subRoom.playerServices[i].clearAllData();
					playername = subRoom.playerServices[i].player.playerName;

//					//删除玩家
					this.subRoom.playerServices.splice(i, 1);;
					break;
				}
				if(subRoom.playerServices[i].player.playerType == Player.ONLINE){
					isOnlinePlayer = true;
				}
			}
			
			if(!playername == ""){
				bool = true;
				if(isOnlinePlayer){				
					MessageService.instance.exitRoomI(playername);
				}
			}
			
			return bool;
			
		}
		/**
		 * 发送所有玩家下注情况
		 * @param str
		 */
		public function sendAllPlayerBetting(str:String):void{
			var isOnlinePlayer:Boolean = false;
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(subRoom.playerServices[i].player.playerType == Player.ONLINE){
					isOnlinePlayer = true;
					break;
				}
			}
			if(isOnlinePlayer){			
				MessageService.instance.allPlayerBettingI(str);
			}
		}
		
		/**
		 * 玩家下注
		 * @param playerName 				用户名
		 * @param zdT		庄对
		 * @param xdT		闲对
		 * @param zT 		庄
		 * @param xT 		闲
		 * @param hT 		和
		 */
		public function playerBetting(playerName:String,zdT:int, xdT:int, zT:int, xT:int, hT:int):void{

			var bool:Boolean = false;
			var isOnlinePlayer:Boolean = false;
			var i:int = 0;
			var betting:String = "";
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(subRoom.playerServices[i].player.playerName == playerName && 
					subRoom.playerServices[i].checkBetMoney(zdT, xdT, zT, xT, hT)){
					subRoom.playerServices[i].updateBetting(zdT, xdT, zT, xT, hT);
					betting = subRoom.playerServices[i].getBettingToString();
					bool = true;
				}
				if(subRoom.playerServices[i].player.playerType == Player.ONLINE){
					isOnlinePlayer = true;
				}
			}
			if(bool){
				if(isOnlinePlayer){				
					MessageService.instance.playerBettingI(betting);
				}
			}
		}
		
		/**
		 * 获得所有玩家的名字和剩下金额组合字符串
		 * @return
		 */
		public function getAllPlayerMoney():Vector.<String>{
			var list:Vector.<String> = new Vector.<String>();
			var i:int = 0;
			for (i = 0; i < subRoom.playerServices.length; i++) {
				list.push(subRoom.playerServices[i].player.playerName + "," 
					+ subRoom.playerServices[i].player.haveMoney);
			}
			return list;
		}
		/**
		 * 获得所有玩家信息
		 * @return
		 */
		public function getAllPlayerInfo():Vector.<String>{
			var list:Vector.<String> = new Vector.<String>();
			var i:int = 0;
			for (i = 0; i < subRoom.playerServices.length; i++) {
				list.push(subRoom.playerServices[i].player.playerName + "," 
					+ subRoom.playerServices[i].player.authz + ","
					+ subRoom.playerServices[i].player.haveMoney + ","
					+ subRoom.playerServices[i].player.zdT + ","
					+ subRoom.playerServices[i].player.xdT + ","
					+ subRoom.playerServices[i].player.zT + ","
					+ subRoom.playerServices[i].player.xT + ","
					+ subRoom.playerServices[i].player.hT);
			}
			return list;
		}
		/**
		 * 获得座位号
		 * @return
		 */
		private function getSeatNum():int{
			var seatNum:int = 0;
			var i:int = 0;
			for (i = 0; i < 7; i++) {
				for (var j:int = 0; j < subRoom.playerServices.length; j++) {
					if(subRoom.playerServices[j].player.authz != (i+1)){
						seatNum = i + 1;
					}else{
						seatNum = 0;
						break;
					}
				}
				if(seatNum != 0){
					break;
				}
			}
			return seatNum;
		}
		
		/**
		 * 发牌
		 * @param xPokers
		 * @param zPokers
		 */
		public function dispensePokers(xPokers:Vector.<Poker>, zPokers:Vector.<Poker>):void{
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(this.subRoom.playerServices[i].player.playerType == Player.ONLINE){
					this.subRoom.playerServices[i].dispensePokers(xPokers,zPokers);
				}
			}
			
		}
		
		/**
		 * 游戏结果
		 * @param record
		 */
		public function gameResult(record:Record):void{
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				this.subRoom.playerServices[i].gameResult(record);
			}
			i = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(this.subRoom.playerServices[i].player.playerType == Player.ONLINE){
					this.subRoom.playerServices[i].sendGameResult(record);
				}
			}
		}
		
		/**
		 * 通过用户名获得用户操作类
		 * @param playerName
		 * @return
		 */
		public function getPlayerServiceByPlayerName(playerName:String):PlayerService{
			var playerService:PlayerService = null;
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(subRoom.playerServices[i].player.playerName == playerName){
					playerService = subRoom.playerServices[i];
					break;
				}
			}
			
			return playerService;
		}
		/**
		 * 删除用户
		 * @param playerName
		 * @return
		 */
		public function removePlayerServiceByPlayerName(playerName:String):PlayerService{
			var playerService:PlayerService = null;
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(subRoom.playerServices[i].player.playerName == playerName){
					playerService = subRoom.playerServices[i];
					subRoom.playerServices.splice(i, 1);
					break;
				}
			}
			
			return playerService;
		}
		
		public function countDownI(num:int):void{
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
//				if(this.subRoom.playerServices[i].player.playerType == Player.ONLINE){
					subRoom.playerServices[i].countDown(num);
//				}
			}
		}
	}
}