package com.hundredHappySyncServer.services
{
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
//			if(playerService.getClass().getSimpleName().equals("AndroidService")){
				this.subRoom.playerServices.push(playerService);
				playerService.subRoomService = this; 
				
				playerService.player.authz = getSeatNum(); // 获得方位
				//----------------------------------------------------
//				addObserver(playerService);
				//-----------------------------------------------------
				playerService.player().game = true;
				
				
				playerAddRoomI(playerService);
				
				return;
//			}
			var lastPlayerService:PlayerService = getPlayerServiceByPlayerName(playerService.player.playerName);
			//		if(lastPlayerService != null){
			//			lastPlayerService.player.setIserver(playerService.player.getIserver());
			//			lastPlayerService.player.setChipGroupItems(playerService.player.getChipGroupItems());
			//			playerService = lastPlayerService;
			//		}else{
			//			this.subRoom.getPlayerServices().add(playerService);
			//			playerService.setSubRoomService(this);
			//			playerService.player.setAuthz(this.getSeatNum()); // 获得方位
			//			//----------------------------------------------------
			//			addObserver(playerService);
			//			//-----------------------------------------------------
			//		}
			if(playerService.player().game){
				return;
			}
			
			if(lastPlayerService == null){
			
				this.subRoom.playerServices.push(playerService);
				playerService.subRoomService = this; 
				playerService.player().haveMoney = 10000;
				playerService.player().authz = this.getSeatNum(); // 获得方位
				//----------------------------------------------------
//				addObserver(playerService);
				//-----------------------------------------------------
				playerService.player().game = true;
//				ArrayList<Object> list = new ArrayList<Object>();
//				list.add(getAllPlayerInfo());		//当前所有玩家信息
//				list.add(roomService.getRoom().getHistoryRecord());		//当前台桌的历史记录
//				list.add(roomService.getRoom().getRoomNo());	//房间编号
//				list.add(roomService.getRoom().getGameNo() + "-" + (roomService.getRoom().getHistoryRecord().size() + 1));//房间局号
//				// 2011-5-19 11:01 如果房间倒计时小于5并且当前状态是可下注状态就改为0（不可下注状态），否则就是正常的
//				int type = roomService.getRoom().getTimers() <= 5 && roomService.getRoom().getRoomType() == 1 ? 0 : roomService.getRoom().getRoomType(); 
//				list.add(type);	//房间类型
//				list.add(playerService.player.getChipGroupItem().getUperLimit());	//玩家上限
//				list.add(playerService.player.getChipGroupItem().getLowerLimit());	//和下限
//				list.add(roomService.getRoom().getHundredHappDeskDefinition().getMaxZhuangXianMoney());	//当前台桌的限红
//				list.add(playerService.player.getChipGroupItem().getChips());			//玩家有多少筹码
//				playerService.enterRoom(list);
//				
//				playerAddRoomI(playerService);
				
				// g 2011-6-23 10:20  玩家进入游戏，发送当前房间的所有玩家的下注情况到客户端
//				roomService.allPlayerBetting();
			}
			
		}
		
		/**
		 * 发送洗牌消息给房间玩家
		 */
		public function gameState():void{
//			message.setHead("stateI");
//			message.setContent(roomService.getRoom().getRoomType());
//			if(roomService.getRoom().getRoomType() == 1){	//如果是1 ，那么表示可以下注，就清楚当前所有用户上一次的下注情况
//				clearAllPlayerBetting();
//			}
//			setChanged();
//			notifyObservers(message);
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
			var playername:String = "";
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(subRoom.playerServices[i].player.layerName == playerName){
					if(subRoom.playerServices[i].checkIsBetting()){
						subRoom.playerServices[i].clearAllData();
						playername = subRoom.playerServices[i].player.playerName;
//						GameHallService.getInstance().getRemoteService().getUserService().enterGame(playername, OnlineStatus.OFF_LINE);
						//删除观察者
//						this.deleteObserver(subRoom.playerServices[i]);
//						//删除玩家
//						this.subRoom.getPlayerServices().remove(i);
						
					}else{
						//发送阻止消息， “你已经下注，不能退出”
						subRoom.playerServices[i].showDeterResult("你已经下注，不能退出");
					}
					
				}
			}
			
			if(!playername == ""){
				bool = true;
				
				//------------------------------------------------------
				
//				message.setHead("exitRoomI");
//				message.setContent(playerName);
//				
//				setChanged();
//				notifyObservers(message);
			}
			
			return bool;
			
		}
		/**
		 * 发送所有玩家下注情况
		 * @param str
		 */
		public function sendAllPlayerBetting(str:String):void{
//			message.setHead("allPlayerBettingI");
//			message.setContent(str);
//			setChanged();
//			notifyObservers(message);
		}
		
//		/**
//		 * 当新用户进来的时候初始化当前桌子其他玩家情况
//		 */
//		public void initPlayers(){
//			//组合数据
//			ArrayList<String> arr = new ArrayList<String>();
//			for(int i=0; i<this.subRoom.getPlayerServices().size(); i++){
//				arr.add(subRoom.playerServices[i].getBettingToString());
//			}
//			
//			//发送数据
//			for(int i=0; i<this.subRoom.getPlayerServices().size(); i++){
//				subRoom.playerServices[i].initPlayers(arr);
//			}
//		}
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
//			message.setHead("playerBettingI");
			var bool:Boolean = false;
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				if(subRoom.playerServices[i].player.playerName == playerName && 
					subRoom.playerServices[i].checkBetMoney(zdT, xdT, zT, xT, hT)){
					subRoom.playerServices[i].updateBetting(zdT, xdT, zT, xT, hT);
//					message.setContent(subRoom.playerServices[i].getBettingToString());
					bool = true;
				}
			}
			if(bool){
//				setChanged();
//				notifyObservers(message);
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
				this.subRoom.playerServices[i].dispensePokers(xPokers,zPokers);
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
				this.subRoom.playerServices[i].sendGameResult(record);
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
				if(subRoom.playerServices[i].player.playerName == (playerName){
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
				if(subRoom.playerServices[i].player.playerName == (playerName){
					playerService = subRoom.playerServices[i];
					subRoom.playerServices.splice(i, 1);
					break;
				}
			}
			
			return playerService;
		}
		
		public function countDownI(num:int){
			var i:int = 0;
			for(i=0; i<this.subRoom.playerServices.length; i++){
				subRoom.playerServices[i].countDown(num);
			}
		}
	}
}