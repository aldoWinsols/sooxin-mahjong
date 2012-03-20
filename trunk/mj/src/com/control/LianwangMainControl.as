package com.control
{
	import com.milkmangames.nativeextensions.ios.StoreKit;
	import com.model.Alert;
	import com.model.Duihuanlog;
	import com.model.MainPlayer;
	import com.services.MainPlayerService;
	import com.services.RemoteService;
	import com.view.LianwangMain;
	
	import flash.events.MouseEvent;
	
	import mx.rpc.events.ResultEvent;
	
	public class LianwangMainControl
	{
		private static const D60_PRODUCT_ID:String="com.sooxin.mahjongM.d60";
		private static const D250_PRODUCT_ID:String="com.sooxin.mahjongM.d250";
		
		public var lianwangMain:LianwangMain;
		public static var instance:LianwangMainControl;
		public function LianwangMainControl(lianwangMain:LianwangMain)
		{
			this.lianwangMain = lianwangMain;
			instance = this;
			
			this.lianwangMain.d60B.addEventListener(MouseEvent.CLICK,d60BClickHandler);
			this.lianwangMain.d250B.addEventListener(MouseEvent.CLICK,d250BClickHandler);
			
			this.lianwangMain.logB.addEventListener(MouseEvent.CLICK,logBClickHandler);
			
			this.lianwangMain.dIphoneB.addEventListener(MouseEvent.CLICK,dIphoneBClickHandler);
			this.lianwangMain.dIpadB.addEventListener(MouseEvent.CLICK,dIpadBClickHandler);
			this.lianwangMain.check.addEventListener(MouseEvent.CLICK, check_clickHandler);
			this.lianwangMain.cancel.addEventListener(MouseEvent.CLICK, cancel_clickHandler);
		}
		
		protected function d60BClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			StoreKit.storeKit.purchaseProduct(D60_PRODUCT_ID,1);
		}
		
		protected function d250BClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			StoreKit.storeKit.purchaseProduct(D250_PRODUCT_ID,1);
		}
		
		protected function dIphoneBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			lianwangMain.duihuan.visible =true;
//			lianwangMain.jingpinName.text = "iPhone 4s 16G";
			lianwangMain.jiangpinDianshu.text = "7000";
		}
		
		protected function dIpadBClickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			lianwangMain.duihuan.visible =true;
//			lianwangMain.jingpinName.text = "iPad2 16G";
			lianwangMain.jiangpinDianshu.text = "5000";
		}
		
		protected function cancel_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			lianwangMain.duihuan.visible =false;
//			lianwangMain.jingpinName.text = "";
			lianwangMain.jiangpinDianshu.text = "";
			clear();
		}
		
		protected function check_clickHandler(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(lianwangMain.contactName.text.length <=0){
				Alert.show("联系人没有填写！");
				return;
			}
			
			if(lianwangMain.contactTel.text.length <=0){
				Alert.show("联系电话没有填写！");
				return;
			}
			
			if(lianwangMain.contactAddress.text.length <=0){
				Alert.show("邮寄地址没有填写！");
				return;
			}
			
			var duihuanlog:Duihuanlog = new Duihuanlog();
			duihuanlog.playerName = MainPlayerService.getInstance().mainPlayer.playername;
//			duihuanlog.itemName = lianwangMain.jingpinName.text;
			duihuanlog.duihuanMoney = lianwangMain.jiangpinDianshu.text as Number;
			duihuanlog.lastHaveMoney = MainPlayerService.getInstance().mainPlayer.haveMoney;
			duihuanlog.nowHaveMoney = MainPlayerService.getInstance().mainPlayer.haveMoney - duihuanlog.duihuanMoney;
			duihuanlog.contactName = lianwangMain.contactName.text;
			duihuanlog.contactTel = lianwangMain.contactTel.text;
			duihuanlog.contactAddress = lianwangMain.contactAddress.text;
			
			RemoteService.instance.playerService.duihuan(duihuanlog);
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,duihuanResultHandler);
		}
		
		private function duihuanResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,duihuanResultHandler);
			if(e.result is MainPlayer){
				Alert.show("奖品领取成功！");
				clear();
			}else{
				Alert.show(e.result.toString());
			}
		}
		
		private function logBClickHandler(e:MouseEvent):void{
			
//			LogControl.instance.getGameHistoryClickHandler(null);
			LianwangHomeControl.instance.lianwangHome.currentState = "log";
		}
		
		private function clear():void{
			lianwangMain.contactName.text = "";
			lianwangMain.contactTel.text = "";
			lianwangMain.contactAddress.text = "";
		}
	}
}