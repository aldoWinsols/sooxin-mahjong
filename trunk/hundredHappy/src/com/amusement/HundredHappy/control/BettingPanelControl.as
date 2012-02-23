package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.model.betting.Betting;
	import com.amusement.HundredHappy.model.jetton.BaccaratJetton;
	import com.amusement.HundredHappy.services.BettingPanelService;
	import com.amusement.HundredHappy.services.DeskPanelService;
	import com.amusement.HundredHappy.view.BettingPanel;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class BettingPanelControl
	{
		/*[Embed(source="com/amusement/HundredHappy/assets/hh_confirm_btn.png")]
		private var _ConfirmBtnDef:Class;
		[Embed(source="com/amusement/HundredHappy/assets/hh_confirm_shine.swf")]
		private var _ConfirmBtnShine:Class;*/
		
		private static var _instance:BettingPanelControl;
		private var _bettingPanel:BettingPanel;
		
		public function BettingPanelControl(bettingPanel:BettingPanel)
		{
			_instance = this;
			
			this._bettingPanel = bettingPanel;
			
			init();
		}
		
		private function init():void{
//			setConfirmShine(false);
			updateBettingLight();
			
			addListeners();
		}
		
		private function addListeners():void{
			this._bettingPanel.confirmBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._bettingPanel.cancelBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._bettingPanel.clearBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			DeskPanelService.instance.updatePrompt();
			switch(event.currentTarget.id){
				case "confirmBtn":
					setCanBet(false);
//					setConfirmShine(false);
					BettingPanelService.instance.confirmBet();
					break;
				case "cancelBtn":
					BettingPanelService.instance.cancelLastBet();
					/*if(DeskPanelService.instance.selfHundredHappyPlayerService.getCurrentBetTotal() <= 0){
						setConfirmShine(false);
					}*/
					break;
				case "clearBtn":
//					setConfirmShine(false);
					BettingPanelService.instance.clearCurrentBet();
					break;
			}
		}
		
		public function updateJettonsValue(values:Array):void{
			for(var i:int = 0; i < values.length; i ++){
				updateJettonValueByNumber(i + 1, values[i]);
			}
		}
		
		public function updateJettonValueByNumber(jettonNo:int, value:int):void{
			if(jettonNo > 0  && jettonNo <= 5 && value > 0){
				var jetton:BaccaratJetton = this._bettingPanel.getChildByName("jetton" + jettonNo) as BaccaratJetton;
				if(jetton){
					jetton.value = value;
				}
			}
		}
		
		public function updateSmallJettonsV(total:Number, type:String, authz:Number):void{
			var betting:Betting = this._bettingPanel.getChildByName(type + "B") as Betting;
			if(betting){
				betting.updateJettonsByAuthz(total, authz);
			}
		}
		
		public function setCanBet(value:Boolean):void{
			var disObjCon:DisplayObjectContainer;
			for(var i:int = 0; i < this._bettingPanel.numElements; i ++){
				disObjCon = this._bettingPanel.getElementAt(i) as DisplayObjectContainer;
				if(disObjCon && !(disObjCon is BaccaratJetton)){
					disObjCon.mouseChildren = value;
					disObjCon.mouseEnabled = value;
				}
			}
		}
		
		//12-02-03 高亮显示投注区域
		public function updateBettingLight(result:String = "", type:int = 0):void{
			this._bettingPanel.zhuang.showLight(false);
			this._bettingPanel.xian.showLight(false);
			this._bettingPanel.he.showLight(false);
			this._bettingPanel.zhuangDui.showLight(false);
			this._bettingPanel.xianDui.showLight(false);
			
			switch(result){
				case "z":
					this._bettingPanel.zhuang.showLight(true);
					break;
				case "x":
					this._bettingPanel.xian.showLight(true);
					break;
				case "h":
					this._bettingPanel.he.showLight(true);
					break;
			}
			
			switch(type){
				case 1:
					this._bettingPanel.xianDui.showLight(true);
					break;
				case 2:
					this._bettingPanel.zhuangDui.showLight(true);
					break;
				case 3:
					this._bettingPanel.zhuangDui.showLight(true);
					this._bettingPanel.xianDui.showLight(true);
					break;
			}
		}
		
		/*public function setConfirmShine(value:Boolean):void{
			if(value){
				this._bettingPanel.ConfirmSkin = _ConfirmBtnShine;
			}else{
				this._bettingPanel.ConfirmSkin = _ConfirmBtnDef;
			}
			
//			if(value){
//				if(!this._bettingPanel.confirmShine.isPlaying){
//					this._bettingPanel.confirmShine.play();
//				}
//			}else{
//				this._bettingPanel.confirmShine.end();
//			}
		}*/
		
		//////////////////////////////////// getter/setter /////////////////////////////////////////////////
		public static function get instance():BettingPanelControl
		{
			return _instance;
		}


	}
}