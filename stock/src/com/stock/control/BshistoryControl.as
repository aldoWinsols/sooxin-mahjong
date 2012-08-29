package com.stock.control
{
	import com.stock.services.BshistoryService;
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.view.Bshistory;
	
	import mx.binding.utils.BindingUtils;
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
			
			BindingUtils.bindProperty(this.bshistory.dg,"dataProvider",BshistoryService.getInstance(),"bshistorys");
		}
	}
}