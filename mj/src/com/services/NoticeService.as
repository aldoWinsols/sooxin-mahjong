package com.services
{
	import com.view.Notice;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class NoticeService
	{
		public static var instance:NoticeService = null;
		private var netLoader:URLLoader;
		private var localLoader:URLLoader;
		public var chatList:XMLList;
		
		public function NoticeService()
		{
			getNetChats();
		}
		
		public static function getInstance():NoticeService{
			if(instance == null){
				instance = new NoticeService();
			}
			return instance;
		}
		
		public function getNetChats():void
		{
			netLoader = new URLLoader(new URLRequest("http://www.sooxin.net/chat.xml"));
			netLoader.addEventListener(Event.COMPLETE, netLoadCompleteHandler, false, 0, true);
			netLoader.addEventListener(IOErrorEvent.IO_ERROR,netErrorHandler);
		}
		
		private function netErrorHandler(e:IOErrorEvent):void{
			localLoader = new URLLoader(new URLRequest("chat.xml"));
			localLoader.addEventListener(Event.COMPLETE, localLoadCompleteHandler, false, 0, true);
		}
		
		private function netLoadCompleteHandler(event:Event):void{
			var loader:URLLoader = URLLoader(event.currentTarget);
			var configXML:XML = XML(loader.data);
			chatList = configXML.chats.chat;
			Notice.instance.startTimer();
		}
		
		private function localLoadCompleteHandler(event:Event):void{
			var loader:URLLoader = URLLoader(event.currentTarget);
			var configXML:XML = XML(loader.data);
			chatList = configXML.chats.chat;
		}
	}
}