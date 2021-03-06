package com.stock.services
{
	import com.stock.control.BargainControl;
	import com.stock.control.LinechartControl;
	import com.stock.control.MainControl;
	import com.stock.control.StockListControl;
	import com.stock.control.SunKLineControl;
	import com.stock.model.Stock;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	
	import org.flexunit.internals.matchers.Each;

	public class StockListService
	{
		[Bindable]
		public var stocks:ArrayCollection;
		
		public static var instance:StockListService;
		
		public function StockListService()
		{
			stocks = new ArrayCollection();
		}
		
		public static function getInstance():StockListService{
			if(instance == null){
				instance = new StockListService();
			}
			
			return instance;
		}
		
		public function getPriceByStockCode(stockCode:String):Number{
			var price:Number = 0;
			for each(var obj:Object in stocks){
				if(obj.stockCode == stockCode){
					price = obj.nowPrice;
				}
			}
			return price;
		}
		
		public function init(sks:Array):void{
			for(var i:int=0; i<sks.length; i++){
				var stock:Stock = new Stock();
				
				stock.stockCode = sks[i].stock.stockCode;
				stock.stockName = sks[i].stock.stockName;
				stock.allStockNum = sks[i].stock.allStockNum;
				stock.liutongStockNum = sks[i].stock.liutongStockNum;
				stock.jinzhi = sks[i].stock.jinzhi;
				stock.shouyi = sks[i].stock.shouyi;
				stock.lastDayCjshou = sks[i].stock.lastDayCjshou;
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
			
			BindingUtils.bindProperty(StockListControl.instance.stockList.list,"dataProvider",this,"stocks");
			StockListControl.instance.stockList.height = (sks.length+1)*40;
		}
		
		public function update(timeStr:String,stockCode:String,topPrice:Number,bottomPrice:Number,nowPrice:Number,nowCjNum:Number):void{
			for each(var stock:Object in stocks){
				if(stock.stockCode == stockCode){
					stock.topPrice = topPrice;
					stock.bottomPrice = bottomPrice;
					stock.nowPrice = nowPrice;
					stock.nowCjNum = nowCjNum;
					
					stock.zhangdie = nowPrice - stock.lastDayEndPrice;
					stock.zhangfu = ((nowPrice - stock.lastDayEndPrice)/stock.lastDayEndPrice*100).toFixed(2);
					
					var zhanghuL:Number = ee(stock.topPrice-stock.lastDayEndPrice) + ee(stock.lastDayEndPrice-stock.bottomPrice);
					stock.zhenfu = (zhanghuL/stock.lastDayEndPrice*100).toFixed(2);
					
					var cjNum:int = 0;
					for(var i:int=0;i<BargainService.instance.cjhistorys.length;i++){
						cjNum += BargainService.instance.cjhistorys.getItemAt(i).cjNum;
					}
					stock.huanshou = (cjNum/stock.allStockNum*100).toFixed(2);
					
					stock.shizhi = Number(stock.allStockNum*stock.nowPrice/100000000).toFixed(2);
				}
			}
			
			if(MainControl.instance.main.currentState == "stockMain" && BargainService.instance.stock.stockCode == stockCode){	
				LinechartControl.instance.update(timeStr,Number((nowPrice-5).toFixed(2)),nowCjNum);
				SunKLineControl.instance.update(5,nowPrice,topPrice,5,nowCjNum);
			}
			
			PlayerService.instance.updateZhichan();
		}
		
		private function ee(num:Number):Number{
			if(num<0){
				return 0;
			}
			return num;
		}
	}
}