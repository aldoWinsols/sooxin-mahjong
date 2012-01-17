package com.mahjongSyncServer.services
{
	import com.mahjongSyncServer.util.PlayerTypeEnum;
	
	public class LogicService
	{
		private var playerServices:Vector.<PlayerService> = null;
		private var roomService:RoomService = null;
		public var opertions:Vector.<PlayerService> = null;
		private var priorityPlayerService:PlayerService = null;
		private var currentPriority:int = 0;
		public function LogicService(playerServices:Vector.<PlayerService>, roomService:RoomService)
		{
			this.playerServices = playerServices;
			this.roomService = roomService;
			opertions = new Vector.<PlayerService>();
		}
		private var dingzhangCount:int = 0;
		public function dealLogic(dealPlayerService:PlayerService):void{
			
			var isHave:Boolean = false;
			for(var i:int=0;i<opertions.length;i++){
				if(opertions[i].player.azimuth == dealPlayerService.player.azimuth){
					opertions[i] = dealPlayerService;
					isHave = true;
				}
			}
			
			if(!isHave){
				opertions.push(dealPlayerService);
			}
			trace(dealPlayerService.player.azimuth + "  ======  " + dealPlayerService.player.needOperationName);
			
			var haveHu:Boolean = false;
			if(opertions.length == 4){
				for(var i:int=0; i<4; i++){
					if(opertions[i].player.needOperationName == "hu"){
						PlayerService.huCount ++;
					}
				}
				for(var i:int=0; i<4; i++){
					if(opertions[i].player.playerType == PlayerTypeEnum.ONLINE){
						if(opertions[i].player.couldOperationNames.length >0 && opertions[i].player.needOperationName == "" ){
							if(checkHaveHuName(opertions[i].player.couldOperationNames)){
								opertions[i].player.needOperationName = "showOperation";
								opertions[i].decOperationName();
								return;
							}
						}
					}
				}
				
				for(var i:int=0; i<4; i++){
					if(opertions[i].player.needOperationName == "hu"){
						haveHu = true;
						opertions[i].decOperationName();
					}
				}
				
				if(haveHu){
					for(var i:int=0; i<4; i++){
						if(opertions[i].player.needOperationName != "hu"){
							opertions[i].player.needOperationName = "";
						}
					}
					
					haveHu = false;
					opertions.splice(0,4);
					return;
				}else{
					for(var i:int=0; i<4; i++){
						if(opertions[i].player.playerType == PlayerTypeEnum.ANDROID){
							if(opertions[i].player.needOperationName == "gang" || opertions[i].player.needOperationName == "peng" || 
								opertions[i].player.needOperationName == "zigang" || opertions[i].player.needOperationName == "zihu"){
								opertions[i].decOperationName();
								clearAllOperationName(opertions[i].player.azimuth);
								opertions.splice(0,4);
								return;
							}
						}
					}
					
					for(var i:int=0; i<4; i++){
						if(opertions[i].player.playerType == PlayerTypeEnum.ONLINE){
							if(opertions[i].player.couldOperationNames.length>0 && (opertions[i].player.couldOperationNames[0] =="peng" || opertions[i].player.couldOperationNames[0] =="gang") && opertions[i].player.needOperationName == "" ){
								opertions[i].player.needOperationName = "showOperation";
								opertions[i].decOperationName();
								clearAllOperationName(opertions[i].player.azimuth);
								opertions.splice(0,4);
								return;
							}else if(opertions[i].player.couldOperationNames.length>0 && (opertions[i].player.couldOperationNames[0] =="zigang" || opertions[i].player.couldOperationNames[0] =="zihu") && opertions[i].player.needOperationName == "" ){
								opertions[i].player.needOperationName = "showOperation";
								opertions[i].decOperationName();
								clearAllOperationName(opertions[i].player.azimuth);
								opertions.splice(0,4);
								return;
							}else if(opertions[i].player.couldOperationNames.length>0 && opertions[i].player.couldOperationNames[0] =="getOneMahjong"){
								opertions[i].player.needOperationName = "getOneMahjong";
								opertions[i].decOperationName();
								opertions.splice(0,4);
								return;
							}else if(opertions[i].player.couldOperationNames.length>0 && opertions[i].player.couldOperationNames[0] =="showDingzhang"){
								opertions[i].player.needOperationName = "showDingzhang";
//								opertions[i].decOperationName();
//								opertions.splice(0,4);
//								return;
							}
						}
					}
					
					for(var i:int=0; i<4; i++){
						opertions[i].decOperationName();
					}
					opertions.splice(0,4);
				}
			}
		}
		
		public function clearAllOperationName(azimith:int):void{
			for(var i:int=0; i<opertions.length; i++){
				if(opertions[i].player.azimuth != azimith){
					opertions[i].player.needOperationName = "";
					if(opertions[i].player.playerType == PlayerTypeEnum.ONLINE){
						opertions[i].player.couldOperationNames = [];
					}
				}
				
			}
		}
		
		private function checkHaveHuName(arr:Array):Boolean{
			for(var i:int=0;i<arr.length;i++){
				if(arr[i] == "hu"){
					return true;
				}
			}
			
			return false;
		}
		
		//通知观察者
		public function send(devil:PlayerService = null):void{
			if(devil == null){
				for(var i:int=0; i<playerServices.length;i++){
					playerServices[i].calOperationName(devil);
				}
				return;
			}
			
			if(devil.player.lastNeedOperationName == "getOneMahjong" && !devil.player.isDingzhang){
				for(var i:int=0; i<playerServices.length;i++){
					playerServices[i].calOperationName(devil);
				}	
			}else if(devil.player.lastNeedOperationName == "getOneMahjong"){
				for(var i:int=0; i<playerServices.length;i++){
					if(playerServices[i].player.azimuth == devil.player.azimuth){
						playerServices[i].calOperationName(devil);
					}else{
						dealLogic(playerServices[i]);
					}
				}	
			}else if(devil.player.lastNeedOperationName == "putOneMahjong" || devil.player.lastNeedOperationName == "hu"){
				for(var i:int=0; i<playerServices.length;i++){
					if((playerServices[i].player.azimuth != devil.player.azimuth) && (!playerServices[i].player.ishu)){
						playerServices[i].calOperationName(devil);
					}else{
						playerServices[i].player.couldOperationNames = [];
						dealLogic(playerServices[i]);
					}
				}	
			}else{
				for(var i:int=0; i<playerServices.length;i++){
					if(!playerServices[i].player.ishu){
						playerServices[i].calOperationName(devil);
					}else{
						dealLogic(playerServices[i]);
					}
				}
			}
			
		}
	}
}