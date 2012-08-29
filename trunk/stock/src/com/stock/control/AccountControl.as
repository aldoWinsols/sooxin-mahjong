package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.services.BagService;
	import com.stock.services.BshistoryService;
	import com.stock.services.NowWeituoService;
	import com.stock.services.PlayerService;
	import com.stock.view.Account;
	
	import flash.events.MouseEvent;

	public class AccountControl
	{
		public var account:Account;
		public static var instance:AccountControl;
		public function AccountControl(account:Account)
		{
			this.account = account;
			instance = this;
			
			this.account.operationB.addEventListener(MouseEvent.CLICK,operationBClickHandler);
			this.account.bshistoryB.addEventListener(MouseEvent.CLICK,bshistoryBClickHandler);
			this.account.bagB.addEventListener(MouseEvent.CLICK,bagBClickHandler);
			this.account.updatePwdB.addEventListener(MouseEvent.CLICK,updatePwdBClickHandler);
			this.account.closeB.addEventListener(MouseEvent.CLICK,closeBClickHandler);
			this.account.nowWeituoB.addEventListener(MouseEvent.CLICK,nowWeituoBClickHandler);
		}
		
		protected function nowWeituoBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.account.currentState = "nowWeituo";
			NowWeituoService.getInstance().getNowWeituo();
		}
		
		protected function closeBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.account.visible = false;
		}
		
		protected function updatePwdBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.account.currentState = "updatePwd";
		}
		
		protected function bagBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.account.currentState = "bag";
			BagService.instance.getBags();
		}
		
		protected function bshistoryBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.account.currentState = "bshistory";
			BshistoryService.getInstance().getBshistory();
		}
		
		protected function operationBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.account.currentState = "operation";
		}
		
		
	}
}