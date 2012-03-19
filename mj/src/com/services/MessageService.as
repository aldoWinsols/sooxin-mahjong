package com.services
{
	
	import flash.net.NetConnection;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import mx.events.CloseEvent;

	public class MessageService
	{
		private static var _instance:MessageService=null;

		private var _conn:NetConnection;

		public function MessageService()
		{
		}

		public static function get instance():MessageService
		{
			if (_instance == null)
			{
				_instance=new MessageService();
			}
			return _instance;
		}
		
		public function startWeihuI(obj:Object):void{
			var array:Array = String(obj.content).split("=");
		}
		
		public function stopMessageI(obj:Object):void{
			
		}
		
		public function loginPlayerI(obj:Object):void{
			var array:Array = obj.content as Array;
			
			for(var key:String in array){
				MainPlayerService.instance.setRoomNumByType(key, int(array[key]));
			}
		}
		
		public function sendRoomNumI(obj:Object):void{
			var strs:Array = (obj.content as String).split(",");
			MainPlayerService.instance.setRoomNumByType(strs[0], int(strs[1]));
		}
		
		public function restartGame(e:CloseEvent):void{
			navigateToURL(new URLRequest("javascript:location.reload();"),"_self");
		}
		
		//--------------------------------- player login success function -----------------------------
		
		public function disConnectPlayerI(obj:Object):void{
			MainSyncService.instance.disConnServer();
			
			var content:String = obj.content;
		}
		
		public function updatePlayerMoneyI(obj:Object):void{
			var content:Number = obj.content;
			
		}
		
		//---------------------------------------------------------
		private function onOneMsgResult(obj:Object):void
		{
			trace("one_result:" + obj);
		}

		private function onOneMsgStatus(obj:Object):void
		{
			trace("one_status:" + obj);
		}
		
		//----------------------------------------------------------------------------------------
		private function alertCloseHandlder(event:CloseEvent):void{
			
		}

		//----------------------------------------------------------
		public function set conn(value:NetConnection):void
		{
			this._conn=value;
		}
	}
}