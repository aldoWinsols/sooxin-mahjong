package com.mahjongSyncServer.services.action{

	import com.mahjongSyncServer.model.Message;
	import com.mahjongSyncServer.services.PlayerService;
	import com.mahjongSyncServer.services.RoomService;
	import com.mahjongSyncServer.util.HuPai;
	import com.mahjongSyncServer.util.PlayerTypeEnum;
	import com.mahjongSyncServer.util.Util;
	
	import mx.collections.ArrayList;
	
	public class AndroidAction extends BaseAction {
	
		override public function getOperationName(devil:PlayerService = null):Array{
			
			var res:Array = new Array();
			
			if(player.needOperationName != ""){
				return res;
			}
			if((devil == null) && (this.player.azimuth == 3)){
				player.needOperationPlayerService = devil;
				res.push("getOneMahjong");
				return res;
			}
			
			if(devil && (this.player.azimuth != 3) && !player.isDingzhang 
					&& devil.player.lastNeedOperationName == "getOneMahjong"){
				player.needOperationPlayerService = devil;
				res.push("dingzhang");
				return res;
			}
				
			if(devil){
				if(!this.player.isDingzhang){
					
					if(this.player.azimuth == 3){
						if(devil.player.lastNeedOperationName == "dingzhang"){
							dingzhangCount ++;
							if(dingzhangCount == 3){
								player.needOperationPlayerService = devil;
								res.push("dingzhang");
								return res;
							}
						}
						
						if(this.player.sparr.length == 1 || player.sparr.length == 4 || player.sparr.length == 7
							|| player.sparr.length == 10 || player.sparr.length == 13){
							player.needOperationPlayerService = devil;
							res.push("getOneMahjong");
						}
						
					}else{
						player.needOperationPlayerService = devil;
						res.push("dingzhang");
					}
					
					return res;
				}
				
				if(!this.player.isDingzhang && devil.player.lastNeedOperationName == "getOneMahjong"){
					if(this.player.azimuth == 3){
						player.needOperationPlayerService = devil;
						res.push("dingzhang");
						return res;
					}
				}
				
				if(this.player.isDingzhang && (getPlayer().azimuth != devil.player.azimuth)){
					var value:int =devil.player.nowOperationMahjongValue;
					player.needOperationPlayerService = devil;
					
					if(devil.player.lastNeedOperationName == "putOneMahjong" || (devil.player.lastNeedOperationName == "zigang" && devil.player.haveWanGang)){
						if(checkHu(value) && (judgeMahjongList() || checkHaveNum(value) < 2)){
							if(this.checkFangHu(value)){
								res.push("hu");
							}
						}
					}
					
					if(devil.player.lastNeedOperationName == "hu" && 
						devil.player.playerType == PlayerTypeEnum.ONLINE && 
						!devil.player.isZihu){
						if(checkHu(value) && (judgeMahjongList() || checkHaveNum(value) < 2)){
							if(this.checkFangHu(value)){
								res.push("hu");
							}
						}
					}
					
					if((devil.player.lastNeedOperationName == "putOneMahjong" || devil.player.lastNeedOperationName == "xiao") && checkGang(value)){
						res.push("gang");
					}
					
					if((devil.player.lastNeedOperationName == "putOneMahjong" || devil.player.lastNeedOperationName == "xiao")
								&& (!haveQiDui() || haveQingyisePeng(value) || !havePengGuize(value))){
						if(checkPeng(value)){
							res.push("peng");
						}
					}
					
					if(res.length > 0){
						return res;
					}
				}else{
					player.needOperationPlayerService = devil;
					if(checkZiHu(true)){
						res.push("zihu");
					}
					if(checkGang(devil.player.nowOperationMahjongValue)){
						res.push("zigang");
					}
					if(res.length > 0){
						return res;
					}
				}
				
				
				
				
				if(this.player.azimuth == devil.player.azimuth){
					if(this.player.sparr.length == 2 || player.sparr.length == 5 || player.sparr.length == 8
						|| player.sparr.length == 11 || player.sparr.length == 14){
						player.needOperationPlayerService = devil;
						res.push("putOneMahjong");
						return res;
					}
				}
				
				if(devil && (player.azimuth == devil.player.azimuth)  && (devil.player.lastNeedOperationName == "zigang")){
					if(this.player.sparr.length == 1 || player.sparr.length == 4 || player.sparr.length == 7
						|| player.sparr.length == 10 || player.sparr.length == 13){
						player.needOperationPlayerService = devil;
						res.push("getOneMahjong");
						return res;
					}
				}
				if(devil.player.lastNeedOperationName == "putOneMahjong" || devil.player.lastNeedOperationName == "hu" ||
						(devil.player.lastNeedOperationName == "xiao" && !devil.player.xiaoIsZihu)){
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
		/**
		 * 随机生成一个数与剩余的牌堆比较
		 * @return
		 */
		private function judgeMahjongList():Boolean{
			
			if(getRoom().mahjongs.length < (Math.round(Math.random()*4)+32)){
				return true;
			}
			
			return false;
		}
		/**
		 * 检查出牌里是否有某牌
		 * @param value
		 * @return
		 */
		private function checkHaveInOutarr( value:int):Boolean{
			for(var i:int=0; i<getPlayer().outarr.length; i++){
				if(getPlayer().outarr[i] == value){
					return true;
				}
			}
			return false;
		}
		/**
		 * 判断什么时候该碰，什么时候不该碰
		 * @param value
		 * @return
		 */
		private function havePengGuize( value:int):Boolean{
			
			//如果前面有打过的牌，则不碰回来
			if(checkHaveInOutarr(value)){
				return true;
			}
			
			if(checkHaveNum(value - 1) == 1 && checkHaveNum(value + 1) == 2 && checkHaveNum(value + 2) == 1){//  牌型   122334  碰 2
				return true;
			}else if(checkHaveNum(value - 2) == 1 && checkHaveNum(value - 1) == 2 && checkHaveNum(value + 1) == 1){//  牌型   122334  碰3
				return true;
			}else if(checkHaveNum(value - 1) == 1 && checkHaveNum(value + 1) == 1){//  牌型   7889  碰8
				return true;
			}else if(checkHaveNum(value + 1) == 2 && checkHaveNum(value + 2) == 2){//  牌型   223344  碰2
				return true;
			}else if(checkHaveNum(value + 1) == 2 && checkHaveNum(value - 1) == 2){//  牌型   223344  碰3
				return true;
			}else if(checkHaveNum(value - 1) == 2 && checkHaveNum(value - 2) == 2){//  牌型   223344  碰4
				return true;
			}
			
			return false;
			
		}
		/**
		 * 判断是否是清一色
		 * @param value
		 * @return
		 */
		private function haveQingyisePeng( value:int):Boolean{
			
			if(this.transformersPeiXing == 1){
				if((value / 10) != (this.qingyiseType / 10)){
					return false;
				}
			}
			return true;
			
		}
		/**
		 * 判断是否是七对
		 * @return
		 */
		private function haveQiDui():Boolean{
			
			for(var i:int=1; i < 30; i ++){
				var list:Vector.<int> = getPlayer().sparr.concat();
				if(i != 10 && i != 20){
					list.push(i);
				}
				Util.sortVector(list);
				var result:String = HuPai.getHuResult(list, getPlayer().pparr.concat(), getPlayer().gparr.concat())[1];
				if(result == "七对"){
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * 获得机器人的牌型
		 * @param sparr1
		 */
		override public function huoDePaiXing():void{
			
			var allArr:Vector.<int> = getPlayer().sparr.concat();
			allArr.concat(getPlayer().pparr);
			allArr.concat(getPlayer().gparr);
			
			//  查找是否能够做成清一色
			var wannum:int = 0;
			var tongnum:int = 0;
			var tiaonum:int = 0;
			for(var i:int=0;i < allArr.length; i++){
				if(allArr[i] < 10){
					wannum ++;
				}else if(allArr[i] > 10 && allArr[i] < 20){
					tongnum ++;
				}else if(allArr[i] > 20 && allArr[i] < 30){
					tiaonum ++;
				}
			}
			
			//如果万字大于10，并且碰杠里面没有万字 且桌上的牌个数大于8张
			if((wannum > 10) && checkHaveSortInPG(0) && (getRoom().mahjongs.length > 8)){
				transformersPeiXing = 1;
				qingyiseType = 0;
			}
			//如果筒字大于10，并且碰杠里面没有筒字 且桌上的牌个数大于8张
			else if((tongnum > 10) && checkHaveSortInPG(10)  && (getRoom().mahjongs.length > 8)){
				transformersPeiXing = 1;
				qingyiseType = 10;
			//如果条字大于10，并且碰杠里面没有条字 且桌上的牌个数大于8张
			}else if((tiaonum > 10) && checkHaveSortInPG(20)  && (getRoom().mahjongs.length > 8)){
				transformersPeiXing = 1;
				qingyiseType = 20;
			}else{
				transformersPeiXing = 0;
				qingyiseType = 30;
			}
		}
		
		//检查碰杠里没有此类型的牌
		public function checkHaveSortInPG( value:int):Boolean{
			for(var i:int=0; i<getPlayer().pparr.length; i++){
				if((value/10) != (int(int(getPlayer().pparr[i])/10))){
					return false;
				}
			}
			
			for(var j:int=0; j<getPlayer().gparr.length; j++){
				if((value/10) != (int(getPlayer().gparr[j])/10)){
					return false;
				}
			}
			
			return true;
		}
	
		override public function getPutOneMahjongValue():int{
			var value:int = 0;
			
			for (var i:int = 0; i < getPlayer().sparr.length; i++) {
				if (int(getPlayer().sparr[i] / 10) == int(getPlayer().dingzhangValue / 10)) {
					value = getPlayer().sparr[i];
					break;
				}
			}

			if (value == 0) {
				value = huoDeDP();
			}
			return value;
		}
		//获得最该摸的牌
		override public function huoDeMP():int{
			var xp:Vector.<int> = huoDeXP1();
			
			//删除定张类牌
			for(var j:int=0; j<xp.length; j++){
				if(int(xp[j]/10) == int(getPlayer().dingzhangValue/10)){
					xp.splice(j,1);
				}
			}
				
			for(var i:int=0; i<xp.length-1; i++){
				if(int(xp[i]/10) != int(getPlayer().dingzhangValue/10)){
					if(xp[i] == (xp[i+1]-1)){
						if(quMahjongInMahjongs(xp[i]-1)){
							return xp[i]-1;
						}
						
						if(quMahjongInMahjongs(xp[i]+1)){
							return xp[i]+1;
						}
					}else if(xp[i] == (xp[i+1]-2)){
						if(quMahjongInMahjongs(xp[i]+1)){
							return xp[i]+1;
						}
					}else{
						i++;
					}
				}else{
					
				}
			}
			
			//2010-10-17 14:54 s
			for(var i:int=xp.length - 1; i>= 0; i--){
				if(int(xp[i]/10) != int(getPlayer().dingzhangValue/10)){
					if(quMahjongInMahjongs(xp[i] - 1)){
						return xp[i] - 1;
					}
					
					if(quMahjongInMahjongs(xp[i] + 1)){
						return xp[i] + 1;
					}
					
					if(quMahjongInMahjongs(xp[i])){
						return xp[i];
					}
				}
				
			}
			
			return 0;
		}
		//获得闲牌 3，4不排开，供摸牌的时候找相关需要的牌用
		private function huoDeXP1():Vector.<int>{
			
			var xx:int = 0;// -将的个数
			var abc:int = 0;// 刻,顺的个数
			
			var ja:Vector.<int> = new Vector.<int>();// 将A的位置.
			var jb:Vector.<int> = new Vector.<int>();// 将B的位置.
			
			var xp:Vector.<int> = new Vector.<int>();// 将B的位置.
			
			var mj:Vector.<int> = player.sparr.concat();
			mj = Util.sortVector(mj);
			
			var tempmj:Vector.<int> = new Vector.<int>();
			
			tempmj.concat(mj);
			// mj = tempmj.slice(0, 13);
			
			for (var i:int = 0; i < player.sparr.length; i++) {
				for (var j:int = i; j < player.sparr.length; j++) {
					for (var n:int = j; n < player.sparr.length; n++) {
						
						if (i != j && j != n && i != n
							&& mj[i] == mj[j]
							&& mj[j] == mj[n] && mj[i] != -1) {
							
							abc += 1;
							mj[i] = -1;
							mj[j] = -1;
							mj[n] = -1;
						}
					}
				}
			}
			for (var i:int = 0; i < player.sparr.length; i++) {
				for (var j:int = i; j < player.sparr.length; j++) {
					for (var n:int = j; n < player.sparr.length; n++) {
						
						if (i != j && j != n && i != n && mj[i] != -1
							&& mj[j] != -1 && mj[n] != -1) {
							
							var a:int = mj[i];
							var b:int = mj[j];
							var c:int = mj[n];
							var temp:int = 0;
							if (b >= a && b >= c) {
								temp = b;
								b = a;
								a = temp;
								if (c > b) {
									temp = b;
									b = c;
									c = temp;
								}
							} else if (c >= a && c >= b) {
								temp = a;
								a = c;
								c = temp;
								if (c > b) {
									temp = b;
									b = c;
									c = temp;
								}
							} else if (c >= b) {
								temp = b;
								b = c;
								c = temp;
							}
							if (a == b + 1 && a == c + 2) {
								abc += 1;
								mj[i] = -1;
								mj[j] = -1;
								mj[n] = -1;
							}
						}
					}
				}
			}
			
			// 找将
			for (var i:int = 0; i < player.sparr.length; i++) {
				for (var j:int = i; j < player.sparr.length; j++) {
					if (i != j && mj[i] == mj[j] && mj[i] != -1) {
						ja.push(i);
						jb.push(j);
						mj[i] = -1;
						mj[j] = -1;
						xx++;
						
					}
				}
			}
			
			for(var i=0; i <mj.length; i++){
				if(mj[i] != -1){
					if(checkHaveNum(mj[i]) != 3){
						xp.push(mj[i]);
					}
				}
			}
			
			return xp;
		}

		/**
		 * 从派堆里取出麻将
		 * @param mahjongValue
		 * @return
		 */
		private function quMahjongInMahjongs(mahjongValue:int):Boolean{
			for(var i:int=0; i<getRoom().mahjongs.length; i++){
				if(getRoom().mahjongs[i] == mahjongValue){
					return true;
				}
			}
			return false;
		}
		/**
		 * 获得闲牌
		 * @return
		 */
		private function huoDeDP():int{
		
			var mj:Vector.<int> = getPlayer().sparr.concat();
			Util.sortVector(mj);
			
			//----------------------------------------
			//判断是否是清一色，如果是清一色并且有叫，再判断最后摸起来的一张牌是不是跟当前清一色的牌色相同，如果不相同，就把最后一张牌的值返回
			//g 2010-10-12 16:49
			var newSparr:Vector.<int> = getPlayer().sparr.concat();
			newSparr.pop();
			
			if(HuPai.checkQys(newSparr, getPlayer().pparr.concat(), getPlayer().gparr.concat())){
				if((getPlayer().sparr[0] / 10) != (getPlayer().sparr[getPlayer().sparr.length - 1] / 10)){
					//获得手上牌是否有叫，返回小于15的数字表示有叫，等于15表示没有叫
					var qysxiajiao:int = huodeXiajiaoPai();		
					if(qysxiajiao != 15){
						return getPlayer().sparr[getPlayer().sparr.length - 1];
					}
				}
				
			}
			//-----------------------------------------------------------
			
			
			//--------------------------------------------------------------------------
			//如果可以打清一色，在打完非相关类牌后再执行下叫判断，或者不能打清一色时候就每次做下叫判断
			var bool:Boolean = true;
			for(var i:int=0; i<getPlayer().sparr.length; i++){
				if((int(int(getPlayer().sparr[i]) / 10)) != (this.qingyiseType/10) ){
					bool = false;
					break;
				}
			}
			if(((this.transformersPeiXing == 1) && bool) || (this.transformersPeiXing == 0)){
				var xiajiaoPai:int = huodeXiajiaoPai();
				if(xiajiaoPai != 15){
					return int(getPlayer().sparr[xiajiaoPai]);
				}
			}
			//--------------------------------------------------------------------------
			
			var xp:Vector.<int> = calXP();//里面包含了如果可以打清一色应该找出的闲置
			var mj1:Vector.<int> = mj.concat(); 
			if(xp.length == 0) {
				for(var i:int=mj1.length - 1; i >= 0; i--){
					if(mj1[i] != -1){
						return mj1[i];
					}
				}
			}else{
	
				//如找出的闲牌为 2，3  5，7 则考虑打5,7 2247应该打7
				for(var i:int=0;i<xp.length;i++){
					if(((i + 1) < xp.length) && xp[i] != (xp[i+1])){
						
						//2010-10-19 19:06
						//如手上的牌123243435465464 11,11,12 ，可以做清一色，但撤11,11,12，先撤12打，按以前的规则就会打11
						if(this.transformersPeiXing == 1){
							for(var j:int=0; j < xp.length; j ++){
								if(int(xp[j]/10) != int(this.qingyiseType/10)){
									if(checkHaveNum(xp[j])<2){
										return xp[j];
									}
								}
							}
						}
						
						//-------------------------------------------------------------------
						// 打牌之前是碰牌的话，就判断闲牌里面是否有大于（小于）1个数或者2个数跟碰牌值比较，如果有就返回这一张牌
						// 2010-10-24 00:58 s
						//如688，前面是碰的话，并且这个时候检查6为闲牌，就把6打出去
						var msg:Message = Message(getRoom().historyMessage[getRoom().historyMessage.length - 1]);
						if(msg.head == "pengI"){
							var list:Array = Array(msg.content);
							for(var j:int=0;j<xp.length;j++){
								if(int(list[1]) - 1 == xp[j] || 
										int(list[1]) - 2 == xp[j] || 
										int(list[1]) + 1 == xp[j] || 
										int(list[1]) + 2 == xp[j]){
									return xp[j];
								}
							}
						}
						
						//22345的情况，本身检查2,5为闲牌，但这里不为闲牌，做为修正
						//这里判断必须先于 124 689 的判断，不然两者有冲突
						//2010-10-19 18:47 s
						if((xp.length - i) >=2){
							if(int(xp[i+1]/10) == int(xp[i]/10)){
								if((xp[i+1]-xp[i] == 3) && (checkHaveNum(xp[i]) == 2) && (checkHaveNum(xp[i]+1) == 1) && (checkHaveNum(xp[i]+2) == 1)){
									i++;
									continue;
								}
							}
						}
						
						// 例如1，2,4 打1  2010-10-17 18:32 g
						if(xp[i] == 4 || xp[i] == 14 || xp[i] == 24){
							if(checkHaveNum(xp[i] - 3) == 1){
								return xp[i] - 3;
							}
						}
						// 例如6，8,9 打9  2010-10-17 18:32g
						if(xp[i] == 6 || xp[i] == 16 || xp[i] == 26){
							if(checkHaveNum(xp[i] + 3) == 1){
								return xp[i] + 3;
							}
						}
	
						//3456的情况，本身检查6为闲牌，但这里不首先为闲牌，如果找不到更好的闲牌，再打，做为修正
						//2010-10-19 18:47 s
						if((xp.length - i) >=2){
							if(int(xp[i+1]/10) == int(xp[i]/10)){
								if(xp[i] != 1 && xp[i] != 11 && xp[i] != 21){
									if(xp[i] != 2 && xp[i] != 12 && xp[i] != 22){
										if((checkHaveNum(xp[i]-1) > 0) || (checkHaveNum(xp[i]-2) > 0)){
											return xp[i+1];
										}
									}else{
										if((checkHaveNum(xp[i]-1) > 0)){
											return xp[i+1];
										}
									}
								}
							}
						}
						
						//-------------------------------------------------------------------
						if(xp[i] != 9 && xp[i] != 19 && xp[i] != 29){
							if(xp[i] != 8 && xp[i] != 18 && xp[i] != 28){
								if(xp[i] != 1 && xp[i] != 11 && xp[i] != 21){
									if(xp[i] != 2 && xp[i] != 12 && xp[i] != 22){
										if((checkHaveNum(xp[i]-1) < 2) && (checkHaveNum(xp[i]+1) < 2) && (checkHaveNum(xp[i]-2) < 2) && (checkHaveNum(xp[i]+2) < 2)){
											return xp[i];
										}
									}else{
										if((checkHaveNum(xp[i]-1) < 2) && (checkHaveNum(xp[i]+1) < 2) && (checkHaveNum(xp[i]+2) < 2)){
											return xp[i];
										}
									}
								}else{
									if((checkHaveNum(xp[i]+1) < 2) && (checkHaveNum(xp[i]+2) < 2)){
										return xp[i];
									}
								}
							}else{
								if((checkHaveNum(xp[i]-1) < 2) && (checkHaveNum(xp[i]+1) < 2) && (checkHaveNum(xp[i]-2) < 2)){
									return xp[i];
								}
							}
						}else{
							if((checkHaveNum(xp[i]-1) < 2) && (checkHaveNum(xp[i]-2) < 2)){
								return xp[i];
							}
						}
					}else{
						i++;
					}
				}
				return xp[xp.length - 1];
			}
			return int(getPlayer().sparr[0]);
	    }
		
		//------------------------------------------------------------------
		//机器人打什么牌下叫最合适
		//获得下叫打什么牌最好
		private function huodeXiajiaoPai():int{
			var maxGailv:int = 0;
			var shouldPutWeizhi:int = 15;
	//		
			
			//判断下叫的个数不能大于最初的下叫个数，就按照最初的下叫个数来出牌
			//---------------------获得手上最初的下叫个数
			var newSparr:Vector.<int> = getPlayer().sparr.concat();
			newSparr.pop();
			maxGailv = huodeHupaiGailv(newSparr);
			if(maxGailv > 0){	//如果下叫个数大于0把最后一张牌的索引保存下来
				shouldPutWeizhi = getPlayer().sparr.length - 1;
			}
			//----------------------------------------
			
			var mj:Vector.<int>;
			for(var i:int=0; i<getPlayer().sparr.length; i++){
				mj = getPlayer().sparr.concat();
//				mj.removeItemAt(i);
				mj.splice(i,1);
				
				var gailv:int = huodeHupaiGailv(mj);
				
				if(gailv>maxGailv){
					maxGailv = gailv;
					shouldPutWeizhi = i;
				}
			}
			return shouldPutWeizhi;
		}
		
		/**
		 * 获得有几个叫，胡牌的概率
		 * @param sp
		 * @return
		 */
		private function huodeHupaiGailv(sp:Vector.<int>):int{
			var gailv:int = 0;
			
			for(var i:int=1; i<29; i++){
				var mj:Vector.<int> = sp.concat();
				if((i!=10) && (i!=20)){
					mj.push(i);
					Util.sortVector(mj);
					
					if(HuPai.checkHu(mj)){
						gailv += findMahjongNum(i);
					}
				}
			}
			
			return gailv;
		}
		
		private function findMahjongNum(m:int):int{
			var num:int = 0;
			for(var i:int=0; i<getRoom().mahjongs.length;i++){
				if(getRoom().mahjongs[i] == m){
					num++;
				}
			}
			return num;
		}
		
		public function calXP():Vector.<int>{
			var xx:int = 0;// -将的个数
			var abc:int = 0;// 刻,顺的个数
			
			var ja:Vector.<int> = new Vector.<int>();// 将A的位置.
			var jb:Vector.<int> = new Vector.<int>();// 将B的位置.
			
			var xp:Vector.<int> = new Vector.<int>();// 将B的位置.
			
			var mj:Vector.<int> = this.player.sparr.concat();
			mj = Util.sortVector(mj);
			
			
			//--------------------------------------------------------------------
			if(transformersPeiXing == 1){
				var mm:Vector.<int> = new Vector.<int>();// 将B的位置.
				for (var i:int = 0; i < this.player.sparr.length; i++) {
					if((this.player.sparr[i] / 10) != (qingyiseType / 10)){
						mm.push(this.player.sparr[i]);
						
					}
				}
				if(mm.length > 0){
					return mm;
				}
			}
			
			var tempmj:Vector.<int> = new Vector.<int>();
			tempmj.concat(mj);
			// mj = tempmj.slice(0, 13);
			
			for (var i:int = 0; i < this.player.sparr.length; i++) {
				for (var j:int = i; j < this.player.sparr.length; j++) {
					for (var n:int = j; n < this.player.sparr.length; n++) {
						
						if (i != j && j != n && i != n
							&& mj[i] == mj[j]
							&& mj[j] == mj[n] && mj[i] != -1) {
							
							abc += 1;
							mj[i] = -1;
							mj[j] = -1;
							mj[n] = -1;
						}
					}
				}
			}
			for (var i:int = 0; i < this.player.sparr.length; i++) {
				for (var j:int = i; j < this.player.sparr.length; j++) {
					for (var n:int = j; n < this.player.sparr.length; n++) {
						
						if (i != j && j != n && i != n && mj[i] != -1
							&& mj[j] != -1 && mj[n] != -1) {
							
							var a:int = mj[i];
							var b:int = mj[j];
							var c:int = mj[n];
							var temp:int = 0;
							if (b >= a && b >= c) {
								temp = b;
								b = a;
								a = temp;
								if (c > b) {
									temp = b;
									b = c;
									c = temp;
								}
							} else if (c >= a && c >= b) {
								temp = a;
								a = c;
								c = temp;
								if (c > b) {
									temp = b;
									b = c;
									c = temp;
								}
							} else if (c >= b) {
								temp = b;
								b = c;
								c = temp;
							}
							if (a == b + 1 && a == c + 2) {
								abc += 1;
								mj[i] = -1;
								mj[j] = -1;
								mj[n] = -1;
							}
						}
					}
				}
			}
			
			// 找将
			for (var i:int = 0; i < this.player.sparr.length; i++) {
				for (var j:int = i; j < this.player.sparr.length; j++) {
					if (i != j && mj[i] == mj[j] && mj[i] != -1) {
						ja.push(i);
						jb.push(j);
						mj[i] = -1;
						mj[j] = -1;
						xx++;
						
					}
				}
			}
			
			var mj1:Vector.<int> = mj.concat();
			
			for(var i:int=0;i < this.player.sparr.length; i++){
				for(var j:int=i;j < this.player.sparr.length; j++){
					if(i != j && mj[i] != -1 && mj[j] != -1 
						&& mj[i] / 10 == mj[j] / 10
						&& Math.abs(mj[i] - mj[j]) < 2){
						mj[i] = -1;
						mj[j] = -1;
					}
				}
			}
			
			var num:int = 0;
			for(var i:int=0; i <mj.length; i++){
				if(mj[i] != -1){
					num ++;
					if(checkHaveNum(mj[i]) != 3){
						xp.push(mj[i]);
					}
				}
			}
			if(num == 0) {
				for(var i:int=0; i <mj1.length; i++){
					if(mj1[i] != -1){
						xp.push(mj1[i]);
					}
				}
			}
			return xp;
		}
		
		//查看手上有多少个一样的
		private function checkHaveNum(value:int):int{
			var num:int = 0;
			for(var i:int=0; i<this.getPlayer().sparr.length; i++){
				if(int(int(this.getPlayer().sparr[i])) == value){
					num++;
				}
			}
			return num;
		}
		
		/**
		 * 获得自杠的值
		 * @param value
		 * @return
		 */
		private function huoDeZiGangValue(value:int):int{
			var haveNum:int = 0;
			
			for (var i:int = 0; i < getPlayer().pparr.length; i = i + 3) {
				if (int(getPlayer().pparr[i]) == value && value / 10 != getPlayer().dingzhangValue / 10) { // 用手牌和碰牌数组比较，是否有杠,并且不是定章类
					return int(getPlayer().pparr[i]);
				}
			}
			
			for (var i:int = 0; i < getPlayer().sparr.length; i++) {
				haveNum = 0;
				for (var j:int = 0; j < getPlayer().sparr.length; j++) {
					if (int(getPlayer().sparr[i]) == int(getPlayer().sparr[j])
							&& (int(int(getPlayer().sparr[i]) / 10) != getPlayer().dingzhangValue / 10)) {// 手上的牌循环比较，是否有相同的4张牌，并且不是定章类
						haveNum++;
						if (haveNum == 4) {
							return int(getPlayer().sparr[i]);
						}
					}
				}
			}
			return 0;
			
		}
	}
}