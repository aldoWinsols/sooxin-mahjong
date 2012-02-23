package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.DeskPanelControl;
	import com.amusement.HundredHappy.control.GameHallPanelControl;
	import com.service.PlayerService;
	
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.controls.Alert;

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
			
			Alert.show(content);
			HundredHappySyncService.instance.closeConn();
			DeskPanelService.instance.playerExitRoom(PlayerService.instance.player.acctName);
		}
		//----------------------------------------------------------------------------------------------
		/**
		 * 进入大厅
		 * @param obj
		 * 
		 */
		public function enterGameI(obj:Object):void{
			var content:Array = obj.content;
			GameHallPanelService.instance.initRoom(content);
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
		public function hallGameResultI(obj:Object):void{
			var content:String = obj.content;
			var contents:Array = content.split(",");
			
			GameHallPanelService.instance.addHistoryByRoom(contents[0], contents[1], contents[2]);
		}
		
		/**
		 * 大厅显示房间状态
		 * @param obj
		 * 
		 */
		public function gameHallStateI(obj:Object):void{
			var content:String = obj.content;
			var contents:Array = content.split(",");
			
			GameHallPanelService.instance.updateStateByRoom(contents[1], contents[0]);
		}
		
		/**
		 * 大厅房间倒计时 
		 * @param obj
		 * 
		 */
		public function gameHallCountdownI(obj:Object):void{
			var content:String = obj.content;
			var contents:Array = content.split(",");
			
			GameHallPanelService.instance.updateCountdownByRoom(contents[1], contents[0]);
		}
		
		/**
		 * 玩家进入房间 
		 * @param obj
		 * 
		 */
		public function enterRoomI(obj:Object):void{
			var content:Array = obj.content;
			GameHallPanelService.instance.resetRoom();
			DeskPanelService.instance.initRoom(content[0], content[1], content[2], content[3], content[4], content[7], content[5], content[6], content[8]);
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
		public function exitRoomI(obj:Object):void{
			var content:String = obj.content;
			DeskPanelService.instance.playerExitRoom(content);
		}
		
		/**
		 * 房间倒计时
		 * */
		public function countDownI(obj:Object):void{
			DeskPanelService.instance.updateCountDownV(int(obj.content));
		}
		
		
		/**
		 * 房间状态 
		 * @param obj
		 * 
		 */
		public function stateI(obj:Object):void{
			var content:int = obj.content;
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
			var content:String = obj.content;
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
		public function gameResultI(obj:Object):void{
			var content:Array = obj.content;
			DeskPanelService.instance.gameResult(content[0].result, content[0].type, content[1], content[2], content[3]);
//			DeskPanelService.instance.setGameResult(content[0].result, content[0].type, content[1], content[2]);
		}
		
		/**
		 * 玩家投注返回 
		 * @param obj
		 * 
		 */
		public function playerBettingI(obj:Object):void{
			var content:String = obj.content;
			var contents:Array = content.split(",");
			
			DeskPanelService.instance.updateTouzhuByPlayerName(contents[0], contents[1], contents[2], contents[3], contents[4], contents[5], contents[6]);
		}
		
		public function allPlayerBettingI(obj:Object):void{
			var content:String = obj.content;
			var contents:Array = content.split(",");
			
			DeskPanelService.instance.updateRealtimePot(contents[2], contents[3], contents[4], contents[0], contents[1]);
		}

		//-----------------------------------------------------------------------------------------------
		//玩家选择房间调用后台服务
		public function enterRoom(roomNo:String, max:String, min:String):void{
			_conn.call("enterRoom", new Responder(onOneMsgResult, onOneMsgStatus), roomNo, PlayerService.instance.player.acctName, max, min);
		}

		//退出台桌
		public function exitRoom():void{
			_conn.call("exitRoom", new Responder(onOneMsgResult, onOneMsgStatus), DeskPanelService.instance.deskNo, PlayerService.instance.player.acctName);
		}
		
		//玩家下注调用后台服务
		public function updatePlayerBet(zhuangduiT:Number, xianduiT:Number, zhuangT:Number, xianT:Number, heT:Number):void
		{
			_conn.call("updatePlayerBet", new Responder(onOneMsgResult, onOneMsgStatus), DeskPanelService.instance.deskNo, PlayerService.instance.player.acctName, zhuangduiT, xianduiT, zhuangT, xianT, heT);
		}
		
		//转台
		public function changeRoom(changeRoomNo:String):void{
			_conn.call("changeRoom", new Responder(onOneMsgResult, onOneMsgStatus), DeskPanelService.instance.deskNo, PlayerService.instance.player.acctName, changeRoomNo);
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