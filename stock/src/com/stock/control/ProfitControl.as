package com.stock.control
{
	import com.stock.services.BargainService;
	import com.stock.services.RemoteService;
	import com.stock.view.Profit;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class ProfitControl
	{
		public static var instance:ProfitControl;
		private var profit:Profit;
		public function ProfitControl(profit:Profit)
		{
			this.profit = profit;
			instance = this;
		}
		
		public function getProfits(){
			RemoteService.instance.stockInfoService.getProfits(BargainService.instance.stock.stockCode);
			RemoteService.instance.stockInfoService.addEventListener(ResultEvent.RESULT,getProfitsResultHandler);
		}
		
		protected function getProfitsResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.stockInfoService.removeEventListener(ResultEvent.RESULT,getProfitsResultHandler);
			this.profit.dg.dataProvider = event.result as ArrayCollection;
		}
	}
}