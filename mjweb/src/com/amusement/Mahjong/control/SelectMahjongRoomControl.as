package com.amusement.Mahjong.control
{
	import com.amusement.Mahjong.view.SelectMahjongRoom;
	
	import flash.events.MouseEvent;

	public class SelectMahjongRoomControl
	{
		private static var _instance:SelectMahjongRoomControl;
		
		private var _selectMahjongRoom:SelectMahjongRoom;
		
		public function SelectMahjongRoomControl(selectMahjongRoom:SelectMahjongRoom)
		{
			_instance = this;
			
			_selectMahjongRoom = selectMahjongRoom;
			
			init();
		}
		
		private function init():void{
			addListeners();
		}
		
		private function addListeners():void{
//			this._selectMahjongRoom.backBtn.addEventListener(MouseEvent.CLICK, btnClickHandler, false, 0, true);
		}
		
		private function btnClickHandler(event:MouseEvent):void{
			MahjongApplictionControl.instance.backHall();
		}
	}
}