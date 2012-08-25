package com.stock.control
{
	import com.stock.model.Stock;
	import com.stock.services.StockSyncService;
	import com.stock.view.StockList;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayList;

	public class StockListControl
	{
		public static var instance:StockListControl;
		private var stockList:StockList;
		
		[Bindable]
		public var stocks:ArrayList = new ArrayList();
		
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
			
			for(var i:int =0;i<stocks.length;i++){
				if(stocks.getItemAt(i).stockCode == stockList.list.selectedItem.stockCode){
					var sk:Stock = stocks.getItemAt(i) as Stock;
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
		
		public function init(sks:Array):void{
			for(var i:int=0; i<sks.length; i++){
				var stock:Stock = new Stock();
				
				stock.stockCode = sks[i].stock.stockCode;
				stock.stockName = sks[i].stock.stockName;
				stock.allStockNum = sks[i].stock.allStockNum;
				stock.liutongStockNum = sks[i].stock.liutongStockNum;
				stock.shouyi = sks[i].stock.shouyi;
				stock.PE = sks[i].stock.PE;
				
				stock.lastDayEndPrice = sks[i].stock.lastDayEndPrice;
				stock.todayStartPrice = sks[i].stock.todayStartPrice;
				stock.topPrice = sks[i].stock.topPrice;
				stock.bottomPrice = sks[i].stock.bottomPrice;
				stock.nowPrice = sks[i].stock.nowPrice;
				stock.nowCjNum = sks[i].stock.nowCjNum;
				
				stock.cjhistorys = sks[i].stock.cjhistorys;
				
				stock.buyOrders = sks[i].stock.buyOrders;
				stock.saleOrders = sks[i].stock.saleOrders;
				
				this.stocks.addItem(stock);
			}
	
			BindingUtils.bindProperty(stockList.list,"dataProvider",this,"stocks");
			stockList.height = (sks.length+1)*40;
		}
		
		public function update(timeStr:String,stockCode:String,topPrice:Number,bottomPrice:Number,nowPrice:Number,nowCjNum:Number):void{
			for(var i:int=0; i<stocks.length; i++){
				if(stocks.getItemAt(i).stockCode == stockCode){
					stocks.getItemAt(i).topPrice = topPrice;
					stocks.getItemAt(i).bottomPrice = bottomPrice;
					stocks.getItemAt(i).nowPrice = nowPrice;
					stocks.getItemAt(i).nowCjNum = nowCjNum;
					
					stocks.getItemAt(i).zhangdie = nowPrice - stocks.getItemAt(i).lastDayEndPrice;
					stocks.getItemAt(i).zhangfu = ((nowPrice - stocks.getItemAt(i).lastDayEndPrice)/stocks.getItemAt(i).lastDayEndPrice*100).toFixed(2)+"%";
				}
			}
			
			if(MainControl.instance.main.currentState == "stockMain" && BargainControl.instance.stock.stockCode == stockCode){	
				LinechartControl.instance.update(timeStr,Number((nowPrice-5).toFixed(2)),nowCjNum);
			}
		}
	}
}