package com.stock.control
{
	import com.stock.services.BagService;
	import com.stock.services.ConfigService;
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
			this.menu.paihangB.addEventListener(MouseEvent.CLICK,paihangBClickHandler);
			this.menu.bankB.addEventListener(MouseEvent.CLICK,bankBClickHandler);
			this.menu.newsB.addEventListener(MouseEvent.CLICK,newsBClickHandler);
			this.menu.chongzhiB.addEventListener(MouseEvent.CLICK,chongzhiBClickHandler);
		}
		
		protected function chongzhiBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			MainControl.instance.main.chongzhi.visible = true;
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
			MainControl.instance.main.ipo.visible = true;
		}
		private function paihangBClickHandler(e:MouseEvent):void{
			MainControl.instance.main.paihang.visible = true;
			MainControl.instance.main.paihang.init();

		}
		private function bankBClickHandler(e:MouseEvent):void{
			MainControl.instance.main.bank.visible = true;
			MainControl.instance.main.bank.lilvV.text = ConfigService.instance.config.dayLoanLv.toString();
		}
		private function newsBClickHandler(e:MouseEvent):void{
			MainControl.instance.main.news.visible = true;
			MainControl.instance.main.news.getNews();
		}
		
		public function initMenuB(){
			this.menu.indexB.selected = false;
			this.menu.accountB.selected = false;
			this.menu.paihangB.selected = false;
			this.menu.ipoB.selected = false;
			this.menu.bankB.selected = false;
			this.menu.newsB.selected = false;
		}
	}
}