package com.stock.services
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class NowWeituoService
	{
		public static var instance:NowWeituoService;
		
		[Bindable]
		public var nowWeituos:ArrayCollection;
		public function NowWeituoService()
		{
		}
		
		public static function getInstance():NowWeituoService{
			if(instance == null){
				instance = new NowWeituoService();
			}
			
			return instance;
		}
		
		public function getNowWeituo():void{
			RemoteService.instance.bshistoryService.getNowWeituoByPlayerName(PlayerService.instance.player.playerName);
			RemoteService.instance.bshistoryService.addEventListener(ResultEvent.RESULT,getNowWeituoResultHandler);
		}
		
		protected function getNowWeituoResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.bshistoryService.removeEventListener(ResultEvent.RESULT,getNowWeituoResultHandler);
			nowWeituos = event.result as ArrayCollection;
		}
	}
}