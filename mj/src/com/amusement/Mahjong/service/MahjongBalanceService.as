package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongApplictionControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.control.MainSenceControl;
	import com.control.RoomListControl;
	import com.model.Alert;
	import com.services.MainPlayerService;

	public class MahjongBalanceService
	{
		public static var instance:MahjongBalanceService;
		public function MahjongBalanceService()
		{
			instance = this;
		}
		
		public function continueClickHandler():void{
			if(MahjongRoomControl.instance.isNetwork){
				if(RoomListControl.instance.checkIsEnter(RoomListControl.instance.nowJoinRoomNum)){
					MahjongRoomControl.instance.clearTabletop();
					
					MahjongSyncService.instance.continueGame();
				}else{
					Alert.show("您当前的点数少于此房间最小进入点数");
				}
			}else{
				MainSenceControl.instance.mainButDJClickHandler(null);
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
			switch(MahjongRoomControl.instance.playerAzimuth){
				case 1:
					MainPlayerService.getInstance().mainPlayer.haveMoney += zongji[0];
					break;
				case 2:
					MainPlayerService.getInstance().mainPlayer.haveMoney += zongji[1];
					break;
				case 3:
					MainPlayerService.getInstance().mainPlayer.haveMoney += zongji[2];
					break;
				case 4:
					MainPlayerService.getInstance().mainPlayer.haveMoney += zongji[3];
					break;
			}
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