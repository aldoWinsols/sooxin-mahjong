package com.services
{
	import com.model.Alert;
	import com.model.MainPlayer;
	import com.util.MD5;
	
	import mx.rpc.events.ResultEvent;

	public class MainPlayerService
	{
		public var mainPlayer:MainPlayer;
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
		
	}
}