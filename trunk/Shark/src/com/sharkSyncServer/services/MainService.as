package com.sharkSyncServer.services{

	import com.amusement.Shark.service.SharkSyncService;
	import com.sharkSyncServer.model.AllTouzhu;
	import com.sharkSyncServer.model.Player;
	import com.sharkSyncServer.util.Util;

	/**
	 * 
	 * @author Administrator
	 * 2012-3-2 14:15 gmr start 玩家下注，立即修改数据库
	 * 2012-3-21 14:59 gmr start 玩家下注时判断下注金额是否小于当前金额
	 */
	public class MainService {
	
		public static var allTouzhuJia:AllTouzhu = new AllTouzhu();
		public static function updateTouzhu(players:Vector.<Player>, o:Object):Boolean {
			var player:Player = new Player();
			player.playername = o.playername;
			player.dabaishaT = o.dabaishaT;
			player.shiziT = o.shiziT;
			player.laoyingT = o.laoyingT;
			player.laohuT = o.laohuT;
			player.xiongmaoT = o.xiongmaoT;
			player.kongqueT = o.kongqueT;
			player.geziT = o.geziT;
			player.yanziT = o.yanziT;
			player.houziT = o.houziT;
			player.feiqinT = o.feiqinT;
			player.zoushouT = o.zoushouT;
	
			for (var i:int = 0; i < players.length; i++) {
				if (players[i].playername == player.playername) {
					
					// 2012-3-2 14:15 gmr start 玩家下注，立即修改数据库
					var allTouzhu:int = player.dabaishaT + player.shiziT + player.laoyingT + player.laohuT + player.xiongmaoT + player.kongqueT + player.geziT + 
									player.yanziT + player.houziT + player.feiqinT + player.zoushouT;
	
					var touzhuMoney:int = allTouzhu - players[i].lastTouzhu;
					// 2012-3-21 14:59 gmr end
					
					players[i].lastTouzhu = allTouzhu;
					// 2012-3-2 14:15 gmr end 
					
					players[i].dabaishaT = player.dabaishaT;
					players[i].shiziT = player.shiziT;
					players[i].laoyingT = player.laoyingT;
					players[i].laohuT = player.laohuT;
					players[i].xiongmaoT = player.xiongmaoT;
					players[i].kongqueT = player.kongqueT;
					players[i].geziT = player.geziT;
					players[i].yanziT = player.yanziT;
					players[i].houziT = player.houziT;
					players[i].feiqinT = player.feiqinT;
					players[i].zoushouT = player.zoushouT;
					
//					BroadcastService.broadcast("updateAllTouzhuC", getAllTouzhu(TimerServer.players));
					
					SharkSyncService.instance.updateAllTouzhuC(getAllTouzhu(TimerServer.players));
					return true;
				}
			}
			return true;
		}
	
		public static function getAllTouzhu(players:Vector.<Player>):AllTouzhu {
			var allTouzhu:AllTouzhu = new AllTouzhu();
			for (var i:int = 0; i < players.length; i++) {
				allTouzhu.dabaishaAll += players[i].dabaishaT;
				allTouzhu.shiziAll += players[i].shiziT;
				allTouzhu.laoyingAll += players[i].laoyingT;
				allTouzhu.laohuAll += players[i].laohuT;
				allTouzhu.xiongmaoAll += players[i].xiongmaoT;
				allTouzhu.kongqueAll += players[i].kongqueT;
				allTouzhu.geziAll += players[i].geziT;
				allTouzhu.yanziAll += players[i].yanziT;
				allTouzhu.houziAll += players[i].houziT;
				allTouzhu.feiqinAll += players[i].feiqinT;
				allTouzhu.zoushouAll += players[i].zoushouT;
			}
			allTouzhu.dabaishaAll += allTouzhuJia.dabaishaAll;
			allTouzhu.shiziAll += allTouzhuJia.shiziAll;
			allTouzhu.laoyingAll += allTouzhuJia.laoyingAll;
			allTouzhu.laohuAll += allTouzhuJia.laohuAll;
			allTouzhu.xiongmaoAll += allTouzhuJia.xiongmaoAll;
			allTouzhu.kongqueAll += allTouzhuJia.kongqueAll;
			allTouzhu.geziAll += allTouzhuJia.geziAll;
			allTouzhu.yanziAll += allTouzhuJia.yanziAll;
			allTouzhu.houziAll += allTouzhuJia.houziAll;
			allTouzhu.feiqinAll += allTouzhuJia.feiqinAll;
			allTouzhu.zoushouAll += allTouzhuJia.zoushouAll;
			return allTouzhu;
		}
		
	
		public static function getZongjiJiaTouzhu(players:Vector.<Player>, countDownNum:int):AllTouzhu{
			
			//只更新机器人的投住总计
			getAllTouzhuJia(players,countDownNum);
			var allTouzhuPlayer:AllTouzhu = getAllTouzhu(players);
			return allTouzhuPlayer;
		}
		
		private static function getAllTouzhuJia(players:Vector.<Player>, countDownNum:int):AllTouzhu {
			countDownNum = 60-countDownNum;
			
			if((Math.random() * 100) > 70){ 
				
				allTouzhuJia.feiqinAll += (Math.round((Math.random() *70)+countDownNum))*10;
				allTouzhuJia.zoushouAll += (Math.round((Math.random() *70)+countDownNum))*10;
				
				if((Math.random() * 100) > 80){
					allTouzhuJia.houziAll += (fixed(Math.random()) *60+countDownNum)*10;
					allTouzhuJia.yanziAll += (fixed(Math.random()) *60+countDownNum)*10;
				}
				 
				if((Math.random() * 100) > 90){
					allTouzhuJia.geziAll += (fixed(Math.random()) *40+countDownNum)*10;
					allTouzhuJia.kongqueAll += (fixed(Math.random()) *40+countDownNum)*10;
					allTouzhuJia.xiongmaoAll += (fixed(Math.random()) *40+countDownNum)*10;
					allTouzhuJia.laohuAll += (fixed(Math.random()) *40+countDownNum)*10;
				}
				
				if((Math.random() * 100) > 90){
					allTouzhuJia.laoyingAll += (fixed(Math.random()) *30+countDownNum)*10;
					allTouzhuJia.shiziAll += (fixed(Math.random()) *30+countDownNum)*10;
				}
				
				if((Math.random() * 100) > 90){
					allTouzhuJia.dabaishaAll += (fixed(Math.random()) * 10)*10 + 10;
				}
			}
			
			return allTouzhuJia;
		}
		
		private static function fixed(value:Number):int{
			return value;
		}
		
		public static function clearAllTouzhu():void{
			allTouzhuJia.dabaishaAll = 0;
			allTouzhuJia.feiqinAll = 0;
			allTouzhuJia.geziAll = 0;
			allTouzhuJia.houziAll = 0;
			allTouzhuJia.kongqueAll = 0;
			allTouzhuJia.laohuAll = 0;
			allTouzhuJia.laoyingAll = 0;
			allTouzhuJia.shiziAll = 0;
			allTouzhuJia.xiongmaoAll = 0;
			allTouzhuJia.yanziAll = 0;
			allTouzhuJia.zoushouAll = 0;
		}
	
	}
}
