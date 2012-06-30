package com.control
{
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.control.MahjongSeatControl;
	import com.model.Alert;
	import com.services.MainPlayerService;
	import com.services.RemoteService;
	import com.view.RoomList;
	
	import flash.events.MouseEvent;
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
			
			roomList.dg.addEventListener(MouseEvent.CLICK,dg_clickHandler);
			getRooms();
		}
		
		
		public var nowJoinRoomNum:int = 0;
		protected function dg_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
			if(!checkIsEnter(roomList.dg.selectedItem.fanNum)){
				Alert.show("您当前的点数少于此房间最小进入点数:"+roomList.dg.selectedItem.joinNum);
				return;
			}
			
			nowJoinRoomNum = roomList.dg.selectedItem.fanNum;
			LianwangHomeControl.instance.roomClick(roomList.dg.selectedItem.connUrl);
			MahjongRoomControl.instance._mahjongRoom.gameModel.text = "连网模式";
			MahjongRoomControl.instance.isNetwork = true;
			MahjongSeatControl.instance.stopShowChat();
			
			MainSenceControl.instance.mainSence.currentState =  "gameing";
			MainSenceControl.instance.mainSence.waitInfo.visible = true;
			
			MahjongRoomControl.instance._mahjongRoom.roomName.text = roomList.dg.selectedItem.fanNum + "点/番";
		}
		
		public function reEnterRoom(roomNum:int):void{
			var url:String = "";
			var item:Object;
			
			for(var i:int=0; i<rooms.length;i++){
				if(roomNum == rooms.getItemAt(i).fanNum){
					item = rooms.getItemAt(i);
					url = rooms.getItemAt(i).connUrl;
				}
			}
			
			LianwangHomeControl.instance.roomClick(url);
			MahjongRoomControl.instance._mahjongRoom.gameModel.text = "连网模式";
			MahjongRoomControl.instance.isNetwork = true;
			MahjongSeatControl.instance.stopShowChat();
			
			MainSenceControl.instance.mainSence.currentState =  "gameing";
			MainSenceControl.instance.mainSence.waitInfo.visible = true;
			
			MahjongRoomControl.instance._mahjongRoom.roomName.text = item.fanNum + "点/番";
		}
		
		public function checkIsEnter(roomNum:int):Boolean{
			for(var i:int=0; i<rooms.length; i++){
				if(roomNum == rooms.getItemAt(i).fanNum){
					if(MainPlayerService.getInstance().mainPlayer.haveMoney < rooms.getItemAt(i).joinNum){
						return false;
					}
				}
			}
			
			return true;
		}
		
		public function getRooms():void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.roomService.getRooms();
			RemoteService.instance.roomService.addEventListener(ResultEvent.RESULT,getRoomsResultHandler);
		}
		
		public var rooms:ArrayCollection;
		private function getRoomsResultHandler(e:ResultEvent):void{
			RemoteService.instance.roomService.removeEventListener(ResultEvent.RESULT,getRoomsResultHandler);
			rooms = e.result as ArrayCollection;
			for(var i:int=0; i<rooms.length; i++){
				if(!rooms.getItemAt(i).isView){
					rooms.removeItemAt(i);
					i--;
				}
			}
			roomList.dg.dataProvider = rooms;
			
			if(MainPlayerService.getInstance().mainPlayer.offlineGameNo != 0){
				reEnterRoom(MainPlayerService.getInstance().mainPlayer.offlineGameNo);
			}
		}
		
		public function setRoomNumByType(roomType:String, roomNum:int):void{
			try{
				var arr:ArrayCollection = roomList.dg.dataProvider as ArrayCollection;
				for(var i:int=0; i<arr.length; i++){
					if(arr.getItemAt(i).fanNum == roomType){
						arr.getItemAt(i).onlineNum = roomNum;
					}
				}
				roomList.dg.dataProvider = arr;
			}catch(e:Error){
				
			}
			
		}
	}
}