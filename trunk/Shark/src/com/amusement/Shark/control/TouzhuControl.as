package com.amusement.Shark.control
{
	import com.amusement.Shark.SharkApp;
	import com.amusement.Shark.main.Touzhu;
	import com.amusement.Shark.model.SharkTouzhu;
	import com.amusement.Shark.service.SharkSoundService;
	import com.amusement.Shark.service.SharkSyncService;
	import com.model.Player;
	import com.control.MainSceneControl;

	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import mx.controls.Alert;

	public class TouzhuControl
	{
		private var sharkApp:SharkApp;
		public var touzhu:Touzhu;
		public static var instance:TouzhuControl;
		public var isUserDisconn:Boolean=false;
		public var updateTouzhuTimer:Timer;

		public function TouzhuControl(touzhu:Touzhu)
		{
			this.touzhu=touzhu;
			if (instance == null)
			{
				instance=this;
			}

			this.touzhu.quxiaoB.addEventListener(MouseEvent.CLICK, quxiaoHandler);
			this.touzhu.xuyaB.addEventListener(MouseEvent.CLICK, xuyaHandler);
			this.touzhu.exitB.addEventListener(MouseEvent.CLICK, exitHandler);


			//每5秒向服务器发送一次投住更新
			updateTouzhuTimer=new Timer(5000);
			updateTouzhuTimer.addEventListener(TimerEvent.TIMER, updateTouzhuHandler);
			updateTouzhuTimer.start();
		}

		//获得所有投住对象
		public function getTouzhu():Array
		{
			return touzhu.touzhuPan.getChildren();
		}

		public var dabaishaNum:int;
		public var geziNum:int;
		public var yanziNum:int;
		public var kongqueNum:int;
		public var laoyingNum:int;
		public var shiziNum:int;
		public var laohuNum:int;
		public var xiongmaoNum:int;
		public var houziNum:int;
		public var feiqinNum:int;
		public var zoushouNum:int;

		//设置上次历史记录
		public function setValue():void
		{
			dabaishaNum=touzhu.dabaisha.setLastValue();
			geziNum=touzhu.gezi.setLastValue();
			yanziNum=touzhu.yanzi.setLastValue();
			kongqueNum=touzhu.kongque.setLastValue();
			laoyingNum=touzhu.laoying.setLastValue();
			feiqinNum=touzhu.feiqin.setLastValue();
			zoushouNum=touzhu.zoushou.setLastValue();
			shiziNum=touzhu.shizi.setLastValue();
			laohuNum=touzhu.laohu.setLastValue();
			xiongmaoNum=touzhu.xiongmao.setLastValue();
			houziNum=touzhu.houzi.setLastValue();
		}

		//清空所有投住
		public function setAllZero():void
		{
			this.touzhu.dabaisha.setZero();
			this.touzhu.gezi.setZero();
			this.touzhu.yanzi.setZero();
			this.touzhu.kongque.setZero();
			this.touzhu.laoying.setZero();
			this.touzhu.feiqin.setZero();
			this.touzhu.zoushou.setZero();
			this.touzhu.shizi.setZero();
			this.touzhu.laohu.setZero();
			this.touzhu.xiongmao.setZero();
			this.touzhu.houzi.setZero();
		}

		//锁定所有投住
		public function setAllClock():void
		{
			this.touzhu.dabaisha.clock();
			this.touzhu.shizi.clock();
			this.touzhu.laoying.clock();
			this.touzhu.laohu.clock();
			this.touzhu.xiongmao.clock();
			this.touzhu.kongque.clock();
			this.touzhu.gezi.clock();
			this.touzhu.yanzi.clock();
			this.touzhu.houzi.clock();
			this.touzhu.feiqin.clock();
			this.touzhu.zoushou.clock();
			this.touzhu.dabaisha.buttonNoCss();
			this.touzhu.shizi.buttonNoCss();
			this.touzhu.laoying.buttonNoCss();
			this.touzhu.laohu.buttonNoCss();
			this.touzhu.xiongmao.buttonNoCss();
			this.touzhu.kongque.buttonNoCss();
			this.touzhu.gezi.buttonNoCss();
			this.touzhu.yanzi.buttonNoCss();
			this.touzhu.houzi.buttonNoCss();
			this.touzhu.feiqin.buttonNoCss();
			this.touzhu.zoushou.buttonNoCss();
			this.touzhu.xuyaB.buttonMode=false;
			this.touzhu.quxiaoB.buttonMode=false;
			this.touzhu.xuyaB.enabled=false;
			this.touzhu.quxiaoB.enabled=false;
			this.touzhu.exitB.enabled=false;

		}

		//解开锁定
		public function setAllUnclock():void
		{
			this.touzhu.dabaisha.unclock();
			this.touzhu.shizi.unclock();
			this.touzhu.laoying.unclock();
			this.touzhu.laohu.unclock();
			this.touzhu.xiongmao.unclock();
			this.touzhu.kongque.unclock();
			this.touzhu.gezi.unclock();
			this.touzhu.yanzi.unclock();
			this.touzhu.houzi.unclock();
			this.touzhu.feiqin.unclock();
			this.touzhu.zoushou.unclock();
			this.touzhu.dabaisha.buttonYouCss();
			this.touzhu.shizi.buttonYouCss();
			this.touzhu.laoying.buttonYouCss();
			this.touzhu.laohu.buttonYouCss();
			this.touzhu.xiongmao.buttonYouCss();
			this.touzhu.kongque.buttonYouCss();
			this.touzhu.gezi.buttonYouCss();
			this.touzhu.yanzi.buttonYouCss();
			this.touzhu.houzi.buttonYouCss();
			this.touzhu.feiqin.buttonYouCss();
			this.touzhu.zoushou.buttonYouCss();
			this.touzhu.xuyaB.buttonMode=true;
			this.touzhu.quxiaoB.buttonMode=true;
			this.touzhu.xuyaB.enabled=true;
			this.touzhu.quxiaoB.enabled=true;
			this.touzhu.exitB.enabled=true;
		}


		//向远程服务端发送更新投住
		public function updateTouzhuHandler(e:TimerEvent):void
		{
			SharkTouzhu.instance.playername=Player.instance.playerName;
			SharkTouzhu.instance.dabaishaT=this.touzhu.dabaisha.yazhuNum;
			SharkTouzhu.instance.shiziT=this.touzhu.shizi.yazhuNum;
			SharkTouzhu.instance.yanziT=this.touzhu.yanzi.yazhuNum;
			SharkTouzhu.instance.geziT=this.touzhu.gezi.yazhuNum;
			SharkTouzhu.instance.laoyingT=this.touzhu.laoying.yazhuNum;
			SharkTouzhu.instance.kongqueT=this.touzhu.kongque.yazhuNum;
			SharkTouzhu.instance.feiqinT=this.touzhu.feiqin.yazhuNum;
			SharkTouzhu.instance.zoushouT=this.touzhu.zoushou.yazhuNum;
			SharkTouzhu.instance.laohuT=this.touzhu.laohu.yazhuNum;
			SharkTouzhu.instance.xiongmaoT=this.touzhu.xiongmao.yazhuNum;
			SharkTouzhu.instance.houziT=this.touzhu.houzi.yazhuNum;

			SharkSyncService.instance.updateTouzhuS(SharkTouzhu.instance);
		}

		public function getAllTouzhu():int
		{
			return dabaishaNum + geziNum + yanziNum + kongqueNum + feiqinNum + laoyingNum + zoushouNum + shiziNum + laohuNum + xiongmaoNum + houziNum;
		}

		public function xuyaHandler(e:MouseEvent):void
		{
			if (getAllTouzhu() > Player.instance.currentPoints)
			{
				Alert.show("你的热点数不足");
			}
			else
			{
				touzhu.dabaisha.xuya(dabaishaNum);
				touzhu.gezi.xuya(geziNum);
				touzhu.yanzi.xuya(yanziNum);
				touzhu.kongque.xuya(kongqueNum);
				touzhu.laoying.xuya(laoyingNum);
				touzhu.feiqin.xuya(feiqinNum);
				touzhu.zoushou.xuya(zoushouNum);
				touzhu.shizi.xuya(shiziNum);
				touzhu.laohu.xuya(laohuNum);
				touzhu.xiongmao.xuya(xiongmaoNum);
				touzhu.houzi.xuya(houziNum);


				Player.instance.updateNowMoneyOnlyAllTouzhu(-getAllTouzhu());

				//更新投住到服务器端
				TouzhuControl.instance.updateTouzhuHandler(null);
			}
		}

		public function quxiaoHandler(e:MouseEvent):void
		{
			setAllZero();
			Player.instance.setNowMoney(); //复位用户的monwy显示

			//更新投住到服务器端
			TouzhuControl.instance.updateTouzhuHandler(null);
		}

		public function exitHandler(e:MouseEvent):void
		{
			isUserDisconn=true;
			//倒计时4秒的时候退出按钮也同时被锁定
			//如果已经进入倒计算
			if (SharkSyncService.instance.conn != null)
			{
				SharkSyncService.instance.disConnServer();
			}
			TouzhuControl.instance.setAllZero();
			Player.instance.setNowMoney();
			setAllUnclock();
			SharkSoundService.instance.stopAllMusic(); // 退出的时候关闭声音
			//如果规则正在显示则关闭显示
			if (MainSceneControl.instance.mainSceneApp.gameRule.visible)
			{
				MainSceneControl.instance.mainSceneApp.gameRule.visible=false;
			}
			//移出此module
			MainSceneControl.instance.mainSceneApp.gameModule.unloadModule();
			MainSceneControl.instance.mainSceneApp.gameModule.visible=false;
		}
	}
}