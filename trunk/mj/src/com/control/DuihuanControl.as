package com.control
{
	import com.milkmangames.nativeextensions.ios.StoreKit;
	import com.model.Alert;
	import com.model.Duihuanlog;
	import com.model.MainPlayer;
	import com.services.MainPlayerService;
	import com.services.RemoteService;
	import com.view.Duihuan;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	import spark.events.GridSelectionEvent;

	public class DuihuanControl
	{
		private var duihuan:Duihuan;
		public static var instance:DuihuanControl;
		public function DuihuanControl(duihuan:Duihuan)
		{
			this.duihuan = duihuan;
			
			
			this.duihuan.currentState = "check";
			instance = this;
			this.duihuan.dg.addEventListener(GridSelectionEvent.SELECTION_CHANGE,selectChaneHandler);
			this.duihuan.cancelB.addEventListener(MouseEvent.CLICK,cancelBClickHandler);
			this.duihuan.checkB.addEventListener(MouseEvent.CLICK,checkBClickHandler);
			
			if(MainControl.instance.main.applicationDPI == 320){
				duihuan.dg.alpha = 1;
				duihuan.duihuaiViewNavigator.title="";
			}
			
			this.duihuan.currentState = "main";
			getShangpin();
		}
		
		protected function checkBClickHandler(event:MouseEvent):void
		{
			duihuan.contactNameErr.text="";
			duihuan.contactTelErr.text="";
			duihuan.contactAddressErr.text="";
			// TODO Auto-generated method stub
			if(duihuan.contactName.text.length <=0){
				duihuan.contactNameErr.text="联系人没有填写！";
				return;
			}
			
			if(duihuan.contactTel.text.length <=0){
				duihuan.contactTelErr.text="联系电话没有填写！";
				return;
			}
			
			if(duihuan.contactAddress.text.length <=0){
				duihuan.contactAddressErr.text="邮寄地址没有填写！";
				return;
			}
			
			var duihuanlog:Duihuanlog = new Duihuanlog();
			duihuanlog.playerName = MainPlayerService.getInstance().mainPlayer.playerName;
			duihuanlog.itemName = duihuan.jingpinName.text;
			duihuanlog.duihuanMoney = Number(duihuan.jiangpinDianshu.text);
			duihuanlog.lastHaveMoney = MainPlayerService.getInstance().mainPlayer.haveMoney;
			duihuanlog.nowHaveMoney = MainPlayerService.getInstance().mainPlayer.haveMoney - duihuanlog.duihuanMoney;
			duihuanlog.contactName = duihuan.contactName.text;
			duihuanlog.contactTel = duihuan.contactTel.text;
			duihuanlog.contactAddress = duihuan.contactAddress.text;
			duihuanlog.state = "等待发货";
			duihuanlog.duihuanTime = new Date();
			
			RemoteService.instance.playerService.duihuan(duihuanlog);
			RemoteService.instance.playerService.addEventListener(ResultEvent.RESULT,duihuanResultHandler);
		}
		
		private function duihuanResultHandler(e:ResultEvent):void{
			RemoteService.instance.playerService.removeEventListener(ResultEvent.RESULT,duihuanResultHandler);
			if(e.result is MainPlayer){
				Alert.show("奖品领取成功！");
				clear();
				MainPlayerService.getInstance().mainPlayer = e.result as MainPlayer;
				this.duihuan.currentState = "main";
			}else{
				trace(e.result.toString());
				Alert.show(e.result.toString());
			}
		}
		
		private function clear():void{
			duihuan.contactName.text = "";
			duihuan.contactTel.text = "";
			duihuan.contactAddress.text = "";
		}
		
		private function cancelBClickHandler(e:MouseEvent):void{
			this.duihuan.currentState = "main";
		}
		
		public function getShangpin():void{
			RemoteService.instance.shangpinService.huodeAllShangpin();
			RemoteService.instance.shangpinService.addEventListener(ResultEvent.RESULT,huodeAllShangpinResultHandler);
		}
		
		private function huodeAllShangpinResultHandler(e:ResultEvent):void{
			RemoteService.instance.shangpinService.removeEventListener(ResultEvent.RESULT,huodeAllShangpinResultHandler);
			duihuan.dg.dataProvider = e.result as ArrayCollection;
		}
		
		private function selectChaneHandler(e:GridSelectionEvent):void{
			this.duihuan.currentState = "check";
			duihuan.jingpinName.text = duihuan.dg.selectedItem.shangpinName;
			duihuan.jiangpinDianshu.text = duihuan.dg.selectedItem.price;
		}
	}
}