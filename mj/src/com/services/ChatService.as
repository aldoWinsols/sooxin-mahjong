package com.services
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ChatService
	{
		public static var instance:ChatService;
		public var chatList:XMLList;
		
		public static function getInstance():ChatService{
			if(instance == null){
				instance = new ChatService();
			}
			
			return instance;
		}
		
		var fileReference:FileReference;
		
		public function ChatService(){
			fileReference = new FileReference();
			
			getNetChats();
		}
		
		
		var netLoader:URLLoader;
		var localLoader:URLLoader;
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
		}
		
		private function localLoadCompleteHandler(event:Event):void{
			var loader:URLLoader = URLLoader(event.currentTarget);
			var configXML:XML = XML(loader.data);
			chatList = configXML.chats.chat;
		}
	}
}