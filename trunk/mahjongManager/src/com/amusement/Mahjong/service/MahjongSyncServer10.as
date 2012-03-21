package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongSettingControl;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.controls.Alert;

	public class MahjongSyncServer10
	{
		private static var instance:MahjongSyncServer10;
		public var conn:NetConnection;

		public function MahjongSyncServer10()
		{
			connServer();
		}

		public static function getInstance():MahjongSyncServer10
		{
			if(instance == null){
				instance = new MahjongSyncServer10();
			}
			return instance;
		}

		public function connServer():void
		{
			NetConnection.defaultObjectEncoding=flash.net.ObjectEncoding.AMF0;
			conn=new NetConnection();
			conn.client=this;

			conn.addEventListener(NetStatusEvent.NET_STATUS, statusHandler);
			conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);

			conn.connect("rtmp://127.0.0.1/mahjongSyncServer10", "osroot", "", "");

			function statusHandler(evt:NetStatusEvent):void
			{
				trace(evt.info.code);
				if (evt.info.code == "NetConnection.Connect.Success")
				{
					//Alert.show("连接成功！");
					getTransformerState();
					
					getOnlineNum();
					
					getAgencyEqualAndIpEqual();
				}
				else
				{
					if(evt.info.code == "NetConnection.Connect.Failed"){
						Alert.show("连接失败！请重新登陆");
					}
					trace("无法连接同步服务！MahjongSyncServer5" + evt.info.code);
				}
			}

			function asyncErrorHandler(e:AsyncErrorEvent):void
			{
				trace(e.toString());
			}
		}

		public function disConnServer():void
		{
			conn.close();
			conn=null;
			instance = null;
		}
		
		public function updateTransformerState(onlineNum:int, transformerWinGailv:Number):void
		{
			conn.call("updateTransformerState", new Responder(onOneMsgResult, onOneMsgStatus), onlineNum, transformerWinGailv);
		}
		
		public function getTransformerState():void
		{
			conn.call("getTransformerState", new Responder(getTransformerStateResult, onOneMsgStatus));
		}
		
		public function getOnlineNum():void{
			conn.call("getOnlineNum",new Responder(getOnlineNumResult,onOneMsgStatus));
		}
		
		public function getRoomPlayerList():void{
			conn.call("getRoomPlayerList",new Responder(getRoomPlayerListResult,onOneMsgStatus));
		}
		
		public function updateAgencyEqualAndIpEqual(isIpEqual:Boolean , isAgencyEqual:Boolean):void{
			conn.call("updateAgencyEqualAndIpEqual",new Responder(onOneMsgResult,onOneMsgStatus), isIpEqual, isAgencyEqual);
		}
		
		public function serverDisconnectClient(playerName:String):void{
			conn.call("serverDisconnectClient",new Responder(onOneMsgResult,onOneMsgStatus), playerName);
		}
		
		public function getAgencyEqualAndIpEqual():void{
			conn.call("getAgencyEqualAndIpEqual",new Responder(getAgencyEqualAndIpEqualResult,onOneMsgStatus));
		}
		
		private function getOnlineNumResult(obj:Object):void{
			var result : String = obj.toString();
			MahjongSettingControl.instance.getOnlineNum10(result);
		}
		
		private function getAgencyEqualAndIpEqualResult(obj:Object):void{
			var result : String = obj.toString();
			var array:Array = result.split(",");
			var isIpEqual:Boolean = array[0] == "false" ? false : true;
			var isAgencyEqual:Boolean = array[1] == "false" ? false : true;
			MahjongSettingControl.instance.updateEqual10(isIpEqual, isAgencyEqual);
		}
		
		private function getTransformerStateResult(obj:Object):void
		{
			MahjongSettingControl.instance.updateMahjong10(Number(obj));
			trace("one_result:" + obj);
		}
		
		//---------------------------------------------------------
		private function onOneMsgResult(obj:Object):void
		{
			Alert.show("修改成功！");
		}
		
		private function getRoomPlayerListResult(obj:Object):void{
			
		}
		
		private function onOneMsgStatus(obj:Object):void
		{
			trace("one_status:" + obj);
		}

	}
}