package com.amusement.HundredHappy.services
{
	
	import com.amusement.HundredHappy.control.DeskPanelControl;
	import com.control.MainSceneControl;
	import com.service.ConfigService;
	import com.service.PlayerService;
	import com.util.GameTypeEvent;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.utils.Timer;
	
	import mx.controls.Alert;

	/**
	 * 2012-2-23 9:39 gmr start 添加游戏退出监听事件
	 * */
	public class HundredHappySyncService
	{
		NetConnection.defaultObjectEncoding=flash.net.ObjectEncoding.AMF3;
		
		private static var _instance:HundredHappySyncService;
		
		private var _connState:String; //连接状态
		private var _conn:NetConnection;
		private var _svrPath:String
		
		public var connStateTimer:Timer;
		
		public function HundredHappySyncService()
		{
			_conn=new NetConnection();
			_conn.client = MessageService.instance;
			MessageService.instance.conn = _conn; 
			
			//g 2011-5-17 11:27 时钟
			connStateTimer=new Timer(100);
			connStateTimer.addEventListener(TimerEvent.TIMER, connStateHandler);
			connStateTimer.start();
			
			// 2012-2-23 9:39 gmr start 添加游戏退出监听事件
			MainSceneControl.instance.mainSceneApp.addEventListener(GameTypeEvent.HUNDREDHAPPY_EXITGAME, onDisconnection);
			// 2012-2-23 9:39 gmr end
		}
		
		// g 2011-5-17  13:56  是否可以创建
		public static function get instance():HundredHappySyncService
		{
			if (_instance == null){
				_instance = new HundredHappySyncService();
			}
			return _instance;
		}
		
		// g 2011-5-17 16:00 判断instance是否为空
		public static function isInstanceBeNull():Boolean{
			if(_instance){
				return false;
			}else{
				return true;
			}
		}
		
		public function connServer():void{ 
			_conn.addEventListener(NetStatusEvent.NET_STATUS, statusHandler);
			_conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_conn.connect(ConfigService.instance.hundredHappy, PlayerService.instance.player.acctName, PlayerService.instance.player.acctPwd, PlayerService.instance.ip); 
		}
		
		public function closeConn():void{
			connStateTimer.stop();
			_conn.removeEventListener(NetStatusEvent.NET_STATUS, statusHandler);
			_conn.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_conn.close();
		}
		
		// 2012-2-23 9:39 gmr start 添加游戏退出监听事件
		public function onDisconnection(event:Event):void{
			closeConn();
		}
		// 2012-2-23 9:39 gmr end
		
		private function statusHandler(evt:NetStatusEvent):void
		{
			trace(evt.info.code);
			if (evt.info.code == "NetConnection.Connect.Success")
			{
				_connState = "连接成功！";
			}
			else
			{
				// g 2011-6-7  15:58  添加TIMER停止
				connStateTimer.stop();
				Alert.show("连接失败！请重新登陆");
				_connState = "连接失败！请重新登陆";
			}
		}
		
		//g 2011-5-17 11:27 每5秒钟发送一次网络质量检测
		private var connTimes:int=49;
		private var connTimesT:int=0;
		private var isResult:Boolean = true;
		
		public function connStateHandler(e:TimerEvent):void
		{
			connTimes++;
			if (connTimes % 51 == 0 && isResult)
			{
				isResult = false;
				connTimesT=connTimes;
				if (_conn == null)
				{
					DeskPanelControl.instance.setNetworkWidth(0);
				}
				else
				{
					try
					{
						_conn.call("getConnState", new Responder(onResult, onStatus));
					}
					catch (e:Error)
					{
						trace(e);
					}
				}
			}
			if(!isResult){
				if(connTimes % 50 == 0){
					DeskPanelControl.instance.setNetworkWidth(0);
					MainSceneControl.instance.mainSceneApp.connState.visible = true;
					//Alert.show("你当前网络质量差！");
				}
			}
		}
		
		private function onResult(obj:Object):void
		{
			try{
				var width:int = 100 - (connTimes - connTimesT);
				if(width < 0){
					width = 0;
				}
				DeskPanelControl.instance.setNetworkWidth(width);
				connTimes=0;
				isResult = true;
			}catch(e:Error){
				
			}
			
			//trace("result:" + obj);
		}
		
		private function onStatus(obj:Object):void
		{
			trace("status:" + obj);
		}
		
		public function asyncErrorHandler(e:AsyncErrorEvent):void
		{
			Alert.show("服务器同步发生异常！");
		}

	}
}