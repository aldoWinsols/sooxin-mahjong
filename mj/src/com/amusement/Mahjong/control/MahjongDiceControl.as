package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.service.MahjongSoundService;
	import com.amusement.Mahjong.view.MahjongDice;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;
	import mx.flash.UIMovieClip;

	public class MahjongDiceControl
	{
		private static var _instance:MahjongDiceControl;
		
		private var _mahjongDice:MahjongDice;
		
		private var _ui:UIComponent;
		private var _dice:MovieClip;
		private var diceOperation:DiceOperation;
		
		public function MahjongDiceControl(mahjongDice:MahjongDice)
		{
			_instance = this;
			
			this._mahjongDice = mahjongDice;
			
			init();
		}
		
		private function init():void{
			_ui = new UIComponent();
			this._mahjongDice.addElement(_ui);
			diceOperation = new DiceOperation(_mahjongDice);
//			var diceLoader:Loader = new Loader();
//			diceLoader.load(new URLRequest("com/amusement/Mahjong/assets/mahjong_dice.swf"));
//			diceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, diceLoaderComplete, false, 0, true);
		}
		
		private function diceLoaderComplete(event:Event):void{
			event.currentTarget.removeEventListener(Event.COMPLETE, diceLoaderComplete);
			
			_dice = event.currentTarget.content;
			_ui.addChild(_dice);
		}
		
		public function show(num:int):void{
			MahjongSoundService.instance.soundPlay("saizi");//骰子声音
			
			this._mahjongDice.visible = true;
//			if(this._dice){
//				this._dice.sz.gotoAndStop(num);
//			}
			diceOperation.showSaizi(num);
		}
		
		public function hide():void{
			diceOperation.removeLastSaizi();
			this._mahjongDice.visible = false;
		}

		//-----------------------------------------------------------
		public static function get instance():MahjongDiceControl
		{
			return _instance;
		}

	}
}