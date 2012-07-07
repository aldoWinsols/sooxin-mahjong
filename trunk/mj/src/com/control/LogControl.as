package com.control
{
	import com.services.ConfigService;
	import com.services.MainPlayerService;
	import com.services.RemoteService;
	import com.view.Log;
	
	import flash.events.MouseEvent;
	
	import mx.binding.utils.BindingUtils;
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.rpc.events.ResultEvent;

	public class LogControl
	{
		public static var instance:LogControl;
		private var log:Log;
		public function LogControl(log:Log)
		{
			instance = this;
			this.log = log;
			this.log.currentState="jiangpin";
			this.log.currentState="chongzhi";
			this.log.currentState="game";
			
			getGameHistoryClickHandler(null);
			this.log.gameHistoryB.addEventListener(MouseEvent.CLICK,getGameHistoryClickHandler);
			this.log.chongzhiHistoryB.addEventListener(MouseEvent.CLICK,getChongzhiHistoryClickHandler);
			this.log.prizeHistoryB.addEventListener(MouseEvent.CLICK,getPrizeHistoryClickHandler);
			
			if(MainControl.instance.main.applicationDPI == 320){
				log.gameHistory.alpha = 1;
				log.chongzhiHistory.alpha = 1;
				log.prizeHistory.alpha = 1;
			}
			
			if(!ConfigService.instance.config.hideJiangpin){
				this.log.prizeHistoryB.visible = true;
			}
		}
		
		public function getGameHistoryClickHandler(e:MouseEvent):void{
			this.log.currentState="game";
			RemoteService.instance.playlogService.findPlayLog(MainPlayerService.getInstance().mainPlayer.playerName);
			RemoteService.instance.playlogService.addEventListener(ResultEvent.RESULT,getGameHistoryResult);
		}
		
		private function getChongzhiHistoryClickHandler(e:MouseEvent):void{
			this.log.currentState="chongzhi";
			RemoteService.instance.chongzhiService.findChongzhiLog(MainPlayerService.getInstance().mainPlayer.playerName);
			RemoteService.instance.chongzhiService.addEventListener(ResultEvent.RESULT,getChongzhiHistoryResult);
		}
		
		private function getPrizeHistoryClickHandler(e:MouseEvent):void{
			this.log.currentState="jiangpin";
			RemoteService.instance.duihuanService.findDuihuanLog(MainPlayerService.getInstance().mainPlayer.playerName);
			RemoteService.instance.duihuanService.addEventListener(ResultEvent.RESULT,getPrizeHistoryResult);
		}
		
		
		private function getGameHistoryResult(e:ResultEvent):void{
			RemoteService.instance.playlogService.removeEventListener(ResultEvent.RESULT,getGameHistoryResult);
			var array:ArrayCollection = changeID(e.result as ArrayCollection);
			this.log.gameHistory.dataProvider = array;
		}
		private function getChongzhiHistoryResult(e:ResultEvent):void{
			RemoteService.instance.chongzhiService.removeEventListener(ResultEvent.RESULT,getChongzhiHistoryResult);
			this.log.chongzhiHistory.dataProvider = changeID(e.result as ArrayCollection);
		}
		private function getPrizeHistoryResult(e:ResultEvent):void{
			RemoteService.instance.duihuanService.removeEventListener(ResultEvent.RESULT,getPrizeHistoryResult);
			this.log.prizeHistory.dataProvider = changeID(e.result as ArrayCollection);
		}
		
		private function changeID(arr:ArrayCollection):ArrayCollection{
			var n:int = arr.length;
			var arrNew:ArrayCollection = new ArrayCollection();
			for(var i:int=arr.length-1; i>-1; i--){
				arr.getItemAt(i).id = n--;
				arrNew.addItem(arr.getItemAt(i));
			}
			
			return arrNew;
		}
	}
}