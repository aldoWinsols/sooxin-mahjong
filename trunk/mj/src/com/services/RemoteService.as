package com.services
{
	import com.control.MainSenceControl;
	import com.model.Alert;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.managers.CursorManager;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class RemoteService
	{
		public var mainUrl:String = "http://192.168.1.1:8080/";
		public static var instance:RemoteService;
		
		public var chongzhiService:RemoteObject;
		public var duihuanService:RemoteObject;
		public var playlogService:RemoteObject;
		public var playerService:RemoteObject;
		public var shangpinService:RemoteObject;
		public var noticeService:RemoteObject;		
		public var configService:RemoteObject;
		public var roomService:RemoteObject;
		
		public var connState:Boolean = false;

		
		private var netLoader:URLLoader;
		private var localLoader:URLLoader;
		public var urlList:XMLList;
		public function RemoteService()
		{
//			netLoader = new URLLoader(new URLRequest("http://www.sooxin.net/config.xml"));
//			netLoader.addEventListener(Event.COMPLETE, netLoadCompleteHandler, false, 0, true);
//			netLoader.addEventListener(IOErrorEvent.IO_ERROR,netErrorHandler);
		}
		
		private function netErrorHandler(e:IOErrorEvent):void{
			
		}
		
		private function netLoadCompleteHandler(event:Event):void{
			var loader:URLLoader = URLLoader(event.currentTarget);
			var configXML:XML = XML(loader.data);
			urlList = configXML.url.mainUrl;
			mainUrl = urlList[0].@text;
		}
		
		
		public function init():void{
			chongzhiService=getConfiguredRO("chongzhiService");
			duihuanService=getConfiguredRO("duihuanService");
			playlogService=getConfiguredRO("playlogService");
			playerService=getConfiguredRO("playerService");
			shangpinService=getConfiguredRO("shangpinService");
			noticeService=getConfiguredRO("noticeService");
			configService=getConfiguredRO("configService");
			roomService=getConfiguredRO("roomService");
		}

		//得到单例
		public static function getInstance():RemoteService
		{
			if(instance == null){
				instance = new RemoteService();
			}
			return instance;
		}

		private function resultHandler(e:ResultEvent):void
		{
			CursorManager.removeBusyCursor();
		}

		private function addResultEvent(ro:RemoteObject):void
		{
			ro.addEventListener(ResultEvent.RESULT, resultHandler);
		}

		private function invokeHandler(e:InvokeEvent):void
		{
			CursorManager.setBusyCursor();
		}

		private function addInvokeEvent(ro:RemoteObject):void
		{
			ro.addEventListener(InvokeEvent.INVOKE, invokeHandler);
		}


		private function faultHandler(e:FaultEvent):void
		{
			Alert.show("您的网络连接异常,请检查确认后重新操作,或联系客服!");
			trace(e.toString());
			CursorManager.removeBusyCursor();
			
			if(MainSenceControl.instance.mainSence.loginWaitInfo.visible){
				MainSenceControl.instance.mainSence.loginWaitInfo.visible = false;
			}
		}

		private function addFaultEvent(ro:RemoteObject):void
		{
			ro.addEventListener(FaultEvent.FAULT, faultHandler);
		}


		private function addAllEvent(ro:RemoteObject):void
		{
			addInvokeEvent(ro);
			addResultEvent(ro);
			addFaultEvent(ro);
		}

		private function setEndPoint(ro:RemoteObject):void
		{

			ro.endpoint=mainUrl+"panda/messagebroker/amf";
			trace(ro.endpoint);
		}


		//得到配置好的RemoteObject
		private function getConfiguredRO(destination:String):RemoteObject
		{
			var ro:RemoteObject=new RemoteObject(destination);

			setEndPoint(ro);
			addAllEvent(ro);

			return ro;
		}
	}
}