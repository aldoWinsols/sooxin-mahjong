package com.services
{
	import com.control.ChongzhiControl;
	import com.control.MainSenceControl;
	import com.control.RoomListControl;
	import com.model.Alert;
	import com.model.MainPlayer;
	import com.util.MD5;
	
	import mx.rpc.events.ResultEvent;

	public class MainPlayerService
	{
		[Bindable]
		public var mainPlayer:MainPlayer;
		
		[Bindable]
		public var roomNum5:int = 0;
		[Bindable]
		public var roomNum10:int = 0;
		[Bindable]
		public var roomNum20:int = 0;
		[Bindable]
		public var roomNum50:int = 0;
		[Bindable]
		public var roomNum100:int = 0;
		public static var _instance:MainPlayerService;
		public function MainPlayerService()
		{
			mainPlayer = new MainPlayer();
		}
		
		public static function getInstance():MainPlayerService
		{
			if(_instance == null){
				_instance = new MainPlayerService();
			}
			return _instance;
		}

		public static function set instance(value:MainPlayerService):void
		{
			_instance = value;
		}

		public function regeist(playerName:String, playerPwd:String):void{
			
		}
		
		public function login():void{
//			if(mainPlayer.playerName == ""){
				var player:MainPlayer = new MainPlayer();
				player.playerName = GameCenterService.instance.playerName;
				player.playerName = "sooo3xin" + (Math.random() * 3000);
				
				RemoteService.instance.playerService.login(player);
				RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,loginResultHandler);
//			}
		}
		
		private function loginResultHandler(e:ResultEvent):void{
			MainSenceControl.instance.mainSence.loginWaitInfo.visible = false;
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,loginResultHandler);
			mainPlayer = e.result as MainPlayer;
			MainSenceControl.instance.mainSence.currentState = "lianwangHome";
			
			if(RoomListControl.instance){
				RoomListControl.instance.roomList.dg.dataProvider = RoomListControl.instance.rooms;
			}
			
			if(RoomListControl.instance){
				RoomListControl.instance.checkReConn();
			}
			
		}
		
		public function chongzhi(money:Number):void{
			ChongzhiControl.instance.chongzhi.wait.visible = false;
			RemoteService.instance.playerService.chongzhi(mainPlayer.playerName, money);
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT, chongzhiResaultHandler);
		}
		
		private function chongzhiResaultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT, chongzhiResaultHandler);
			if(e.result is MainPlayer){
				Alert.show("充值成功!");
				this.mainPlayer = e.result as MainPlayer;
			}
			else{
				Alert.show(e.result.toString());
			}
		}
		
		
	}
}