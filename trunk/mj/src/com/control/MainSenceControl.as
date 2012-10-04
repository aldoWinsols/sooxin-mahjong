package com.control
{
	import com.amusement.Mahjong.control.MahjongApplictionControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.service.MahjongSyncService;
	import com.mahjongSyncServer.services.RoomService;
	import com.model.Alert;
	import com.services.ChatService;
	import com.services.ConfigService;
	import com.services.DataService;
	import com.services.GameCenterService;
	import com.services.MainPlayerService;
	import com.services.MainSyncService;
	import com.services.RemoteService;
	import com.view.MainSence;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;

	public class MainSenceControl
	{
		public static var instance:MainSenceControl;
		public var mainSence:MainSence;
		public static var hasAccessToken:Boolean = false;
		private var appKey:String = "801121817";
		private var appSecret:String = "44e1659a923015c2f4d912a935eacdb2";
		
		public function MainSenceControl(mainSence:MainSence)
		{
			this.mainSence = mainSence;
			instance = this;
			
			ChatService.getInstance();
			GameCenterService.getInstance();
			RemoteService.getInstance();
			
			DataService.instance;
			
			MainPlayerService.getInstance();

			this.mainSence.currentState = "lianwangHome";
//			this.mainSence.currentState = "verifier";
			this.mainSence.currentState = "gameing";
			
			this.mainSence.currentState = "lianwangHome";
			
			ConfigService.getInstance();
			RemoteService.getInstance().init();
			ConfigService.instance.getConfig();
			
//			mobileConfig();
			
//			this.mainSence.mainButDJ.addEventListener(MouseEvent.CLICK,mainButDJClickHandler);
//			this.mainSence.mainButQQ.addEventListener(MouseEvent.CLICK,mainButQQClickHandler);
//			this.mainSence.mainButLW.addEventListener(MouseEvent.CLICK,mainButLWClickHandler);
//			this.mainSence.verifierCommitB.addEventListener(MouseEvent.CLICK,verifierCommitBClickHandler);
//			this.mainSence.verifierCancelB.addEventListener(MouseEvent.CLICK,verifierCancelBClickHandler);
		}

		
		
		
		public function mainButDJClickHandler(e:MouseEvent):void{
			
			MainSenceControl.instance.mainSence.currentState = "gameing";
			
			MahjongRoomControl.instance.clearTabletop();
			
			this.mainSence.mahjongAppliction.visible = true;
			MahjongRoomControl.instance._mahjongRoom.jiesuanOperation.visible = false;
			MahjongRoomControl.instance.isNetwork = false;
			MahjongRoomControl.instance._mahjongRoom.roomType.visible = false;
			MahjongApplictionControl.instance._mahjongAppliction.mahjongRoom.visible = true;
			MahjongSyncService.instance.isNetwork = false;
			MahjongRoomControl.instance._mahjongRoom.gameModel.text = "单机模式";
			RoomService.instance.beginGame("player", 10000);
			
		}
		private function mainButQQClickHandler(e:MouseEvent):void{
//			if(hasAccessToken)
//			{
//				this.mainSence.currentState = "lianwangHome";
//			}
//			else
//			{
//				//获取未授权的Token
//				authorizeAPI.openUserAuthPage();
//				this.mainSence.currentState = "verifier";
//			}
			
		}

	}
}