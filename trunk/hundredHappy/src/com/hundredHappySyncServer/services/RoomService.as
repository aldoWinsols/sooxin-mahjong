package com.hundredHappySyncServer.services
{
	import com.hundredHappySyncServer.model.Poker;
	import com.hundredHappySyncServer.model.Record;
	import com.hundredHappySyncServer.model.Room;
	import com.hundredHappySyncServer.util.Util;

	public class RoomService
	{
		public var room:Room = null;
		public function RoomService(roomNo:String)
		{
			room = new Room();
			room.roomNo = roomNo;
			shufflePokers(); // 初始化的时候洗牌
//			saveCardArray();
		}
		
		/**
		 * 有用户加入
		 * @param playerService
		 */
		public function enterRoom( playerService:PlayerService):void {
			var subRoomService:SubRoomService = getIdleSubRoomServices();
			// 如果有空闲就直接加，或者就新建一个
			if (subRoomService != null) {
				subRoomService.addPlayerService(playerService);
			} else {
				subRoomService = new SubRoomService();
				subRoomService.roomService = this; // 传递引用
				subRoomService.addPlayerService(playerService);
				room.subRoomServices.push(subRoomService);
			}
		}
		
		/**
		 *  有用户退出
		 * @param client
		 */
		public function exitRoom(playerName:String):Boolean {
			var i:int = 0;
			for (i = 0; i < this.room.subRoomServices.length; i++) {
				if(room.subRoomServices[i].exitRoom(playerName)){
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 洗牌 并 切牌
		 */
		private function shufflePokers():void {
			room.pokers = new Vector.<Poker>();
			var gameNo:String = String(123);
			gameNo = gameNo.substring(3);
			room.gameNo == gameNo;							//累加的牌局数量
			var i:int = 0;
			// g 2011-5-24  17:20  判断庄对和闲对的数量，如果数量过多久重新洗牌， 循环100次，如果100次还不能洗出满意的牌，就取最后一次（不过机率是非常的小的）
			var j:int = 0;
			for(j=0; j<100; j++){
				i = 0;
				for (i = 0; i < 8; i++) { 
					var list:Vector.<Poker> = Util.instance.pokers.concat();
					room.pokers = room.pokers.concat(Util.instance.getRandow(list,true));
				}
				
				// g 2011-5-26  10:32  重新把8副洗好的牌重新洗一次
				Util.instance.getRandow(room.pokers, true);
				
				var random:int = 50 + (Math.random() * 30);				//保存白咭位置
				room.whiteCardNum = random;
				
				i = 0;
				// 切掉多少副牌的数量
				for (i = 0; i < 8; i++) {
					this.room.pokers.splice(0, 1);
				}
				if(!false){
					break; 
				}else{
					room.pokers = new Vector.<Poker>();
				}
			} 
			room.historyRecord = new Vector.<Record>();
			
			var pokersStr:String = "";
			i = 0;
			for (i = 0; i < room.pokers.length; i++) {
				pokersStr += room.pokers[i].sort + room.pokers[i].value + ",";
			}
			// g 2011-6-1  9:23 存储洗牌数组的字符串
			room.shuffleStr = pokersStr;
		}
		
		// g 2011-5-24  17:20  判断庄对和闲对的数量，如果数量过多久重新洗牌
		private function isPokersPairs():Boolean{
			room.historyRecord = new Vector.<Record>();
			var list:Vector.<Poker> = room.pokers.concat();
			var i:int = 0;
			for (i = 0; i < 100; i++) {
//				clear(); // 发牌前先清一到
				room.xPokers.push(list[0]);
				list.splice(0, 1);
				room.zPokers.push(list[0]);
				list.splice(0, 1);
				room.xPokers.push(list[0]);
				list.splice(0, 1);
				room.zPokers.push(list[0]);
				list.splice(0, 1);
				
				computePlayerCountOut();
				
				if(fillPokerRule("x")){
					room.xPokers.push(list[0]);
					list.splice(0, 1);
				}
				if(fillPokerRule("z")){
					room.zPokers.push(list[0]);
					list.splice(0, 1);
				}
				
				calResult(); // 计算结果
				
				if(list.length <= room.whiteCardNum){
					break;
				}
			}
			
			var zdnum:int = 0;
			var xdnum:int = 0;
			i = 0;
			for (i = 0; i < room.historyRecord.length; i++) {
				if(room.historyRecord[i].type == 1){
					xdnum ++;
				}else if(room.historyRecord[i].type == 2){
					zdnum ++;
				}else if(room.historyRecord[i].type == 3){
					zdnum ++;
					xdnum ++;
				}
			}
			
			if(zdnum > 4 || xdnum > 4){
				return true;
			}else{
				return false;
			}
			
		}
		
		public function dealTimer():void {
			room.timers = room.timers - 1;
			
			
			if(room.roomType > 0){			//只有下注状态或者洗牌状态才给玩家发送倒计时
				var i:int = 0;
				for (i = 0; i < this.room.subRoomServices.length; i++) {
					this.room.subRoomServices[i].countDownI(room.timers);
				}
			}
			
//			trace("倒计时 ： " + room.timers);
			
			if(room.roomType == 1){
				GameHallService.instance.sendRoomTimerNum(room.roomNo, room.timers);
			}
			
			if(room.timers <= 5 && room.roomType == 1){
				room.isBetting = false;
				GameHallService.instance.gameHallState(room.roomNo, 0);
			}
			
			if (room.timers <= 0 && room.roomType == 1) {			//下注状态
				dispensePokers(); // 发牌
				var timerNum:int = (room.zPokers.length + room.xPokers.length) * 3;	//根据发了几张牌来计算等待多少秒
				timerNum = timerNum + 10;			//翻完牌后的等待时间
				
				room.timers = timerNum;
				
				room.roomType = 0;
			}
			
			if(room.timers <= 0 && room.roomType == 0){				//无状态
				room.roomType = 1;
				room.timers = room.bettingTimer;
				room.isBetting = true;
				
				if(!checkIsShuffle()){
					gameState();
				}
				
			}else if(room.timers == 8 && room.roomType == 0){
				calResult(); // 计算结果
				gameResult(3);//发送结果
				
//				//2011-5-23  10:49  改变游戏结算后再删除掉线用户的 这段代码的位置
//				removePlayerIsUnline(); //游戏结算后再删除掉线的用户
			}
			
			if(room.timers <= 0 && room.roomType == 2){				//洗牌状态
				room.roomType = 1;
				room.timers = room.bettingTimer;
				room.isBetting = true;
//				saveCardArray();
				gameState();
			}
		}
		/**
		 * 开发发牌
		 */
		private function dispensePokers():void {
			
			clear(); // 发牌前先清一到
			
			this.room.xPokers.push(room.pokers[0]);
			room.pokers.splice(0, 1);
			this.room.zPokers.push(room.pokers[0]);
			room.pokers.splice(0, 1);
			this.room.xPokers.push(room.pokers[0]);
			room.pokers.splice(0, 1);
			this.room.zPokers.push(room.pokers[0]);
			room.pokers.splice(0, 1);
			
			computePlayerCountOut();
			
			if(fillPokerRule(Record.RESULT_XianWin)){
				this.room.xPokers.push(room.pokers[0]);
				room.pokers.splice(0, 1);
			}
			if(fillPokerRule(Record.RESULT_ZhuangWin)){
				this.room.zPokers.push(room.pokers[0]);
				room.pokers.splice(0, 1);
			}
			
			//通知下面发牌
			var i:int = 0;
			for(i=0; i<this.room.subRoomServices.length; i++){
				this.room.subRoomServices[i].dispensePokers(room.xPokers, room.zPokers);
			}
			
		}
		
		/**
		 * 计算结果
		 */
		private function calResult():void {
			
			computePlayerCountOut();
			
			var record:Record = new Record();
			if (room.zNum > room.xNum) {
				record.result = Record.RESULT_ZhuangWin;
			} else if (this.room.zNum < this.room.xNum) {
				record.result = Record.RESULT_XianWin;
			} else {
				record.result = Record.RESULT_ZhuangXianSame;
			}
			//判断是否有庄对或者闲对
			if(room.xPokers[0].value == room.xPokers[1].value && 
				room.zPokers[0].value == room.zPokers[1].value){
				record.type = Record.ZhuangXianPair;
			}else if(room.xPokers[0].value == room.xPokers[1].value){
				record.type = Record.XianPair;
			}else if(room.zPokers[0].value == room.zPokers[1].value){
				record.type = Record.ZhuangPair;
			}
			
//			trace("最后结果：" + record.result);
			this.room.historyRecord.push(record);
		}
		
		/**
		 * 统计玩家的点数
		 */
		private function computePlayerCountOut():void{
			
			var xnum:int = 0;
			var i:int = 0;
			for (i = 0; i < room.xPokers.length; i++) {
				if(room.xPokers[i].value < 10){	// 只查找小于10点一下的牌
					xnum += room.xPokers[i].value;		//然后累加起来
				}
			}
			xnum = xnum % 10;
			
			room.xNum = xnum;		//保存闲家的点数
			
			var znum:int = 0;
			i = 0;
			for (i = 0; i < room.zPokers.length; i++) {
				if(room.zPokers[i].value < 10){// 只查找小于10点一下的牌
					znum += room.zPokers[i].value;//然后累加起来
				}
			}	
			znum = znum % 10;
			room.zNum = znum;//保存庄家的点数
			
		}
		
		/**
		 * 补牌规则
		 */
		private function fillPokerRule(bettype:String):Boolean{
			
			var fillPokerResult:Boolean = true;		//补牌结果
			
			if(bettype == "x"){		//如果是闲家
				if(room.xNum > 5 || room.zNum > 7){		//闲家的总点数大于5点或者庄家的总点数大于7不得补牌
					fillPokerResult = false;
				}else{//否则就要补牌
					fillPokerResult = true;
				}
			}else if(bettype == "z"){	//如果是庄家
				if(room.xPokers.length > 2){		//如果闲家补牌
					var value:int = room.xPokers[room.xPokers.length - 1].value;
					if(room.zNum == 3 && value == 8){//如果两牌合计为3点并且闲家补得的牌为8点庄家不得补牌
						fillPokerResult = false;
					}else if(room.zNum == 4 && (value < 2 || value > 7)){
						fillPokerResult = false;	//如果庄家两牌合计为4点并且闲家补得牌的第三张牌小于2或者大于7，庄家不得补牌
					}else if(room.zNum == 5 && (value < 4 || value > 7)){
						fillPokerResult = false;	//如果庄家两牌合计为5点并且闲家补得牌的第三张牌小于4或者大于7，庄家不得补牌
					}else if(room.zNum == 6 && (value < 6 || value > 7)){
						fillPokerResult = false;	//如果庄家两牌合计为6点并且闲家补得牌的第三张牌小于6或者大于7，庄家不得补牌
					}else if(room.zNum > 6){//庄家两牌合计大于6点，不得补牌
						fillPokerResult = false;
					}else{
						fillPokerResult = true;
					}
				}else{	//如果闲家没有补牌
					if(room.zNum >= 6){		//庄家两牌合计大于等于6点，庄家不得补牌
						fillPokerResult = false;
					}else if(room.xNum > 7){	//闲家两牌合计大于7，庄家不得补牌
						fillPokerResult = false;
					}else{
						fillPokerResult = true;
					}
				}
			}
			
			return fillPokerResult;
		}
		
		/**
		 * 每局结果
		 */
		private function gameResult(sendType:int):void{
			var record:Record = room.historyRecord[room.historyRecord.length - 1];
			
			// g 2011-6-7  14:00 添加每一局的结果到日志文件中 
//			saveHistory(record);
			var i:int = 0;
			if(sendType == 1){
				for (i = 0; i < room.subRoomServices.length; i++) {
					room.subRoomServices[i].gameResult(record);
				}
			}else if(sendType == 2){
				//向大厅发送结果消息
				GameHallService.instance.hallGameResult(room.roomNo, record);
			}else{
				i = 0;
				for (i = 0; i < room.subRoomServices.length; i++) {
					room.subRoomServices[i].gameResult(record);
				}
				//向大厅发送结果消息
				GameHallService.instance.hallGameResult(room.roomNo, record);
			}
			
		}
		/**
		 * 发送房间状态
		 */
		private function gameState():void{
			var i:int = 0;
			for (i = 0; i < room.subRoomServices.length; i++) {
				room.subRoomServices[i].gameState();
			}
			
			GameHallService.instance.gameHallState(room.roomNo, room.roomType);
		}
		
		/**
		 * 发送所有玩家的下注总和
		 */
		public function allPlayerBetting():void{
			var zdT:int = 0;
			var xdT:int = 0;
			var zT:int = 0;
			var xT:int = 0;
			var hT:int = 0;
			
			var len:int = room.subRoomServices.length;
			var i:int = 0;
			for (i = 0; i < len; i++) {
				var subLen:int = room.subRoomServices[i].subRoom.playerServices.length;
				var j:int = 0;
				for (j = 0; j < subLen; j++) {
					var playerService:PlayerService = room.subRoomServices[i].subRoom.playerServices[j];
					zdT += playerService.player.zdT;
					xdT += playerService.player.xdT;
					zT += playerService.player.zT;
					xT += playerService.player.xT;
					hT += playerService.player.hT;
				}
			}
			
			room.totalZdT = zdT;
			room.totalXdT = xdT;
			room.totalZT = zT;
			room.totalXT = xT;
			room.totalHT = hT;
			
			//发送所有玩家下注总和
			var str:String = zdT + "," + xdT + "," + zT + "," + xT + "," + hT;
			i = 0;
			for (i = 0; i < len; i++) {
				room.subRoomServices[i].sendAllPlayerBetting(str);
			}
		}
		
		/**
		 * 发送所有玩家的下注总和(不包括机器人)  g 2011-6-1  11:13
		 */
		private function allPlayerBetting1(playerType:int):String{
			var zdT:int = 0;
			var xdT:int = 0;
			var zT:int = 0;
			var xT:int = 0;
			var hT:int = 0;
			
			var len:int = room.subRoomServices.length;
			var i:int = 0;
			for (i = 0; i < len; i++) {
				var subLen:int = room.subRoomServices[i].subRoom.playerServices.length;
				var j:int = 0;
				for (j = 0; j < subLen; j++) {
					var playerService:PlayerService = room.subRoomServices[i].subRoom.playerServices[j];
//					if(playerService.getClass().getSimpleName().equals("PlayerService")){
						zdT += playerService.player.zdT;
						xdT += playerService.player.xdT;
						zT += playerService.player.zT;
						xT += playerService.player.xT;
						hT += playerService.player.hT;
//					}
				}
			}
			
			//发送所有玩家下注总和
			var content:String = "下注情况 ： 闲  " + xT + ", 庄  " + zT + ",  和  " + hT + ",  闲对   " + xdT + ",  庄对   " + zdT;
			return content;
		}
		
		private function clear():void {
			this.room.zPokers = new Vector.<Poker>();
			this.room.xPokers = new Vector.<Poker>();
			
			this.room.zNum = 0;
			this.room.xNum = 0;
			
			this.room.totalHT = 0;
			this.room.totalXdT = 0;
			this.room.totalXT = 0;
			this.room.totalZdT = 0;
			this.room.totalZT = 0;
		}
		
		/**
		 * 通过用户名获得玩家操作类
		 * @param playerName
		 * @return
		 */
		public function getSubRoomServiceByPlayerName(playerName:String):SubRoomService{
			var subRoomService:SubRoomService = null;
			var i:int = 0;
			for (i = 0; i < room.subRoomServices.length; i++) {
				if(room.subRoomServices[i].getPlayerServiceByPlayerName(playerName) != null){
					subRoomService = room.subRoomServices[i];
					break;
				}
			}
			return subRoomService;
		}
		
		/**
		 * 删除用户
		 * @param playerName
		 * @return
		 */
		public function removeSubRoomServicePlayerName(playerName:String):SubRoomService{
			var subRoomService:SubRoomService = null;
			var i:int = 0;
			for (i = 0; i < room.subRoomServices.length; i++) {
				if(room.subRoomServices[i].getPlayerServiceByPlayerName(playerName) != null){
					subRoomService = room.subRoomServices[i];
					if(subRoomService.subRoom.playerServices.length == 0){
						room.subRoomServices.splice(i, 1);
					}
					break;
				}
			}
			return subRoomService;
		}
		
		/**
		 * 获得有空闲位置的桌子
		 * 
		 * @return
		 */
		public function getIdleSubRoomServices():SubRoomService {
			var subRoomService:SubRoomService = null;
			var i:int = 0;
			for (i = 0; i < room.subRoomServices.length; i++) {
				if (room.subRoomServices[i].subRoom
					.playerServices.length < 7) {
					subRoomService = room.subRoomServices[i];
					break;
				}
			}
			return subRoomService;
		}
		
		/**
		 * 判断是否洗牌
		 */
		private function checkIsShuffle():Boolean{
			if(room.pokers.length <= room.whiteCardNum){			//判断洗牌的位置
				// g 2011-6-1  9:23 本局结束才存储洗牌数组的字符串
				//			log.info("房间   " + room.getRoomNo() + "  洗牌的数组字符串：" + room.getShuffleStr());
				room.roomType = 2;
				room.timers = room.shuffleTimer;
				room.isBetting = false;
				shufflePokers();
				gameState();
				return true;
			}
			return false;
		}
	}
}