package com.girlfriend.control
{
	import com.girlfriend.model.Ware;
	import com.girlfriend.view.Store;
	
	import mx.collections.ArrayList;

	public class StoreControl
	{
		private var store:Store;
		private var wareList:Vector.<Ware> = new Vector.<Ware>();//在销商品
		public function StoreControl(store:Store)
		{
			this.store = store;
		}
		
		
		private function buy():void{
			
		}
	}
}