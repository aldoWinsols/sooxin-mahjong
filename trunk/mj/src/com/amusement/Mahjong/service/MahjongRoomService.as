package com.amusement.Mahjong.service
{
	import com.amusement.Mahjong.control.MahjongBalanceControl;
	import com.amusement.Mahjong.control.MahjongDiceControl;
	import com.amusement.Mahjong.control.MahjongDingzhangControl;
	import com.amusement.Mahjong.control.MahjongGangControl;
	import com.amusement.Mahjong.control.MahjongInfoControl;
	import com.amusement.Mahjong.control.MahjongOperationControl;
	import com.amusement.Mahjong.control.MahjongPlayerControlD;
	import com.amusement.Mahjong.control.MahjongPlayerControlL;
	import com.amusement.Mahjong.control.MahjongPlayerControlR;
	import com.amusement.Mahjong.control.MahjongPlayerControlU;
	import com.amusement.Mahjong.control.MahjongQuemenControl;
	import com.amusement.Mahjong.control.MahjongRoomControl;
	import com.amusement.Mahjong.control.MahjongSeatControl;
	import com.amusement.Mahjong.control.MahjongSignControl;
	import com.amusement.Mahjong.control.MahjongTimerControl;
	import com.amusement.Mahjong.control.MahjongVideoControl;
	import com.amusement.Mahjong.control.MahjongWordControl;
	import com.amusement.Mahjong.model.Mahjong;
	import com.amusement.Mahjong.util.MahjongUtil;
	import com.amusement.Mahjong.view.MahjongDingzhang;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import spark.components.Group;

	public class MahjongRoomService
	{
		private var _mahjongs:Array;
		private var _mjs:Array;
		
		private var _effectTimer:Timer;
		private var _nowDealPlayerAzimuth:int = 3;
		
		public function MahjongRoomService()
		{
			initMahjongs();
			_effectTimer = new Timer(1000);
		}
		
		public function initRoom(roomNo:Number, playerAzimuth:int):void{
			MahjongRoomControl.instance.roomNo = roomNo;
			MahjongInfoControl.instance.setRoomNum(roomNo);
			
			MahjongRoomControl.instance.playerAzimuth = playerAzimuth;
			
			MahjongSeatControl.instance.show();
			
			MahjongPoolService.instance.resetMahjongs();
			resetMahjongs();
			
			sortMahjongs();
		}
		
		public function reset():void{
			resetEffectTimer();
			MahjongTimerControl.instance.reset();
			
			if(MahjongRoomControl.instance.isVideo){//测试
				MahjongVideoControl.instance.hide();
			}
			MahjongDiceControl.instance.hide();
			MahjongQuemenControl.instance.hide();
			MahjongDingzhangControl.instance.hide();
			MahjongWordControl.instance.hide();
			MahjongGangControl.instance.hide();
			MahjongOperationControl.instance.hide();
			MahjongBalanceControl.instance.hide();
			MahjongSignControl.instance.hide();
			MahjongSeatControl.instance.hide();
			
			MahjongPlayerControlD.instance.reset();
			MahjongPlayerControlL.instance.reset();
			MahjongPlayerControlR.instance.reset();
			MahjongPlayerControlU.instance.reset();
			
			MahjongPoolService.instance.resetMahjongs();
			resetMahjongs();
			
			MahjongRoomControl.instance.nowPutPlayerAzimuth = 0;
			MahjongRoomControl.instance.nowPutMahjong = null;
			
			MahjongRoomControl.instance.putState = 0;
			MahjongRoomControl.instance.selectMahjong = null;
		}
		
		/**
		 * 重置效果显示器 
		 * 
		 */
		public function resetEffectTimer():void{
			_effectTimer.reset();
			_effectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, diceHandler);
			_effectTimer.removeEventListener(TimerEvent.TIMER, dealHandler);
			_effectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, wordHandler);
		}
		
		/**
		 * 显示骰子 
		 * @param num
		 * 
		 */
		public function showDice(num:int):void{
			_effectTimer.delay = 2000;
			_effectTimer.repeatCount = 1;
			_effectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, diceHandler, false, 0, true);
			
			updateMahjongsByDice(num);
			
			MahjongDiceControl.instance.show(num);
			
			_effectTimer.start();
		}
		
		public function diceHandler(event:TimerEvent):void{
			_effectTimer.reset();
			_effectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, diceHandler);
			
			showDeal();
		}
		
		/**
		 * 显示发牌 
		 * 
		 */
		public function showDeal():void{
			_effectTimer.delay = 500;
			_effectTimer.repeatCount = 0;
			_effectTimer.addEventListener(TimerEvent.TIMER, dealHandler, false, 0, true);
			
			MahjongSoundService.instance.soundPlay("fapai");//发牌声音
			
			_effectTimer.start();
		}
		
		public function dealHandler(event:TimerEvent):void{
			if(_effectTimer.currentCount == 1){
				_nowDealPlayerAzimuth = 3;
			}else{
				_nowDealPlayerAzimuth = (_nowDealPlayerAzimuth + 1) <= 4 ? _nowDealPlayerAzimuth + 1 : 1;
			}
			
			switch(_effectTimer.currentCount){
				case 13://3发1张
					this.dispenseMahjongs(3, 1);
					break;
				case 14://4发1张
					this.dispenseMahjongs(4, 1);
					break;
				case 15://1发1张
					this.dispenseMahjongs(1, 1);
					break;
				case 16://2发1张
					this.dispenseMahjongs(2, 1);
					break;
				case 17://向服务器发送准备就绪消息
					_effectTimer.reset();
					_effectTimer.removeEventListener(TimerEvent.TIMER, dealHandler);
					
					MahjongDiceControl.instance.hide();//隐藏骰子
					
					if(MahjongRoomControl.instance.isVideo){
						MahjongVideoControl.instance.show();//显示录像控制面板
						MahjongPlayerControlU.instance._mahjongPlayer.pd.visible = false;
						MahjongPlayerControlD.instance._mahjongPlayer.pd.visible = false;
						MahjongPlayerControlL.instance._mahjongPlayer.pd.visible = false;
						MahjongPlayerControlR.instance._mahjongPlayer.pd.visible = false;
					}else{
						MahjongSyncService.instance.dealOver();
					}
					break;
				default://循环发4张
					this.dispenseMahjongs(_nowDealPlayerAzimuth, 4);
					break;
			}
		}
		
		/**
		 * 显示文字（碰/杠/胡） 
		 * @param wordName
		 * @param azimuth
		 * 
		 */
		public function showWord(wordName:String, azimuth:int):void{
			_effectTimer.reset();
			_effectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, wordHandler);
			
			_effectTimer.delay = 2000;
			_effectTimer.repeatCount = 1;
			_effectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, wordHandler, false, 0, true);
			
			MahjongWordControl.instance.show(wordName, azimuth);
			
			_effectTimer.start();
		}
		
		public function wordHandler(event:TimerEvent):void{
			_effectTimer.reset();
			_effectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, wordHandler);
			
			MahjongWordControl.instance.hide();
		}
		
		/**
		 * 垒牌 
		 * 
		 */
		public function sortMahjongs():void{
			var count:int=0;
			var i:int;
			switch (MahjongRoomControl.instance.playerAzimuth)
			{
				case 1:
					for (i = 0; i < MahjongRoomControl.instance.mahjongs.length; i ++)
					{
						//换初始起点
						//0度牌堆
						if (i < 28){
							MahjongPlayerControlD.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i, count);
						}
						//90度牌堆
						if (i >= 28 && i < 54){
							MahjongPlayerControlL.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 28, count);
						}
						//180度牌堆
						if (i >= 54 && i < 82){
							MahjongPlayerControlU.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 54, count);
						}
						//270度牌堆
						if (i >= 82 && i < 108){
							MahjongPlayerControlR.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 82, count);
						}
						//上下排牌
						count ++;
					}
					break;
				
				case 2:
					for (i = 0; i < MahjongRoomControl.instance.mahjongs.length; i ++)
					{
						//换初始起点
						//0度牌堆
						if (i < 28){
							MahjongPlayerControlL.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i, count);
						}
						//90度牌堆
						if (i >= 28 && i < 54){
							MahjongPlayerControlU.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 28, count);
						}
						//180度牌堆
						if (i >= 54 && i < 82){
							MahjongPlayerControlR.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 54, count);
						}
						//270度牌堆
						if (i >= 82 && i < 108){
							MahjongPlayerControlD.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 82, count);
						}
						//上下排牌
						count ++;
					}
					break;
				
				case 3:
					for (i = 0; i < MahjongRoomControl.instance.mahjongs.length; i ++)
					{
						//换初始起点
						//0度牌堆
						if (i < 28){
							MahjongPlayerControlU.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i, count);
						}
						//90度牌堆
						if (i >= 28 && i < 54){
							MahjongPlayerControlR.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 28, count);
						}
						//180度牌堆
						if (i >= 54 && i < 82){
							MahjongPlayerControlD.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 54, count);
						}
						//270度牌堆
						if (i >= 82 && i < 108){
							MahjongPlayerControlL.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 82, count);
						}
						//上下排牌
						count ++;
						
					}
					break;
				
				case 4:
					for (i = 0; i < MahjongRoomControl.instance.mahjongs.length; i  ++){
						//换初始起点
						//0度牌堆
						if (i < 28){
							MahjongPlayerControlR.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i, count);
						}
						//90度牌堆
						if (i >= 28 && i < 54){
							MahjongPlayerControlD.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 28, count);
						}
						//180度牌堆
						if (i >= 54 && i < 82){
							MahjongPlayerControlL.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 54, count);
						}
						//270度牌堆
						if (i >= 82 && i < 108){
							MahjongPlayerControlU.instance.sortMahjong(MahjongRoomControl.instance.mahjongs[i], i - 82, count);
						}
						//上下排牌
						count ++;
						
					}
					break;
			}
		}
		
		/**
		 * 根据骰子点数定位麻将起始点 
		 * @param diceNumber 骰子点数
		 * 
		 */
		public function updateMahjongsByDice(diceNumber:int):void
		{
			var mahjongsT:Array;
			
			//根据点数显示有所不同
			if (diceNumber == 3 || diceNumber == 7 || diceNumber == 11){
				mahjongsT = MahjongRoomControl.instance.mahjongs.splice(0, diceNumber * 2);
			}else if (diceNumber == 2 || diceNumber == 6 || diceNumber == 10){
				mahjongsT = MahjongRoomControl.instance.mahjongs.splice(0, 28 + diceNumber * 2);
			}else if (diceNumber == 5 || diceNumber == 9){
				mahjongsT = MahjongRoomControl.instance.mahjongs.splice(0, 54 + diceNumber * 2);
			}else if (diceNumber == 4 || diceNumber == 8 || diceNumber == 12){
				mahjongsT = MahjongRoomControl.instance.mahjongs.splice(0, 82 + diceNumber * 2);
			}
			
			MahjongRoomControl.instance.mahjongs = MahjongRoomControl.instance.mahjongs.concat(mahjongsT);
		}
		
		/**
		 * 发牌 
		 * @param playerAzimuthR
		 * @param num
		 * 
		 */
		public function dispenseMahjongs(playerAzimuthR:int, num:int):void{
			var mahjongs:Array = this.getMahjongsByNumber(num);
			//是否需要更换为隐藏（有值）麻将
			if(MahjongRoomControl.instance.playerAzimuth == playerAzimuthR || MahjongRoomControl.instance.isVideo){
				for each(var mahjong:Mahjong in mahjongs){
					if(mahjong.parent){
						Group(mahjong.parent).removeElement(mahjong);
					}
				}
				
				var mahjongValues:Array = this.getPlayerMahjongValues(playerAzimuthR).splice(0, num);
				mahjongs = MahjongPoolService.instance.getMahjongsByValues(mahjongValues, MahjongRoomControl.instance.mahjongColor);
			}
			
			var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
			switch (resPlayerAzimuth)
			{
				case 1:
					MahjongPlayerControlU.instance.dispenseMahjong(mahjongs);
					break;
				case 2:
					MahjongPlayerControlL.instance.dispenseMahjong(mahjongs);
					break;
				case 3:
					MahjongPlayerControlD.instance.dispenseMahjong(mahjongs);
					break;
				case 4:
					MahjongPlayerControlR.instance.dispenseMahjong(mahjongs);
					break;
			}
		}
		
		//-----------------------------------------------------------------------------------
		/**
		 * 定章 
		 * @param playerAzimuthR 定章方位
		 * @param dingzhangValue 定章值
		 * 
		 */
		public function dingzhang(playerAzimuthR:int, dingzhangValue:int):void{
			var resPlayerAzimuth:int=MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
			switch (resPlayerAzimuth)
			{
				case 1:
					MahjongPlayerControlU.instance.dingzhangV(dingzhangValue);
					break;
				case 2:
					MahjongPlayerControlL.instance.dingzhangV(dingzhangValue);
					break;
				case 3:
					if(MahjongRoomControl.instance.isVideo){
						MahjongDingzhangControl.instance.hide();
					}
					MahjongPlayerControlD.instance.dingzhangV(dingzhangValue);
					break;
				case 4:
					MahjongPlayerControlR.instance.dingzhangV(dingzhangValue);
					break;
			}
			
			if(!MahjongRoomControl.instance.isVideo){
				//庄家显示请定章？？？(由服务器通知)
				/*if(MahjongRoomControl.instance.playerAzimuth == 3 && MahjongPlayerControlD.instance.state == 0 &&
					(MahjongPlayerControlL.instance.state == 1 || MahjongPlayerControlL.instance.state == 2) && 
					(MahjongPlayerControlR.instance.state == 1 || MahjongPlayerControlR.instance.state == 2) && 
					(MahjongPlayerControlU.instance.state == 1 || MahjongPlayerControlU.instance.state == 2)){
					MahjongDingzhangControl.instance.show();
				}else*/ if(MahjongRoomControl.instance.playerAzimuth == 3 && playerAzimuthR == 3){//庄家定章
					//缺处理
					if(MahjongPlayerControlD.instance.state == 2){
						MahjongRoomControl.instance.putState = 2;
						MahjongTimerControl.instance.show(3);
					}else if(MahjongPlayerControlD.instance.state == 1){
						MahjongPlayerControlD.instance.replacePutDingzhang();
					}
				}
			}
		}
		
		/**
		 * 摸牌 
		 * @param playerAzimuthR 摸牌方位
		 * @param getOneMahjongValue 摸牌值
		 * 
		 */
		public function getOneMahjong(playerAzimuthR:int, getOneMahjongValue:int):void{
			var mahjong:Mahjong = this.getMahjong();
			//是否需要更换为隐藏（有值）麻将
			if(MahjongRoomControl.instance.playerAzimuth == playerAzimuthR || MahjongRoomControl.instance.isVideo){
				MahjongOperationControl.instance.hide();
				if(mahjong.parent){
					Group(mahjong.parent).removeElement(mahjong);
				}
				mahjong = MahjongPoolService.instance.getMahjongByValue(getOneMahjongValue, MahjongRoomControl.instance.mahjongColor);
			}
			
			if(mahjong){
				var resPlayerAzimuth:int=MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
				switch (resPlayerAzimuth){
					case 1:
						MahjongPlayerControlU.instance.getOneMahjongV(mahjong);
						break;
					case 2:
						MahjongPlayerControlL.instance.getOneMahjongV(mahjong);
						break;
					case 3:
						MahjongPlayerControlD.instance.getOneMahjongV(mahjong);
						break;
					case 4:
						MahjongPlayerControlR.instance.getOneMahjongV(mahjong);
						break;
				}
				
				if(!MahjongRoomControl.instance.isVideo){
					if(playerAzimuthR == 3 && MahjongPlayerControlD.instance.state == 0){//庄家第一次摸牌 
						//其他玩家显示请定章   考虑请定章由服务器通知
						/*if(MahjongRoomControl.instance.playerAzimuth != 3){
						MahjongDingzhangControl.instance.show();
						}*/
						return;
					}else if(MahjongRoomControl.instance.playerAzimuth == playerAzimuthR){
						var haveZimo:Boolean = MahjongPlayerControlD.instance.checkHuMine();
						var haveGangArr:Array = MahjongPlayerControlD.instance.checkGangMine(MahjongRoomControl.instance.mahjongs.length);
						if(haveZimo || haveGangArr.length > 0){
							return;
						}else if(MahjongRoomControl.instance.playerAzimuth != 3 && MahjongPlayerControlD.instance.state == 1){
							MahjongPlayerControlD.instance.replacePutDingzhang();
						}else{
							MahjongRoomControl.instance.putState = 2;
							MahjongTimerControl.instance.show(3);
						}
					}else{
						MahjongTimerControl.instance.show(resPlayerAzimuth);
					}
				}
			}
		}
		
		/**
		 * 打牌 
		 * @param playerAzimuthR 打牌方位
		 * @param putOneMahjongValue 打牌值
		 * @param isPutDingzhang 是不是翻定章
		 * 
		 */
		public function putOneMahjong(playerAzimuthR:int, putOneMahjongValue:int, isPutDingzhang:Boolean = false):void{
			if(MahjongRoomControl.instance.isVideo){
				MahjongOperationControl.instance.hide();
			}else{
				MahjongTimerControl.instance.hide();
			}
			
			MahjongSoundService.instance.soundPlay(putOneMahjongValue);//打牌声音
			
			var mahjong:Mahjong;
			var resPlayerAzimuth:int=MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
			switch (resPlayerAzimuth)
			{
				case 1:
					mahjong = MahjongPlayerControlU.instance.putOneMahjongV(putOneMahjongValue, isPutDingzhang);
					break;
				case 2:
					mahjong = MahjongPlayerControlL.instance.putOneMahjongV(putOneMahjongValue, isPutDingzhang);
					break;
				case 3:
					mahjong = MahjongPlayerControlD.instance.putOneMahjongV(putOneMahjongValue, isPutDingzhang);
					break;
				case 4:
					mahjong = MahjongPlayerControlR.instance.putOneMahjongV(putOneMahjongValue, isPutDingzhang);
					break;
			}
			
			if(mahjong){
				MahjongRoomControl.instance.nowPutMahjong = mahjong;
				MahjongRoomControl.instance.nowPutPlayerAzimuth = playerAzimuthR;
			}
		}
		
		/**
		 * 碰 
		 * @param playerAzimuthR
		 * @param pengValue
		 * 
		 */
		public function peng(playerAzimuthR:int, pengValue:int):void{
			if(MahjongRoomControl.instance.isVideo){
				MahjongOperationControl.instance.hide();
			}
			
			if(MahjongRoomControl.instance.nowPutMahjong.value == pengValue){
				if(removeLastMahjongByOut(MahjongRoomControl.instance.nowPutPlayerAzimuth, pengValue)){	
					MahjongSoundService.instance.soundPlay("peng");//碰声音
					
					var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
					this.showWord("peng", resPlayerAzimuth);
					switch (resPlayerAzimuth){
						case 1:
							MahjongPlayerControlU.instance.pengV(MahjongRoomControl.instance.nowPutMahjong);
							break;
						case 2:
							MahjongPlayerControlL.instance.pengV(MahjongRoomControl.instance.nowPutMahjong);
							break;
						case 3:
							MahjongPlayerControlD.instance.pengV(MahjongRoomControl.instance.nowPutMahjong);
							break;
						case 4:
							MahjongPlayerControlR.instance.pengV(MahjongRoomControl.instance.nowPutMahjong);
							break;
					}
				}
				
				if(!MahjongRoomControl.instance.isVideo){
					if( MahjongRoomControl.instance.playerAzimuth == playerAzimuthR){
						if(MahjongRoomControl.instance.playerAzimuth != 3 && MahjongPlayerControlD.instance.state == 1){
							MahjongPlayerControlD.instance.replacePutDingzhang();
						}else{
							MahjongRoomControl.instance.putState = 2;
							MahjongTimerControl.instance.show(3);
						}
					}else{
						MahjongTimerControl.instance.show(resPlayerAzimuth);
					}
				}
			}
		}
		
		/**
		 * 杠 
		 * @param playerAzimuthR
		 * @param gangValue
		 * @param isZigang
		 * 
		 */
		public function gang(playerAzimuthR:int, gangValue:int, isZigang:Boolean = false):void{
			if(MahjongRoomControl.instance.isVideo){
				MahjongOperationControl.instance.hide();
			}
			
			var mahjong:Mahjong;
			if(isZigang){
				mahjong = removeOneMahjongBySp(playerAzimuthR, gangValue);
			}else{
				if(MahjongRoomControl.instance.nowPutMahjong.value == gangValue){
					if(removeLastMahjongByOut(MahjongRoomControl.instance.nowPutPlayerAzimuth, gangValue)){
						mahjong = MahjongRoomControl.instance.nowPutMahjong;
					}
				}
			}
			
			if(mahjong){
				MahjongSoundService.instance.soundPlay("gang");//杠声音
				
				var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
				this.showWord("gang", resPlayerAzimuth);
				switch (resPlayerAzimuth){
					case 1:
						MahjongPlayerControlU.instance.gangV(mahjong, isZigang);
						break;
					case 2:
						MahjongPlayerControlL.instance.gangV(mahjong, isZigang);
						break;
					case 3:
						MahjongPlayerControlD.instance.gangV(mahjong, isZigang);
						break;
					case 4:
						MahjongPlayerControlR.instance.gangV(mahjong, isZigang);
						break;
				}
			}
		}
		
		/**
		 * 胡 
		 * @param playerAzimuthR
		 * @param huValue
		 * @param huType
		 * @param isAfterGang
		 * @param haveHuCount
		 * @param qiangGangAzimuth
		 * 
		 */
		public function hu(playerAzimuthR:int, huValue:int, huType:int = 0, isAfterGang:Boolean = false, haveHuCount:int = 1, qiangGangAzimuth:int = 0):void{
			if(MahjongRoomControl.instance.isVideo){
				MahjongOperationControl.instance.hide();
			}else{
				MahjongTimerControl.instance.hide();
			}
			
			var mahjong:Mahjong;
			switch(huType){
				case 0: //点炮
					if(haveHuCount > 1){
						mahjong = MahjongPoolService.instance.getMahjong(huValue, MahjongRoomControl.instance.mahjongColor);
					}else if(removeLastMahjongByOut(MahjongRoomControl.instance.nowPutPlayerAzimuth, huValue)){
						mahjong = MahjongRoomControl.instance.nowPutMahjong;
					}
					if(isAfterGang){
						MahjongSoundService.instance.soundPlay("gangshangpao");//杠上炮声音
					}else{
						MahjongSoundService.instance.soundPlay("hu");//胡声音
					}
					break;
				case 1: //自摸
					mahjong = removeOneMahjongBySp(playerAzimuthR, huValue);
					if(isAfterGang){
						MahjongSoundService.instance.soundPlay("gangshanghua");//杠上花声音
					}else{
						MahjongSoundService.instance.soundPlay("zimo");//自摸声音
					}
					break;
				case 2: //抢杠
					mahjong = restoreGpAndPp(qiangGangAzimuth, huValue);
					break;
			}
			
			if(mahjong){
				var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
				this.showWord("hu", resPlayerAzimuth);
				switch (resPlayerAzimuth){
					case 1:
						MahjongPlayerControlU.instance.huV(mahjong, huType, haveHuCount, qiangGangAzimuth);
						break;
					case 2:
						MahjongPlayerControlL.instance.huV(mahjong, huType, haveHuCount, qiangGangAzimuth);
						break;
					case 3:
						MahjongPlayerControlD.instance.huV(mahjong, huType, haveHuCount, qiangGangAzimuth);
						break;
					case 4:
						MahjongPlayerControlR.instance.huV(mahjong, huType, haveHuCount, qiangGangAzimuth);
						break;
				}
			}
		}
		
		/**
		 * 倒牌 
		 * @param playerMahjongValues
		 * 
		 */
		public function cut(playerMahjongValues:Array):void{
			if(playerMahjongValues){
				var resPlayerAzimuth:int;
				for(var i:int = 1; i < playerMahjongValues.length; i ++){
					this.setPlayerMahjongValues(i, playerMahjongValues[i]);
					
					resPlayerAzimuth = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, i);
					switch (resPlayerAzimuth){
						case 1:
							MahjongPlayerControlU.instance.cutV();
							break;
						case 2:
							MahjongPlayerControlL.instance.cutV();
							break;
						case 4:
							MahjongPlayerControlR.instance.cutV();
							break;
					}
				}
				
			}
		}
		
		/**
		 * 显示操作面板 
		 * @param playerAzimuthR 座位号
		 * @param isPeng 是否碰
		 * @param isGang 是否杠
		 * @param isHu 是否胡
		 * @param isZimo 是否自摸
		 * @param isZigang 是否自杠
		 * 
		 */
		public function showOperation(playerAzimuthR:int, isPeng:Boolean, isGang:Boolean, isHu:Boolean, isZimo:Boolean, isZigang:Boolean):void{
			if(MahjongRoomControl.instance.playerAzimuth == playerAzimuthR){
				if(!MahjongRoomControl.instance.isVideo && MahjongRoomControl.instance.mahjongs.length < 5 && isHu){
					//向服务器发送胡请求
					this.isZimo = isZimo;
					var timer:Timer = new Timer(1000, 1);
					timer.addEventListener(TimerEvent.TIMER, onTimer);
					timer.start();
				}else{
					MahjongOperationControl.instance.show(isPeng, isGang, isHu, isZimo, isZigang);
				}
			}
		}
		private var isZimo:Boolean = false;
		private function onTimer(e:TimerEvent):void{
			MahjongSyncService.instance.hu(isZimo);
		}
		/**
		 * 显示定章面板 
		 * @param playerAzimuthR
		 * 
		 */
		public function showDingzhang(playerAzimuthR:int):void{
			if(!MahjongRoomControl.instance.isVideo || MahjongRoomControl.instance.playerAzimuth == playerAzimuthR){
				MahjongDingzhangControl.instance.show();
			}
		}
		
		//------------------------------------- 重连 相关方法 -------------------------------------------
		public function doOffline(isOnline:Boolean = false, waitTime:int = 50):void{
			MahjongTimerControl.instance.offline(isOnline, waitTime);
		}
		
		/**
		 * 重构桌面 
		 * @param players
		 * 
		 */
		public function reconstructTabletop(players:Array):void{
			var resPlayerAzimuth:int;
			//重构各方的牌面
			for(var i:int = 1; i < players.length; i ++){
				resPlayerAzimuth = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, i);
				switch (resPlayerAzimuth){
					case 1:
						MahjongPlayerControlU.instance.reconstruct(players[i]);
						break;
					case 2:
						MahjongPlayerControlL.instance.reconstruct(players[i]);
						break;
					case 3:
						MahjongPlayerControlD.instance.reconstruct(players[i]);
						break;
					case 4:
						MahjongPlayerControlR.instance.reconstruct(players[i]);
						break;
				}
			}
		}
		
		/**
		 * 重连后，玩家自行操作
		 * 
		 */
		public function doPlayAfterRestart(isShowOperation:Boolean = false, operationContent:String = ""):void{
			if(isShowOperation){//显示操作面板（碰/点胡/点杠）
				var operationContents:Array = operationContent.split(",");
				
				var isPeng:Boolean = false;
				var isGang:Boolean = false;
				var isHu:Boolean = false;
				for(var i:int = 0; i < operationContents.length; i ++){
					switch(operationContents[i]){
						case "peng":
							isPeng = true;
							break;
						case "gang":
							isGang = true;
							break;
						case "hu":
							isHu = true;
							break;
					}
				}
				
				showOperation(MahjongRoomControl.instance.playerAzimuth, isPeng, isGang, isHu, false, false);
			}else{
				var sprrLength:int = MahjongPlayerControlD.instance.getSpLength();
				switch(MahjongPlayerControlD.instance.state){
					case 0://未定章
						if(MahjongRoomControl.instance.playerAzimuth == 3){
							//庄  闲已经定章完毕
							if((MahjongPlayerControlL.instance.state == 1 || MahjongPlayerControlL.instance.state == 2) && 
								(MahjongPlayerControlR.instance.state == 1 || MahjongPlayerControlR.instance.state == 2) && 
								(MahjongPlayerControlU.instance.state == 1 || MahjongPlayerControlU.instance.state == 2)){
								if(MahjongPlayerControlD.instance.checkHuMine()){//天胡？
									showOperation(MahjongRoomControl.instance.playerAzimuth, false, false, true, true, false);
								}else{
									showDingzhang(MahjongRoomControl.instance.playerAzimuth);
								}
							}
						}else{
							//闲  庄已摸牌第一张牌
							if(this.getSprrLengthFromBanker() == 14){
								showDingzhang(MahjongRoomControl.instance.playerAzimuth);
							}
						}
						break;
					case 1://未翻定章
						if(sprrLength == 13 || sprrLength == 10){
							MahjongPlayerControlD.instance.replacePutDingzhang();
						}
						break;
					case 2://缺
					case 3://已显示定章类型
						if(sprrLength == 14 || sprrLength == 11 || sprrLength == 8 || sprrLength == 5 || sprrLength == 2){//己方操作？
							var haveZimo:Boolean = MahjongPlayerControlD.instance.checkHuMine();
							var haveGangArr:Array = MahjongPlayerControlD.instance.checkGangMine(MahjongRoomControl.instance.mahjongs.length);
							if(haveZimo || haveGangArr.length > 0){//自摸 自杠
								showOperation(MahjongRoomControl.instance.playerAzimuth, false, Boolean(haveGangArr.length), haveZimo, haveZimo, Boolean(haveGangArr.length));
							}else{
								MahjongRoomControl.instance.putState = 2;
								MahjongTimerControl.instance.show(3);
							}
						}
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 * 重连后，代替玩家进行操作 
		 * 
		 */
		public function replacePlayAfterRestart(isShowOperation:Boolean = false, operationContent:String = ""):void{
			if(isShowOperation){//显示操作面板（碰/点胡/点杠）
				//代替点消
				MahjongSyncService.instance.xiao(false, false);
			}else{
				var sprrLength:int = MahjongPlayerControlD.instance.getSpLength();
				switch(MahjongPlayerControlD.instance.state){
					case 0://未定章
						if(MahjongRoomControl.instance.playerAzimuth == 3){
							//庄  闲已经定章完毕
							if((MahjongPlayerControlL.instance.state == 1 || MahjongPlayerControlL.instance.state == 2) && 
								(MahjongPlayerControlR.instance.state == 1 || MahjongPlayerControlR.instance.state == 2) && 
								(MahjongPlayerControlU.instance.state == 1 || MahjongPlayerControlU.instance.state == 2)){
								if(MahjongPlayerControlD.instance.checkHuMine()){//天胡？
									MahjongSyncService.instance.hu(true);
								}/*else{
									MahjongPlayerControlD.instance.replaceDingzhang();
								}*/
							}
						}/*else{
							//闲  庄已摸牌第一张牌
							if(this.getSprrLengthFromBanker() == 14){
								MahjongPlayerControlD.instance.replaceDingzhang();
							}
						}*/
						break;
					case 1://未翻定章
						if(sprrLength == 13 || sprrLength == 10){
							MahjongPlayerControlD.instance.replacePutDingzhang();
						}
						break;
					case 2://缺
					case 3://已显示定章类型
						if(sprrLength == 14 || sprrLength == 11 || sprrLength == 8 || sprrLength == 5 || sprrLength == 2){//己方操作？
							if(MahjongPlayerControlD.instance.checkHuMine()){//自摸？
								MahjongSyncService.instance.hu(true);
							}else{
								MahjongPlayerControlD.instance.replacePutMahjong();
							}
						}
						break;
					default:
						break;
				}
			}
		}
		
		/**
		 * 获取当前出的牌 
		 * @param playerAzimuthR
		 * @return 
		 * 
		 */
		public function getLastPutMahjong(playerAzimuthR:int):Mahjong{
			var mahjong:Mahjong;
			if(playerAzimuthR > 0){
				var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
				switch (resPlayerAzimuth){
					case 1:
						mahjong = MahjongPlayerControlU.instance.getLastOutMahjong();
						break;
					case 2:
						mahjong = MahjongPlayerControlL.instance.getLastOutMahjong();
						break;
					case 3:
						mahjong = MahjongPlayerControlD.instance.getLastOutMahjong();
						break;
					case 4:
						mahjong = MahjongPlayerControlR.instance.getLastOutMahjong();
						break;
				}
				
			}
			return mahjong;
		}
		
		/**
		 * 获取庄手牌长度 
		 * @return 
		 * 
		 */
		public function getSprrLengthFromBanker():int{
			var sprrLength:int;
			var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, 3);
			switch (resPlayerAzimuth){
				case 1:
					sprrLength = MahjongPlayerControlU.instance.getSpLength();
					break;
				case 2:
					sprrLength = MahjongPlayerControlL.instance.getSpLength();
					break;
				case 3:
					sprrLength = MahjongPlayerControlD.instance.getSpLength();
					break;
				case 4:
					sprrLength = MahjongPlayerControlR.instance.getSpLength();
					break;
			}
			return sprrLength;
		}
		
		//---------------------------------桌面（可见）麻将操作--------------------------------
		/**
		 * 初始化麻将 
		 * 
		 */
		public function initMahjongs():void{
			MahjongRoomControl.instance.mahjongs = MahjongPoolService.instance.getMahjongsByNumber(108, MahjongRoomControl.instance.mahjongColor);
			_mjs = [];
		}
		
		/**
		 * 重置麻将 
		 * 
		 */
		public function resetMahjongs():void{
			MahjongRoomControl.instance.mahjongs = MahjongRoomControl.instance.mahjongs.concat(_mjs);
			_mjs.splice(0, _mjs.length);
		}
		
		/**
		 * 设置麻将颜色 
		 * @param color
		 * 
		 */
		public function updateMahjongsColor(color:String):void{
			for each(var mahjong:Mahjong in MahjongRoomControl.instance.mahjongs){
				mahjong.setColor(MahjongRoomControl.instance.mahjongColor);
			}
		}
		
		/**
		 * 获取牌堆中 第一张麻将
		 * @return 
		 * 
		 */
		public function getMahjong():Mahjong{
			var mahjong:Mahjong = MahjongRoomControl.instance.mahjongs.shift();
			_mjs.push(mahjong);
			return mahjong;
		}
		
		/**
		 * 获取牌堆中 前num数量张麻将 
		 * @param num
		 * @return 
		 * 
		 */
		public function getMahjongsByNumber(num:int):Array{
			var mahjongs:Array = MahjongRoomControl.instance.mahjongs.splice(0, num);
			_mjs = _mjs.concat(mahjongs);
			return mahjongs;
		}
		
		//------------------------------------对各方牌处理方法------------------------------------------
		/**
		 * 设置玩家麻将值数数组 
		 * @param playerAzimuthR
		 * @param mahjongValues
		 * 
		 */
		public function setPlayerMahjongValues(playerAzimuthR:int, mahjongValues:Array):void{
			if(mahjongValues){
				var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
				switch (resPlayerAzimuth){
					case 1:
						MahjongPlayerControlU.instance.mahjongValues = mahjongValues;
						break;
					case 2:
						MahjongPlayerControlL.instance.mahjongValues = mahjongValues;
						break;
					case 3:
						MahjongPlayerControlD.instance.mahjongValues = mahjongValues;
						break;
					case 4:
						MahjongPlayerControlR.instance.mahjongValues = mahjongValues;
						break;
				}
				
			}
		}
		
		/**
		 * 获取玩家麻将值数组 
		 * @param playerAzimuthR
		 * @return 
		 * 
		 */
		public function getPlayerMahjongValues(playerAzimuthR:int):Array{
			var mahjongValues:Array;
			var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
			switch (resPlayerAzimuth){
				case 1:
					mahjongValues = MahjongPlayerControlU.instance.mahjongValues;
					break;
				case 2:
					mahjongValues = MahjongPlayerControlL.instance.mahjongValues;
					break;
				case 3:
					mahjongValues = MahjongPlayerControlD.instance.mahjongValues;
					break;
				case 4:
					mahjongValues = MahjongPlayerControlR.instance.mahjongValues;
					break;
			}
			return mahjongValues;
		}
		
		/**
		 * 删除最后打出的牌 
		 * @param playerAzimuthR
		 * @param mahjongValue
		 * @return 
		 * 
		 */
		private function removeLastMahjongByOut(playerAzimuthR:int, mahjongValue:int):Mahjong{
			var mahjong:Mahjong;
			var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
			switch (resPlayerAzimuth){
				case 1:
					mahjong = MahjongPlayerControlU.instance.popOutMahjong(mahjongValue);
					break;
				case 2:
					mahjong = MahjongPlayerControlL.instance.popOutMahjong(mahjongValue);
					break;
				case 3:
					mahjong = MahjongPlayerControlD.instance.popOutMahjong(mahjongValue);
					break;
				case 4:
					mahjong = MahjongPlayerControlR.instance.popOutMahjong(mahjongValue);
					break;
			}
			return mahjong;
		}
		
		/**
		 * 根据值删除手中一张牌
		 * @param playerAzimuthR
		 * @param mahjongValue
		 * @return 
		 * 
		 */
		private function removeOneMahjongBySp(playerAzimuthR:int, mahjongValue:int):Mahjong{
			var mahjong:Mahjong;
			var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
			switch (resPlayerAzimuth){
				case 1:
					mahjong = MahjongPlayerControlU.instance.getMahjongBySp(mahjongValue);
					break;
				case 2:
					mahjong = MahjongPlayerControlL.instance.getMahjongBySp(mahjongValue);
					break;
				case 3:
					mahjong = MahjongPlayerControlD.instance.getMahjongBySp(mahjongValue);
					break;
				case 4:
					mahjong = MahjongPlayerControlR.instance.getMahjongBySp(mahjongValue);
					break;
			}
			return mahjong;
		}
		
		/**
		 * 复原碰牌与杠牌
		 * （被抢杠后，杠牌被还原到碰牌）
		 * @param playerAzimuthR
		 * @param mahjongValue
		 * @return 
		 * 
		 */
		private function restoreGpAndPp(playerAzimuthR:int, mahjongValue:int):Mahjong{
			var mahjong:Mahjong;
			var resPlayerAzimuth:int = MahjongUtil.getRemotePlayerAzimuth(MahjongRoomControl.instance.playerAzimuth, playerAzimuthR);
			switch (resPlayerAzimuth){
				case 1:
					mahjong = MahjongPlayerControlU.instance.restoreMahjongsByGpAndPp(mahjongValue);
					break;
				case 2:
					mahjong = MahjongPlayerControlL.instance.restoreMahjongsByGpAndPp(mahjongValue);
					break;
				case 3:
					mahjong = MahjongPlayerControlD.instance.restoreMahjongsByGpAndPp(mahjongValue);
					break;
				case 4:
					mahjong = MahjongPlayerControlR.instance.restoreMahjongsByGpAndPp(mahjongValue);
					break;
			}
			return mahjong;
		}
	}
}