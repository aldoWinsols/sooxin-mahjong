package com.services
{
	import com.control.MainSenceControl;
	import com.model.Config;
	
	import mx.rpc.events.ResultEvent;

	public class ConfigService
	{
		public static var instance:ConfigService;
		public var config:Config = new Config();
		public function ConfigService()
		{
	
		}
		
		public function getConfig():void{
			RemoteService.instance.configService.getConfig();
			RemoteService.instance.configService.addEventListener(ResultEvent.RESULT,getConfigHandler);
		}
		
		
		private function getConfigHandler(e:ResultEvent):void{
			RemoteService.instance.configService.removeEventListener(ResultEvent.RESULT,getConfigHandler);
			config = e.result as Config;
			
			if(MainSenceControl.instance.mainSence.currentState == "login"){
				MainPlayerService.getInstance().login();
			}
		}
		public static function getInstance():ConfigService{
			if(instance == null){
				instance = new ConfigService();
			}
			return instance;
		}
	}
}