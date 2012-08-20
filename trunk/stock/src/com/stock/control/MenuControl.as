package com.stock.control
{
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
			this.menu.zhijinB.addEventListener(MouseEvent.CLICK,zhijinBClickHandler);
			this.menu.weituoB.addEventListener(MouseEvent.CLICK,weituoBClickHandler);
			this.menu.bankB.addEventListener(MouseEvent.CLICK,bankBClickHandler);
			this.menu.chongzhiB.addEventListener(MouseEvent.CLICK,chongzhiBClickHandler);
		}
		
		private function indexBClickHandler(e:MouseEvent):void{
			
		}
		private function accountBClickHandler(e:MouseEvent):void{
			
		}
		private function zhijinBClickHandler(e:MouseEvent):void{
			initMenuB();
			this.menu.zhijinB.selected = true;
			MainControl.instance.main.currentState = "bag";
			
			if(BagControl.instance != null){
				BagControl.instance.getBags();
			}
		}
		private function weituoBClickHandler(e:MouseEvent):void{
			initMenuB();
			this.menu.weituoB.selected = true;
			MainControl.instance.main.currentState = "bshistory";
			
			if(BshistoryControl.instance != null){
				BshistoryControl.instance.getBshistory();
			}
		}
		private function bankBClickHandler(e:MouseEvent):void{
			
		}
		private function chongzhiBClickHandler(e:MouseEvent):void{
			
		}
		
		public function initMenuB(){
			this.menu.indexB.selected = false;
			this.menu.accountB.selected = false;
			this.menu.zhijinB.selected = false;
			this.menu.weituoB.selected = false;
			this.menu.bankB.selected = false;
			this.menu.chongzhiB.selected = false;
		}
	}
}