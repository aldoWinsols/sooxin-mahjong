package com.amusement.HundredHappy.control
{
	
	import com.amusement.HundredHappy.model.Room;
	import com.amusement.HundredHappy.services.GameHallPanelService;
	import com.amusement.HundredHappy.services.HundredHappySyncService;
	import com.amusement.HundredHappy.view.GameHallPanel;
	import com.service.PlayerService;
	
	import flash.events.MouseEvent;
	
	public class GameHallPanelControl
	{
		private static var _instance:GameHallPanelControl = null;
		
		private var _gameHallPanel:GameHallPanel = null;
		
		public function GameHallPanelControl(gameHallPanel:GameHallPanel)
		{
			_instance = this;
			
			this._gameHallPanel = gameHallPanel;
			
//			this._gameHallPanel.notice.start(13);
			
			init();
		}
		
		private function init():void{
			addListeners();
		}
		
		private function addListeners():void{
			_gameHallPanel.exitBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "exitBtn":
					HundredHappySyncService.instance.closeConn();
					
					clearRooms();
					
					HundredHappyControl.instance.unload();
					break;
			}
		}
		
		private function getGameHallHistoryByRoomNo(roomNo:String):Room{
			var room:Room;
			for(var i:int = 0; i < this._gameHallPanel.roomList.numChildren; i ++){
				room = this._gameHallPanel.roomList.getChildAt(i) as Room;
				if(room){
					if(room.roomName == roomNo){
						return room;
					}
				}
			}
			return null;
		}

		public function initRoom(array:Array):void{
			var history:Array;
			var strArr:Array;
			for(var i:int = 0; i < array.length; i ++){
				var room:Room = new Room();
				this._gameHallPanel.roomList.addElement(room);
				
				room.setLimitList(PlayerService.instance.player.acctLimits);
				
				strArr = array[i].toString().split(",");
				room.roomName = strArr.shift();
				room.setRoomState(strArr.shift());
				for(var j:int = 0; j < strArr.length - 1; j ++){
					history = strArr[j].split(";");
					room.addHistory(history[0], history[1]);
				}
			}
		} 
		
		public function addRoom(roomNo:String):void{
			var gameHallHistory:Room = new Room();
			this._gameHallPanel.roomList.addElement(gameHallHistory);
			
			gameHallHistory.name = roomNo;
		}
		
		public function removeRoom(roomNo:String):void{
			var room:Room;
			for(var i:int = 0;i < this._gameHallPanel.roomList.numChildren; i++){
				room = this._gameHallPanel.roomList.getChildAt(i) as Room;
				if(room){
					if(room.name == roomNo){
						this._gameHallPanel.roomList.removeElement(room);
					}
				}
			}
		}
		
		public function clearRooms():void{
			this._gameHallPanel.roomList.removeAllElements();
		}
		
		public function addRoomHistory(roomNo:String, str:String, type:int):void{
			var room:Room = getGameHallHistoryByRoomNo(roomNo);
			if(room){
				room.addHistory(str, type);
			}
		}
		
		public function updateRoomState(state:int, roomNo:String):void{
			var room:Room = getGameHallHistoryByRoomNo(roomNo);
			if(room){
				room.setRoomState(state);
			}
		}
		
		public function hideRoomLimitList():void{
			var room:Room = getGameHallHistoryByRoomNo(GameHallPanelService.instance.selectRoomNo);
			if(room){
				room.hideLimitList();
			}
		}
		
		public function updateRoomCountdown(count:int, roomNo:String):void{
			var room:Room = getGameHallHistoryByRoomNo(roomNo);
			if(room){
				room.updateCountdown(count);
			}
		}
		
		public static function get instance():GameHallPanelControl
		{
			return _instance;
		}
	}
}