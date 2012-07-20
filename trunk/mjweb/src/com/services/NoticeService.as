package com.services
{
	import com.view.Notice;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class NoticeService
	{
		public static var instance:NoticeService = null;
		private var netLoader:URLLoader;
		private var localLoader:URLLoader;
		public var chatList:XMLList;
		var getTimer:Timer = new Timer(300000);
		
		public function NoticeService()
		{
			getTimer.addEventListener(TimerEvent.TIMER,getTimerHandler);
			getTimer.start();
			
			getNetChats();
		}
		
		private function getTimerHandler(e:TimerEvent):void{
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
			netLoader = new URLLoader(new URLRequest("http://www.sooxin.net/notice.xml"));
			netLoader.addEventListener(Event.COMPLETE, netLoadCompleteHandler, false, 0, true);
			netLoader.addEventListener(IOErrorEvent.IO_ERROR,netErrorHandler);
		}
		
		private function netErrorHandler(e:IOErrorEvent):void{
			localLoader = new URLLoader(new URLRequest("notice.xml"));
			localLoader.addEventListener(Event.COMPLETE, localLoadCompleteHandler, false, 0, true);
		}
		
		private function netLoadCompleteHandler(event:Event):void{
			var loader:URLLoader = URLLoader(event.currentTarget);
			var configXML:XML = XML(loader.data);
			chatList = configXML.chats.chat;
			
			if(!Notice.timer.running){
				Notice.instance.startTimer();
			}
		}
		
		private function localLoadCompleteHandler(event:Event):void{
			var loader:URLLoader = URLLoader(event.currentTarget);
			var configXML:XML = XML(loader.data);
			chatList = configXML.chats.chat;
			
			if(!Notice.timer.running){
				Notice.instance.startTimer();
			}
		}
	}
}