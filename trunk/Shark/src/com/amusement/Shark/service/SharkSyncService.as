package com.amusement.Shark.service
{
	import com.amusement.Shark.control.*;
	import com.amusement.Shark.model.SharkTouzhu;
	import com.model.Alert;
	import com.service.*;
	import com.sharkSyncServer.services.MainService;
	import com.sharkSyncServer.services.TimerServer;
	
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;

	/**
	 * 2012-2-23 9:39 gmr start 添加游戏退出监听事件
	 * */
	public class SharkSyncService extends Sprite
	{
		public var connState:Boolean; //连接状态

		NetConnection.defaultObjectEncoding=flash.net.ObjectEncoding.AMF0;

		public static var instance:SharkSyncService;

		public static function getInstance():SharkSyncService
		{
			if (instance == null)
			{
				instance=new SharkSyncService();
			}
			return instance;
		}

		//---------------------------------------------------------------------
		public var conn:NetConnection;

		public function SharkSyncService()
		{
		}

		//---------------------------
		//返回服务器异常等 并结束游戏
		public function serverExcpetion(ex:String):void
		{
			Alert.show(ex.toString());
			SharkSyncService.instance.disConnServer();
//			TouzhuControl.instance.setAllUnclock();
			BetPanelControl.instance.setLock(false);
//			TouzhuControl.instance.setAllZero();
			BetPanelControl.instance.clear();
//			Player.instance.setNowMoney();
//			SharkSoundService.instance.stopAllMusic(); //退出时关闭声音
			SharkSystemPanelControl.instance.finish();
		}


		public function connServer():void
		{
			conn=new NetConnection();
			conn.addEventListener(NetStatusEvent.NET_STATUS, statusHandler);
			conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
//			conn.connect(svrPath, Player.instance.playerName);
//			conn.connect(svrPath, PlayerService.instance.player.acctName, PlayerService.instance.player.acctPwd, PlayerService.instance.ip);
			conn.client=this;
			
			// 2012-2-23 9:39 gmr end
		}

		public function disConnServer():void
		{
			if(conn){
				conn.close();
			}
			conn=null;
		}
		
		// 2012-2-23 9:39 gmr start 添加游戏退出监听事件
		public function onDisconnection(event:Event):void{
			disConnServer();
		}
		// 2012-2-23 9:39 gmr end

		private function statusHandler(evt:NetStatusEvent):void
		{
			trace(evt.info.code);
			if (evt.info.code == "NetConnection.Connect.Success")
			{
				connState=true;
			}
			else
			{
//				if (TouzhuControl.instance.isUserDisconn)
				if (SharkControl.instance.isUserDisconn)
				{
//					SharkSoundService.instance.stopAllMusic();
					SharkSystemPanelControl.instance.finish();
//					TouzhuControl.instance.isUserDisconn=false;
					SharkControl.instance.isUserDisconn=false;
				}
				else
				{
					connState=false;
					Alert.show("對不起，由於服務斷開，現返回大廳！");
					disConnServer();
//					TouzhuControl.instance.setAllUnclock();
					BetPanelControl.instance.setLock(false);
//					TouzhuControl.instance.setAllZero();
					BetPanelControl.instance.clear();
//					Player.instance.setNowMoney();
//					PlayerService.instance.setNowMoney();
//					SharkSoundService.instance.stopAllMusic();
					SharkSystemPanelControl.instance.finish();
					//如果规则正在显示则关闭显示
					/*if (MainSceneControl.instance.mainSceneApp.gameRule.visible)
					{
						MainSceneControl.instance.mainSceneApp.gameRule.visible=false;
					}*/
					//移出此module
//					MainSceneControl.instance.mainSceneApp.gameModule.unloadModule();
//					MainSceneControl.instance.mainSceneApp.gameModule.visible=false;
//					MainSceneControl.instance.setZezhaoVisible(false);
					
//					PlayerService.instance.playerEnterSomeGame();
				}

			}
		}

		//---------------------------------------------------------------------------------------------
		public function updateOnlineNumber(n:int):void
		{

			SharkSyncService.instance.updateOnlineNumber(n);
		}

		public var downNumber:int;

		public function updateCountDownNumberC(n:int):void
		{
			downNumber=n;
			SharkControl.instance.updateCountDownNumber(n);
		}

		public function runC(resaultNum:int, gameNum:Number):void
		{
			SharkControl.instance.runC(resaultNum, gameNum);
		}

		public function updateTouzhuS(sharkTouzhu:SharkTouzhu):void
		{
			//如果处于连接状态则发送
			if (conn != null)
			{
//				conn.call("updateTouzhu", new Responder(getResult, getError), sharkTouzhu);
				MainService.updateTouzhu(TimerServer.players, sharkTouzhu);
			}
		}

		public function updateAllTouzhuC(o:Object):void
		{
			if (downNumber > 4 && downNumber < 45)
			{
				SharkControl.instance.sharkApp.allTouzhu.updateAllTouzhu(o);
			}
		}


		//显示结果面板的控制

		public function isSuccessUpdateDataC(bool:Boolean, changeNum:int, touzhu:Object):void
		{
			SharkControl.instance.isSuccessUpdateData(bool, changeNum, touzhu);
		}

		public function asyncErrorHandler(e:AsyncErrorEvent):void
		{
			Alert.show("服务器同步发生异常！")
		}

		//远程调用返回结果
		public function getResult(r:Object):void
		{
			//Alert.show("服务端返回结果为：....." + returnobj);
		}

		public function getError(e:Object):void
		{
			Alert.show("程序异常！")
		}

	}
}