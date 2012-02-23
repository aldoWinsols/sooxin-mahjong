package com.amusement.HundredHappy.model
{
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import spark.core.SpriteVisualElement;

	public class HistoryBig extends SpriteVisualElement
	{
		[Embed(source="com/amusement/HundredHappy/assets/history/zhuang.png")]
		private var ZImage:Class;
		
		[Embed(source="com/amusement/HundredHappy/assets/history/xian.png")]
		private var XImage:Class;
		
		[Embed(source="com/amusement/HundredHappy/assets/history/he.png")]
		private var HImage:Class;
		
		[Embed(source="com/amusement/HundredHappy/assets/history/xiandui.png")]
		private var XDImage:Class;
		
		[Embed(source="com/amusement/HundredHappy/assets/history/zhuangdui.png")]
		private var ZDImage:Class;
		
		private var _img:Bitmap;
		
		private var _flashTimer:Timer;
		
		public function HistoryBig(str:String, type:int = 0,isNeedShansuo:Boolean = false)
		{
			if(isNeedShansuo){
				_flashTimer = new Timer(500,6);
				_flashTimer.addEventListener(TimerEvent.TIMER,flashTimerHandler,false,0,true);
				_flashTimer.addEventListener(TimerEvent.TIMER_COMPLETE,completeHandler);
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
			
			switch(type){
				case 1:
					setXiandui();
					break;
				case 2:
					setZhuangdui();
					break;
				case 3:
					setXiandui();
					setZhuangdui();
					break;
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
		
		private function setXiandui():void{
			var bmp:Bitmap = new XDImage();
			this.addChild(bmp);
		}
		
		private function setZhuangdui():void{
			var bmp:Bitmap = new ZDImage();
			bmp.x = 14;
			bmp.y = 14;
			this.addChild(bmp);
		}
		
		public function startTwinkle():void{
			_flashTimer.start();
		}
	}
}