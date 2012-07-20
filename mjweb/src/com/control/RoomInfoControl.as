package com.control
{
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.service.MahjongSyncNetworkService;
	import com.view.CreateRoom;
	import com.view.RoomInfo;
	
	import flash.events.MouseEvent;

	public class RoomInfoControl
	{
		private var roomInfo:CreateRoom;
		public function RoomInfoControl(roomInfo:CreateRoom)
		{
			this.roomInfo = roomInfo;
			this.roomInfo.currentState = "create";
			this.roomInfo.currentState = "enter";
			this.roomInfo.currentState = "main";
			
			this.roomInfo.btnEnterGame.addEventListener(MouseEvent.CLICK, onBtnEnterGame);
			this.roomInfo.btnOk.addEventListener(MouseEvent.CLICK, onBtnOk);
			this.roomInfo.btnCreateRoom.addEventListener(MouseEvent.CLICK, onBtnCreateRoom);
			this.roomInfo.btnEnterRoom.addEventListener(MouseEvent.CLICK, onBtnEnterRoom);
		}
		
		private function onBtnEnterGame(e:MouseEvent):void{
			var roomNo1:String = roomInfo.txtRoomNo0.text;
			var password1:String = roomInfo.txtRoomPassword0.text;
			
			
			LianwangHomeControl.instance.roomClick("rtmp://127.0.0.1/createMahjongSyncServer");
			
			MahjongSyncNetworkService.instance.enterRoom(roomNo1, password1);
			
			
			
			MainSenceControl.instance.mainSence.currentState =  "gameing";
			MainSenceControl.instance.mainSence.waitInfo.visible = true;
			
			MahjongRoomControl.instance._mahjongRoom.roomType.visible = true;
			MahjongRoomControl.instance._mahjongRoom.roomName.text = 5 + "点/番";
		}
		
		private function onBtnOk(e:MouseEvent):void{
			
			var roomNo:String = roomInfo.txtRoomNo.text;
			var password:String = roomInfo.txtRoomPassword.text;
			var roomNum:int = int(roomInfo.txtRoomNum.text);
			var enterRoomNum:int = int(roomInfo.txtEnterRoomNum.text);
			var maxFanNum:int = int(roomInfo.txtMaxFanNum.text);
			
			LianwangHomeControl.instance.roomClick("rtmp://127.0.0.1/createMahjongSyncServer");
			
			MahjongSyncNetworkService.instance.createRoomService(roomNo, password, enterRoomNum, maxFanNum, roomNum);
			
			
			
			MainSenceControl.instance.mainSence.currentState =  "gameing";
			MainSenceControl.instance.mainSence.waitInfo.visible = true;
			
			MahjongRoomControl.instance._mahjongRoom.roomType.visible = true;
			MahjongRoomControl.instance._mahjongRoom.roomName.text = 5 + "点/番";
		}
		
		private function onBtnCreateRoom(e:MouseEvent):void{
			this.roomInfo.currentState = "create";
		}
		
		private function onBtnEnterRoom(e:MouseEvent):void{
			this.roomInfo.currentState = "enter";
		}
	}
}