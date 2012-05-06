package com.mahjongSyncServer.services{

	import com.mahjongSyncServer.model.Balance;
	import com.mahjongSyncServer.services.PlayerService;
	import com.mahjongSyncServer.util.HuPai;
	import com.services.GameCenterService;
	
	public class BalanceService {
		public var baseNum:int = 5;
	
		public var balanceList:Vector.<Balance>;
		private var maxFunnum:int = 16;
		
		private static var _instance:BalanceService;
		
		public function BalanceService(){
			balanceList = new Vector.<Balance>();
		}
	
		public static function get instance():BalanceService
		{
			if(_instance == null){
				_instance = new BalanceService();
			}
			return _instance;
		}

		public function findUserByAzimuth(playerServices:Vector.<PlayerService>, playerAzimuth:int):PlayerService {
			var playerService:PlayerService = null;
			for (var i:int = 0; i < playerServices.length; i++) {
				if (playerServices[i].player.azimuth == playerAzimuth) {
					playerService = playerServices[i];
					break;
				}
			}
			return playerService;
		}
	
		// 添加杠上炮转移信息到balanceList集合里面去
		public function balanceMove(moveAzimuth1:int, moveAzimuth2:int):Balance{
			
			var aziumthNum:Number = 0;
			var balance:Balance = new Balance();
			balance.balanceName = "转移";
			
			for (var i:int = balanceList.length - 1; i >= 0 ; i --) {
				if(balanceList[i].playerAzimuth == moveAzimuth1){
					if(moveAzimuth1 == 1){
						aziumthNum = balanceList[i].azimuth1;
						balance.azimuth1 = -(aziumthNum);
					}
					else if(moveAzimuth1 == 2){
						aziumthNum = balanceList[i].azimuth2;
						balance.azimuth2 = -(aziumthNum);
					}
					else if(moveAzimuth1 == 3){
						aziumthNum = balanceList[i].azimuth3;
						balance.azimuth3 = -(aziumthNum);
					}
					else if(moveAzimuth1 == 4){
						aziumthNum = balanceList[i].azimuth4;
						balance.azimuth4 = -(aziumthNum);
					}
					break;
				}
			}
			
			if(moveAzimuth2 == 1){
				balance.azimuth1 = aziumthNum;
			}
			else if(moveAzimuth2 == 2){
				balance.azimuth2 = aziumthNum;
			}
			else if(moveAzimuth2 == 3){
				balance.azimuth3 = aziumthNum;	
			}
			else if(moveAzimuth2 == 4){
				balance.azimuth4 = aziumthNum;
			}
			balanceList.push(balance);
			return balance;
		}
		
		// 杠结算
		public function balanceGang(lastPlayerAzimuth:int, thisPlayerAzimuth:int,
				playerServices:Vector.<PlayerService>, haveWanGang:Boolean):void {
			var balance:Balance = new Balance();
			balance.playerAzimuth = thisPlayerAzimuth;
			if (lastPlayerAzimuth == thisPlayerAzimuth ) {
				var fanNum:int = 1;	// 默认值为1  弯杠为1 ， 暗杠为2
				
				if(!haveWanGang){	// 如果是暗杠
					fanNum = 2;
					balance.balanceName = "下雨";
				}
				else{
					balance.balanceName = "刮风";
					balance.haveWanGang = haveWanGang;
				}
				
				
				switch (thisPlayerAzimuth) {
				case 1:
					if (!findUserByAzimuth(playerServices, 2).player.ishu) {
						balance.azimuth2 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 3).player.ishu) {
						balance.azimuth3 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 4).player.ishu) {
						balance.azimuth4 = -baseNum * fanNum;
					}
					balance.azimuth1 = -(balance.azimuth2 + balance.azimuth3 + balance.azimuth4);
					break;
	
				case 2:
					if (!findUserByAzimuth(playerServices, 1).player.ishu) {
						balance.azimuth1 = -baseNum * fanNum;;
					}
	
					if (!findUserByAzimuth(playerServices, 3).player.ishu) {
						balance.azimuth3 = -baseNum * fanNum;;
					}
	
					if (!findUserByAzimuth(playerServices, 4).player.ishu) {
						balance.azimuth4 = -baseNum * fanNum;;
					}
					balance.azimuth2 = -(balance.azimuth1 + balance.azimuth3 + balance.azimuth4);
					break;
	
				case 3:
					if (!findUserByAzimuth(playerServices, 1).player.ishu) {
						balance.azimuth1 = -baseNum * fanNum;;
					}
	
					if (!findUserByAzimuth(playerServices, 2).player.ishu) {
						balance.azimuth2 = -baseNum * fanNum;;
					}
	
					if (!findUserByAzimuth(playerServices, 4).player.ishu) {
						balance.azimuth4 = -baseNum * fanNum;;
					}
					balance.azimuth3 = -(balance.azimuth1 + balance.azimuth2 + balance.azimuth4);
					break;
	
				case 4:
					if (!findUserByAzimuth(playerServices, 1).player.ishu) {
						balance.azimuth1 = -baseNum * fanNum;;
					}
	
					if (!findUserByAzimuth(playerServices, 2).player.ishu) {
						balance.azimuth2 = -baseNum * fanNum;;
					}
	
					if (!findUserByAzimuth(playerServices, 3).player.ishu) {
						balance.azimuth3 = -baseNum * fanNum;;
					}
					balance.azimuth4 = -(balance.azimuth1 + balance.azimuth2 + balance.azimuth3);
					break;
				}
			} else {
				balance.balanceName = "下雨";
				switch (lastPlayerAzimuth) {
				case 1:
					balance.azimuth1 = -(2 * baseNum);
					break;
				case 2:
					balance.azimuth2 = -(2 * baseNum);
					break;
				case 3:
					balance.azimuth3 = -(2 * baseNum);
					break;
				case 4:
					balance.azimuth4 = -(2 * baseNum);
					break;
				}
	
				switch (thisPlayerAzimuth) {
				case 1:
					balance.azimuth1 = 2 * baseNum;
					break;
				case 2:
					balance.azimuth2 = 2 * baseNum;
					break;
				case 3:
					balance.azimuth3 = 2 * baseNum;
					break;
				case 4:
					balance.azimuth4 = 2 * baseNum;
					break;
				}
			}
			balanceList.push(balance);
		}
	
		// 胡结算
		public function balanceHu(lastPlayerAzimuth:int, thisPlayerAzimuth:int,
				huName:String, fanNum:int, playerServices:Vector.<PlayerService>, haveGangHua:Boolean, haveGangPao:Boolean):void {
			
			var balance:Balance = new Balance();
			if(fanNum > maxFunnum){
				fanNum = maxFunnum;
			}
			if (lastPlayerAzimuth == thisPlayerAzimuth) {
				balance.balanceName = "自摸";
				if(haveGangHua){
					balance.balanceName = "";
					balance.balanceName += "杠上花" + huName;
				}
				else if(haveGangPao){
					balance.balanceName = "";
					balance.balanceName += "杠上炮" + huName;
				}
				else{
					balance.balanceName += huName;
				}
				
				fanNum = fanNum * 2;    //自摸加一番
	
				if(fanNum > maxFunnum){
					fanNum = maxFunnum;
				}
				switch (thisPlayerAzimuth) {
				case 1:
					if (!findUserByAzimuth(playerServices, 2).player.ishu) {
						balance.azimuth2 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 3).player.ishu) {
						balance.azimuth3 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 4).player.ishu) {
						balance.azimuth4 = -baseNum * fanNum;
					}
					balance.azimuth1 = -(balance.azimuth2 + balance.azimuth3 + balance.azimuth4);
					break;
	
				case 2:
					if (!findUserByAzimuth(playerServices, 1).player.ishu) {
						balance.azimuth1 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 3).player.ishu) {
						balance.azimuth3 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 4).player.ishu) {
						balance.azimuth4 = -baseNum * fanNum;
					}
					balance.azimuth2 = -(balance.azimuth1 + balance.azimuth3 + balance.azimuth4);
					break;
	
				case 3:
					if (!findUserByAzimuth(playerServices, 1).player.ishu) {
						balance.azimuth1 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 2).player.ishu) {
						balance.azimuth2 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 4).player.ishu) {
						balance.azimuth4 = -baseNum * fanNum;
					}
					balance.azimuth3 = -(balance.azimuth1 + balance.azimuth2 + balance.azimuth4);
					break;
	
				case 4:
					if (!findUserByAzimuth(playerServices, 1).player.ishu) {
						balance.azimuth1 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 2).player.ishu) {
						balance.azimuth2 = -baseNum * fanNum;
					}
	
					if (!findUserByAzimuth(playerServices, 3).player.ishu) {
						balance.azimuth3 = -baseNum * fanNum;
					}
					balance.azimuth4 = -(balance.azimuth1 + balance.azimuth2 + balance.azimuth3);
					break;
				}
			} else {
				balance.balanceName = "放炮";
				if(haveGangHua){
					balance.balanceName = "";
					balance.balanceName += "杠上花" + huName;
				}
				else if(haveGangPao){
					balance.balanceName = "";
					balance.balanceName += "杠上炮" + huName;
				}
				else{
					balance.balanceName += huName;
				}
				
				switch (lastPlayerAzimuth) {
				case 1:
					balance.azimuth1 = -baseNum * fanNum;
					break;
				case 2:
					balance.azimuth2 = -baseNum * fanNum;
					break;
				case 3:
					balance.azimuth3 = -baseNum * fanNum;
					break;
				case 4:
					balance.azimuth4 = -baseNum * fanNum;
					break;
				}
	
				switch (thisPlayerAzimuth) {
				case 1:
					balance.azimuth1 = baseNum * fanNum;
					break;
				case 2:
					balance.azimuth2 = baseNum * fanNum;
					break;
				case 3:
					balance.azimuth3 = baseNum * fanNum;
					break;
				case 4:
					balance.azimuth4 = baseNum * fanNum;
					break;
				}
			}
			balanceList.push(balance);
			
			
			//=============================================
			if(fanNum >= 8){
				GameCenterService.instance.reportAchievement("jp");
			}else{
				if(huName.indexOf("清一色") != -1){
					GameCenterService.instance.reportAchievement("qys");
				}
				if(huName.indexOf("小七对") != -1){
					GameCenterService.instance.reportAchievement("xqd");
				}
				if(huName.indexOf("大对子") != -1){
					GameCenterService.instance.reportAchievement("ddz");
				}
			}
		}
	
		// 赔叫结算
		public function balancePeiHu(playerServices:Vector.<PlayerService>):void {
			var balance:Balance = new Balance();
			balance.balanceName = "赔叫";
			
			for(var i:int=0;i < playerServices.length;i ++){
				if(!playerServices[i].player.ishu){
					if(HuPai.checkJiao(playerServices[i]) != null){
						
						var fanNum:int = int(HuPai.checkJiao(playerServices[i])[1]);
						//返回最大翻
						if(fanNum > maxFunnum){
							fanNum = maxFunnum;
						}
						
						playerServices[i].player.fanNum = fanNum;
						playerServices[i].player.haveJiao = fanNum == 0 ? false : true;
						
					}
				}
			}
			
			for(var i:int=0;i < playerServices.length;i ++){
				for(var j:int=0;j < playerServices.length;j ++){	
					if((!playerServices[i].player.ishu && playerServices[i].player.haveJiao) 
						&& (!playerServices[j].player.ishu && !playerServices[j].player.haveJiao)){
						var peiNum:int = playerServices[i].player.peiNum + 
												(playerServices[i].player.fanNum* this.baseNum);
						playerServices[i].player.peiNum = peiNum;
						peiNum = playerServices[j].player.peiNum + 
												(-playerServices[i].player.fanNum* this.baseNum);
						playerServices[j].player.peiNum = peiNum;
						
						for (var k:int = 0; k < balanceList.length; k++) {	// 查找没有下叫的用户，同时把没下叫的用户的所有杠牌结算移除
							//System.out.println(balanceList[k].balanceName + " === " + balanceList[k].playerAzimuth + "   , " + balanceList[k].azimuth1 + " , " + balanceList[k].azimuth2 + " , " + balanceList[k].azimuth3 + " , " + balanceList[k].azimuth4);
							if(balanceList[k].playerAzimuth == playerServices[j].player.azimuth){
								balanceList.splice(k,1);
								k --;
							}
						}
					}
				}
			}
			
			var haveJiao:Boolean = false;
			var huNum:int = 0;
			for(var i:int=0;i < playerServices.length;i ++){	// 检测所有没有胡牌用户是否有叫
				if(playerServices[i].player.ishu){
					huNum ++;
				}
				if(!playerServices[i].player.ishu && playerServices[i].player.haveJiao){
					haveJiao = true;
					break;
				}
			}
			
			if(!haveJiao && huNum < 3){// 最后赔叫时，如果没有胡牌的几个用户都没有叫，则删除所有杠牌记录
				for(var i:int=0;i < playerServices.length;i ++){		
					for (var j:int = 0; j < balanceList.length; j++){
						if(!playerServices[i].player.ishu && !playerServices[i].player.haveJiao){
							if(balanceList[j].playerAzimuth == playerServices[i].player.azimuth){
								balanceList.splice(j,1);
								j --;
							}
						}
					}
				}
			}
			
			balance.azimuth1 = playerServices[0].player.peiNum;
			balance.azimuth2 = playerServices[1].player.peiNum;
			balance.azimuth3 = playerServices[2].player.peiNum;
			balance.azimuth4 = playerServices[3].player.peiNum;
			
			if(balance.azimuth1 != 0 || balance.azimuth2 != 0 || balance.azimuth3 != 0 || balance.azimuth4 != 0){
				balanceList.push(balance);
			}
	
		}
	}
}