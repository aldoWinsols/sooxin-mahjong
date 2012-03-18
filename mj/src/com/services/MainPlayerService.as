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
		
	}
}