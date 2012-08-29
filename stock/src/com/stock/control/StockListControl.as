package com.stock.control
{
	import com.stock.model.Stock;
	import com.stock.services.BargainService;
	import com.stock.services.StockListService;
	import com.stock.services.StockSyncService;
	import com.stock.view.StockList;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayList;

	public class StockListControl
	{
		public static var instance:StockListControl;
		public var stockList:StockList;
		
		
		public function StockListControl(stockList:StockList)
		{
			this.stockList = stockList;
			instance = this;
			this.stockList.list.addEventListener(MouseEvent.CLICK,listClickHandler);
			
			BindingUtils.bindProperty(this.stockList.list,"dataProvider",StockListService.getInstance(),"stocks");
			
		}
		
		protected function listClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			MainControl.instance.main.stockList.visible = false;
			StockSyncService.getInstance().dealStock(stockList.list.selectedItem.stockCode);
			for each(var stock:Stock in StockListService.instance.stocks){
				if(stock.stockCode == stockList.list.selectedItem.stockCode){
					var sk:Stock = stock as Stock;
					BargainService.instance.stock.stockCode = sk.stockCode;
					BargainService.instance.stock.stockName = sk.stockName;
					
					BargainService.instance.stock.jinzhi = sk.jinzhi;
					BargainService.instance.stock.allStockNum = sk.allStockNum;
					BargainService.instance.stock.liutongStockNum = sk.liutongStockNum;
					BargainService.instance.stock.lastDayEndPrice = sk.lastDayEndPrice;
					
					BargainService.instance.stock.PE = sk.PE;
					
					break;
					
				}
			}
			
			MainControl.instance.main.stockList.visible = false;
			MainControl.instance.main.stockMain.visible = true;
			stockList.list.selectedItem = null;
		}
		
		
	}
}