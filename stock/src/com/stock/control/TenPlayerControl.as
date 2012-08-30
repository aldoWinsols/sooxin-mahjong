package com.stock.control
{
	import com.stock.services.BargainService;
	import com.stock.services.RemoteService;
	import com.stock.view.TenPlayer;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class TenPlayerControl
	{
		public static var instance:TenPlayerControl;
		private var tenPlayer:TenPlayer;
		public function TenPlayerControl(tenPlayer:TenPlayer)
		{
			this.tenPlayer = tenPlayer;
			instance = this;
		}
		
		public function getTenPlayers(){
			RemoteService.instance.tenPlayerService.getTenPlayers(BargainService.instance.stock.stockCode);
			RemoteService.instance.tenPlayerService.addEventListener(ResultEvent.RESULT,getTenPlayersResultHandler);
		}
		
		protected function getTenPlayersResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.tenPlayerService.removeEventListener(ResultEvent.RESULT,getTenPlayersResultHandler);
			this.tenPlayer.dg.dataProvider = event.result as ArrayCollection;
		}
	}
}