package com.stock.services
{
	import com.stock.view.Notice;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	
	public class NoticeService
	{
		public static var instance:NoticeService = null;
		public var notices:ArrayCollection;
		
		public function NoticeService()
		{
			getNotie();
		}
		
		public static function getInstance():NoticeService{
			if(instance == null){
				instance = new NoticeService();
			}
			return instance;
		}
		
		public function getNotie():void
		{
			RemoteService.instance.stockInfoService.getNotie();
			RemoteService.instance.stockInfoService.addEventListener(ResultEvent.RESULT,getNotieResultHandler);

		}
		
		protected function getNotieResultHandler(event:ResultEvent):void
		{
			// TODO Auto-generated method stub
			RemoteService.instance.stockInfoService.removeEventListener(ResultEvent.RESULT,getNotieResultHandler);
			notices = event.result as ArrayCollection;
		}		

	}
}