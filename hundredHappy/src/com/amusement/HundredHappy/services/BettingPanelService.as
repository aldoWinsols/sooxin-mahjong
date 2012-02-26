package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.BettingPanelControl;
	import com.amusement.HundredHappy.model.HundredHappyPlayer;
	import com.amusement.HundredHappy.model.jetton.BaccaratJetton;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class BettingPanelService
	{
		private static var _instance:BettingPanelService;
		
		private var _selectJetton:BaccaratJetton;
		
		private var _betRecords:Array;
		
		private var _resultEffectTimer:Timer;
		private var _result:String;
		private var _type:int;
		
		public function BettingPanelService()
		{
			_betRecords = [];
			
			_result = "";
			_type = 0;
			
			_resultEffectTimer = new Timer(500);
			_resultEffectTimer.addEventListener(TimerEvent.TIMER, resultEffectHandler, false, 0, true);
		}

		public static function get instance():BettingPanelService
		{
			if(_instance == null){
				_instance = new BettingPanelService();
			}
			return _instance;
		}
		
		public function updateJettons(values:Array):void{
			values.sort(Array.NUMERIC);
			BettingPanelControl.instance.updateJettonsValue(values);
		}
		
		public function updateSmallJettons(type:String, authz:Number, total:Number):void{
			BettingPanelControl.instance.updateSmallJettonsV(total, type, authz);
		}
		
		public function confirmBet():void{
			if(DeskPanelService.instance.selfHundredHappyPlayerService.getCurrentBetTotal() > 0){
//				if(DeskPanelService.instance.selfHundredHappyPlayerService.checkBelowMin()){
//					//低于下限
//					DeskPanelService.instance.updatePrompt("dyxx");
//					setOperatable(true);
//				}else{
					var hhp:HundredHappyPlayer = DeskPanelService.instance.selfHundredHappyPlayerService.hundredHappyPlayer;
					MessageService.instance.updatePlayerBet(hhp.zhuangduiC, hhp.xianduiC, hhp.zhuangC, hhp.xianC, hhp.heC);
					delAllBetRecord();
					DeskPanelService.instance.selfHundredHappyPlayerService.clearTouC();
//				}
			}else{
				setOperatable(true);
			}
		}
		
		public function cancelLastBet():void{
			var record:Object = delLastBetRecord();
			if(record){
				DeskPanelService.instance.selfHundredHappyPlayerService.updateBet(-record.value, record.type);
			}
		}
		
		public function clearCurrentBet():void{
			BettingPanelService.instance.delAllBetRecord();
			DeskPanelService.instance.selfHundredHappyPlayerService.clearBetCurrent();
		}
		
		/**
		* 添加一条新投注记录 
		* @param zoneName
		* 
		*/
		public function addBetRecord(type:String, value:int):void{
			_betRecords.push({type:type, value:value});
		}
		
		/**
		 * 删除最后一条投注记录 
		 * @return 
		 * 
		 */
		public function delLastBetRecord():Object{
			return _betRecords.pop();
		}
		
		/**
		 * 删除所有投注记录 
		 * 
		 */
		public function delAllBetRecord():void{
			_betRecords.splice(0, _betRecords.length);
		}
		
		/**
		 * 是否可投注 
		 * @param value
		 * 
		 */
		public function setOperatable(value:Boolean):void{
			BettingPanelControl.instance.setCanBet(value);
			/*if(!value){
				BettingPanelControl.instance.setConfirmShine(value);
			}*/
		}
		
		/*public function updateConfirmShine(value:Boolean):void{
			BettingPanelControl.instance.setConfirmShine(value);
		}*/
		
		public function showResult(result:String, type:int):void{
			this._result = result;
			this._type = type;
			BettingPanelControl.instance.updateBettingLight(result, type);
			_resultEffectTimer.start();
		}
		
		public function hideResult():void{
			_resultEffectTimer.reset();
			this._result = "";
			this._type = 0;
			BettingPanelControl.instance.updateBettingLight();
		}
		
		
		private function resultEffectHandler(event:TimerEvent):void{
			if(_resultEffectTimer.currentCount % 2){
				BettingPanelControl.instance.updateBettingLight();
			}else{
				BettingPanelControl.instance.updateBettingLight(_result, _type);
			}
		}
		
		//---------------------------------------------------------------------------------
		public function get selectJetton():BaccaratJetton
		{
			return _selectJetton;
		}

		public function set selectJetton(value:BaccaratJetton):void
		{
			_selectJetton = value;
		}
	}
}