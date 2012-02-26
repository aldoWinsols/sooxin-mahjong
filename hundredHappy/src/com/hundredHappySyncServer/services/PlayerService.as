package com.hundredHappySyncServer.services
{
	import com.amusement.HundredHappy.services.MessageService;
	import com.hundredHappySyncServer.model.Player;
	import com.hundredHappySyncServer.model.Poker;
	import com.hundredHappySyncServer.model.Record;
	import com.hundredHappySyncServer.util.Util;
	
	import flash.net.dns.AAAARecord;

	public class PlayerService
	{
		public var subRoomService:SubRoomService;
		public var player:Player;
		public function PlayerService()
		{
			player = new Player();
		}
		
		/**
		 * 更新投住
		 * @param zdT
		 * @param xdT
		 * @param zT
		 * @param xT
		 * @param hT
		 */
		public function updateBetting(zdT:int, xdT:int, zT:int, xT:int, hT:int):void{
			this.player.zdT += zdT;
			this.player.xdT += xdT;
			this.player.zT += zT;
			this.player.xT += xT;
			this.player.hT += hT;
			var allBetValue:int = player.zdT + player.xdT + player.zT + player.xT + player.hT;
			var allValue:int = zdT + xdT + zT + xT + hT;
//			GameHallService.instance.getRemoteService().getUserService().deductMoney(player.getPlayerName(), allValue);
			player.betMoney = allBetValue;
			player.haveMoney = player.haveMoney - allValue;
		}
		
		/**
		 * 检测玩家下注的金额是否超过规定的下注金额
		 * @param zdT
		 * @param xdT
		 * @param zT
		 * @param xT
		 * @param hT
		 * @return
		 */
		public function checkBetMoney(zdT:int, xdT:int, zT:int, xT:int, hT:int):Boolean{
			var bool:Boolean = true;
			var haveZdt:int = player.zdT + zdT;
			var haveXdt:int = player.xdT + xdT;
			var havezt:int = player.zT + zT;
			var havext:int = player.xT + xT;
			var haveht:int = player.hT + hT;
			
			var SumNum:int = zdT + xdT + zT + xT + hT;
			
			return bool;
		}
		
		/**
		 * 清除下注金额
		 */
		public function clearBetting():void{
			this.player.zdT = 0;
			this.player.xdT = 0;
			this.player.zT = 0;
			this.player.xT = 0;
			this.player.hT = 0;
			this.player.betMoney = 0;
		}
		
		/** 
		 * 获得投住的String
		 * @return
		 */
		public function getBettingToString():String{
			return player.playerName + "," + player.zdT + "," + player.xdT + "," + player.zT + "," + player.xT + "," + player.hT + "," + player.haveMoney;
		}
		
		/**
		 * 开局结算
		 * @param record
		 */
		public function settlement(record:Record):void{
			var notZhuangMoney:Number = 0;		//非下注庄输赢金额
			var zhuangMoney:Number = 0;			//下注庄输赢金额
			var resultStr:String = "";
			resultStr += "闲牌： ";
			var i:int = 0;
			for (i = 0; i < subRoomService.roomService.room.xPokers.length; i++) {
				// g 2011-5-26  10:31  添加的牌的花色
				resultStr += subRoomService.roomService.room.xPokers[i].sort + 
					subRoomService.roomService.room.xPokers[i].value + ",";
			}
			
			resultStr += "庄牌： ";
			i = 0;
			for (i = 0; i < subRoomService.roomService.room.zPokers.length; i++) {
				// g 2011-5-26  10:31  添加的牌的花色
				resultStr += subRoomService.roomService.room.zPokers[i].sort + 
					subRoomService.roomService.room.zPokers[i].value + ",";
			}
			
			if(record.result == "x"){			//结果   “闲”
				resultStr += "开局结果：闲";
				notZhuangMoney += player.xT;
				zhuangMoney = -player.zT;
				notZhuangMoney -= player.hT;
			}else if(record.result == "z"){	//结果   “庄”
				resultStr += "开局结果：庄";
				zhuangMoney = player.zT;
				notZhuangMoney -= player.xT;
				notZhuangMoney -= player.hT;
			}else{										//结果  “和”
				resultStr += "开局结果：和";
				notZhuangMoney += player.hT * 7;
			}
			
			if(record.type == 1){					//结果   “闲对”
				resultStr += ", 闲对";
				notZhuangMoney += player.xdT * 10;
				notZhuangMoney -= player.zdT;
			}else if(record.type == 2){			//结果   “庄对”
				resultStr += ", 庄对";
				notZhuangMoney += player.zdT * 10;
				notZhuangMoney -= player.xdT;
			}else if(record.type == 3){			//结果    “闲对、庄对”
				resultStr += ", 闲对, 庄对";
				notZhuangMoney += player.xdT * 10;
				notZhuangMoney += player.zdT * 10;
			}else{										//结果    “无”
				notZhuangMoney -= player.xdT;
				notZhuangMoney -= player.zdT;
			}
			var content:String = "下注情况 ： 闲  " + player.xT + ", 庄  " + player.zT + ",  和  " + player.hT
				+ ",  闲对   " + player.xdT + ",  庄对   " + player.zdT;
			
			resultStr += ", " + content;
			balance(zhuangMoney, notZhuangMoney);
			clearBetting();
		}
		
		private function balance(zhuangMoney:Number, notZhuangMoney:Number):void{
			player.winOrlose = 0;
			if(zhuangMoney > 0){
				zhuangMoney = zhuangMoney * 0.95;
				player.winOrlose = zhuangMoney - notZhuangMoney;
			}else{
				player.winOrlose = notZhuangMoney + zhuangMoney;
			}
			player.haveMoney += player.betMoney;
			player.haveMoney += player.winOrlose;
		}
		
		/**
		 * 连接游戏
		 */
		public function enterGame():void{
//			sendPlayerLimits();
			if(Player.ANDROID){
				return;
			}
			MessageService.instance.enterGameI(GameHallService.instance.getRooms());
		}
		
		/**
		 * 发送玩家限制信息
		 */
		private function sendPlayerLimits():void{
//			message.setHead("playerLimitI");
//			message.setContent(player.getChipGroupItems());
//			MessageService.instance.send(player.getIserver(), message);
			
		}
		
		/**
		 * 退出游戏
		 * @param str
		 */
		public function exitGame(str:String):void{
		}
		
		/**
		 * 退出房间
		 * @param str
		 */
		public function exitRoom(str:String):void{
			MessageService.instance.exitRoomI(str);
		}
		
		/**
		 * 进入房间显示历史记录
		 * @param history
		 */
		public function enterRoom(players:Vector.<String>, historys:Vector.<Record>, deskNo:String, gameNo:String, state:int, limitHong:Number, max:Number, min:Number, valuesStr:String):void{
			MessageService.instance.enterRoomI(players, historys, deskNo, gameNo, state, limitHong, max, min, valuesStr);
		}
		
		/**
		 * 发牌
		 * @param xPokers
		 * @param zPokers
		 */
		public function dispensePokers(xPokers:Vector.<Poker>, zPokers:Vector.<Poker>):void{
			MessageService.instance.dispensePokersI(Util.instance.changePokersToString(xPokers)+";"+Util.instance.changePokersToString(zPokers));
		}

		/**
		 * 房间洗牌发送给所有用户
		 * @param roomNo	房间编号
		 * @param type		0：不在洗牌中  1:下注状态  2： 在洗牌中
		 */
		public function gameHallState(roomNo:String, type:int):void{
			MessageService.instance.gameHallStateI(roomNo + "," + type);
		}
	
		/**
		 * 发送当局结果到客户端
		 * @param record
		 */
		public function gameResult(record:Record):void{
			settlement(record);
		}

		/**
		 * 发送输赢结果   g 2011-5-24 13:58
		 */
		public function sendGameResult(record:Record):void{
			var list:Vector.<Object> = new Vector.<Object>();
			var nextGameNo:String = subRoomService.roomService.room.gameNo + "-" 
				+ (subRoomService.roomService.room.historyRecord.length + 1);
			MessageService.instance.gameResultI(record.result,record.type, subRoomService.getAllPlayerMoney(),nextGameNo, player.winOrlose);
		}
	
		/**
		 * 发送大厅所有桌子的历史记录到客户端 
		 * @param roomNo
		 * @param res
		 */
		public function hallGameResult(roomNo:String, record:Record):void{
			MessageService.instance.hallGameResultI(roomNo+","+record.result + "," + record.type);
		}

		/**
		 * 第一次进来的时候初始化其他玩家
		 * @param arr
		 */
		public function initPlayers(arr:Vector.<String>):void{
//			message.setHead("initPlayersI");
//			message.setContent(arr);
//			MessageService.instance.send(player.getIserver(), message);
		}

		/**
		 * 清除所有数据
		 */
		public function clearAllData():void{
			clearBetting();
			player.authz = 0;
			player.game = false;
		}

		public function countDown(num:int):void{ 
			MessageService.instance.countDownI(num);
		}

		/**
		 * 发送房间
		 * @param timer
		 */
		public function roomTimer( roomNo:String, timer:int):void{
			MessageService.instance.gameHallCountdownI(roomNo + "," + timer);
		}
	}
}