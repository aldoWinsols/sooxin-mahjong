package com.services
{
	import com.model.Alert;
	import com.model.MainPlayer;
	import com.util.MD5;
	
	import mx.rpc.events.ResultEvent;

	public class MainPlayerService
	{
		public var mainPlayer:MainPlayer;
		[Bindable]
		public var roomNum10:int = 0;
		[Bindable]
		public var roomNum20:int = 0;
		[Bindable]
		public var roomNum50:int = 0;
		[Bindable]
		public var roomNum100:int = 0;
		private static var _instance:MainPlayerService;
		public function MainPlayerService()
		{

		}
		
		public static function get instance():MainPlayerService
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
		
		public function chongzhi(money:int):void{
			RemoteService.instance.playerService.chongzhi(mainPlayer.playername, money);
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
		
		public function setRoomNumByType(roomType:String, roomNum:int){
			switch(roomType){
				case "10":
					roomNum10 = roomNum;
					break
				case "20":
					roomNum20 = roomNum;
					break
				case "50":
					roomNum50 = roomNum;
					break
				case "100":
					roomNum100 = roomNum;
					break
			}
		}
	}
}