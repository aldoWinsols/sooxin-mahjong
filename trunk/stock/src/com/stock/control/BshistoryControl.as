package com.stock.control
{
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.view.Bshistory;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class BshistoryControl
	{
		public static var instance:BshistoryControl;
		private var bshistory:Bshistory;
		public function BshistoryControl(bshistory:Bshistory)
		{
			this.bshistory = bshistory;
			instance = this;
			
			getBshistory();
		}
		
		public function getBshistory(){
			RemoteService.instance.bshistoryService.getBshistoryByPlayerName(PlayerService.instance.player.playerName);
			RemoteService.instance.bshistoryService.addEventListener(ResultEvent.RESULT,getBshistoryResultHandler);
		}
		
		private function getBshistoryResultHandler(e:ResultEvent):void{
			RemoteService.instance.bshistoryService.removeEventListener(ResultEvent.RESULT,getBshistoryResultHandler);
			this.bshistory.dg.dataProvider = e.result as ArrayCollection;
		}
	}
}