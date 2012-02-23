package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.PlayerSeatPanelControl;
	import com.amusement.HundredHappy.model.HundredHappyPlayer;
	import com.service.PlayerService;

	public class PlayerSeatPanelService
	{
		private static var _instance:PlayerSeatPanelService;
		
		private var _hundredHappyPlayerServices:Array;
		
		public function PlayerSeatPanelService()
		{
			_hundredHappyPlayerServices = [];
			
			var player:HundredHappyPlayer;
			for(var i:int = 1; i <= 7; i ++){
				_hundredHappyPlayerServices[i] = new HundredHappyPlayerService();
				player = _hundredHappyPlayerServices[i].hundredHappyPlayer;
				PlayerSeatPanelControl.instance.bind(i, player);
			}
		}
		
		public static function get instance():PlayerSeatPanelService
		{
			if(_instance == null){
				_instance = new PlayerSeatPanelService();
			}
			return _instance;
		}
		
		/**
		 * 玩家进入房间初始化玩家 
		 * @param arr
		 * 
		 */
		public function initPlayer(arr:Array):void{
			var strArr:Array;
			for each(var str:String in arr){
				strArr = str.split(",");
				addPlayer(strArr[1], strArr[0], strArr[2]);
				_hundredHappyPlayerServices[strArr[1]].updateTou(strArr[3], strArr[4], strArr[5], strArr[6], strArr[7], strArr[2]);
				if(PlayerService.instance.player.acctName == strArr[0]){
					DeskPanelService.instance.selfHundredHappyPlayerService = _hundredHappyPlayerServices[strArr[1]];
					PlayerSeatPanelControl.instance.setSeatMine(strArr[1]);
				}
			}
		}
		
		/**
		 * 其他玩家加入房间 
		 * @param authz
		 * @param playerName
		 * @param currentPoint
		 * 
		 */
		public function addPlayer(authz:int, playerName:String, currentPoint:Number):void{
			_hundredHappyPlayerServices[authz].playerEnter(authz, playerName, currentPoint);
		}
		
		/**
		 * 其他玩家退出房间 
		 * @param playerName
		 * 
		 */
		public function removePlayer(playerName:String):void{
			var hundredHappyService:HundredHappyPlayerService;
			for(var i:int = 0; i < _hundredHappyPlayerServices.length; i ++){
				hundredHappyService = _hundredHappyPlayerServices[i] as HundredHappyPlayerService;
				if(hundredHappyService && hundredHappyService.hundredHappyPlayer.acctName/*playerName*/ == playerName){
					hundredHappyService.playerLeave();
					break;
				}
			}
		}
		
		/**
		 * 自己退出房间
		 * 
		 */
		public function clearPlayer():void{
			var hundredHappyService:HundredHappyPlayerService;
			for(var i:int = 0; i < _hundredHappyPlayerServices.length; i ++){
				hundredHappyService = _hundredHappyPlayerServices[i] as HundredHappyPlayerService;
				if(hundredHappyService){
					hundredHappyService.playerLeave();
				}
			}
			PlayerSeatPanelControl.instance.resetSeat();
		}
		
		/**
		 * 根据玩家名字 更新玩家点数 
		 * @param playerName
		 * @param currentPoint
		 * 
		 */
		public function updateCurrentPoint(playerName:String, currentPoint:Number):void{
			var hundredHappyService:HundredHappyPlayerService;
			for(var i:int = 0; i < _hundredHappyPlayerServices.length; i ++){
				hundredHappyService = _hundredHappyPlayerServices[i] as HundredHappyPlayerService;
				if(hundredHappyService && hundredHappyService.hundredHappyPlayer.acctName/*playerName*/ == playerName){
					hundredHappyService.clearTou();
					hundredHappyService.hundredHappyPlayer.currentPoint = currentPoint;
					break;
				}
			}
		}
		
		/**
		 * 根据名字 更新玩家下注 
		 * @param playerName
		 * @param zhuangduiT
		 * @param xianduiT
		 * @param zhuangT
		 * @param xianT
		 * @param heT
		 * @param currentPoint
		 * 
		 */
		public function updateBetByPlayerName(playerName:String, zhuangduiT:Number, xianduiT:Number, zhuangT:Number, xianT:Number, heT:Number, currentPoint:Number):void{
			var hundredHappyService:HundredHappyPlayerService;
			for(var i:int = 0; i < _hundredHappyPlayerServices.length; i ++){
				hundredHappyService = _hundredHappyPlayerServices[i] as HundredHappyPlayerService;
				if(hundredHappyService && hundredHappyService.hundredHappyPlayer.acctName/*playerName*/ == playerName){
					hundredHappyService.updateTou(zhuangduiT, xianduiT, zhuangT, xianT, heT, currentPoint);
					break;
				}
			}
		}

	}
}