package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.view.Bank;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class BankControl
	{
		private var bank:Bank;
		public function BankControl(bank:Bank)
		{
			this.bank = bank;
			this.bank.commit.addEventListener(MouseEvent.CLICK,commitClickHandler);
			this.bank.loanB.addEventListener(MouseEvent.CLICK,loanBClickHandler);
			this.bank.returnB.addEventListener(MouseEvent.CLICK,returnBClickHandler);
		}
		
		protected function returnBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.bank.currentState = "return";
			
			RemoteService.instance.bankService.getBanks(PlayerService.instance.player.playerName);
			RemoteService.instance.bankService.addEventListener(ResultEvent.RESULT,getBanksResultHandler);
		}
		
		protected function getBanksResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.bankService.removeEventListener(ResultEvent.RESULT,getBanksResultHandler);
			this.bank.dg.dataProvider = event.result as ArrayCollection;
		}
		
		protected function loanBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.bank.currentState = "loan";
		}
		
		protected function commitClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.bankService.loan(PlayerService.instance.player.playerName,this.bank.money.value,this.bank.days.value);
			RemoteService.instance.bankService.addEventListener(ResultEvent.RESULT,loanResultHandler);
		}
		
		protected function loanResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.bankService.removeEventListener(ResultEvent.RESULT,loanResultHandler);
			Alert.show(event.result.toString());
		}
	}
}