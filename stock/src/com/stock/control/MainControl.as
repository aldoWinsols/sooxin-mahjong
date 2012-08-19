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
			StockSyncService.getInstance();
			
			this.main.currentState = "stockList";
			this.main.indexB.addEventListener(MouseEvent.CLICK,indexBClickHandler);
			this.main.accountB.addEventListener(MouseEvent.CLICK,accountBClickHandler);
			this.main.zhijinB.addEventListener(MouseEvent.CLICK,zhijinBClickHandler);
			this.main.weituoB.addEventListener(MouseEvent.CLICK,weituoBClickHandler);
			this.main.bankB.addEventListener(MouseEvent.CLICK,bankBClickHandler);
			this.main.chongzhiB.addEventListener(MouseEvent.CLICK,chongzhiBClickHandler);
			
			this.main.currentState = "login";
			
			BindingUtils.bindProperty(this.main.stockList.list,"dataProvider",MainService.instance,"stocks");
		}
		
		private function indexBClickHandler(e:MouseEvent):void{
			
		}
		private function accountBClickHandler(e:MouseEvent):void{
			
		}
		private function zhijinBClickHandler(e:MouseEvent):void{
			initMenuB();
			this.main.zhijinB.selected = true;
			this.main.currentState = "bag";
			
			if(BagControl.instance != null){
				BagControl.instance.getBags();
			}
		}
		private function weituoBClickHandler(e:MouseEvent):void{
			initMenuB();
			this.main.weituoB.selected = true;
			this.main.currentState = "bshistory";
			
			if(BshistoryControl.instance != null){
				BshistoryControl.instance.getBshistory();
			}
		}
		private function bankBClickHandler(e:MouseEvent):void{
			
		}
		private function chongzhiBClickHandler(e:MouseEvent):void{
			
		}
		
		public function initMenuB(){
			this.main.indexB.selected = false;
			this.main.accountB.selected = false;
			this.main.zhijinB.selected = false;
			this.main.weituoB.selected = false;
			this.main.bankB.selected = false;
			this.main.chongzhiB.selected = false;
		}
	}
}