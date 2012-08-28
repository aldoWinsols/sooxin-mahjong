package com.stock.services
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class BagService
	{
		[Bindable]
		public var bags:ArrayCollection;
		public static var instance:BagService;
		public function BagService()
		{
			getBags();
		}
		
		public static function getInstance():BagService{
			if(instance == null){
				instance = new BagService();
			}
			return instance;
		}
		
		public function getBags(){
			RemoteService.instance.bagService.getBagsByPlayerName(PlayerService.instance.player.playerName);
			RemoteService.instance.bagService.addEventListener(ResultEvent.RESULT,getBagsResultHandler);
		}
		
		public function getBagsResultHandler(e:ResultEvent):void{
			RemoteService.instance.bagService.removeEventListener(ResultEvent.RESULT,getBagsResultHandler);
			bags = e.result as ArrayCollection;
		}
	}
}