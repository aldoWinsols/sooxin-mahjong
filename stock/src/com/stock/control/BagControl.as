package com.stock.control
{
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.view.Bag;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class BagControl
	{
		public static var instance:BagControl;
		private var bag:Bag;
		public function BagControl(bag:Bag)
		{
			this.bag = bag;
			instance = this;
			
			getBags();
		}
		
		public function getBags(){
			RemoteService.instance.bagService.getBagsByPlayerName(PlayerService.instance.player.playerName);
			RemoteService.instance.bagService.addEventListener(ResultEvent.RESULT,getBagsResultHandler);
		}
		
		public function getBagsResultHandler(e:ResultEvent):void{
			RemoteService.instance.bagService.removeEventListener(ResultEvent.RESULT,getBagsResultHandler);
			this.bag.dg.dataProvider = e.result as ArrayCollection;
		}
	}
}