package com.services
{
	
	import com.control.LianwangHomeControl;
	import com.control.MainSenceControl;
	import com.model.Alert;
	import com.view.LianwangHome;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;
	
	import mx.events.CloseEvent;
	
	public class MainSyncService
	{
		NetConnection.defaultObjectEncoding=flash.net.ObjectEncoding.AMF3;
		
		private static var _instance:MainSyncService;
		
		private var _connState:String; //连接状态
		private var _conn:NetConnection;
		private var _svrPath:String;
		private var _isConnection:Boolean = false;
		private var _isReconnection:Boolean = true;
		
		
		
		private var _connStateTimer:Timer;
		private var _connTimes:int = 49;
		private var _connTimesT:int = 0;
		private var _isResult:Boolean = true;
		
		public function MainSyncService()
		{
			_conn=new NetConnection();
			_conn.client=MessageService.instance;
			MessageService.instance.conn = _conn;
			_connStateTimer = new Timer(100);
			_connStateTimer.addEventListener(TimerEvent.TIMER, connTimerHandler, false, 0, true);
			connServer("");
		}
		
		public function get conn():NetConnection
		{
			return _conn;
		}
		
		public function get isConnection():Boolean{
			return _isConnection;
		}
		
		public function closeConn():void{
			if(_isConnection && _conn){
				_isReconnection = false;
				_conn.close();
			}
		}

		public function set conn(value:NetConnection):void
		{
			_conn = value;
		}

		public static function get instance():MainSyncService
		{
			if (_instance == null)
			{
				_instance=new MainSyncService();
			}
			return _instance;
		} 
		
		public function connServer(playerName:String):void
		{
			var str:String = ConfigService.instance.config.mainConnUrl;
			_conn.addEventListener(NetStatusEvent.NET_STATUS, statusHandler); 
			_conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_conn.connect(str, playerName);
			_connStateTimer.start();
		}
		
		private function connTimerHandler(event:TimerEvent):void{
			_connTimes++;
			if (_connTimes % 51 == 0 && _isResult){
				_isResult = false;
				
				_connTimesT = _connTimes;
				
				if (_conn == null){
					LianwangHomeControl.instance.lianwangHome.network.setStateWidth(0);
				}else{
					try{
						_conn.call("getConnState", new Responder(connStateResultHandler, connStateStatusHandler));
					}catch (e:Error){
						trace(e);
					}
				}
			}
			
			if(!_isResult){
				if(_connTimes % 50 == 0){
					LianwangHomeControl.instance.lianwangHome.network.setStateWidth(0);
//					MahjongRoomControl.instance.updateNetworkWidth(0);
//					MainSceneControl.instance.mainSceneApp.connState.visible = true;
					_isResult = true;
				}
			}
		}
		
		private function connStateResultHandler(obj:Object):void{
			try{
				var width:int = 100 - (_connTimes - _connTimesT);
				
				if(width < 0){
					width = 0;
				}
				
				LianwangHomeControl.instance.lianwangHome.network.setStateWidth(width);
//				MahjongRoomControl.instance.updateNetworkWidth(width);
				
				_connTimes=0;
				
				_isResult = true;
			}catch(e:Error){
				
			}
		}
		
		private function connStateStatusHandler(obj:Object):void{
			trace("conn_state_status_handler:" + obj);
		}
		
		public function disConnServer():void{
			_conn.removeEventListener(NetStatusEvent.NET_STATUS, statusHandler); 
			_conn.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_conn.close();
		}
		
		private var connectionNo:int = 0;
		private var connectionTimer:Timer = null;
		
		private function statusHandler(evt:NetStatusEvent):void
		{
			trace(evt.info.code);
			if (evt.info.code == "NetConnection.Connect.Success")
			{
				_isConnection = true;
				_connState="连接成功！";
				connectionNo = 0;
			}
			else
			{
				// 2011-5-17  14:29 添加重连机制， 超过5次就不在重新连接
				connectionNo ++;
				if(connectionNo >= 6){
//					NewAlert.show("重连次数超过5次，请检测你的网络！");
					navigateToURL(new URLRequest("javascript:location.reload();"),"_self");
				}else{
					if(_isReconnection){
//						NewAlert.show("与服务器断开连接！这是第 " + connectionNo + " 次重新连接服务器");
						if(connectionTimer == null){
							connectionTimer = new Timer(1000, 1);
							connectionTimer.addEventListener(TimerEvent.TIMER, onConnectionTimer);
						}
						connectionTimer.start();
					}
				}
				// V1.9 2011-9-5 11:28 连接断开属性
				_isConnection = false;
				
				_connState="连接失败！请重新登陆";
				if(MainSenceControl.instance.mainSence.currentState == "gameing"){
					MainSenceControl.instance.mainSence.currentState = "lianwangHome";
				}
				if(LianwangHomeControl.instance.lianwangHome.currentState == "main"){
					Alert.show("同步服务连接失败！请检查网络或联系客服！");
				}
			}
			
		}
		private function onConnectionTimer(e:TimerEvent):void{
//			_conn.connect(ConfigService.instance.mainSyncServerURL, PlayerService.instance.player.acctName);
		}
		
		public function asyncErrorHandler(e:AsyncErrorEvent):void
		{
//			Alert.show("服务器同步发生异常！");
		}
		
		private function reconnAlertClose(event:CloseEvent):void{
			navigateToURL(new URLRequest("javascript:location.reload();"),"_self");
		}
	}
}