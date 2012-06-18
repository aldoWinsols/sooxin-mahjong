package com.mahjongSyncServer.services
{
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.service.MahjongSyncService;
	import com.mahjongSyncServer.model.Balance;
	import com.mahjongSyncServer.model.Message;
	import com.mahjongSyncServer.model.Player;
	import com.mahjongSyncServer.services.action.AndroidAction;
	import com.mahjongSyncServer.services.action.BaseAction;
	import com.mahjongSyncServer.services.action.OnlineAction;
	import com.mahjongSyncServer.util.FanpaiTypeEnum;
	import com.mahjongSyncServer.util.HuPai;
	import com.mahjongSyncServer.util.PlayerTypeEnum;
	import com.mahjongSyncServer.util.Util;

	public class PlayerService
	{
		public var player:Player;
		private var roomService:RoomService;
		public var action:BaseAction;
		
		private var logicSwitch:Boolean = false;
		private var timeNum:Number = 0;
		private var operationTimeNum:Number = 0;
		private var putOneMahjongValue:int = 0;
		public static var huCount:int = 0;
		
		public function PlayerService(roomService:RoomService,playerType:int, azimuth:int, playerName:String)
		{
			this.roomService = roomService;
			player = new Player();
			player.azimuth = azimuth;
			this.player.playerType = playerType;
			
			if(playerType == PlayerTypeEnum.ONLINE){
				this.action = new OnlineAction();
			}else{
				this.action = new AndroidAction();
			}
			player.playerName = playerName;
			action.setPlayer(this.player);
			action.setRoom(this.roomService.room);
		}
		
		public function onTimer():void{
			if(logicSwitch){
				if(timeNum >= operationTimeNum){
					logicSwitch = false;
					operationTimeNum = 0;
					if(player.needOperationName == "dingzhang"){
						
						player.isDingzhang = true;
						
						dingZhang();
						MahjongSyncService.instance.dingzhangI(player.azimuth, player.dingzhangValue);
						var obj:Array = new Array();
						obj.push(player.azimuth);
						obj.push(player.nowOperationMahjongValue);
						roomService.addHistoryMessage("dingzhangI", obj);
						player.needOperationName = "";
						this.roomService.logicService.send(this);
						
						return;
					}
					
					if(player.needOperationName == "showDingzhang"){
						
						if(!this.player.isDingzhang){
							MahjongSyncService.instance.showDingzhangI(null);
						}
						if(player.azimuth != 3){
							var obj:Array = new Array();
							obj.push(player.azimuth);
							player.isShowDingzhang = true;
							roomService.addHistoryMessage("showDingzhangI", obj);
						}
						player.needOperationName = "";
						return;
					}
					
					if(player.needOperationName == "showOperation"){
						MahjongSyncService.instance.showOperationI(player.azimuth,player.couldOperationNames.concat());
						var obj:Array = player.couldOperationNames.concat();
						obj.unshift(player.azimuth);
						roomService.addHistoryMessage("showOperationI", obj);
						player.lastNeedOperationName = player.needOperationName;
						player.needOperationName = "";
						
						return;
					}
					
					if(player.needOperationName == "getOneMahjong"){
						if(this.roomService.room.mahjongs.length == 0){
							BalanceService.instance.balancePeiHu(this.roomService.playerServices);
							this.roomService.endGame();
							return;
						}
						huCount = 0;
						var haveHuCount:int = 0;
						for(var i:int =0; i<4;i++){
							if(this.roomService.playerServices[i].player.ishu){
								haveHuCount ++;
							}
						}
						if(haveHuCount == 3){
							this.roomService.endGame();
							return;
						}
						
						var mahjongValue:int = getOneMahjong();
						player.huCount = 0;
						player.nowOperationMahjongValue = mahjongValue;
						MahjongSyncService.instance.getOneMahjongI(player.azimuth, mahjongValue);
						player.lastNeedOperationName = player.needOperationName;
						
						var obj:Array = new Array();
						obj.push(player.azimuth);
						obj.push(mahjongValue);
						roomService.addHistoryMessage("getOneMahjongI", obj);						
						
						if(player.needOperationPlayerService && player.needOperationPlayerService.player.azimuth != player.azimuth){
							player.needOperationPlayerService.player.lastGang = false;
						}
						player.haveWanGang = false;
						player.lastFangFanNum = 0;
						for(var i:int=0;i<4;i++){
							if(roomService.playerServices[i].player.azimuth != 3 && 
								roomService.playerServices[i].player.playerType == PlayerTypeEnum.ANDROID &&
								!roomService.playerServices[i].player.isShowDingzhang){
								roomService.playerServices[i].player.isShowDingzhang = true;
								var obj:Array = new Array();
								obj.push(roomService.playerServices[i].player.azimuth);
								roomService.addHistoryMessage("showDingzhangI", obj);
							}
						}
						
						player.needOperationName = "";
						this.roomService.logicService.send(this);
						trace(player.azimuth + " === getOneMahjong  == ================= " + mahjongValue);
						return;
					}
					
					if(player.needOperationName == "putOneMahjong"){
						
						var isPutDingzhang:Boolean = false;
						var value:int = 0;
						var fanType:int = 0;
						if(player.playerType == PlayerTypeEnum.ANDROID){
							if(player.dingzhangFanpai == FanpaiTypeEnum.NO_FANPAI){
								isPutDingzhang = true;
								player.dingzhangFanpai = FanpaiTypeEnum.YES_FANPAI;
								value = player.dingzhangValue;
								fanType = 1;
								if(value == 0 || value == 10 || value == 20){
									isPutDingzhang = false;
									fanType = 0;
									value = action.getPutOneMahjongValue();
								}
							}else{
								value = action.getPutOneMahjongValue();
							}
						}else{
							value = player.nowOperationMahjongValue;
							isPutDingzhang = player.isPutDingzhang;
							fanType = isPutDingzhang ? 1 : 0;
						}
						var mahjongValue:int = putOneMahjong(value);
						trace(player.azimuth + " ===== putOneMahjong  ===  " + mahjongValue);
						player.nowOperationMahjongValue = mahjongValue;
						player.huCount = 0;
						MahjongSyncService.instance.putOneMahjongI(player.azimuth, mahjongValue, isPutDingzhang);
						
						var obj:Array = new Array();
						obj.push(player.azimuth);
						obj.push(player.nowOperationMahjongValue);
						obj.push(fanType);
						roomService.addHistoryMessage("putOneMahjongI", obj);
						
						player.lastNeedOperationName = player.needOperationName;
						player.needOperationName = "";
						
						this.roomService.logicService.send(this);
						return;
					}
					
					if(player.needOperationName == "peng"){
						var value:int = peng(this.player.needOperationPlayerService);
							
						MahjongSyncService.instance.pengI(this.player.azimuth,value);
						
						player.lastNeedOperationName = player.needOperationName;
						if(player.needOperationPlayerService){
							player.needOperationPlayerService.player.lastGang = false;
						}
						var obj:Array = new Array();
						obj.push(player.azimuth);
						obj.push(value);
						roomService.addHistoryMessage("pengI", obj);
						
						player.needOperationName = "";
						
						//如果是机器人，则直接做打牌操作，不需要通知
						//如果是玩家，等待玩家操作
						if(player.playerType == PlayerTypeEnum.ANDROID){
							player.needOperationName = "putOneMahjong";
							decOperationName();
						}
						return;
					}
					
					if(player.needOperationName == "hu"){
						this.player.ishu = true;
						var value:int = hu(this.player.needOperationPlayerService,false);
						this.player.needOperationPlayerService.player.huCount ++;
						
						var message:Message = roomService.room.historyMessage[roomService.room.historyMessage.length - 2];
						var content:Array = Array(message.content);
						if(message.head == "gangI" && int(content[0][0]) == this.player.needOperationPlayerService.player.azimuth && int(content[0][2]) == 1 && this.player.needOperationPlayerService.player.haveWanGang){
							this.player.needOperationPlayerService.player.lastGang = false;
							MahjongSyncService.instance.huI(this.player.azimuth,value,2, this.player.needOperationPlayerService.player.lastGang, this.player.needOperationPlayerService.player.huCount,this.player.needOperationPlayerService.player.azimuth);
						}else{
							MahjongSyncService.instance.huI(this.player.azimuth,value,0, this.player.needOperationPlayerService.player.lastGang, this.player.needOperationPlayerService.player.huCount,0);
						}
						
//						MahjongSyncService.instance.huI(this.player.azimuth,value,0, this.player.needOperationPlayerService.player.lastGang, this.player.needOperationPlayerService.player.huCount,0);
						player.nowOperationMahjongValue = value;
						player.lastNeedOperationName = player.needOperationName;
						player.huCount = this.player.needOperationPlayerService.player.huCount;
						var obj:Array = new Array();
						obj.push(player.azimuth);
						obj.push(value);
						obj.push(0);
						obj.push(this.player.needOperationPlayerService.player.huCount);
						obj.push(0);
						obj.push(this.player.needOperationPlayerService.player.lastGang?1:0);
						roomService.addHistoryMessage("huI", obj);
						
						player.needOperationName = "";
						
						this.roomService.logicService.send(this);
						return;
					}
					if(player.needOperationName == "gang"){
						var value:int = gang(this.player.needOperationPlayerService);
						
						MahjongSyncService.instance.gangI(this.player.azimuth,value,false);
						player.lastNeedOperationName = player.needOperationName;
						player.lastGang = true;
						if(player.needOperationPlayerService){
							player.needOperationPlayerService.player.lastGang = false;
						}
						var obj:Array = new Array();
						obj.push(player.azimuth);
						obj.push(value);
						obj.push(0);
						roomService.addHistoryMessage("gangI", obj);
						
						//不需要发送消息，直接确定摸牌
						player.needOperationName = "getOneMahjong";
						decOperationName();
						return;
					}
					if(player.needOperationName == "zigang"){
						if(this.player.playerType == PlayerTypeEnum.ANDROID){
							var value:int = ziGang(player.zigangValue);
						}else{
							var value:int = ziGang(player.nowOperationMahjongValue);
						}
						player.lastGang = true;
						MahjongSyncService.instance.gangI(this.player.azimuth,value,true);
						player.lastNeedOperationName = player.needOperationName;
						player.nowOperationMahjongValue = value;
						
						var obj:Array = new Array();
						obj.push(player.azimuth);
						obj.push(value);
						obj.push(1);
						roomService.addHistoryMessage("gangI", obj);
						player.needOperationName = "";
						this.roomService.logicService.send(this);
						//不需要发送消息，直接确定摸牌
//						player.needOperationName = "getOneMahjong";
//						decOperationName();
						return;
					}
					
					if(player.needOperationName == "zihu"){
						var value:int = hu(this.player.needOperationPlayerService,true);
						var message:Message = roomService.room.historyMessage[roomService.room.historyMessage.length - 3];
						var content:Array = Array(message.content);
						if(message.head == "gangI" && int(content[0][0]) == player.azimuth && int(content[0][2]) == 1){
							player.lastGang = true;
						}else{
							player.lastGang = false;
						}
						MahjongSyncService.instance.huI(this.player.azimuth,value, 1, player.lastGang, 0, 0);
						
						var obj:Array = new Array();
						obj.push(player.azimuth);
						obj.push(value);
						obj.push(1);
						obj.push(0);
						obj.push(0);
						obj.push(player.lastGang?1:0);
						roomService.addHistoryMessage("huI", obj);
						player.isZihu = true;
						player.lastNeedOperationName = player.needOperationName;
						player.needOperationName = "";
						player.lastNeedOperationName = "hu";
						
						this.roomService.logicService.send(this);
					}
				}
			}
			timeNum += 0.1;
		}
		
		//--------------------------------------------------------------------------------
		
		/**
		 * 获得当前可以操作的名字
		 * @param value
		 */
		public function calOperationName(devil:PlayerService):void{
			player.couldOperationNames = null;//清空可操作的方法
			
			// TODO Auto-generated method stub
			if(!player.ishu){
				player.couldOperationNames = this.action.getOperationName(devil);
				
				for(var i:int; i<player.couldOperationNames.length;i++){
//					trace("azimuth : " + player.azimuth + "   OperationName : " + player.couldOperationNames[i]);
					
					if(player.playerType == PlayerTypeEnum.ANDROID){
						this.player.needOperationName = player.couldOperationNames[i];
						var isShowOperation = false;
						for(var i:int = 0;i < player.couldOperationNames.length; i++){
							if(player.couldOperationNames[i] == "peng" || 
								player.couldOperationNames[i] == "gang" || 
								player.couldOperationNames[i] == "hu" || 
								player.couldOperationNames[i] == "zigang" || 
								player.couldOperationNames[i] == "zihu"){
								isShowOperation = true;
							}
						}
						if(isShowOperation){
							var obj:Array = player.couldOperationNames.concat();
							obj.unshift(player.azimuth);
							roomService.addHistoryMessage("showOperationI", obj);
						}
						
					}
				}				
				//向桌面发送申请自己的操作
				this.roomService.logicService.dealLogic(this);
			}
			
		}
		
		/**
		 * 决定操作
		 * @param value
		 */
		public function decOperationName():void{
			logicSwitch = true;
			timeNum = 0;
			
			this.player.lastNeedOperationName = player.needOperationName;
			
			if(player.needOperationName == "getOneMahjong"){
				this.operationTimeNum = 0;
			}else{
				this.operationTimeNum = MahjongSyncService.instance.playHandSpeed;
			}
			
			if(this.player.playerType == PlayerTypeEnum.ONLINE){
				
				this.operationTimeNum = 0;
				
				if(player.needOperationName == "getOneMahjong" && !player.isDingzhangFanpai){
					this.operationTimeNum = 1;
					player.isDingzhangFanpai = true;
				}
			}
		}
		
		public function dingZhang():int{
			var dingzhangValue:int = action.checkLessMahjongType();
			player.dingzhangValue = dingzhangValue;
			player.nowOperationMahjongValue = dingzhangValue;
			return dingzhangValue;
			
		}
		
		public function getOneMahjong():int {
			var value:int;
			if(this.player.playerType == PlayerTypeEnum.ANDROID && (Math.random()*100 < MahjongSyncService.instance.level)){
				value = this.action.huoDeMP();
				
				if(value == 0){
					value = this.roomService.room.mahjongs.shift();
				}else{
					for(var i:int=0; i<this.roomService.room.mahjongs.length; i++){
						if(value == this.roomService.room.mahjongs[i]){
							this.roomService.room.mahjongs.splice(i,1);
							break;
						}
					}
				}
			}else{
				value = this.roomService.room.mahjongs.shift();
			}
			
			player.sparr.push(value);
			player.nowOperationMahjongValue = value;
			player.isFangTuiDa = false;
			
			MahjongRoomControl.instance._mahjongRoom.mahjongsNum.text = this.roomService.room.mahjongs.length.toString();
				
			return value;
		}
		
		//---------------------------------------------------------------------------------
		
		public function putOneMahjong(mahjongValue:int):int {
			for(var i:int=0;i<this.player.sparr.length;i++){
				if(this.player.sparr[i] == mahjongValue){
					this.player.sparr.splice(i,1);
					break;
				}
			}
			
			player.outarr.push(mahjongValue);
			player.nowOperationMahjongValue = mahjongValue;
			
			return mahjongValue;
		}
		
		public function peng(devil:PlayerService):int {
			var t:int = 0;
			var value:int = devil.player.outarr.pop();
			
			for (var i:int = 0; i < player.sparr.length; i++) {
				if (player.sparr[i] == value) {
					t++;
					
					player.pparr.push(player.sparr.splice(i,1));
					i --;
					
					// 本身可以杠只选择了杠
					if (t == 2) {
						break;
					}
				}
			}

			player.pparr.push(value);
			
			// 2011-08-12 16:38 g
			//如果可以碰，又可以胡，如果玩家执行了碰的操作，就存一个放牛的翻数，则未过手前不能再胡
			if(HuPai.checkHu(player.sparr)){
				player.isFangTuiDa = true;
				var strr:Vector.<String> = HuPai.getHuResult(player.sparr, player.pparr, player.gparr);
				player.lastFangFanNum = int(strr[1]);
			}
			
			return value;
		}
		
		public function gang(devil:PlayerService):int {
			var value:int = devil.player.outarr.pop();
			for (var i:int = 0; i < player.sparr.length; i++) {
				if (player.sparr[i] == value) {
					player.gparr.push(player.sparr.splice(i,1));
					i --;
				}
			}
			
			player.gparr.push(value);
			
			BalanceService.instance.balanceGang(player.needOperationPlayerService.player.azimuth,player.azimuth,this.roomService.playerServices,false);
			
			return value;
		}
		
		public function ziGang(value:int):int {
			//把手牌移到杠里去
			for (var i:int = 0; i < player.sparr.length; i++) {
				if (player.sparr[i] == value) {
					player.gparr.push(player.sparr.splice(i,1));
					i --;
				}
			}
			
			//把碰牌移到杠里去
			for (var i:int = 0; i < player.pparr.length; i++) {
				if (player.pparr[i] == value) {
					player.haveWanGang = true;
					player.gparr.push(player.pparr.splice(i,1));
					i --;
				}
			}
			
			BalanceService.instance.balanceGang(player.needOperationPlayerService.player.azimuth,player.azimuth,this.roomService.playerServices,player.haveWanGang);
			
			return value;
		}
		
		public function hu(devil:PlayerService, isZihu:Boolean):int {
			player.ishu = true;
			
			var sparr:Vector.<int> = player.sparr.concat();
			var value:int = 0;
			
			if(!isZihu){
				if(devil.player.outarr.length > 0 &&
					(devil.player.outarr[devil.player.outarr.length - 1] == devil.player.nowOperationMahjongValue)){
					value = devil.player.outarr.pop();
				}else{
					value = devil.player.nowOperationMahjongValue;
				}
				
				sparr.push(value);
			}else{
				value = devil.player.nowOperationMahjongValue;
				for(var i:int = 0;i < player.sparr.length;i ++){
					if(player.sparr[i] == value){
						player.sparr.splice(i ,1)
							break;
					}
				}
			}
			
			var huResult:Vector.<String> = HuPai.getHuResult(sparr,player.pparr,player.gparr);
			
			if(devil.player.lastGang){
				var gangHua:Boolean = false;
				var gangPao:Boolean = false;
				if(isZihu){
//					gangHua = true;
					var message:Message = roomService.room.historyMessage[roomService.room.historyMessage.length - 3];
					var content:Array = Array(message.content);
					if(message.head == "gangI" && int(content[0][0]) == player.azimuth && int(content[0][2]) == 1){
						gangHua = true;
					}
				}else{
					gangPao = true;
					gangPaoMove(player.azimuth, devil.player.azimuth);
					huCount --;
				}
				BalanceService.instance.balanceHu(player.needOperationPlayerService.player.azimuth,player.azimuth,huResult[0],int(huResult[1]),this.roomService.playerServices,gangHua,gangPao);
			}else{
				BalanceService.instance.balanceHu(player.needOperationPlayerService.player.azimuth,player.azimuth,huResult[0],int(huResult[1]),this.roomService.playerServices,false,false);
				
			}
			
			return value;
		}
		
		
		/**
		 * 如果是杠上炮，就把杠牌转移给胡牌用户
		 * @param huAzimuth				胡牌用户
		 * @param dianhuAzimuth			杠上炮用户
		 */
		private function gangPaoMove(huAzimuth:int,  dianhuAzimuth:int):void{
			var balances:Vector.<Balance> = BalanceService.instance.balanceList;
			for (var i:int = balances.length - 1; i >= 0 ; i--) {
				if(balances[i].playerAzimuth == dianhuAzimuth){ 
					
					if(balances[i].balanceName == "下雨"){
						var balacne:Balance = BalanceService.instance.balanceMove(dianhuAzimuth, huAzimuth);
						if(huCount > 1){
							balacne.azimuth1 = Util.instance.fixed(balacne.azimuth1 / huCount);
							balacne.azimuth2 = Util.instance.fixed(balacne.azimuth2 / huCount);
							balacne.azimuth3 = Util.instance.fixed(balacne.azimuth3 / huCount);
							balacne.azimuth4 = Util.instance.fixed(balacne.azimuth4 / huCount);
						}
					}else if(balances[i].balanceName == "刮风"){
						if(balances[i].haveWanGang){
							var balacne:Balance = BalanceService.instance.balanceMove(dianhuAzimuth, huAzimuth);
							if(huCount > 1){
								balacne.azimuth1 = Util.instance.fixed(balacne.azimuth1 / huCount);
								balacne.azimuth2 = Util.instance.fixed(balacne.azimuth2 / huCount);
								balacne.azimuth3 = Util.instance.fixed(balacne.azimuth3 / huCount);
								balacne.azimuth4 = Util.instance.fixed(balacne.azimuth4 / huCount);
							}
							
						}else{
							var balacne:Balance = BalanceService.instance.balanceMove(dianhuAzimuth, huAzimuth);
							if(huCount > 1){
								balacne.azimuth1 = Util.instance.fixed(balacne.azimuth1 / huCount);
								balacne.azimuth2 = Util.instance.fixed(balacne.azimuth2 / huCount);
								balacne.azimuth3 = Util.instance.fixed(balacne.azimuth3 / huCount);
								balacne.azimuth4 = Util.instance.fixed(balacne.azimuth4 / huCount);
							}
						}
					}
					break;	
				}
			}
			
		}
	}
}