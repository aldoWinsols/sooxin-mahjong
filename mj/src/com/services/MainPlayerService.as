package com.services
{
	import com.control.ChongzhiControl;
	import com.control.LianwangHomeControl;
	import com.control.MainSenceControl;
	import com.control.RoomListControl;
	import com.model.Alert;
	import com.model.MainPlayer;
	import com.util.MD5;
	import com.view.MainSence;
	
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
		
		public function itunesLogin():void{
			if(GameCenterService.instance.playerName == ""){
				Alert.show("您当前系统没有APPLE帐户登录，请登录后再进行操作！具体步骤为：设置→Store→登录→");
				LianwangHomeControl.instance.lianwangHome.loginWaitInfo.visible = false;
				return;
			}

			var player:MainPlayer = new MainPlayer();
			player.playerName = GameCenterService.instance.playerName;
//			player.playerName = "sooooxin";
			
			RemoteService.instance.playerService.login(player);
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,itunesLoginResultHandler);
		}
		
		public function login(player:MainPlayer):void{
			RemoteService.instance.playerService.login(player,0);
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,loginResultHandler);
		}
		private function loginResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,loginResultHandler);
			LianwangHomeControl.instance.lianwangHome.loginWaitInfo.visible = false;
			if(e.result is MainPlayer){
				mainPlayer = e.result as MainPlayer;
				LianwangHomeControl.instance.lianwangHome.currentState = "main";
				if(!ConfigService.instance.config.hideJiangpin){
					LianwangHomeControl.instance.lianwangHome.mainLiwuB.visible = true;
					LianwangHomeControl.instance.lianwangHome.mainHomeB.x = 489;
				}
				
				if(RoomListControl.instance){
					RoomListControl.instance.roomList.dg.dataProvider = RoomListControl.instance.rooms;
				}
				
				if(RoomListControl.instance){
					RoomListControl.instance.checkReConn();
				}
			}else{
				Alert.show(e.result.toString());
			}
		}
		
		private function itunesLoginResultHandler(e:ResultEvent):void{
			LianwangHomeControl.instance.lianwangHome.loginWaitInfo.visible = false;
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,itunesLoginResultHandler);
			mainPlayer = e.result as MainPlayer;
			
			LianwangHomeControl.instance.lianwangHome.currentState = "main";
			if(!ConfigService.instance.config.hideJiangpin){
				LianwangHomeControl.instance.lianwangHome.mainLiwuB.visible = true;
				LianwangHomeControl.instance.lianwangHome.mainHomeB.x = 489;
			}
			
			if(RoomListControl.instance){
				RoomListControl.instance.roomList.dg.dataProvider = RoomListControl.instance.rooms;
			}
			
			if(RoomListControl.instance){
				RoomListControl.instance.checkReConn();
			}
			
		}
		
		public function chongzhi(money:Number,receipt:String):void{
//			Alert.show(receipt);
			ChongzhiControl.instance.chongzhi.wait.visible = false;
			RemoteService.instance.playerService.chongzhi(mainPlayer.playerName, money, receipt);
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