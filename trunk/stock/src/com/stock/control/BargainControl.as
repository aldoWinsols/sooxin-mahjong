package com.stock.control
{
	import com.stock.model.Stock;
	import com.stock.view.Bargain;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	
	import spark.components.Form;

	public class BargainControl
	{
		private var bargain:Bargain;
		public static var instance:BargainControl;
		
		public var buys:Array = new Array();
		public var sales:Array = new Array();
		
		public var cjhistorys:ArrayCollection = new ArrayCollection();
		public var bargainShowCjhistorys:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var stock:Stock = new Stock();

		public function BargainControl(bargain:Bargain)
		{
			instance = this;
			this.bargain = bargain;
			BindingUtils.bindProperty(this.bargain.stockCodeL,"text",this.stock,"stockCode");
			BindingUtils.bindProperty(this.bargain.stockNameL,"text",this.stock,"stockName");
			
			BindingUtils.bindProperty(this.bargain.nowPriceL,"text",this.stock,"nowPrice");
			BindingUtils.bindProperty(this.bargain.topPriceL,"text",this.stock,"topPrice");
			BindingUtils.bindProperty(this.bargain.bottomPriceL,"text",this.stock,"bottomPrice");
			
			BindingUtils.bindProperty(this.bargain.todayStartPriceL,"text",this.stock,"todayStartPrice");
			BindingUtils.bindProperty(this.bargain.zhangfuL,"text",this.stock,"zhangfu");
			BindingUtils.bindProperty(this.bargain.zhangdieL,"text",this.stock,"zhangdie");
			
			BindingUtils.bindProperty(this.bargain.zpanL,"text",this.stock,"zpan");
			BindingUtils.bindProperty(this.bargain.wpanL,"text",this.stock,"wpan");
			BindingUtils.bindProperty(this.bargain.npanL,"text",this.stock,"npan");
			BindingUtils.bindProperty(this.bargain.liangbL,"text",this.stock,"liangb");
			
			BindingUtils.bindProperty(this.bargain.allStockNumL,"text",this.stock,"allStockNum");
			BindingUtils.bindProperty(this.bargain.liutongStockNumL,"text",this.stock,"liutongStockNum");
			BindingUtils.bindProperty(this.bargain.shouyiL,"text",this.stock,"shouyi");
			BindingUtils.bindProperty(this.bargain.PEL,"text",this.stock,"PE");
			
			BindingUtils.bindProperty(this.bargain.huanshouL,"text",this.stock,"huanshou");
			BindingUtils.bindProperty(this.bargain.jinzhiL,"text",this.stock,"jinzhi");
		}
		
		public function updateJiaoyi(topPrice:Number,bottomPrice:Number,nowPrice:Number,nowCjNum:Number,buys:Array,sales:Array,cjhistory:Array){
			this.buys = buys;
			this.sales = sales;
			
			for(var i:int=0; i<cjhistory.length;i++){
				this.cjhistorys.addItem(cjhistory[i]);
				
				bargainShowCjhistorys.addItem(cjhistory[i]);
				if(bargainShowCjhistorys.length > 8){
					bargainShowCjhistorys.removeItemAt(0);
				}
			}
			this.bargain.cjHistoryList.dataProvider = bargainShowCjhistorys;
			
			
			for(var i:int=0; i<cjhistorys.length;i++){
				if(cjhistorys[i].cjSort == "B"){
					stock.npan += cjhistorys[i].cjNum;
				}else{
					stock.wpan += cjhistorys[i].cjNum;
				}
			}
			stock.zpan = stock.npan + stock.wpan;
			
			this.bargain.buyNum1.text = "";
			this.bargain.buyPrice1.text = "";
			this.bargain.buyNum2.text = "";
			this.bargain.buyPrice2.text = "";
			this.bargain.buyNum3.text = "";
			this.bargain.buyPrice3.text = "";
			this.bargain.buyNum4.text = "";
			this.bargain.buyPrice4.text = "";
			this.bargain.buyNum5.text = "";
			this.bargain.buyPrice5.text = "";

			this.bargain.saleNum1.text = "";
			this.bargain.salePrice1.text = "";
			this.bargain.saleNum2.text = "";
			this.bargain.salePrice2.text = "";
			this.bargain.saleNum3.text = "";
			this.bargain.salePrice3.text = "";
			this.bargain.saleNum4.text = "";
			this.bargain.salePrice4.text = "";
			this.bargain.saleNum5.text = "";
			this.bargain.salePrice5.text = "";
			
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
				this.bargain.buyNum1.text = buys[0].wtNum;
				this.bargain.buyPrice1.text = buys[0].wtPrice;
			}
			if(buys[1] != null){
				this.bargain.buyNum2.text = buys[1].wtNum;
				this.bargain.buyPrice2.text = buys[1].wtPrice;
			}
			if(buys[2] != null){
				this.bargain.buyNum3.text = buys[2].wtNum;
				this.bargain.buyPrice3.text = buys[2].wtPrice;
			}
			if(buys[3] != null){
				this.bargain.buyNum4.text = buys[3].wtNum;
				this.bargain.buyPrice4.text = buys[3].wtPrice;
			}
			if(buys[4] != null){
				this.bargain.buyNum5.text = buys[4].wtNum;
				this.bargain.buyPrice5.text = buys[4].wtPrice;
			}
			
			//sales
			if(sales[0] != null){
				this.bargain.saleNum1.text = sales[0].wtNum;
				this.bargain.salePrice1.text = sales[0].wtPrice;
			}
			if(sales[1] != null){
				this.bargain.saleNum2.text = sales[1].wtNum;
				this.bargain.salePrice2.text = sales[1].wtPrice;
			}
			if(sales[2] != null){
				this.bargain.saleNum3.text = sales[2].wtNum;
				this.bargain.salePrice3.text = sales[2].wtPrice;
			}
			if(sales[3] != null){
				this.bargain.saleNum4.text = sales[3].wtNum;
				this.bargain.salePrice4.text = sales[3].wtPrice;
			}
			if(sales[4] != null){
				this.bargain.saleNum5.text = sales[4].wtNum;
				this.bargain.salePrice5.text = sales[4].wtPrice;
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
			
			this.bargain.weibiL.text = ((buyNum-saleNum)/(buyNum+saleNum)*100).toFixed(2)+"%";
			this.bargain.weichaL.text = (buyNum-saleNum)+"";
			
			stock.topPrice = topPrice;
			stock.bottomPrice = bottomPrice;
			stock.nowPrice = nowPrice;
			stock.nowCjNum = nowCjNum;
			
			stock.zhangdie = nowPrice - stock.lastDayEndPrice;
			stock.zhangfu = ((nowPrice - stock.lastDayEndPrice)/stock.lastDayEndPrice*100).toFixed(2)+"%";
			
//			this.bargain.buyList.dataProvider = new ArrayList(buys);
		}
		
		public function update(topPrice,bottomPrice,nowPrice,nowCjNum){
			this.bargain.topPriceL.text = topPrice;
			this.bargain.bottomPriceL.text = bottomPrice;
			this.bargain.nowPriceL.text = nowPrice;
		}
	}
}