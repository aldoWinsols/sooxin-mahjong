package com.stock.control
{
	import com.stock.services.BagService;
	import com.stock.view.Menu;
	
	import flash.events.MouseEvent;

	public class MenuControl
	{
		private var menu:Menu;
		public function MenuControl(menu:Menu)
		{
			this.menu = menu;
			
			this.menu.indexB.addEventListener(MouseEvent.CLICK,indexBClickHandler);
			this.menu.accountB.addEventListener(MouseEvent.CLICK,accountBClickHandler);
			this.menu.ipoB.addEventListener(MouseEvent.CLICK,ipoBClickHandler);
			this.menu.helpB.addEventListener(MouseEvent.CLICK,helpBClickHandler);
			this.menu.bankB.addEventListener(MouseEvent.CLICK,bankBClickHandler);
			this.menu.chongzhiB.addEventListener(MouseEvent.CLICK,chongzhiBClickHandler);
		}
		
		private function indexBClickHandler(e:MouseEvent):void{
			MainControl.instance.main.currentState = "stockMain";
			MainControl.instance.main.stockList.visible = true;
			MainControl.instance.main.stockMain.visible = false;
		}
		private function accountBClickHandler(e:MouseEvent):void{
			MainControl.instance.main.account.visible = true;
		}
		private function ipoBClickHandler(e:MouseEvent):void{
		}
		private function helpBClickHandler(e:MouseEvent):void{

		}
		private function bankBClickHandler(e:MouseEvent):void{
			
		}
		private function chongzhiBClickHandler(e:MouseEvent):void{
			
		}
		
		public function initMenuB(){
			this.menu.indexB.selected = false;
			this.menu.accountB.selected = false;
			this.menu.helpB.selected = false;
			this.menu.ipoB.selected = false;
			this.menu.bankB.selected = false;
			this.menu.chongzhiB.selected = false;
		}
	}
}