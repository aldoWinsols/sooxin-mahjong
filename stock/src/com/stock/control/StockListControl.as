package com.stock.control
{
	import com.stock.model.Stock;
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
			
		}
		
		protected function listClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			MainControl.instance.main.stockList.visible = false;
			StockSyncService.getInstance().dealStock(stockList.list.selectedItem.stockCode);
			
			for each(var stock:Object in StockListService.instance.stocks){
				if(stock.stockCode == stockList.list.selectedItem.stockCode){
					var sk:Stock = stock as Stock;
					BargainControl.instance.stock.stockCode = sk.stockCode;
					BargainControl.instance.stock.stockName = sk.stockName;
					
					BargainControl.instance.stock.jinzhi = sk.jinzhi;
					BargainControl.instance.stock.allStockNum = sk.allStockNum;
					BargainControl.instance.stock.liutongStockNum = sk.liutongStockNum;
					BargainControl.instance.stock.lastDayEndPrice = sk.lastDayEndPrice;
					
					BargainControl.instance.stock.PE = sk.PE;
					
				}
			}
			
			MainControl.instance.main.stockList.visible = false;
			MainControl.instance.main.stockMenu.visible = true;
			MainControl.instance.main.bargain.visible = true;
			MainControl.instance.main.linechart.visible = true;
			stockList.list.selectedItem = null;
		}
		
		
	}
}