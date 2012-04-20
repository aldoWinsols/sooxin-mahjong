package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongApplictionControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.model.Alert;

	public class MahjongBalanceService
	{
		public static var instance:MahjongBalanceService;
		public function MahjongBalanceService()
		{
			instance = this;
		}
		
		public function continueClickHandler():void{
			if(checkEnoughPlayerMoney()){
				MahjongRoomControl.instance.clearTabletop();
				
				MahjongSyncService.instance.continueGame();
			}else{
				Alert.show("您的遊戲點數不足！");
			}
		}
		
		public function exitClickHandler():void{
//			MahjongSyncService.instance.disConnServer();
			
			MahjongRoomControl.instance.clearTabletop();
			
			//关闭界面
//			MahjongApplictionControl.instance.exitGame();
			MahjongApplictionControl.instance.backHall();
		}
		
		/**
		 * 更新玩家点数 
		 * @param zongji
		 * 
		 */
		public function updataPlayerMoney(zongji:Array):void{
//			switch(MahjongRoomControl.instance.playerAzimuth){
//				case 1:
//					PlayerService.instance.updateHaveMoney(zongji[0]);
//					break;
//				case 2:
//					PlayerService.instance.updateHaveMoney(zongji[1]);
//					break;
//				case 3:
//					PlayerService.instance.updateHaveMoney(zongji[2]);
//					break;
//				case 4:
//					PlayerService.instance.updateHaveMoney(zongji[3]);
//					break;
//			}
		}
		
		/**
		 * 隐藏玩家名字 
		 * @param playerName
		 * @return 
		 * 
		 */
		public function subPlayerName(playerName:String):String{
//			if(playerName != PlayerService.instance.player.acctName){
//				playerName = playerName.substr(0,2) + "****";
//			}
			return playerName;
		}
		
		/**
		 * 判断玩家是否有足够的点数，继续游戏 
		 * @return 
		 * 
		 */
		private function checkEnoughPlayerMoney():Boolean{
			var flag:Boolean = false;

			return true;
		}
	}
}