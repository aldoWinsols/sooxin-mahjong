package com.services
{
	import com.services.RemoteService;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class ConfigService
	{
		private static var _instance:ConfigService;
		
		public var mainSyncServerURL:String = "";
		
		public var mahjongSyncServerURL5:String = "";
		public var mahjongSyncServerURL10:String = "";
		public var mahjongSyncServerURL20:String = "";
		public var mahjongSyncServerURL50:String = "";
		public var mahjongSyncServerURL100:String = "";
		
		public function ConfigService()
		{
//			RemoteService.instance.configService.getConfig();
//			RemoteService.instance.configService.addEventListener(ResultEvent.RESULT, getConfigResult);
		}

		public static function get instance():ConfigService
		{
			if(_instance == null){
				_instance = new ConfigService();
			}
			return _instance;
		}
		
		private function getConfigResult(event:ResultEvent):void{
			if(event.result){
				var array:ArrayCollection = event.result as ArrayCollection;
				
				mahjongSyncServerURL5 = getConnectStr("mahjong5", array);
				mahjongSyncServerURL10 = getConnectStr("mahjong10", array);
				mahjongSyncServerURL20 = getConnectStr("mahjong20", array);
				mahjongSyncServerURL50 = getConnectStr("mahjong50", array);
				mahjongSyncServerURL100 = getConnectStr("mahjong100", array);
				mainSyncServerURL = getConnectStr("main", array);
			}
		}
		
		private function getConnectStr(connectType:String, array:ArrayCollection):String{
			for(var i:int = 0; i < array.length; i ++){
				if(array.getItemAt(i).connectType == connectType){
					return array.getItemAt(i).connectStr;
				}
			}
			return "";
		}
	}
}