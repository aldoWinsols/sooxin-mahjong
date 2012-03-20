package com.control
{
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
			this.log.closeB.addEventListener(MouseEvent.CLICK,closeClickHandler);
			
		}
		
		public function getGameHistoryClickHandler(e:MouseEvent):void{
			RemoteService.instance.playlogService.findPlayLog(MainPlayerService.getInstance().mainPlayer.playername);
			RemoteService.instance.playlogService.addEventListener(ResultEvent.RESULT,getGameHistoryResult);
		}
		
		private function getChongzhiHistoryClickHandler(e:MouseEvent):void{
			RemoteService.instance.chongzhiService.findChongzhiLog(MainPlayerService.getInstance().mainPlayer.playername);
			RemoteService.instance.chongzhiService.addEventListener(ResultEvent.RESULT,getChongzhiHistoryResult);
		}
		
		private function getPrizeHistoryClickHandler(e:MouseEvent):void{
			RemoteService.instance.duihuanService.findDuihuanLog(MainPlayerService.getInstance().mainPlayer.playername);
			RemoteService.instance.duihuanService.addEventListener(ResultEvent.RESULT,getPrizeHistoryResult);
		}
		
		
		private function getGameHistoryResult(e:ResultEvent):void{
			RemoteService.instance.playlogService.removeEventListener(ResultEvent.RESULT,getGameHistoryResult);
			var array:ArrayCollection = e.result as ArrayCollection;
			this.log.gameHistory.dataProvider = array;
		}
		private function getChongzhiHistoryResult(e:ResultEvent):void{
			RemoteService.instance.chongzhiService.removeEventListener(ResultEvent.RESULT,getChongzhiHistoryResult);
			this.log.chongzhiHistory.dataProvider = e.result as ArrayList;
		}
		private function getPrizeHistoryResult(e:ResultEvent):void{
			RemoteService.instance.duihuanService.removeEventListener(ResultEvent.RESULT,getPrizeHistoryResult);
			this.log.prizeHistory.dataProvider = e.result as ArrayList;
		}
		
		private function closeClickHandler(e:MouseEvent):void{
			this.log.visible = false;
		}
	}
}