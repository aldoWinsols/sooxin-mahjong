package com.stock.control
{
	import com.stock.services.BargainService;
	import com.stock.view.Bargain;
	
	import mx.binding.utils.BindingUtils;

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
		}
	}
}