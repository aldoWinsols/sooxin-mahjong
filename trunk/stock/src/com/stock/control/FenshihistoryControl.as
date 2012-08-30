package com.stock.control
{
	import com.stock.services.BargainService;
	import com.stock.services.RemoteService;
	import com.stock.view.Fenshihistory;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class FenshihistoryControl
	{
		public static var instance:FenshihistoryControl;
		private var fenshihistory:Fenshihistory;
		public function FenshihistoryControl(fenshihistory:Fenshihistory)
		{
			this.fenshihistory = fenshihistory;
			instance = this;
			
		}
		
		public function init():void{
			
			this.fenshihistory.dg.dataProvider = BargainService.instance.cjhistorys;
		}

	}
}