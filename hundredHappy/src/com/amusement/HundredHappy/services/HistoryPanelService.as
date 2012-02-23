package com.amusement.HundredHappy.services
{
	import com.amusement.HundredHappy.control.HistoryPanelControl;
	
	public class HistoryPanelService
	{
		private static var _instance:HistoryPanelService;
		
		[Bindable]
		public var historyZhang:Number = 0;
		[Bindable]
		public var historyXian:Number = 0;
		[Bindable]
		public var historyHe:Number = 0;
		
		public function HistoryPanelService()
		{
		}

		public static function get instance():HistoryPanelService
		{
			if(_instance == null){
				_instance = new HistoryPanelService();
			}
				
			return _instance;
		}
		
		private function updateHistroyNum(str:String):void{
			switch(str){
				case "z":
					historyZhang += 1;
					break;
				case "x":
					historyXian += 1;
					break;
				case "h":
					historyHe += 1;
					break;
			}
		}
		
		public function initHistroy(arr:Array):void{
			for(var i:int = 0; i< arr.length; i ++){
				addHistroy(arr[i].result, arr[i].type);
			}
		}
		
		public function clearHistroys():void{
			historyZhang = 0;
			historyXian = 0;
			historyHe = 0;
			
			HistoryPanelControl.instance.clearHistory();
		}
		
		public function addHistroy(result:String, type:int):void{
			if(result == "z" || result == "x" || result == "h"){
				HistoryPanelControl.instance.addHistory(result, type);
				updateHistroyNum(result);
			}
		}
		
		public function askWay(str:String):void{
			if(str == "z" || str == "x"){
				HistoryPanelControl.instance.askWay(str);
			}
		}
	}
}