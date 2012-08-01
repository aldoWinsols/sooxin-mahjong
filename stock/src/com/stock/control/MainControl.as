package com.stock.control
{
	import com.stock.services.MainService;
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.services.StockSyncService;
	import com.stock.view.Main;
	
	import mx.binding.utils.BindingUtils;

	public class MainControl
	{
		public static var instance:MainControl;
		public var main:Main;
		public function MainControl(main:Main)
		{
			this.main = main;
			instance = this;
			
			this.main.currentState = "stockList";
			
			RemoteService.getInstance();
			PlayerService.getInstance();
			MainService.getInstance();
			StockSyncService.getInstance();
			
			BindingUtils.bindProperty(this.main.stockList.list,"dataProvider",MainService.instance,"stocks");
		}
	}
}