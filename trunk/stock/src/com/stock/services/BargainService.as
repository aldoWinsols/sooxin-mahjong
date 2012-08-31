package com.stock.services
{
	import com.stock.control.BargainControl;
	import com.stock.control.LinechartControl;
	import com.stock.control.MainControl;
	import com.stock.control.SunKLineControl;
	import com.stock.model.Stock;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;

	public class BargainService
	{
		public static var instance:BargainService;
		
		public var buys:Array = new Array();
		public var sales:Array = new Array();
		
		public var cjhistorys:ArrayCollection = new ArrayCollection();
		public var bargainShowCjhistorys:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var stock:Stock = new Stock();
		
		public function BargainService()
		{
			bargainShowCjhistorys.addItem(new Object());
			bargainShowCjhistorys.addItem(new Object());
			bargainShowCjhistorys.addItem(new Object());
			bargainShowCjhistorys.addItem(new Object());
			bargainShowCjhistorys.addItem(new Object());
			bargainShowCjhistorys.addItem(new Object());
		}
		
		public static function getInstance():BargainService{
			if(instance == null){
				instance = new BargainService();
			}
			return instance;
		}
		
		public function updateJiaoyi(topPrice:Number,bottomPrice:Number,nowPrice:Number,nowCjNum:Number,buys:Array,sales:Array,cjhistory:Array,mlines:Array){
			this.buys = buys;
			this.sales = sales;
			
			for(var i:int=0; i<cjhistory.length;i++){
				this.cjhistorys.addItem(cjhistory[i]);
				
				bargainShowCjhistorys.addItem(cjhistory[i]);
				if(bargainShowCjhistorys.length > 6){
					bargainShowCjhistorys.removeItemAt(0);
				}
			}
			BargainControl.instance.bargain.cjHistoryList.dataProvider = bargainShowCjhistorys;
			
			
			for(var i:int=0; i<cjhistorys.length;i++){
				if(cjhistorys[i].cjSort == "B"){
					stock.npan += cjhistorys[i].cjNum;
				}else{
					stock.wpan += cjhistorys[i].cjNum;
				}
			}
			stock.zpan = stock.npan + stock.wpan;
			
			BargainControl.instance.bargain.buyNum1.text = "";
			BargainControl.instance.bargain.buyPrice1.text = "";
			BargainControl.instance.bargain.buyNum2.text = "";
			BargainControl.instance.bargain.buyPrice2.text = "";
			BargainControl.instance.bargain.buyNum3.text = "";
			BargainControl.instance.bargain.buyPrice3.text = "";
			BargainControl.instance.bargain.buyNum4.text = "";
			BargainControl.instance.bargain.buyPrice4.text = "";
			BargainControl.instance.bargain.buyNum5.text = "";
			BargainControl.instance.bargain.buyPrice5.text = "";
			
			BargainControl.instance.bargain.saleNum1.text = "";
			BargainControl.instance.bargain.salePrice1.text = "";
			BargainControl.instance.bargain.saleNum2.text = "";
			BargainControl.instance.bargain.salePrice2.text = "";
			BargainControl.instance.bargain.saleNum3.text = "";
			BargainControl.instance.bargain.salePrice3.text = "";
			BargainControl.instance.bargain.saleNum4.text = "";
			BargainControl.instance.bargain.salePrice4.text = "";
			BargainControl.instance.bargain.saleNum5.text = "";
			BargainControl.instance.bargain.salePrice5.text = "";
			
			//buys
			
			for(var i:int=0;i<buys.length-1;i++){
				if(buys[i].wtPrice == buys[i+1].wtPrice){
					buys[i].wtNum += buys[i+1].wtNum;
					buys.splice(i+1,1);
					i--;
				}
			}
			
			for(var i:int=0;i<sales.length-1;i++){
				if(sales[i].wtPrice == sales[i+1].wtPrice){
					sales[i].wtNum += sales[i+1].wtNum;
					sales.splice(i+1,1);
					i--;
				}
			}
			
			if(buys[0] != null){
				BargainControl.instance.bargain.buyNum1.text = buys[0].wtNum;
				BargainControl.instance.bargain.buyPrice1.text = buys[0].wtPrice;
			}
			if(buys[1] != null){
				BargainControl.instance.bargain.buyNum2.text = buys[1].wtNum;
				BargainControl.instance.bargain.buyPrice2.text = buys[1].wtPrice;
			}
			if(buys[2] != null){
				BargainControl.instance.bargain.buyNum3.text = buys[2].wtNum;
				BargainControl.instance.bargain.buyPrice3.text = buys[2].wtPrice;
			}
			if(buys[3] != null){
				BargainControl.instance.bargain.buyNum4.text = buys[3].wtNum;
				BargainControl.instance.bargain.buyPrice4.text = buys[3].wtPrice;
			}
			if(buys[4] != null){
				BargainControl.instance.bargain.buyNum5.text = buys[4].wtNum;
				BargainControl.instance.bargain.buyPrice5.text = buys[4].wtPrice;
			}
			
			//sales
			if(sales[0] != null){
				BargainControl.instance.bargain.saleNum1.text = sales[0].wtNum;
				BargainControl.instance.bargain.salePrice1.text = sales[0].wtPrice;
			}
			if(sales[1] != null){
				BargainControl.instance.bargain.saleNum2.text = sales[1].wtNum;
				BargainControl.instance.bargain.salePrice2.text = sales[1].wtPrice;
			}
			if(sales[2] != null){
				BargainControl.instance.bargain.saleNum3.text = sales[2].wtNum;
				BargainControl.instance.bargain.salePrice3.text = sales[2].wtPrice;
			}
			if(sales[3] != null){
				BargainControl.instance.bargain.saleNum4.text = sales[3].wtNum;
				BargainControl.instance.bargain.salePrice4.text = sales[3].wtPrice;
			}
			if(sales[4] != null){
				BargainControl.instance.bargain.saleNum5.text = sales[4].wtNum;
				BargainControl.instance.bargain.salePrice5.text = sales[4].wtPrice;
			}
			
			var buyNum:int = 0;
			var saleNum:int = 0;
			for(var i:int=0; i<5; i++){
				if(buys[i] != null){
					buyNum += this.buys[i].wtNum;
				}
			}
			for(var i:int=0; i<5; i++){
				if(sales[i] != null){
					saleNum += this.sales[i].wtNum;
				}
			}
			
			BargainControl.instance.bargain.weibiL.text = ((buyNum-saleNum)/(buyNum+saleNum)*100).toFixed(2)+"%";
			BargainControl.instance.bargain.weichaL.text = (buyNum-saleNum)+"";
			
			stock.topPrice = topPrice;
			stock.bottomPrice = bottomPrice;
			stock.nowPrice = nowPrice;
			stock.nowCjNum = nowCjNum;
			
			stock.zhangdie = nowPrice - stock.lastDayEndPrice;
			stock.zhangfu = ((nowPrice - stock.lastDayEndPrice)/stock.lastDayEndPrice*100).toFixed(2)+"%";
			
			SunKLineControl.instance.update(5,nowPrice,topPrice,5,nowCjNum);
			
			if(MainControl.instance.main.currentState == "stockMain"){
				for each(var obj:Object in mlines){
					LinechartControl.instance.update(obj.buildDate,Number((obj.price-5).toFixed(2)),obj.turnover);
				}
				
			}
			//			BargainControl.instance.bargain.buyList.dataProvider = new ArrayList(buys);
		}
		
		public function update(topPrice,bottomPrice,nowPrice,nowCjNum){
			BargainControl.instance.bargain.topPriceL.text = topPrice;
			BargainControl.instance.bargain.bottomPriceL.text = bottomPrice;
			BargainControl.instance.bargain.nowPriceL.text = nowPrice;
		}
	}
}