package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.DeskPanelControl;
	import com.amusement.HundredHappy.control.GameHallPanelControl;
	import com.hundredHappySyncServer.model.Record;
	import com.hundredHappySyncServer.services.GameHallService;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	

	public class MessageService
	{
		private static var _instance:MessageService=null;
		
		private var _conn:NetConnection;
		
		public function MessageService()
		{
		}
		
		public static function get instance():MessageService
		{
			if(_instance == null){
				_instance = new MessageService();
			}
			return _instance;
		}
		
		public function serverExcpetion(obj:Object):void{
			var content:String = obj.content;
			
			HundredHappySyncService.instance.closeConn();
//			DeskPanelService.instance.playerExitRoom(PlayerService.instance.player.acctName);
		}
		//----------------------------------------------------------------------------------------------
		/**
		 * 进入大厅
		 * @param obj
		 * 
		 */
		public function enterGameI(obj:Object):void{
			GameHallPanelService.instance.initRoom(obj as Vector.<String>);
		}
		
		/**
		 * 退出大厅
		 * @param obj
		 * 
		 */
		public function exitGameI(obj:Object):void{
			
		}
		
		/**
		 * 大厅显示当前游戏结果 
		 * @param obj
		 * 
		 */
		public function hallGameResultI(content:String):void{
			var contents:Array = content.split(",");
			
			GameHallPanelService.instance.addHistoryByRoom(contents[0], contents[1], contents[2]);
		}
		
		/**
		 * 大厅显示房间状态
		 * @param obj
		 * 
		 */
		public function gameHallStateI(content:String):void{
			var contents:Array = content.split(",");
			
			GameHallPanelService.instance.updateStateByRoom(contents[1], contents[0]);
		}
		
		/**
		 * 大厅房间倒计时 
		 * @param obj
		 * 
		 */
		public function gameHallCountdownI(obj:Object):void{
			var content:String = obj as String;
			var contents:Array = content.split(",");
			
			GameHallPanelService.instance.updateCountdownByRoom(contents[1], contents[0]);
		}
		
		/**
		 * 玩家进入房间 
		 * @param obj
		 * 
		 */
		public function enterRoomI(players:Vector.<String>, historys:Vector.<Record>, deskNo:String, gameNo:String, state:int, limitHong:Number, max:Number, min:Number, valuesStr:String):void{
//			var content:Array = obj as Array;
			GameHallPanelService.instance.resetRoom();
			DeskPanelService.instance.initRoom(players, historys, deskNo, gameNo, state, limitHong, max, min, valuesStr);
		}
		
		/**
		 * 其他玩家加入房间
		 * @param obj
		 * 
		 */
		public function playerAddRoomI(obj:Object):void{
			var content:String = obj.content;
			var contents:Array = content.split(",");
			DeskPanelService.instance.playerEnterRoom(contents[1], contents[0], contents[2]);
		}
		
		/**
		 * 玩家退出房间
		 * @param obj
		 * 
		 */
		public function exitRoomI(content:String):void{
			DeskPanelService.instance.playerExitRoom(content);
		}
		
		/**
		 * 房间倒计时
		 * */
		public function countDownI(obj:Object):void{
			DeskPanelService.instance.updateCountDownV(int(obj));
		}
		
		
		/**
		 * 房间状态 
		 * @param obj
		 * 
		 */
		public function stateI(content:int):void{
			DeskPanelService.instance.updateDeskState(content);
		}
		
		//显示阻止结果
		public function showDeterResultI(obj:Object):void{
			var content:String = obj.content;
			DeskPanelService.instance.showDeterInfo(content);
		}
		
		/**
		 * 显示牌
		 * */
		public function dispensePokersI(obj:Object):void{
			var content:String = obj as String;
			var pokers:Array = content.split(";");
			var xPokers:Array = String(pokers[0]).split(",");
			xPokers.pop();
			var zPokers:Array = String(pokers[1]).split(",");
			zPokers.pop();
			DeskPanelService.instance.showPokers(zPokers, xPokers);
		}
		
		/**
		 * 当局游戏结果
		 * @param obj
		 * 
		 */
		public function gameResultI(result:String, type:int, arr:Vector.<String>, nextGameNo:String, value:Number):void{
			DeskPanelService.instance.gameResult(result, type, arr, nextGameNo, value);
//			DeskPanelService.instance.setGameResult(content[0].result, content[0].type, content[1], content[2]);
		}
		
		/**
		 * 玩家投注返回 
		 * @param obj
		 * 
		 */
		public function playerBettingI(content:String):void{
			var contents:Array = content.split(",");
			
			DeskPanelService.instance.updateTouzhuByPlayerName(contents[0], contents[1], contents[2], contents[3], contents[4], contents[5], contents[6]);
		}
		
		public function allPlayerBettingI(content:String):void{
			var contents:Array = content.split(",");
			
			DeskPanelService.instance.updateRealtimePot(contents[2], contents[3], contents[4], contents[0], contents[1]);
		}

		//-----------------------------------------------------------------------------------------------
		//玩家选择房间调用后台服务
		public function enterRoom(roomNo:String):void{
			GameHallService.instance.enterRoom(roomNo, "g0003", 0, 0);
		}

		//退出台桌
		public function exitRoom():void{
//			_conn.call("exitRoom", new Responder(onOneMsgResult, onOneMsgStatus), DeskPanelService.instance.deskNo, "g0003");
			GameHallService.instance.exitRoom(DeskPanelService.instance.deskNo, "g0003");
		}
		
		//玩家下注调用后台服务
		public function updatePlayerBet(zhuangduiT:Number, xianduiT:Number, zhuangT:Number, xianT:Number, heT:Number):void
		{
			GameHallService.instance.updatePlayerBet(DeskPanelService.instance.deskNo, "g0003", zhuangduiT, xianduiT, zhuangT, xianT, heT);
		}
		
		//转台
		public function changeRoom(changeRoomNo:String):void{
//			_conn.call("changeRoom", new Responder(onOneMsgResult, onOneMsgStatus), DeskPanelService.instance.deskNo, "g0003", changeRoomNo);
			GameHallService.instance.changeRoom(DeskPanelService.instance.deskNo, "g0003", changeRoomNo);
		}
		
		//---------------------------------------------------------
		private function onOneMsgResult(obj:Object):void{
			trace("one_result:" + obj);
		}

		private function onOneMsgStatus(obj:Object):void{
			trace("one_status:" + obj);
		}
		
		//----------------------------------------------------------
		public function set conn(value:NetConnection):void
		{
			this._conn = value;
		}
	}
}