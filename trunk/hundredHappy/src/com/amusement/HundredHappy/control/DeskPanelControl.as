package com.amusement.HundredHappy.control
{
	import com.amusement.HundredHappy.services.DeskPanelService;
	import com.amusement.HundredHappy.services.HistoryPanelService;
	import com.amusement.HundredHappy.services.MessageService;
	import com.amusement.HundredHappy.view.DeskPanel;
	
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;

	public class DeskPanelControl
	{
		private static var _instance:DeskPanelControl=null;
		
		private var _deskPanel:DeskPanel;
		
		[Embed(source="com/amusement/HundredHappy/assets/desk/hh_desk_red.jpg")]
		private var _DeskBgRed:Class;
		[Embed(source="com/amusement/HundredHappy/assets/desk/hh_desk_blue.jpg")]
		private var _DeskBgBlue:Class;
		[Embed(source="com/amusement/HundredHappy/assets/desk/hh_desk_green.jpg")]
		private var _DeskBgGreen:Class;
		
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_qxz.png")]
		private var _PleaseBetImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_shuffling.png")]
		private var _ShufflingImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_bet_success.png")]
		private var _SuccessBetImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_bet_fall.png")]
		private var _FallBetImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_bet_stop.png")]
		private var _StopBetImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_belowMin.png")]
		private var _BelowMinImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_aboveMax.png")]
		private var _AboveMaxImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_excessHong.png")]
		private var _ExcessHongImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_insufficient.png")]
		private var _InsufficientImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_result_zhuang.png")]
		private var _ResultZhuangImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_result_xian.png")]
		private var _ResultXianImg:Class;
		[Embed(source="com/amusement/HundredHappy/assets/prompt/hh_result_he.png")]
		private var _ResultHeImg:Class;

		public function DeskPanelControl(deskPanel:DeskPanel)
		{
			_instance = this;
			
			this._deskPanel = deskPanel;
			
			init();
		}
		
		private function init():void{
			this._deskPanel.DeskBg = _DeskBgRed;
			
//			this._deskPanel.notice.start(14);
			
			addListeners();
		}
		
		private function addListeners():void{
			this._deskPanel.deskBgImg.addEventListener(MouseEvent.MOUSE_DOWN, dragHandler, false, 0, true);
			
			this._deskPanel.askZBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._deskPanel.askXBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			
			this._deskPanel.exitBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
//			this._deskPanel.fullScreenBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
//			this._deskPanel.helpBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			this._deskPanel.systemBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
			
			this._deskPanel.redBgBtn.addEventListener(MouseEvent.CLICK, changeBgHandler, false, 0, true);
			this._deskPanel.blueBgBtn.addEventListener(MouseEvent.CLICK, changeBgHandler, false, 0, true);
			this._deskPanel.greenBgBtn.addEventListener(MouseEvent.CLICK, changeBgHandler, false, 0, true);
			
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "askZBtn":
					HistoryPanelService.instance.askWay("z");
					break;
				case "askXBtn":
					HistoryPanelService.instance.askWay("x");
					break;
				case "systemBtn":
					SystemPanelControl.instance.show(this._deskPanel);
					break;
				case "fullScreenBtn":
					try{
						this._deskPanel.stage.displayState = (this._deskPanel.stage.displayState == StageDisplayState.NORMAL ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL);
					}catch (e:Error){	
					}
					break;
				case "exitBtn":
					if(DeskPanelService.instance.selfHundredHappyPlayerService.getPlayerBetTotal() == 0){
						MessageService.instance.exitRoom();
					}
					break;
			}
		}
		
		private function changeBgHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "redBgBtn":
					this._deskPanel.DeskBg = _DeskBgRed;
					break;
				case "blueBgBtn":
					this._deskPanel.DeskBg = _DeskBgBlue;
					break;
				case "greenBgBtn":
					this._deskPanel.DeskBg = _DeskBgGreen;
					break;
			}
		}
		
		private function dragHandler(event:MouseEvent):void{
			HundredHappyControl.instance.dragHandler(event);
		}

		public function updateCountDownV(count:int):void
		{
			this._deskPanel.countDownV.text = count.toString();
		}
		
		public function show():void{
			this._deskPanel.visible = true;
		}
		
		public function updateTotal(total:Number):void{
			this._deskPanel.totalTou.text = total.toString();
		}
		
		public function reset():void{
			this._deskPanel.betResult.text = "";
			updatePromptV();
			this._deskPanel.countDownV.text = "";
			this._deskPanel.totalTou.text = "";
			this._deskPanel.visible = false;
			
			HundredHappyControl.instance.resetXY();
		}
		
		public function updatePromptV(str:String = ""):void{
			switch(str){
				case "qxz"://请下注
					this._deskPanel.PromptImg = _PleaseBetImg;
					break;
				case "xpz"://洗牌中
					this._deskPanel.PromptImg = _ShufflingImg;
					break;
				case "xzcg"://下注成功
					this._deskPanel.PromptImg = _SuccessBetImg;
					break;
				case "xzsb"://下注失败
					this._deskPanel.PromptImg = _FallBetImg;
					break;
				case "tzxz"://停止下注
					this._deskPanel.PromptImg = _StopBetImg;
					break;
				case "dyxx"://低于下限
					this._deskPanel.PromptImg = _BelowMinImg;
					break;
				case "gysx"://高于上限
					this._deskPanel.PromptImg = _AboveMaxImg;
					break;
				case "cgxh"://超过限红
					this._deskPanel.PromptImg = _ExcessHongImg;
					break;
				case "yebz"://余额不足
					this._deskPanel.PromptImg = _InsufficientImg;
					break;
				case "z"://庄赢
					this._deskPanel.PromptImg = _ResultZhuangImg;
					break;
				case "x"://闲赢
					this._deskPanel.PromptImg = _ResultXianImg;
					break;
				case "h"://和
					this._deskPanel.PromptImg = _ResultHeImg;
					break;
				default:
					this._deskPanel.PromptImg = null;
					break;
			}
		}
		
		public function updateBetResultV(value:Number = 0):void
		{
			var str:String = "";
			
			if(value < 0){
				str = "輸\t" + Math.abs(value).toFixed(2);
			}else if(value > 0){
				str = "贏\t" + value.toFixed(2);
			}
			
			this._deskPanel.betResult.text = str;
		}
	
		//g  2011-5-17  11：35  添加的网络质量设置方法
		public function setNetworkWidth(width:int):void{
//			this._deskPanel.network.setStateWidth(width);
		}
		
		//--------------------------------------------------------------------------------------
		public static function get instance():DeskPanelControl
		{
			return _instance;
		}

	}
}