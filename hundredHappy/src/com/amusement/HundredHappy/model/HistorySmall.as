package com.amusement.HundredHappy.model
{
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import spark.core.SpriteVisualElement;
	
	public class HistorySmall extends SpriteVisualElement
	{
		[Embed(source="com/amusement/HundredHappy/assets/history/zhuang_1.png")]
		private var ZImage:Class;
		
		[Embed(source="com/amusement/HundredHappy/assets/history/xian_1.png")]
		private var XImage:Class;
		
		[Embed(source="com/amusement/HundredHappy/assets/history/he_1.png")]
		private var HImage:Class;
		
		private var _flashTimer:Timer;
		
		private var _img:Bitmap;
		private var _txt:TextField;
		
		private var _hCount:int;
		
		public function HistorySmall(str:String, hCount:int = 0, isNeedShansuo:Boolean = false)
		{
			if(isNeedShansuo){
				_flashTimer = new Timer(500,6);
				_flashTimer.addEventListener(TimerEvent.TIMER,flashTimerHandler,false,0,true);
				_flashTimer.addEventListener(TimerEvent.TIMER_COMPLETE,completeHandler);
				_flashTimer.start();
			}
			
			switch(str){
				case "z":
					_img = new ZImage();
					break;
				
				case "x":
					_img = new XImage();
					break;
				
				case "h":
					_img = new HImage();
					break;
			}
			if(_img){
				this.addChild(_img);
			}
			
			_txt = new TextField();
			_txt.mouseEnabled = false;
			_txt.width = 9;
			_txt.height = 9;
			_txt.defaultTextFormat = new TextFormat(null, 6, 0xAAAAAA, null, null, null, null, null, TextFormatAlign.CENTER);
			this.addChild(_txt);
			
			this._hCount = hCount;
			if(hCount > 0){
				_txt.text = hCount.toString();
			}
		}
		
		private function flashTimerHandler(e:TimerEvent):void{
			if(_img.visible){
				_img.visible = false;
			}else{
				_img.visible = true;
			}
		}
		
		private function completeHandler(e:TimerEvent):void{
			_flashTimer.reset();
			_img.visible = false;
		}
		
		public function startTwinkle():void{
			_flashTimer.start();
		}
		
		public function updateHCount():void{
			_txt.text = (++ _hCount).toString();
		}

		public function get hCount():int
		{
			return _hCount;
		}

	}
}