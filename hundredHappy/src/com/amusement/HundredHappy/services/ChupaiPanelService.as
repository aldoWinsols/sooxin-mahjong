package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.ChupaiPanelControl;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class ChupaiPanelService
	{
		private static var _instance:ChupaiPanelService;
		
		private var _chupaiTimer:Timer;
		
		private var _xPokerArray:Array;
		private var _zPokerArray:Array;
		
		private var _type:String = "x";
		
		public function ChupaiPanelService()
		{
			_xPokerArray = [];
			_zPokerArray = [];
			
			_chupaiTimer = new Timer(3000,6);
			_chupaiTimer.addEventListener(TimerEvent.TIMER , chupaiTimerHandler, false, 0, true);
		}

		public static function get instance():ChupaiPanelService
		{
			if(_instance == null){
				_instance = new ChupaiPanelService();
			}
			return _instance;
		}
		
		public function reset():void{
			_chupaiTimer.reset();
			
			_xPokerArray.splice(0, _xPokerArray.length);
			_zPokerArray.splice(0, _zPokerArray.length);
			
			_type = "x";
			
			ChupaiPanelControl.instance.hide();
		}
		
		private function chupaiTimerHandler(e:TimerEvent):void{
			if(_type == "x"){
				if(_xPokerArray.length > 0){
					ChupaiPanelControl.instance.chupai(_xPokerArray.shift(), _type);
					_type = "y";
				}else if(_zPokerArray.length > 0){
					_type = "y";
					ChupaiPanelControl.instance.chupai(_zPokerArray.shift(), _type);
					_type = "x";
				}
			}else{
				if(_zPokerArray.length > 0){
					ChupaiPanelControl.instance.chupai(_zPokerArray.shift(), _type);
					_type = "x";
				}
			}
			
			if(_xPokerArray.length == 0 && _zPokerArray.length == 0){
				_chupaiTimer.stop();
			}
		}
		
		public function startShowPokers(zPokers:Array, xPokers:Array):void{
			reset();
			
			this._zPokerArray = zPokers;
			this._xPokerArray = xPokers;
			
			_chupaiTimer.start();
			ChupaiPanelControl.instance.show();
		}
	}
}