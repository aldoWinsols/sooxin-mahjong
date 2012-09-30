package com.stock.control
{
	import com.stock.model.Alert;
	import com.stock.model.Ipo;
	import com.stock.model.Player;
	import com.stock.services.PlayerService;
	import com.stock.services.RemoteService;
	import com.stock.view.IpoView;
	
	import flash.events.MouseEvent;
	
	import mx.rpc.events.ResultEvent;

	public class IpoControl
	{
		private var ipoView:IpoView;
		
		private var ipo:Ipo;
		public function IpoControl(ipoView:IpoView)
		{
			this.ipoView = ipoView;
			
			this.ipoView.commit.addEventListener(MouseEvent.CLICK,commitClickHandler);
			
			RemoteService.instance.ipoService.getIpo();
			RemoteService.instance.ipoService.addEventListener(ResultEvent.RESULT,getIpoResultHandler);
		}
		
		protected function commitClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.ipoService.buy(PlayerService.instance.player.playerName,Number(this.ipoView.num.text));
			RemoteService.instance.ipoService.addEventListener(ResultEvent.RESULT,buyResultHandler);
		}
		
		protected function buyResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.ipoService.removeEventListener(ResultEvent.RESULT,buyResultHandler);
			if(event.result is Player){
				PlayerService.instance.player = event.result as Player;
				Alert.show("申购成功！");
			}else{
				Alert.show(event.result.toString());
			}
		}
		
		protected function getIpoResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.ipoService.removeEventListener(ResultEvent.RESULT,getIpoResultHandler);
			this.ipo = event.result as Ipo;
			
			this.ipoView.stockCodeV.text = ipo.stockCode;
			this.ipoView.stockNameV.text = ipo.stockName;
			this.ipoView.allNumV.text = ipo.allNum+"";
			this.ipoView.busNumV.text = ipo.busNum+"";
			this.ipoView.jinzhiV.text = ipo.jinzhi+"";
			this.ipoView.shouyiV.text = ipo.shouyi+"";
			this.ipoView.startBuyV.text = ipo.startBuy;
			this.ipoView.startSaleV.text = ipo.startSale;
			this.ipoView.introdunceV.text = ipo.introdunce;
			this.ipoView.priceV.text = ipo.price+"";
		}
	}
}