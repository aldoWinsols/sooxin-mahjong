package com.control
{
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.control.MahjongSeatControl;
	import com.model.Alert;
	import com.model.RoomMenu;
	import com.services.MainPlayerService;
	import com.services.MainSyncService;
	import com.services.RemoteService;
	import com.tencent.weibo.api.List;
	import com.view.RoomList;
	
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.utils.Timer;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import spark.events.GridSelectionEvent;

	[Bindable]
	public class RoomListControl
	{
		public var roomList:RoomList;
		public static var instance:RoomListControl;

		public var rooms:ArrayCollection = new ArrayCollection();
		
		public function RoomListControl(roomList:RoomList)
		{
			this.roomList = roomList;
			instance = this;
			
			if(MainControl.instance.main.applicationDPI == 320){
				roomList.dg.alpha = 1;
				roomList.roomListViewNavigator.title="";
			}
			
//			roomList.dg.addEventListener(MouseEvent.CLICK,dg_clickHandler);
			roomList.dg.selectedItem = null;
			roomList.dg.addEventListener(GridSelectionEvent.SELECTION_CHANGE,dg_clickHandler);
			getRooms();
			
		}
		
		
		public var nowJoinRoomNum:int = 0;
		protected function dg_clickHandler(event:GridSelectionEvent):void
		{
			// TODO Auto-generated method stub
			if(roomList.dg.selectedItem.onlineNum >= 300){
				Alert.show("房间人数已满，请稍微尝试！");
				roomList.dg.selectedItem = null;
				return;
			}
			
			if(!checkIsEnter(roomList.dg.selectedItem.fanNum)){
				Alert.show("您当前的点数少于此房间最小进入点数:"+roomList.dg.selectedItem.joinNum);
				roomList.dg.selectedItem = null;
				return;
			}
			
			nowJoinRoomNum = roomList.dg.selectedItem.fanNum;
			LianwangHomeControl.instance.roomClick(roomList.dg.selectedItem.connUrl);
			MahjongRoomControl.instance._mahjongRoom.gameModel.text = "连网模式";
			MahjongRoomControl.instance.isNetwork = true;
			MahjongSeatControl.instance.stopShowChat();
			
			MainSenceControl.instance.mainSence.currentState =  "gameing";
			MainSenceControl.instance.mainSence.waitInfo.visible = true;
			
			MahjongRoomControl.instance._mahjongRoom.roomType.visible = true;
			MahjongRoomControl.instance._mahjongRoom.roomName.text = roomList.dg.selectedItem.fanNum + "点/番";
			
			roomList.dg.selectedItem = null;
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
		
		
		private function getRoomsResultHandler(e:ResultEvent):void{
			RemoteService.instance.roomService.removeEventListener(ResultEvent.RESULT,getRoomsResultHandler);
			rooms = new ArrayCollection();
			var arr:ArrayCollection = e.result as ArrayCollection;
			for(var i:int=0; i<arr.length; i++){
				if(!arr.getItemAt(i).isView){
					arr.removeItemAt(i);
					i--;
				}else{
					rooms.addItem(arr.getItemAt(i) as RoomMenu);
				}
			}
			
			this.roomList.dg.dataProvider = rooms;

			//获取房间列表后再连接主服务
			MainSyncService.instance.connServer(MainPlayerService.getInstance().mainPlayer.playerName);
			
			checkReConn();
		}
		
		public function checkReConn():void{
			if(MainPlayerService.getInstance().mainPlayer.offlineGameNo != 0){
				reEnterRoom(MainPlayerService.getInstance().mainPlayer.offlineGameNo);
			}
		}
		
		public function setRoomNumByType(roomType:String, roomNum:int):void{
//			try{
//			var arr:ArrayCollection = new ArrayCollection(rooms.toArray());
				for(var i:int=0; i<rooms.length; i++){
					if(rooms.getItemAt(i).fanNum == roomType){
						rooms.getItemAt(i).onlineNum = roomNum;
					}
				}
//				rooms = arr;
//				this.roomList.dg.dataProvider = arr;
//			}catch(e:Error){
//				
//			}
			
		}
	}
}