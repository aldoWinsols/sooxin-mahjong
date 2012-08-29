package com.stock.control
{
	import com.stock.services.BargainService;
	import com.stock.services.PlayerService;
	import com.stock.services.StockSyncService;
	import com.stock.view.Operation;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;

	public class OperationControl
	{
		public var operation:Operation;
		public function OperationControl(operation:Operation)
		{
			this.operation = operation;
			this.operation.operationB.addEventListener(MouseEvent.CLICK,operationBClickHandler);
			
			BindingUtils.bindProperty(operation.stockCode,"text",BargainService.instance.stock,"stockCode");
			BindingUtils.bindProperty(operation.stockName,"text",BargainService.instance.stock,"stockName");
			
			BindingUtils.bindProperty(operation.zhichan,"text",PlayerService.instance.player,"zhichan");
			BindingUtils.bindProperty(operation.haveMoney,"text",PlayerService.instance.player,"haveMoney");
			BindingUtils.bindProperty(operation.clockMoney,"text",PlayerService.instance.player,"clockMoney");
			BindingUtils.bindProperty(operation.useMoney,"text",PlayerService.instance.player,"useMoney");
			
			BindingUtils.bindProperty(operation.wtPrice,"text",BargainService.instance.stock,"nowPrice");
		}
		
		protected function operationBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(this.operation.buyB.selected){
				StockSyncService.getInstance().buy(BargainService.instance.stock.stockCode,PlayerService.instance.player.playerName,Number(this.operation.wtPrice.text),Number(this.operation.wtNum.text));
			}else{
				StockSyncService.getInstance().sale(BargainService.instance.stock.stockCode,PlayerService.instance.player.playerName,Number(this.operation.wtPrice.text),Number(this.operation.wtNum.text));
			}
		}
	}
}