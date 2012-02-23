package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.DeskPanelControl;
	import com.amusement.HundredHappy.control.HundredHappyControl;
	import com.amusement.HundredHappy.control.SystemPanelControl;
	import com.control.MainSceneControl;
	import com.service.PlayerService;
	
	import flash.net.LocalConnection;
	
	import mx.controls.Alert;

	public class DeskPanelService
	{
		private static var _instance:DeskPanelService;
		
		//自己本地的_selfHundredHappyPlayerService
		[Bindable]
		public var selfHundredHappyPlayerService:HundredHappyPlayerService;
		
		[Bindable]
		public var deskNo:String;//台号
		[Bindable]
		public var gameNo:String;//局号
		[Bindable]
		public var realtimeZhang:Number = 0;
		[Bindable]
		public var realtimeXian:Number = 0;
		[Bindable]
		public var realtimeHe:Number = 0;
		[Bindable]
		public var realtimeZhangdui:Number = 0;
		[Bindable]
		public var realtimeXiandui:Number = 0;
		[Bindable]
		public var limitHong:Number = 0;
		[Bindable]
		public var minBet:Number = 0;
		[Bindable]
		public var maxBet:Number = 2000;
		
		private var _noBetCountMax:int = 4;
		private var _noBetCount:int = 0;
		
		private var _deskState:int;
		private var _gameResult:Object;

		public function DeskPanelService()
		{
			_gameResult = {};
		}
		
		public static function get instance():DeskPanelService
		{
			if (_instance == null)
			{
				_instance=new DeskPanelService();
			}
			return _instance;
		}
		
		private function setDeskState(state:int):void{
			_deskState = state;
			switch(state){
				case 0://
					BettingPanelService.instance.setOperatable(false);
					break
				case 1://可下注
					BettingPanelService.instance.hideResult();
					DeskPanelControl.instance.updateBetResultV();
					this.gameNo = _gameResult.nextGameNo;
					updatePrompt("qxz");
					BettingPanelService.instance.setOperatable(true);
					HundredHappySoundService.instance.play("startBet");
					break;
				case 2://洗牌中
					BettingPanelService.instance.hideResult();
					DeskPanelControl.instance.updateBetResultV();
					BettingPanelService.instance.setOperatable(false);
					HistoryPanelService.instance.clearHistroys();
					updatePrompt("xpz");
					break;
				case 3://停止下注
					BettingPanelService.instance.setOperatable(false);
					updatePrompt("tzxz");
					selfHundredHappyPlayerService.clearBetCurrent();
					HundredHappySoundService.instance.play("stopBet");
					
					if(selfHundredHappyPlayerService.getPlayerBetTotal() > 0){
						_noBetCount = 0;
					}else if(++_noBetCount >= _noBetCountMax){
						MessageService.instance.exitRoom();
						Alert.show("您已連續四次未下注，被請出房間！");
					}
			}
			gc();
		}
		
		/**
		 * 初始化房间（玩家进入房间） 
		 * @param players
		 * @param historys
		 * @param deskNo
		 * @param gameNo
		 * 
		 */
		public function initRoom(players:Array, historys:Array, deskNo:String, gameNo:String, state:int, limitHong:Number, max:Number, min:Number, valuesStr:String):void{
			PlayerService.instance.playerEnterSomeGame("baccarat", deskNo);
			
//			HundredHappyControl.instance.updateNotice(88, -350, 926, 14);
			
			SystemPanelControl.instance.init();
			
			PlayerSeatPanelService.instance.initPlayer(players);
			HistoryPanelService.instance.initHistroy(historys);
			
			this.deskNo = deskNo;
			_gameResult.nextGameNo = gameNo;
			this.limitHong = limitHong;
			this.minBet = min;
			this.maxBet = max;
			
			var jettonValues:Array = valuesStr.split(",");
			if(jettonValues[jettonValues.length - 1] == ""){
				jettonValues.pop();
			}
			BettingPanelService.instance.updateJettons(jettonValues);
			
			setDeskState(state);
			TurntablePanelService.instance.setSelectedRoom(deskNo);
			DeskPanelControl.instance.show();
		}
		
		/**
		 * 其他玩家加入房间 
		 * 
		 */
		public function playerEnterRoom(authz:int, playerName:String, currentPoint:Number):void{
			PlayerSeatPanelService.instance.addPlayer(authz, playerName, currentPoint);
		}
		
		/**
		 * 退出房间 
		 * @param playerName
		 * 
		 */
		public function playerExitRoom(playerName:String):void{
			if(PlayerService.instance.player.acctName == playerName){
				clearRoom();
//				HundredHappyControl.instance.updateNotice(281, -168, 507, 13);
			}else{
				PlayerSeatPanelService.instance.removePlayer(playerName);
			}
		}
		
		public function gameResult(result:String, type:int, arr:Array, nextGameNo:String, value:Number):void{
			updatePrompt(result);
			DeskPanelControl.instance.updateBetResultV(value);
			
			HistoryPanelService.instance.addHistroy(result, type);
			BettingPanelService.instance.showResult(result, type);
			HundredHappySoundService.instance.play(result + type);
			
			var hundredHappyServiceT:HundredHappyPlayerService;
			var strArr:Array;
			for each(var str:String in arr){
				strArr = str.split(",");
				PlayerSeatPanelService.instance.updateCurrentPoint(strArr[0], strArr[1]);
				
				if(PlayerService.instance.player.acctName == strArr[0]){
					PlayerService.instance.player.acctMoney = strArr[1];
					DeskPanelControl.instance.updateTotal(selfHundredHappyPlayerService.getPlayerBetTotal());
				}
			}
			updateRealtimePot();
			
			_gameResult.nextGameNo = nextGameNo;
		}
		
		/**
		 * 设置游戏结果 
		 * @param result
		 * @param type
		 * @param arr
		 * @param nextGameNo
		 * 
		 */
		/*public function setGameResult(result:String, type:int, arr:Array, nextGameNo:String):void{
			_gameResult.result = result;
			_gameResult.type = type;
			_gameResult.arr = arr;
			_gameResult.nextGameNo = nextGameNo;
		}*/
		
		/**
		 * 显示游戏结果 
		 * @param result
		 * @param type
		 * @param arr
		 * 
		 */
		/*public function showGameResult():void{
			DeskPanelControl.instance.updateBetResultV(_gameResult.result);
			
			HistoryPanelService.instance.addHistroy(_gameResult.result, _gameResult.type);
			
			var hundredHappyServiceT:HundredHappyPlayerService;
			var strArr:Array;
			for each(var str:String in _gameResult.arr){
				strArr = str.split(",");
				PlayerSeatPanelService.instance.updateCurrentPoint(strArr[0], strArr[1]);
				
				if(PlayerService.instance.player.playerName == strArr[0]){
					PlayerService.instance.player.currentPoints = strArr[1];
					DeskPanelControl.instance.updateTotal(_selfHundredHappyPlayerService.getPlayerBetTotal());
				}
			}
			updateRealtimePot();
		}*/
		
		/**
		 * 更新倒计时 
		 * @param num
		 * 
		 */
		public function updateCountDownV(num:Number):void{
			DeskPanelControl.instance.updateCountDownV(num);
			//5秒停止下注
			if(num < 5 && (_deskState == 0 || _deskState == 1)){
				setDeskState(3);
			}
			
			if(num < 5 && _deskState == 3){
				HundredHappySoundService.instance.play("chime");
			}
		}
		
		public function updateDeskState(state:int):void{
			ChupaiPanelService.instance.reset();
			setDeskState(state);
		}
		
		/**
		 * 显示牌 
		 * @param zPokers
		 * @param xPokers
		 * 
		 */
		public function showPokers(zPokers:Array, xPokers:Array):void{
			BettingPanelService.instance.setOperatable(false);
			updatePrompt();
			this.selfHundredHappyPlayerService.clearBetCurrent();
			ChupaiPanelService.instance.startShowPokers(zPokers, xPokers);
		}
		
		/**
		 * 玩家下注 
		 * @param playerName
		 * @param zhuangduiT
		 * @param xianduiT
		 * @param zhuangT
		 * @param xianT
		 * @param heT
		 * @param currentPoint
		 * 
		 */
		public function updateTouzhuByPlayerName(playerName:String, zhuangduiT:Number, xianduiT:Number, zhuangT:Number, xianT:Number, heT:Number, currentPoint:Number):void
		{
			PlayerSeatPanelService.instance.updateBetByPlayerName(playerName, zhuangduiT, xianduiT, zhuangT, xianT, heT, currentPoint);
			if(PlayerService.instance.player.acctName == playerName){
				PlayerService.instance.player.acctMoney = currentPoint;
				DeskPanelControl.instance.updateTotal(selfHundredHappyPlayerService.getPlayerBetTotal());
				updatePrompt("xzcg");
				BettingPanelService.instance.setOperatable(true);
			}
		}
		
		/**
		 * 更新即时彩池 
		 * @param zhang
		 * @param xian
		 * @param he
		 * @param zhangdui
		 * @param xiandui
		 * 
		 */
		public function updateRealtimePot(zhang:Number = 0, xian:Number = 0, he:Number = 0, zhangdui:Number = 0, xiandui:Number = 0):void{
			this.realtimeZhang = zhang;
			this.realtimeXian = xian;
			this.realtimeHe = he;
			this.realtimeZhangdui = zhangdui;
			this.realtimeXiandui = xiandui;
		}
		
		public function showDeterInfo(str:String):void{
			selfHundredHappyPlayerService.restoreLastTou();
			switch(str){
				case "zdje":
					Alert.show("您已達到最大可贏點數！", "提示");
					break;
				default:
					updatePrompt(str);
					BettingPanelService.instance.setOperatable(true);
					break;
			}
		}
		
		public function updatePrompt(str:String = ""):void{
			DeskPanelControl.instance.updatePromptV(str);
		}
		
		public function clearRoom():void{
//			HundredHappySoundService.instance.stop();
			SystemPanelControl.instance.finish();
			
			this.deskNo = "";
			this.gameNo = "";
			this._noBetCount = 0;
			updateRealtimePot();
			this.selfHundredHappyPlayerService = null;
//			BettingPanelService.instance.updateConfirmShine(false);
			PlayerSeatPanelService.instance.clearPlayer();
			ChupaiPanelService.instance.reset();
			HistoryPanelService.instance.clearHistroys();
			TurntablePanelService.instance.clearSelected();
			DeskPanelControl.instance.reset();
			MainSceneControl.instance.setZezhaoVisible(false);
			PlayerService.instance.playerEnterSomeGame();
			gc();
		}
		
		private function gc():void {
			try {
				new LocalConnection().connect("www.flashdown.net");
				new LocalConnection().connect("www.flashdown.net");
			} catch (err:Error) {
			}
		}

	}
}