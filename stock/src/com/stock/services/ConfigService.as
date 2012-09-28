package com.stock.services
{
	import com.stock.model.Config;
	
	import mx.rpc.events.ResultEvent;

	public class ConfigService
	{
		public var config:Config;
		public static var instance:ConfigService;
		public function ConfigService()
		{
			RemoteService.instance.configService.getConfig();
			RemoteService.instance.configService.addEventListener(ResultEvent.RESULT,getConfigResultHandler);
		}
		
		protected function getConfigResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.configService.removeEventListener(ResultEvent.RESULT,getConfigResultHandler);
			config = event.result as Config;
		}
		
		public static function getInstance():ConfigService{
			if(instance == null){
				instance = new ConfigService();
			}
			
			return instance;
		}
	}
}