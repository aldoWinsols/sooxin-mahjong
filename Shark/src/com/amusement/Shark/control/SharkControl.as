package com.amusement.Shark.control
{
	import com.amusement.Shark.SharkApp;
	import com.amusement.Shark.main.AllTouzhu;
	import com.amusement.Shark.model.SharkTouzhu;
	import com.amusement.Shark.model.betting.BaseBet;
	import com.amusement.Shark.service.SharkSoundService;
	import com.amusement.Shark.service.SharkSyncService;
	import com.model.Alert;
	import com.service.DataService;
	import com.service.PlayerService;
	
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class SharkControl
	{
		[Embed(source="com/amusement/Shark/assets/desk/shark_desk_green.jpg")]
		private var _GreenBg:Class;
		[Embed(source="com/amusement/Shark/assets/desk/shark_desk_red.jpg")]
		private var _RedBg:Class;
		[Embed(source="com/amusement/Shark/assets/desk/shark_desk_blue.jpg")]
		private var _BlueBg:Class;
		
		
		public var resaultNumber:Number=0; //随机数  中奖数  很重要

		public var runTimer:Timer; //总线timer
		public var resaultAnimal:String; //转盘中奖动物名字

		public var sharkApp:SharkApp;
		public static var instance:SharkControl;
		public var isSoundPlay:Boolean=true;
		public var isShowResult:Boolean=true;
		public var countDownNum:Number;
		public var changeNum:int=0; //用户money改变量

		public var isUserDisconn:Boolean=false;
		
		public function SharkControl(sharkApp:SharkApp)
		{
			this.sharkApp=sharkApp;
			DataService.instance;

			this.sharkApp.BgImg = _BlueBg;
			
//			MainSceneControl.instance.mainSceneApp.loadModule.visible=false;

			SharkSyncService.getInstance();
			SharkSoundService.getInstance();
//			SharkSoundService.instance.openAllMusic(); //播放背景音乐
			SharkSystemPanelControl.instance.init();

			if (SharkSyncService.instance.conn == null)
			{
				trace("connnnnnnnnnnnnnnnnnnn");
				SharkSyncService.instance.connServer(); //连接同步服务
			}

			SharkTouzhu.getInstance();

			if (instance == null)
			{
				instance=this;
			}


			SharkSyncService.getInstance();

			sharkApp.name="shark";
			//主动画timer  旋转主动画timer
			runTimer=new Timer(40);
			runTimer.addEventListener(TimerEvent.TIMER, goRun);

			this.sharkApp.jiaodian.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.sharkApp.jiaodian.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			
			this.sharkApp.greenBgBtn.addEventListener(MouseEvent.CLICK, changeBgHandler, false, 0, true);
			this.sharkApp.redBgBtn.addEventListener(MouseEvent.CLICK, changeBgHandler, false, 0, true);
			this.sharkApp.blueBgBtn.addEventListener(MouseEvent.CLICK, changeBgHandler, false, 0, true);
			
//			TouzhuControl.instance.setAllClock(); //游戏开始进入时候锁定投住
			BetPanelControl.instance.setLock(true);
		}


		public function downHandler(e:MouseEvent):void
		{
//			MainSceneControl.instance.mainSceneApp.gameModule.startDrag();
			this.sharkApp.startDrag();
		}

		public function upHandler(e:MouseEvent):void
		{
//			MainSceneControl.instance.mainSceneApp.gameModule.stopDrag();
			this.sharkApp.stopDrag();
		}
		
		private function changeBgHandler(event:MouseEvent):void{
			switch(event.currentTarget.id){
				case "greenBgBtn":
					this.sharkApp.BgImg = _GreenBg;
					break;
				case "redBgBtn":
					this.sharkApp.BgImg = _RedBg;
					break;
				case "blueBgBtn":
					this.sharkApp.BgImg = _BlueBg;
					break;
			}
		}

		//----------------------------------------------------------------------------------

		//倒计时
		private var lockNum:int; //游戏只能是第一次进入时锁定面板

		public function updateCountDownNumber(n:int):void
		{
			this.countDownNum=n;
			try
			{
				sharkApp.countDownNumberV.text = String(n);
				if (lockNum == 0)
				{
//					TouzhuControl.instance.setAllUnclock(); //当连线成功后即时间开始走时开启投住
					BetPanelControl.instance.setLock(false);
				}
				lockNum++;
				if (n <= 4 && n >= 0)
				{
					BetPanelControl.instance.stopResultEffect();
//					TouzhuControl.instance.setAllClock(); //最后三秒时候锁定投住
					BetPanelControl.instance.setLock(true);
					if (n <= 3 && n > 0)
					{
						SharkSoundService.instance.backCountSound(n);
					}
				}
			}
			catch (e:Error)
			{
			}
		}


		//同步服务结构
		public function runC(resaultNumber:int, gameNum:Number):void
		{
			this.resaultNumber=resaultNumber; //获得随机数字

			this.sharkApp.gameNum.text=gameNum + ""; //显示游戏局号
			MainPanControl.instance.unFulgurate(); //取消上局中奖动物的闪硕
			MainPanControl.instance..setAllUnlight(); //关闭所有的发亮
//			TouzhuControl.instance.setValue();
			BetPanelControl.instance.recordLastAllBet();
			runTimer.start(); //总线开始执行动画

		}


		//---------------------------------------------------------------------------
		//转动动画函数
		public var n:Number=0;
		public var huanDongNumber:Number=10; //缓动个数
		public var huanDongNumberT:Number=huanDongNumber; //转替 中间变量
		public var timeT1:Number=0; //缓动 加速 总时间
		public var timeT2:Number=1 + huanDongNumber * (huanDongNumber - 1) / 2; //缓动 减速 总时间
		public var funA:Number=huanDongNumber; //缓动函数系数  加速
		public var funB:Number=1; //缓动函数系数  减速

		public function goRun(e:TimerEvent):void
		{
			if (n <= huanDongNumberT)
			{
				if (timeT2 == (1 + funA * (funA - 1) / 2))
				{
					funA--;
					n++;
					MainPanControl.instance.setAnimalLight(n); //根据n计算那个动物亮
				}
				timeT2--;
			}


			if ((n >= huanDongNumberT) && (n <= resaultNumber + 140 - huanDongNumber))
			{
				n++;
				MainPanControl.instance.setAnimalLight(n); //根据n计算那个动物亮
			}


			if (n > resaultNumber + 140 - huanDongNumber && n <= resaultNumber + 140)
			{
				if (timeT1 == (1 + funB * (funB - 1) / 2))
				{
					funB++;
					n++;
					MainPanControl.instance.setAnimalLight(n); //根据n计算那个动物亮
				}
				timeT1++;
			}

			//运行结果后，使中奖的动物闪硕
			if (n == resaultNumber + 140)
			{
				MainPanControl.instance.setFulgurateByAnimal(n);
			}

			//中奖后 延迟1000/40 * 40 秒后显示结果
			if (n >= resaultNumber + 140 && n <= resaultNumber + 180)
			{
				n++;
				if (n == resaultNumber + 180)
				{
					runTimer.stop(); //总线停止
					reSet(); //动画复位

					this.sharkApp.animalHistory.getHistory(resaultNumber); //获得游戏历史记录
					//播放人的结果声音
					var resalutAnimal:Object = MainPanControl.instance.gerResaultAnimal(resaultNumber);
					BetPanelControl.instance.startResultEffect(resalutAnimal);
					SharkSoundService.instance.playResultSound(resalutAnimal.type, resalutAnimal.animalName);

					if (isShowResult)
					{
						//--------------------------------------------------------------------------------------
						//计算结果显示面版
						if (!ResaultControl.instance.isshow)
						{
//							var resultArr:Array=TouzhuControl.instance.getTouzhu();
							var resultArr:Array = BetPanelControl.instance.getBets();
							var zongtouzhuNum:int;
							for (var i:int=0; i < resultArr.length; i++)
							{
//								(resultArr[i] as Yazhu).yazhuNum=this.touzhuServer[i];
//								zongtouzhuNum+=(resultArr[i] as Yazhu).yazhuNum;
								
								(resultArr[i] as BaseBet).currentBetNum = this.touzhuServer[i];
								zongtouzhuNum += this.touzhuServer[i];
							}

							var yunsuanfu:String;
							if (changeNum >= 0)
							{
								yunsuanfu="+";
							}
							else
							{
								yunsuanfu="";
							}
							ResaultControl.instance.resault.zongtouzhu.text=zongtouzhuNum + ""; //总投注的点数
							ResaultControl.instance.resault.zongshuying.text=changeNum + ""; //总输赢的点数
							ResaultControl.instance.calculate(this.resaultNumber, resultArr); //计算出押注后的结果值
//							ResaultControl.instance.resault.jiesuanV.text=Player.instance.currentPoints + yunsuanfu + changeNum + "=" + (Player.instance.currentPoints + changeNum) + "";
							var money:Number =  PlayerService.instance.haveMoney + PlayerService.instance.betMoney;
							ResaultControl.instance.resault.jiesuanV.text = money + yunsuanfu + (changeNum.toFixed(2)) + " = " + (money + changeNum).toFixed(2) + "";
						}
						//--------------------------------------------------------------------------

						AllTouzhu.instance.setZero(); // 清空投住统计

						ResaultControl.instance.show(); //游戏结束后结果面板显示
//						TouzhuControl.instance.setAllZero(); //所有投注清0
						BetPanelControl.instance.clear();

//						Player.instance.updateHaveMoney(changeNum);
						PlayerService.instance.updateHaveMoney(changeNum);
						changeNum=0;
					}
					else
					{
						Alert.show("数据存储出现异常！此局作废！");
//						Player.instance.setNowMoney(); //回滚用户的money
//						TouzhuControl.instance.setAllUnclock();
						BetPanelControl.instance.setLock(false);
//						TouzhuControl.instance.setAllZero(); //所有投注清0
						BetPanelControl.instance.clear();
					}
				}
			}
		}

		//转动动画复位
		public function reSet():void
		{
			funA=huanDongNumber;
			funB=1;

			timeT1=0;
			timeT2=1 + huanDongNumber * (huanDongNumber - 1) / 2;

			n=resaultNumber + 140; //复位n  因为上面有个延迟显示结果
			n=n % 28;
			huanDongNumberT=n + huanDongNumber;

		}

		//-----------------------------------------------------------------------------------
		public var touzhuServer:Object=new Array(11); //存储服务端头住情况

		public function isSuccessUpdateData(bool:Boolean, changeNum:int, touzhu:Object):void
		{
			this.touzhuServer=touzhu;
			this.changeNum=changeNum;
			isShowResult=bool;
		}


		//-----------------------------------------------------------------------


		//全屏按钮
		public function quanpingClick():void
		{
			if (this.sharkApp.stage.displayState == StageDisplayState.FULL_SCREEN)
			{
				this.sharkApp.stage.displayState=StageDisplayState.NORMAL;
			}
			else
			{
				this.sharkApp.stage.displayState=StageDisplayState.FULL_SCREEN;
			}
		}

		//音乐开关
		/*public function musicButton():void
		{
			if (SharkSoundService.instance.isPlaySound)
			{
				SharkSoundService.instance.stopAllMusic();
				this.sharkApp.musicOpen.visible=false;
				this.sharkApp.musicClosed.visible=true;
			}
			else
			{
				SharkSoundService.instance.openAllMusic();
				this.sharkApp.musicOpen.visible=true;
				this.sharkApp.musicClosed.visible=false;
			}
		}*/

		//游戏规则
		public function gameRule():void
		{
			/*if (MainSceneControl.instance.mainSceneApp.gameRule.visible)
			{
				MainSceneControl.instance.mainSceneApp.gameRule.visible=false;
			}
			else
			{
				MainSceneControl.instance.mainSceneApp.gameRule.textArea.htmlText=Regulation.sharkRule;
				MainSceneControl.instance.mainSceneApp.gameRule.visible=true;
			}*/
		}
		
		private function exitHandler():void{
			isUserDisconn=true;
			//倒计时4秒的时候退出按钮也同时被锁定
			//如果已经进入倒计算
			if (SharkSyncService.instance.conn != null){
				SharkSyncService.instance.disConnServer();
			}
//			TouzhuControl.instance.setAllZero();
			BetPanelControl.instance.clear();
//			TouzhuControl.instance.setAllUnclock();
			BetPanelControl.instance.setLock(false);
//			SharkSoundService.instance.stopAllMusic(); // 退出的时候关闭声音
			SharkSystemPanelControl.instance.finish();
		}
	}
}