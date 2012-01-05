package com.mahjongSyncServer.services.action{
	import com.mahjongSyncServer.services.PlayerService;
	import com.mahjongSyncServer.services.RoomService;
	
	import mx.collections.ArrayList;
	import mx.states.IOverride;
	
	public class OnlineAction extends BaseAction {

		
		override public function getOperationName(devil:PlayerService = null):Array {
			var res:Array = new Array();
			
			if(player.needOperationName != ""){
				return res;
			}
			
			if(devil && !this.player.isDingzhang && (this.player.azimuth != 3) 
					&& devil.player.lastNeedOperationName == "getOneMahjong"
					&& !player.isShowDingzhang){
				player.needOperationPlayerService = devil;
				res.push("showDingzhang");
				return res;
			}
			
			if(devil && devil.player.lastNeedOperationName == "dingzhang" && player.azimuth == 3){
				dingzhangCount ++;
				if(dingzhangCount == 3){
					player.needOperationPlayerService = devil;
					res.push("showDingzhang");
					return res;
				}
			}
			
			if(devil && this.player.isDingzhang && (player.azimuth != devil.player.azimuth) && player.lastNeedOperationName != "xiao"){
				if((devil.player.lastNeedOperationName == "putOneMahjong" || (devil.player.lastNeedOperationName == "zigang" && devil.player.haveWanGang)) && checkHu(devil.player.nowOperationMahjongValue)){
					if(this.checkFangHu(devil.player.nowOperationMahjongValue)){
						player.needOperationPlayerService = devil;
						res.push("hu");
					}
				}
				if(devil.player.lastNeedOperationName == "putOneMahjong" && this.player.isDingzhang && 
					player.azimuth == 3 && (dingzhangCount >= 3) 
					&& checkGang(devil.player.nowOperationMahjongValue)){
					player.needOperationPlayerService = devil;
					res.push("gang");
				}
				if(devil.player.lastNeedOperationName == "putOneMahjong" && player.azimuth != 3 &&
					this.player.isDingzhang && checkGang(devil.player.nowOperationMahjongValue)){
					player.needOperationPlayerService = devil;
					res.push("gang");
				}
				if(devil.player.lastNeedOperationName == "putOneMahjong" && checkPeng(devil.player.nowOperationMahjongValue)){
					player.needOperationPlayerService = devil;
					res.push("peng");
				}
				
				if(res.length > 0){
					return res;
				}
			}else{
				if(devil && (dingzhangCount >= 3) && player.azimuth == 3 && checkGang(devil.player.nowOperationMahjongValue) && player.lastNeedOperationName != "xiao"){
					player.needOperationPlayerService = devil;
					res.push("zigang");
				}
				if(devil && checkGang(devil.player.nowOperationMahjongValue) && player.lastNeedOperationName != "xiao"){
					player.needOperationPlayerService = devil;
					res.push("zigang");
				}
				if(checkZiHu(true) && player.lastNeedOperationName != "xiao"){
					player.needOperationPlayerService = devil;
					res.push("zihu");
				}
				if(res.length > 0){
					return res;
				}
			}
			
			
			
			if(!this.player.isDingzhang){
				if(devil == null && player.azimuth == 3){
					if(this.player.sparr.length == 1 || player.sparr.length == 4 || player.sparr.length == 7
						|| player.sparr.length == 10 || player.sparr.length == 13){
						player.needOperationPlayerService = devil;
						res.push("getOneMahjong");
					}
				}
				return res;
			}else{
				if(devil && (player.azimuth == devil.player.azimuth)  && (devil.player.lastNeedOperationName == "zigang")){
					if(this.player.sparr.length == 1 || player.sparr.length == 4 || player.sparr.length == 7
						|| player.sparr.length == 10 || player.sparr.length == 13){
						player.needOperationPlayerService = devil;
						res.push("getOneMahjong");
						return res;
					}
				}
				
				if(devil && (devil.player.lastNeedOperationName == "putOneMahjong" || devil.player.lastNeedOperationName == "hu")){
					for(var i:int = 0; i<4; i++){
						if(RoomService.instance.playerServices[i].player.needOperationName != ""){
							return res;
						}
					}
					
					if(this.player.azimuth == nextGetOneMahjongPlyaer(devil.player.azimuth,1)){
						player.needOperationPlayerService = devil;
						res.push("getOneMahjong");
						return res;
					}
					if(this.player.azimuth == nextGetOneMahjongPlyaer(devil.player.azimuth,2)){
						if(RoomService.instance.playerServices[nextGetOneMahjongPlyaer(devil.player.azimuth,1)-1].player.ishu){
							player.needOperationPlayerService = devil;
							res.push("getOneMahjong");
							return res;
						}
					}
					if(this.player.azimuth == nextGetOneMahjongPlyaer(devil.player.azimuth,3)){
						if(RoomService.instance.playerServices[nextGetOneMahjongPlyaer(devil.player.azimuth,1)-1].player.ishu){
							if(RoomService.instance.playerServices[nextGetOneMahjongPlyaer(devil.player.azimuth,2)-1].player.ishu){
								player.needOperationPlayerService = devil;
								res.push("getOneMahjong");
								return res;
							}
						}
					}	
				}
			}
			return res;
		}
	}
	}
