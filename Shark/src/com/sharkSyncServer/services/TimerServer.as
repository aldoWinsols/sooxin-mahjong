package com.sharkSyncServer.services
{
	import com.amusement.Shark.service.SharkSyncService;
	import com.sharkSyncServer.model.AllTouzhu;
	import com.sharkSyncServer.model.Player;
	import com.sharkSyncServer.util.Util;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 
	 * @author Administrator
	 * 2012-3-5 11:17 gmr start 判断玩家异常，主动把玩家连接断开
	 */
	public class TimerServer {
		
		public static var players:Vector.<Player> = null;
		
		private var n:int = 60;
		private var isChiDaiPeiXiao:Boolean = true;// 是否吃大赔小
		private var allTouzhu:AllTouzhu;
	
		public var ran:int = 0;
		public var gameNum:Number = 0;
		public var timer:Timer = null;
	
		public function TimerServer() {
			players = new Vector.<Player>();
			timer = new Timer(1000, 0);
			timer.addEventListener(TimerEvent.TIMER, run);
			timer.start();
		}
		
		public static function addPlayer(playerName:String):void{
			var player:Player = new Player();
			player.playername = playerName;
			players.push(player);
		}
	
		public function run(e:TimerEvent):void {
			n--;
			if (n < 0) {
				n += 60;
				MainService.clearAllTouzhu();
			}

//			BroadcastService.broadcast("updateCountDownNumberC", n);// 广播倒计时
			SharkSyncService.instance.updateCountDownNumberC(n);

			// 每8秒更新一次远程投住情况
			var random:int = 3+(int)(Math.random() * 5);
			
//			// 随机一个秒数更新一次远程投住情况
			if (n >= 10 && (n % random == 0)) {
				SharkSyncService.instance.updateAllTouzhuC(MainService.getZongjiJiaTouzhu(players, n));
			}

			if (n == 3) {
				
//				//2011-2-15 s 检查用户的money
//				checkPlayerHaveMoney();
				
				// 获得总投住情况
				allTouzhu = MainService.getAllTouzhu(players);
				// 让吃大赔小的概率设置为30%
				if ((Math.random() >= getGailv())
						&& allTouzhu.allTouzhuNum() > 0) {
//					System.out.println("shark--------------chidapeixiao----------"+getGailv());
					ran = Util.getOnlyWinRandow() as int;

					// 当只能出大白鲨或猎枪才能包赢的时候，则所有的变为随机
					if (Util.randowNO.length > 1) {
						if ((Util.randowNO[0] == 24)
								&& (Util.randowNO[1] == 25)) {
							ran = Math.round(Math.random() * 28) as int;
						}
					}

				} else {
//					System.out.println("shark--------------------randow--------------");
					ran = Util.getRandow() as int;
				}

				gameNum = 123123;

//				dataService.balance(Application.players, gameNum, ran);// 写入数据库
				balance(gameNum, ran);
			}

			// 每60秒广播运行一次游戏
			if (n == 0) {
				SharkSyncService.instance.runC(ran, gameNum);
//				BroadcastService.broadcast("runC", ran, gameNum);
			}
		}
	
		// 根据投住获取要吃大佩小的概率
		public var cdpxGailv:Number = 0.8;
		public var chaji:Number = 0.2;
		public function getGailv():Number{
			var gailv:Number = 0;
			var haveTouzhuNum:int =0;
			for(var i:int = 0; i <players.length; i++){
				if(players[i].allTouzhu( )> 0){
					haveTouzhuNum++;
				}
			}
			
			if(haveTouzhuNum <=10){
				gailv = cdpxGailv;
			}else if(haveTouzhuNum>10 && haveTouzhuNum<=20){
				gailv = cdpxGailv-chaji;
			}else if(haveTouzhuNum>20 && haveTouzhuNum<=30){
				gailv = cdpxGailv-2*chaji;
			}else if(haveTouzhuNum>30 && haveTouzhuNum<=40){
				gailv = cdpxGailv-3*chaji;
			}else if(haveTouzhuNum>40 && haveTouzhuNum<=50){
				gailv = cdpxGailv-4*chaji;
			}else if(haveTouzhuNum>50){
				gailv = 0;
			}
			
			return gailv;
		}
		
		public function balance(gameNum:Number, ran:int):void {
			for (var i:int = 0; i < players.length; i++) {
				SharkSyncService.instance.isSuccessUpdateDataC(true, players[i].changeNum(ran), players[i].getTouzhu());
				players[i].clear();//清空投注
			}
		}
	}
}
