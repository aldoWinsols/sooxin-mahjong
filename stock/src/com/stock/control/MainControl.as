package com.stock.control
{
	import com.stock.services.MainService;
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.services.StockSyncService;
	import com.stock.view.Main;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;

	public class MainControl
	{
		public static var instance:MainControl;
		public var main:Main;
		public function MainControl(main:Main)
		{
			this.main = main;
			instance = this;
			
			RemoteService.getInstance();
			PlayerService.getInstance();
			MainService.getInstance();
			
			this.main.currentState = "login";
		}
		
		
	}
}