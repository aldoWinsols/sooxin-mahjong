package com.stock.services
{
	import com.stock.control.BargainControl;
	import com.stock.control.LinechartControl;
	import com.stock.control.MainControl;
	import com.stock.model.Cjhistory;
	import com.stock.model.Stock;
	
	import mx.collections.ArrayList;

	public class MainService
	{
		
		public static var instance:MainService;
		public function MainService()
		{
		}
		
		public static function getInstance():MainService{
			if(instance == null){
				instance = new MainService();
			}
			return instance;
		}
		
		
	}
}