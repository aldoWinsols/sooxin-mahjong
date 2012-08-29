package com.stock.services
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class BshistoryService
	{
		[Bindable]
		public var bshistorys:ArrayCollection;
		
		public static var instance:BshistoryService;
		public function BshistoryService()
		{
			bshistorys = new ArrayCollection();
		}
		
		public static function getInstance():BshistoryService{
			if(instance == null){
				instance = new BshistoryService();
			}
			return instance;
		}
		
		public function getBshistory(){
			RemoteService.instance.bshistoryService.getBshistoryByPlayerName(PlayerService.instance.player.playerName);
			RemoteService.instance.bshistoryService.addEventListener(ResultEvent.RESULT,getBshistoryResultHandler);
		}
		
		private function getBshistoryResultHandler(e:ResultEvent):void{
			RemoteService.instance.bshistoryService.removeEventListener(ResultEvent.RESULT,getBshistoryResultHandler);
			bshistorys = e.result as ArrayCollection;
		}
	}
}