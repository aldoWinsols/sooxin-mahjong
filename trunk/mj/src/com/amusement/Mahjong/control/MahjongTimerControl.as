package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.service.MahjongSoundService;
	import com.amusement.Mahjong.service.MahjongTimerService;
	import com.amusement.Mahjong.view.MahjongTimer;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class MahjongTimerControl
	{
		private static var _instance:MahjongTimerControl;
		
		private var _mahjongTimer:MahjongTimer;
		private var _mahjongTimerService:MahjongTimerService;
		
		private var _azimuthDef:Point;
		private var _azimuth1:Point;
		private var _azimuth2:Point;
		private var _azimuth3:Point;
		private var _azimuth4:Point;
		
		private var _gameTimer:Timer;
		private var _repeatCount:int = 20;
		private var _timelagCount:int = 1;
		
		private var _isOnline:Boolean = false;
		private var _count:int = 0;
		private var _num:int = 0;
		
		public function MahjongTimerControl(mahjongTimer:MahjongTimer)
		{
			_instance = this;
			
			this._mahjongTimer = mahjongTimer;
			this._mahjongTimerService = new MahjongTimerService();
			
			init();
		}
		
		private function init():void{
			addLinsteners();
			
			_azimuthDef = new Point(364, 196);
			_azimuth1 = new Point(400, 100);
			_azimuth2 = new Point(64, 250);
			_azimuth3 = new Point(400, 500);
			_azimuth4 = new Point(700, 250);
			
			_gameTimer = new Timer(1000,_repeatCount + 1);
			_gameTimer.addEventListener(TimerEvent.TIMER, timerEventHandler, false, 0, true);
			_gameTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerEventHandler, false, 0, true);
		}
		
		private function addLinsteners():void{
			this._mahjongTimer.timelagBtn.addEventListener(MouseEvent.CLICK, timelagBtnClickHandler, false, 0, true);
		}
		
		private function timerEventHandler(event:TimerEvent):void{
			switch(event.type){
				case TimerEvent.TIMER:
					var remainCount:int = _repeatCount - _gameTimer.currentCount;
					if(remainCount == 0){
						this._mahjongTimer.timelagBtn.enabled = false;
					}
					randomPlaySonud(remainCount);
					this._mahjongTimer.timerTxt.text = (remainCount < 0 ? 0 : remainCount).toString();
					
					this._mahjongTimerService.timerHandler(remainCount, _isOnline);
					break;
				case TimerEvent.TIMER_COMPLETE:
					this._mahjongTimerService.timerCompleteHandler(_isOnline);
					break;
			}
		}
		
		private function randomPlaySonud(remainCount:int):void{
			if(_repeatCount - remainCount >= _count){
				
				if(40 >= _num){
					_count = 101;
					MahjongSoundService.instance.soundPlay("chat");
				}
			}
			
		}
		
		private function timelagBtnClickHandler(event:MouseEvent):void{
			if(_timelagCount >0 && _gameTimer.currentCount < _repeatCount){
				_repeatCount += 10;
				_gameTimer.repeatCount += 10;
				_timelagCount --;
				this._mahjongTimer.timelagBtn.enabled = false;
			}
		}
		
		private function setSite(azimuth:int):void{
			switch(azimuth){
				case 1://方位0
					this._mahjongTimer.visible = true;
//					this._mahjongTimer.x = _azimuth1.x;
//					this._mahjongTimer.y = _azimuth1.y;
					break;
				case 2://方位270
					this._mahjongTimer.visible = true;
//					this._mahjongTimer.x = _azimuth2.x;
//					this._mahjongTimer.y = _azimuth2.y;
					break;
				case 3://方位180
					this._mahjongTimer.visible = true;
//					this._mahjongTimer.x = _azimuth3.x;
//					this._mahjongTimer.y = _azimuth3.y;
					break;
				case 4://方位90
					this._mahjongTimer.visible = true;
//					this._mahjongTimer.x = _azimuth4.x;
//					this._mahjongTimer.y = _azimuth4.y;
					break;
				default:
					this._mahjongTimer.visible = false;
					this._mahjongTimer.x = 0;
					this._mahjongTimer.y = 0;
					break;
			}
		}
		
		public function reset():void{
			hide();
			_timelagCount = 1;
		}
		
		public function show(azimuth:int = 0, repeatCount:int = 20):void{
			this._gameTimer.reset();
			
			_isOnline = true;
			
			_repeatCount = repeatCount;
			_count = Math.random() * 5 + 5;
			_num = Math.random() * 100;
			_gameTimer.repeatCount = repeatCount + 1;
			
			this._mahjongTimer.timerTxt.text = repeatCount.toString();
			
			if(azimuth == 3){
				this._mahjongTimer.timelagBtn.visible = true;
				if(_timelagCount > 0){
					this._mahjongTimer.timelagBtn.enabled = true;
				}else{
					this._mahjongTimer.timelagBtn.enabled = false;
				}
			}else{
				this._mahjongTimer.timelagBtn.visible = false;
			}
			setSite(azimuth);
//			this._mahjongTimer.visible = true;
			
			this._gameTimer.start();
		}
		
		public function hide():void{
			this._gameTimer.reset();
			
			this._mahjongTimer.visible = false;
		}
		
		public function offline(isOnline:Boolean = false, waitTime:int = 50):void{
			this._gameTimer.reset();
			
			this._isOnline = isOnline;
			
			if(isOnline){
				switch(MahjongRoomControl.instance.putState){
					case 1:
						show();
						break;
					case 2:
						show(3, 20);
						break;
					case 3:
						show(3, 10);
						break;
					default:
//						this._mahjongTimer.timerTxt.text = waitTime.toString();
						this._mahjongTimer.timerTxt.text = "0";
						break;
				}
			}else{
				_repeatCount = waitTime;
				_gameTimer.repeatCount = waitTime + 1;
				
				this._mahjongTimer.timerTxt.text = waitTime.toString();
				this._mahjongTimer.timelagBtn.visible = false;
				setSite(0);
				this._mahjongTimer.visible = true;
				
				this._gameTimer.start();
			}
		}

		//-------------------------------------------------------------------------
		public static function get instance():MahjongTimerControl
		{
			return _instance;
		}

	}
}