package com.stock.services
{	
	import com.stock.model.Alert;
	
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
		public var mainUrl:String = "http://127.0.0.1:8080/";
		public static var instance:RemoteService;
		
		public var playerService:RemoteObject;
		public var lineService:RemoteObject;
		public var bshistoryService:RemoteObject;
		public var bagService:RemoteObject;
		
		public var connState:Boolean = false;

		
		private var netLoader:URLLoader;
		private var localLoader:URLLoader;
		public var urlList:XMLList;
		public function RemoteService()
		{
			playerService=getConfiguredRO("playerService");
			lineService=getConfiguredRO("lineService");
			bshistoryService=getConfiguredRO("bshistoryService");
			bagService=getConfiguredRO("bagService");
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

			ro.endpoint=mainUrl+"Stock/messagebroker/amf";
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