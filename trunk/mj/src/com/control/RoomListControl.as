package com.control
{
	import com.services.RemoteService;
	import com.view.RoomList;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import spark.events.GridSelectionEvent;

	public class RoomListControl
	{
		private var roomList:RoomList;
		public static var instance:RoomListControl;
		public function RoomListControl(roomList:RoomList)
		{
			this.roomList = roomList;
			instance = this;
			
			roomList.dg.addEventListener(GridSelectionEvent.SELECTION_CHANGE,dg_selectionChangeHandler);
			getRooms();
		}
		
		protected function dg_selectionChangeHandler(event:GridSelectionEvent):void
		{
			// TODO Auto-generated method stub
			LianwangHomeControl.instance.roomClick(roomList.dg.selectedItem.connUrl);
		}
		
		public function getRooms():void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.roomService.getRooms();
			RemoteService.instance.roomService.addEventListener(ResultEvent.RESULT,getRoomsResultHandler);
		}
		
		private function getRoomsResultHandler(e:ResultEvent):void{
			RemoteService.instance.roomService.removeEventListener(ResultEvent.RESULT,getRoomsResultHandler);
			roomList.dg.dataProvider = e.result as ArrayCollection;
		}
		
		public function setRoomNumByType(roomType:String, roomNum:int):void{
			var arr:ArrayCollection = roomList.dg.dataProvider as ArrayCollection;
			for(var i:int=0; i<arr.length; i++){
				if(arr.getItemAt(i).fanNum == roomType){
					arr.getItemAt(i).onlineNum = roomNum;
				}
			}
			roomList.dg.dataProvider = arr;
		}
	}
}