package com.stock.control
{
	import com.stock.services.BagService;
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.view.Bag;
	
	import mx.binding.utils.BindingUtils;
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
			
			BindingUtils.bindProperty(this.bag.dg,"dataProvider",BagService.getInstance(),"bags");
		}
	}
}