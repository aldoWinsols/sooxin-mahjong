package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.GameHallPanelControl;
	public class GameHallPanelService
	{
		private static var _instance:GameHallPanelService;
		
		private var _selectRoomNo:String;
		
		public function GameHallPanelService()
		{
			_selectRoomNo = "";
		}

		public static function get instance():GameHallPanelService
		{
			if(_instance == null){
				_instance = new GameHallPanelService();
			}
			return _instance;
		}
		
		public function initRoom(array:Vector.<String>):void{
			GameHallPanelControl.instance.initRoom(array);
		}
		
		public function addHistoryByRoom(roomNo:String, str:String, type:int):void{
			GameHallPanelControl.instance.addRoomHistory(roomNo, str, type);
		}
		
		public function updateStateByRoom(state:int, roomNo:String):void{
//			trace(roomNo + "---------" + state);
			GameHallPanelControl.instance.updateRoomState(state, roomNo);
		}
		
		public function hideLimitList():void{
			GameHallPanelControl.instance.hideRoomLimitList();
		}
		
		public function updateCountdownByRoom(count:int, roomNo:String):void{
			GameHallPanelControl.instance.updateRoomCountdown(count, roomNo);
		}
		
		public function enterRoom(max:String, min:String):void{
//			MainSceneControl.instance.setZezhaoVisible(true);
			MessageService.instance.enterRoom(_selectRoomNo);
		}
		
		public function resetRoom():void{
			hideLimitList();
			_selectRoomNo = "";
		}

		//-----------------------------------------------------------------------
		public function get selectRoomNo():String
		{
			return _selectRoomNo;
		}

		public function set selectRoomNo(value:String):void
		{
			_selectRoomNo = value;
		}
	}
}