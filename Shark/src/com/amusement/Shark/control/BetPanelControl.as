package com.amusement.Shark.control
{
	import com.amusement.Shark.main.BetPanel;
	import com.amusement.Shark.model.SharkTouzhu;
	import com.amusement.Shark.model.betting.BaseBet;
	import com.amusement.Shark.service.SharkSyncService;
	import com.model.Alert;
	import com.service.PlayerService;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	

	public class BetPanelControl
	{
		private static var _instance:BetPanelControl;
		
		private var _betPanel:BetPanel;
		
		private var _yanziNum:int=0;
		private var _geziNum:int=0;
		private var _kongqueNum:int=0;
		private var _laoyingNum:int=0;
		private var _feiqinNum:int=0;
		private var _dabaishaNum:int=0;
		private var _zoushouNum:int=0;
		private var _shiziNum:int=0;
		private var _laohuNum:int=0;
		private var _xiongmaoNum:int=0;
		private var _houziNum:int=0;
		
		private var _resultAnimal:Object;
		
		private var _resultEffectTimer:Timer;
		
		public function BetPanelControl(betPanel:BetPanel)
		{
			_instance = this;
			
			this._betPanel = betPanel;
			
			init();
		}
		
		private function init():void{
			_resultEffectTimer = new Timer(500);
			_resultEffectTimer.addEventListener(TimerEvent.TIMER, resultEffectHandler, false, 0, true);
			
		}
		
		private function resultEffectHandler(event:TimerEvent):void{
			if(_resultEffectTimer.currentCount % 2){
				updateBettingLight();
			}else{
				updateBettingLight(_resultAnimal.type, _resultAnimal.animalName);
			}
		}
		
		private function continueBet():void{
			if (getLastAllBet() > PlayerService.instance.haveMoney){
				Alert.show("您的餘額不足，不能續押！");
			}else{
				this._betPanel.yanzi.currentBetNum = _yanziNum;
				this._betPanel.gezi.currentBetNum = _geziNum;
				this._betPanel.kongque.currentBetNum = _kongqueNum;
				this._betPanel.laoying.currentBetNum = _laoyingNum;
				this._betPanel.feiqin.currentBetNum = _feiqinNum;
				this._betPanel.dabaisha.currentBetNum = _dabaishaNum;
				this._betPanel.zoushou.currentBetNum = _zoushouNum;
				this._betPanel.shizi.currentBetNum = _shiziNum;
				this._betPanel.laohu.currentBetNum = _laohuNum;
				this._betPanel.xiongmao.currentBetNum = _xiongmaoNum;
				this._betPanel.houzi.currentBetNum = _houziNum;
				
//				PlayerService.instance.updateNowMoneyOnlyAllTouzhu(-getAllBet());
				
				//更新投住到服务器端
				updateBet();
			}
		}
		
		private function getLastAllBet():int{
			return _yanziNum + _geziNum + _kongqueNum + _laoyingNum
				+ _feiqinNum + _dabaishaNum + _zoushouNum
				+ _shiziNum + _laohuNum + _xiongmaoNum + _houziNum;
		}
		
		private function updateBettingLight(animalType:String = "", animalName:String = ""):void{
			var bet:BaseBet;
			for(var i:int = 0; i < this._betPanel.betGroup.numElements; i ++){
				bet = this._betPanel.betGroup.getElementAt(i) as BaseBet;
				if(bet){
					bet.showLight(false);
					if(bet.animalName == animalName || bet.animalName == animalType){
						bet.showLight(true);
					}
				}
			}
		}
		
		public function getAllBet():int{
			return this._betPanel.yanzi.currentBetNum + this._betPanel.gezi.currentBetNum + this._betPanel.kongque.currentBetNum + this._betPanel.laoying.currentBetNum 
				+ this._betPanel.feiqin.currentBetNum + this._betPanel.dabaisha.currentBetNum + this._betPanel.zoushou.currentBetNum 
				+ this._betPanel.shizi.currentBetNum + this._betPanel.laohu.currentBetNum + this._betPanel.xiongmao.currentBetNum + this._betPanel.houzi.currentBetNum;
		}
		
		public function getBets():Array{
			var arr:Array = [];
			
			var bet:BaseBet;
			for(var i:int = 0; i < this._betPanel.betGroup.numElements; i ++){
				bet = this._betPanel.betGroup.getElementAt(i) as BaseBet;
				if(bet){
					arr.push(bet);
				}
			}
			
			return arr;
		}
		
		public function recordLastAllBet():void{
			_yanziNum = this._betPanel.yanzi.currentBetNum;
			_geziNum = this._betPanel.gezi.currentBetNum;
			_kongqueNum = this._betPanel.kongque.currentBetNum;
			_laoyingNum = this._betPanel.laoying.currentBetNum;
			_feiqinNum = this._betPanel.feiqin.currentBetNum;
			_dabaishaNum = this._betPanel.dabaisha.currentBetNum;
			_zoushouNum = this._betPanel.zoushou.currentBetNum;
			_shiziNum = this._betPanel.shizi.currentBetNum;
			_laohuNum = this._betPanel.laohu.currentBetNum;
			_xiongmaoNum = this._betPanel.xiongmao.currentBetNum;
			_houziNum = this._betPanel.houzi.currentBetNum;
		}
		
		public function updateBet():void{
			SharkTouzhu.instance.playername = PlayerService.instance.playerName;
			
			SharkTouzhu.instance.yanziT = this._betPanel.yanzi.currentBetNum;
			SharkTouzhu.instance.geziT = this._betPanel.gezi.currentBetNum;
			SharkTouzhu.instance.kongqueT = this._betPanel.kongque.currentBetNum;
			SharkTouzhu.instance.laoyingT = this._betPanel.laoying.currentBetNum;
			SharkTouzhu.instance.feiqinT = this._betPanel.feiqin.currentBetNum;
			SharkTouzhu.instance.dabaishaT = this._betPanel.dabaisha.currentBetNum;
			SharkTouzhu.instance.zoushouT = this._betPanel.zoushou.currentBetNum;
			SharkTouzhu.instance.shiziT = this._betPanel.shizi.currentBetNum;
			SharkTouzhu.instance.laohuT = this._betPanel.laohu.currentBetNum;
			SharkTouzhu.instance.xiongmaoT = this._betPanel.xiongmao.currentBetNum;
			SharkTouzhu.instance.houziT = this._betPanel.houzi.currentBetNum;
			
			SharkSyncService.instance.updateTouzhuS(SharkTouzhu.instance);
		}
		
		public function clear():void{
			this._betPanel.yanzi.clear();
			this._betPanel.gezi.clear();
			this._betPanel.kongque.clear();
			this._betPanel.laoying.clear();
			this._betPanel.feiqin.clear();
			this._betPanel.dabaisha.clear();
			this._betPanel.zoushou.clear();
			this._betPanel.shizi.clear();
			this._betPanel.laohu.clear();
			this._betPanel.xiongmao.clear();
			this._betPanel.houzi.clear();
		}
		
		public function setLock(isLock:Boolean):void{
			var bet:BaseBet;
			for(var i:int = 0; i < this._betPanel.betGroup.numElements; i ++){
				bet = this._betPanel.betGroup.getElementAt(i) as BaseBet;
				if(bet){
					bet.mouseEnabled = !isLock;
					bet.mouseChildren = !isLock;
				}
			}
		}
		
		public function startResultEffect(resultAnimal:Object):void{
			this._resultAnimal = resultAnimal;
			updateBettingLight(_resultAnimal.type, _resultAnimal.animalName);
			this._resultEffectTimer.start();
		}
		
		public function stopResultEffect():void{
			this._resultEffectTimer.reset();
			updateBettingLight();
		}

		//----------------------------- getter/setter function ----------------------------------
		public static function get instance():BetPanelControl
		{
			return _instance;
		}

	}
}