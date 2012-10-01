package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.model.Player;
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.view.Bank;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;

	public class BankControl
	{
		private var bank:Bank;
		public static var instance:BankControl;
		public function BankControl(bank:Bank)
		{
			this.bank = bank;
			instance = this;
			this.bank.commit.addEventListener(MouseEvent.CLICK,commitClickHandler);
		}
		
		public function getBanks():void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.bankService.getBanks(PlayerService.instance.player.playerName);
			RemoteService.instance.bankService.addEventListener(ResultEvent.RESULT,getBanksResultHandler);
		}
		
		protected function getBanksResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.bankService.removeEventListener(ResultEvent.RESULT,getBanksResultHandler);
			this.bank.dg.dataProvider = event.result as ArrayCollection;
		}
		
		protected function commitClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.bankService.loan(PlayerService.instance.player.playerName,Number(bank.money.text),Number(bank.days.text));
			RemoteService.instance.bankService.addEventListener(ResultEvent.RESULT,loanResultHandler);
		}
		
		protected function loanResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.bankService.removeEventListener(ResultEvent.RESULT,loanResultHandler);
			
			if(event.result is Player){
				PlayerService.instance.player = event.result as Player;
				getBanks();
				Alert.show("贷款申请成功！");
			}else{
				Alert.show(event.result.toString());
			}
		}
	}
}