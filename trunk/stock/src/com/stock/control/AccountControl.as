package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.services.PlayerService;
	import com.stock.view.Account;
	
	import flash.events.MouseEvent;

	public class AccountControl
	{
		private var account:Account;
		public function AccountControl(account:Account)
		{
			this.account = account;
			this.account.operationB.addEventListener(MouseEvent.CLICK,operationBClickHandler);
			this.account.bshistoryB.addEventListener(MouseEvent.CLICK,bshistoryBClickHandler);
			this.account.bagB.addEventListener(MouseEvent.CLICK,bagBClickHandler);
			this.account.updatePwdB.addEventListener(MouseEvent.CLICK,updatePwdBClickHandler);
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
		}
		
		protected function bshistoryBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.account.currentState = "bshistory";
		}
		
		protected function operationBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.account.currentState = "operation";
		}
		
		
	}
}