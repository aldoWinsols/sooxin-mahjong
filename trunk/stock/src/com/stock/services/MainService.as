package com.stock.services
{
	import com.stock.control.BargainControl;
	import com.stock.control.LinechartControl;
	import com.stock.control.MainControl;
	import com.stock.model.Cjhistory;
	import com.stock.model.Stock;
	
	import mx.collections.ArrayList;

	public class MainService
	{
		[Bindable]
		public var stocks:ArrayList = new ArrayList();
		
		public static var instance:MainService;
		public function MainService()
		{
		}
		
		public static function getInstance():MainService{
			if(instance == null){
				instance = new MainService();
			}
			return instance;
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
			
			MainControl.instance.main.stockList.height = (sks.length+1)*40;
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