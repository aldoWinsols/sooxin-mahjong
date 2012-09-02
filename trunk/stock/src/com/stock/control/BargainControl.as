package com.stock.control
{
	import com.stock.services.BargainService;
	import com.stock.view.Bargain;
	
	import flash.events.Event;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;

	public class BargainControl
	{
		public var bargain:Bargain;
		public static var instance:BargainControl;
		
		public function BargainControl(bargain:Bargain)
		{
			instance = this;
			this.bargain = bargain;
			
			BindingUtils.bindProperty(bargain.stockCodeL,"text",BargainService.instance.stock,"stockCode");
			BindingUtils.bindProperty(bargain.stockNameL,"text",BargainService.instance.stock,"stockName");
			
			BindingUtils.bindProperty(bargain.nowPriceL,"text",BargainService.instance.stock,"nowPrice");
			BindingUtils.bindProperty(bargain.topPriceL,"text",BargainService.instance.stock,"topPrice");
			BindingUtils.bindProperty(bargain.bottomPriceL,"text",BargainService.instance.stock,"bottomPrice");
			
			BindingUtils.bindProperty(bargain.todayStartPriceL,"text",BargainService.instance.stock,"todayStartPrice");
			BindingUtils.bindProperty(bargain.zhangfuL,"text",BargainService.instance.stock,"zhangfu");
			BindingUtils.bindProperty(bargain.zhangdieL,"text",BargainService.instance.stock,"zhangdie");
			
			BindingUtils.bindProperty(bargain.zpanL,"text",BargainService.instance.stock,"zpan");
			BindingUtils.bindProperty(bargain.wpanL,"text",BargainService.instance.stock,"wpan");
			BindingUtils.bindProperty(bargain.npanL,"text",BargainService.instance.stock,"npan");
			BindingUtils.bindProperty(bargain.liangbL,"text",BargainService.instance.stock,"liangb");
			
			BindingUtils.bindProperty(bargain.allStockNumL,"text",BargainService.instance.stock,"allStockNum");
			BindingUtils.bindProperty(bargain.liutongStockNumL,"text",BargainService.instance.stock,"liutongStockNum");
			BindingUtils.bindProperty(bargain.shouyiL,"text",BargainService.instance.stock,"shouyi");
			BindingUtils.bindProperty(bargain.PEL,"text",BargainService.instance.stock,"PE");
			
			BindingUtils.bindProperty(bargain.huanshouL,"text",BargainService.instance.stock,"huanshou");
			BindingUtils.bindProperty(bargain.jinzhiL,"text",BargainService.instance.stock,"jinzhi");
			
			ChangeWatcher.watch(BargainService.instance.stock, "todayStartPrice", todayStartPriceWatcherListener);
			ChangeWatcher.watch(BargainService.instance.stock, "topPrice", topPriceWatcherListener);
			ChangeWatcher.watch(BargainService.instance.stock, "bottomPrice", bottomPriceWatcherListener);
			ChangeWatcher.watch(BargainService.instance.stock, "nowPrice", nowPriceWatcherListener);
			ChangeWatcher.watch(BargainService.instance.stock, "zhangdie", zhangdieWatcherListener);
			ChangeWatcher.watch(BargainService.instance.stock, "liangb", liangbWatcherListener);
			ChangeWatcher.watch(BargainService.instance.stock, "zhangfu", zhangfuWatcherListener);
			
			ChangeWatcher.watch(BargainService.instance.stock, "allStockNum",allStockNumWatcherListener);
			ChangeWatcher.watch(BargainService.instance.stock, "liutongStockNum", liutongStockNumWatcherListener);
		}
		
		private function liutongStockNumWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			bargain.liutongStockNumL.text = BargainService.instance.stock.liutongStockNum/100000000 + "亿";
		}
		
		private function allStockNumWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			bargain.allStockNumL.text = BargainService.instance.stock.allStockNum/100000000 + "亿";
		}
		
		private function liangbWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			if(BargainService.instance.stock.liangb < 1){
				bargain.liangbL.setStyle("color","#00E600");
				bargain.liangbL.text = BargainService.instance.stock.liangb.toFixed(2);
			}else{
				bargain.liangbL.setStyle("color","#ff0000");
				bargain.liangbL.text = BargainService.instance.stock.liangb.toFixed(2);
			}
		}
		
		private function zhangdieWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			if(BargainService.instance.stock.zhangdie < 0){
				bargain.zhangdieL.setStyle("color","#00E600");
			}else{
				bargain.zhangdieL.setStyle("color","#ff0000");
			}
		}
		
		private function nowPriceWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			if(BargainService.instance.stock.nowPrice < BargainService.instance.stock.lastDayEndPrice){
				bargain.nowPriceL.setStyle("color","#00E600");
			}else{
				bargain.nowPriceL.setStyle("color","#ff0000");
			}
		}
		
		private function bottomPriceWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			if(BargainService.instance.stock.bottomPrice < BargainService.instance.stock.lastDayEndPrice){
				bargain.bottomPriceL.setStyle("color","#00E600");
			}else{
				bargain.bottomPriceL.setStyle("color","#ff0000");
			}
		}
		
		private function topPriceWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			if(BargainService.instance.stock.topPrice < BargainService.instance.stock.lastDayEndPrice){
				bargain.topPriceL.setStyle("color","#00E600");
			}else{
				bargain.topPriceL.setStyle("color","#ff0000");
			}
		}
		
		private function todayStartPriceWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			if(BargainService.instance.stock.todayStartPrice < BargainService.instance.stock.lastDayEndPrice){
				bargain.todayStartPriceL.setStyle("color","#00E600");
			}else{
				bargain.todayStartPriceL.setStyle("color","#ff0000");
			}
		}
		
		private function zhangfuWatcherListener(event:Event):void
		{
			// TODO Auto Generated method stub
			if(Number(BargainService.instance.stock.zhangfu)<0){
				bargain.zhangfuL.setStyle("color","#00E600");
				bargain.zhangfuL.text = BargainService.instance.stock.zhangfu+"%";
			}else{
				bargain.zhangfuL.setStyle("color","#ff0000");
				bargain.zhangfuL.text = BargainService.instance.stock.zhangfu+"%";
			}
		}
	}
}