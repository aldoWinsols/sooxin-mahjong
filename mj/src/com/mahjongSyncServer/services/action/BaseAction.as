package com.mahjongSyncServer.services.action{
	
	import com.mahjongSyncServer.interfaces.IAction;
	import com.mahjongSyncServer.model.Message;
	import com.mahjongSyncServer.model.Player;
	import com.mahjongSyncServer.model.Room;
	import com.mahjongSyncServer.services.PlayerService;
	import com.mahjongSyncServer.util.HuPai;
	import com.mahjongSyncServer.util.Util;
	
	import mx.collections.ArrayList;
	
	public class BaseAction implements IAction {
	
		public var player:Player;
		public var room:Room;
		public var dingzhangCount:int = 0;
		public var qingyiseType:int = 0;
		public var transformersPeiXing:int = 0;
		
		public function init(){
			dingzhangCount = 0;
			qingyiseType = 0;
			transformersPeiXing = 0;
		}
		
		public function getPlayer():Player{
			return this.player;
		}
		
		public function setPlayer(player:Player):void{
			this.player = player;
		}
		
		public function setRoom(room:Room):void{
			this.room = room;
		}
		
		public function getRoom():Room{
			return room;
		}
		// 下一个摸牌的用户
		public function nextGetOneMahjongPlyaer(lastGetOneMahjongPlayerAzimuth:int, t:int):int{
			var nextAzimuth:int = 0;
			for (var i:int = 0; i < 3; i++) {
				nextAzimuth = lastGetOneMahjongPlayerAzimuth + t;
				if(nextAzimuth > 4){
					nextAzimuth -= 4;
				}
				return nextAzimuth;
			}
			return null;
		}
		
		
		public function getOperationName(devil:PlayerService = null):Array {
			var play:Player = this.player;
			// TODO Auto-generated method stub
			return null;
		}
		
		public function checkGangFunction(value:int , haveZigang:Boolean):String{
			return "";
		}
	
		public function checkPeng(value:int):Boolean {
			if(int(value / 10) == int(player.dingzhangValue / 10)){
				return false;
			}
			
			var num:int = 0;
	
			for (var i:int = 0; i < player.sparr.length; i++) {
				if (player.sparr[i] == value) {
					num++;
				}
			}
			
			if(num >= 2){
				return true;
			}
			
			return false;
		}
	
		public function checkGang(value:int):Boolean {
			if(room.mahjongs.length == 0){
				return false;
			}
			
//			player.haveWanGang = false;
			
			if(this.player.lastNeedOperationName == "getOneMahjong"){
				var valueNum:int = 0;
				
				for (var i:int = 0; i < player.pparr.length; i++) {
					if(player.pparr[i] == value){
						valueNum ++;
					}
					if(valueNum == 3){
						player.zigangValue = value;
						player.haveWanGang = true;
						return true;
					}
				}
				
				for (var i:int = 0; i < player.sparr.length; i++) {
					valueNum = 0;
					for (var j:int = 0; j < player.sparr.length; j++) {
						if((int(player.sparr[i]/10) != int(player.dingzhangValue/10)) && (player.sparr[i] == player.sparr[j])){
							valueNum++;
						}
					}
					if(valueNum == 4){
						player.zigangValue = player.sparr[i];
						return true;
					}
				}
			}else{
				if(int(value / 10) == int(player.dingzhangValue / 10)){
					return false;
				}
				
				var valueNum:int = 0;
				for (var i:int = 0; i < player.sparr.length; i++) {
					if (player.sparr[i] == value) {
						valueNum++;
					}
				}
				
				if(valueNum == 3){
					player.zigangValue = value;
					return true;
				}
			}
			return false;
		}

		public function checkHu(value:int):Boolean {
			// TODO Auto-generated method stub
			
			if(!checkDingZhang()){
				return false;
			}
			
			if(int(value / 10) == int(player.dingzhangValue / 10)){
				return false;
			}
			
			var haveHu:Boolean = false;
				
			var sparrHu:Vector.<int> = player.sparr.concat();
			sparrHu.push(value);
			
			haveHu = HuPai.checkHu(sparrHu);
			
			return haveHu;
		}
		
		public function checkZiHu(isZihu:Boolean):Boolean {
			// TODO Auto-generated method stub
			
			if(!checkDingZhang()){
				return false;
			}
			
			var haveHu:Boolean = false;
				
			var sparrHu:Vector.<int> = player.sparr.concat();
			haveHu = HuPai.checkHu(sparrHu);
			
			return haveHu;
		}
		
		
		public function checkLessMahjongType():int{
			var value:int = 0;
			
			var wm:int = 0; //万字个数
			var tm:int = 0; //筒字个数
			var ttm:int = 0; // 条字个数
	
			var list:Vector.<int> = getPlayer().sparr.concat();
			Util.sortVector(list);
			
			for (var i:int = 0; i < list.length; i++) {// 找出一类的个数
				if (int(list[i] / 10) == 0) {
					wm++;
				} else if (int(list[i] / 10) == 1) {
					tm++;
				} else if (int(list[i] / 10) == 2) {
					ttm++;
				}
			}
			
			//----------------------------------------------
			var dingzhangSort:int = 0;
			if((wm<(tm-1)) && (wm<(ttm-1))){
				dingzhangSort = 0;
				return findMahjongBySort(dingzhangSort,list);
			}
			
			if((tm<(wm-1)) && (tm<(ttm-1))){
				dingzhangSort = 1;
				return findMahjongBySort(dingzhangSort,list);
			}
			
			if((ttm<(wm-1)) && (ttm<(tm-1))){
				dingzhangSort = 2;
				return findMahjongBySort(dingzhangSort,list);
			}
			
			//---------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------
			
			if((wm == tm) && (wm < ttm)){
				
				//------------------
				if(checkHaveThreeMore(0,list) && (!checkHaveThreeMore(1,list))){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
				if((!checkHaveThreeMore(0,list)) && checkHaveThreeMore(1,list)){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
				//------------------
				if(checkHaveTwoMore(0,list) && (!checkHaveTwoMore(1,list))){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
				if((!checkHaveTwoMore(0,list)) && checkHaveTwoMore(1,list)){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
				//------------------
				
				dingzhangSort = Math.random()>0.5? 0:1;
				return findMahjongBySort(dingzhangSort,list);
			}
			
			if((wm == ttm) && (wm < tm)){
				//------------------
				if(checkHaveThreeMore(0,list) && (!checkHaveThreeMore(2,list))){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
				if((!checkHaveThreeMore(0,list)) && checkHaveThreeMore(2,list)){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
				//------------------
				if(checkHaveTwoMore(0,list) && (!checkHaveTwoMore(2,list))){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
				if((!checkHaveTwoMore(0,list)) && checkHaveTwoMore(2,list)){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
				//------------------
				
				dingzhangSort = Math.random()>0.5? 0:2;
				return findMahjongBySort(dingzhangSort,list);
			}
			
			if((tm == ttm) && (tm < wm)){
				//------------------
				if(checkHaveThreeMore(1,list) && (!checkHaveThreeMore(2,list))){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
				if((!checkHaveThreeMore(1,list)) && checkHaveThreeMore(2,list)){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
				//------------------
				if(checkHaveTwoMore(1,list) && (!checkHaveTwoMore(2,list))){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
				if((!checkHaveTwoMore(1,list)) && checkHaveTwoMore(2,list)){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
				//------------------
				
				dingzhangSort = Math.random()>0.5? 1:2;
				return findMahjongBySort(dingzhangSort,list);
			}
			
			//---------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------
			
			if((tm == (wm-1)) && (tm < ttm)){
				if(checkHaveThreeMore(0,list)){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
				if(checkHaveThreeMore(1,list) && (!checkHaveThreeMore(0,list))){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
				
				//-----------------------
				
				if(checkZhakou(0,list) && checkHaveTwoMore(1,list)){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}else{
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
			}
			
			if((wm == (tm-1)) && (tm < ttm)){
				if(checkHaveThreeMore(1,list)){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
				if(checkHaveThreeMore(0,list) && (!checkHaveThreeMore(1,list))){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
				
				//----------------------------
				
				if(checkZhakou(1,list) && checkHaveTwoMore(0,list)){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}else{
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
			}
			
			
			if((tm == (ttm-1)) && (tm < wm)){
				if(checkHaveThreeMore(2,list)){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
				if(checkHaveThreeMore(1,list) && (!checkHaveThreeMore(2,list))){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
				
				//-----------------------------
				
				if(checkZhakou(2,list) && checkHaveTwoMore(1,list)){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}else{
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
			}
			
			if((ttm == (tm-1)) && (ttm < wm)){
				if(checkHaveThreeMore(1,list)){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
				if(checkHaveThreeMore(2,list) && (!checkHaveThreeMore(1,list))){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}
				
				//-----------------------------
				
				if(checkZhakou(1,list) && checkHaveTwoMore(2,list)){
					dingzhangSort = 1;
					return findMahjongBySort(dingzhangSort,list);
				}else{
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
			}
			
			if((ttm == (wm-1)) && (ttm < tm)){
				if(checkHaveThreeMore(0,list)){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
				if(checkHaveThreeMore(2,list) && (!checkHaveThreeMore(0,list))){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
				
				//-----------------------------
				
				if(checkZhakou(0,list) && checkHaveTwoMore(2,list)){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}else{
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
			}
			
			if((wm == (ttm-1)) && (wm < tm)){
				if(checkHaveThreeMore(2,list)){
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
				if(checkHaveThreeMore(0,list) && (!checkHaveThreeMore(2,list))){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}
				
				//-----------------------------
				
				if(checkZhakou(2,list) && checkHaveTwoMore(0,list)){
					dingzhangSort = 2;
					return findMahjongBySort(dingzhangSort,list);
				}else{
					dingzhangSort = 0;
					return findMahjongBySort(dingzhangSort,list);
				}
			}
			
			//----------------------------------------------
	
			return value;
		}
		
		private function checkZhakou(sort:int, list:Vector.<int>):Boolean{
			var mj:Vector.<int> = new Vector.<int>();
			for(var i:int=0; i<list.length; i++){
				if(int(list[i]/10) == sort){
					mj.push(list[i]);
				}
			}
			
			if(mj.length>3){
				for(var j:int=0; j<mj.length-2; j++){
					if((mj[j+2] - mj[j+1] <= 1) || (mj[j+1] - mj[j] <= 1)){
						return false;
					}
				}

			}else{
				return false;
			}
			return true;
		}
		
		private function checkHaveTwoMore(sort:int, list:Vector.<int>):Boolean{
			var num:int = 0;
			var mj:Vector.<int> = new Vector.<int>();
			for(var i:int=0; i<list.length; i++){
				if(int(list[i]/10) == sort){
					mj.push(list[i]);
				}
			}
			
			for(var i:int=0; i<mj.length; i++){
				num = 0;
				for(var j:int=0; j<mj.length; j++){
					if(mj[i] == mj[j]){
						num++;
						if(num >= 2){
							return true;
						}
					}
				}
				
			}
	
			return false;
		}
		public function checkFangHu(value:int):Boolean{
			var haveHisturyValue:Boolean = false;
			var histuryIndex:int = 0;
			
			if(player.isFangTuiDa){
				for (var i:int = room.historyMessage.length-1; i >= 0 ; i--) {

					var message:Message = room.historyMessage[i];
					var list:Array = Array(message.content);
					if(message.head == "pengI" && int(list[0]) == player.azimuth){
						for(var j:int = i; j <room.historyMessage.length ; j++){
							var message1:Message = room.historyMessage[j];
							if(message1.head == "gangI"){
								return true;
							}
							var list1:Array = Array(message1.content);
							if(message1.head == "getOneMahjongI" && int(list1[0])==player.azimuth){
								return true;
							}
						}
						break; // 2010-1-9 g 解决碰了后退打没过手就胡的问题
					}

				}
			}
			
			var newSparr:Vector.<int> = player.sparr.concat();
			newSparr.push(value);
			
			//2010-11-15 11:40
			var strr:Vector.<String> = HuPai.getHuResult(newSparr,player.pparr,player.gparr);
			var thisFanNum:int = int(strr[1]);
	
			if(thisFanNum>player.lastFangFanNum){
				player.lastFangFanNum = thisFanNum;
				return true;
			}
	
			for (var j:int = room.historyMessage.length - 2; j >= 0 ; j--) {	// 从消息历史记录倒数第二个向前查找打牌消息的值是否与当前胡的值相同
				var message:Message = room.historyMessage[j];
				var list:Array = Array(message.content);
				var haveHu:Boolean = false;
				for (var i:int = 0; i < list.length; i++) {
					if(list[i] == "hu"){
						haveHu = true;
						break;
					}
				}
				if(message.head == "showOperationI" && haveHu && int(list[0]) == player.azimuth){
					haveHisturyValue = true;
					histuryIndex = j;
					break;
				}
			}
			
			//////System.out.println("haveHisturyValue == " + haveHisturyValue);
			if(haveHisturyValue){	// 如果此消息有
				for (var k:int = histuryIndex; k < room.historyMessage.length; k++) {	// 再从该位置查找到最后， 找到摸牌消息方位是否与提示可以胡牌的方位相同，如果相同则说明已经过了一圈了
					var message:Message = room.historyMessage[k];
					var list:Array = Array(message.content);
					if(message.head == "putOneMahjongI" && 
						int(list[0]) == player.azimuth){
						return true;
					}
					
					//2010-10-22 15:22 s
					//-----------------------------------------------------------------
					if(message.head == "gangI"){
						return true;
					}
					//-----------------------------------------------------------------
				}
			}
				
			return false;
		}
		private function checkHaveThreeMore(sort:int, list:Vector.<int>):Boolean{
			var num:int = 0;
			var mj:Vector.<int> = new Vector.<int>();
			for(var i:int=0; i<list.length; i++){
				if(int(list[i]/10) == sort){
					mj.push(list[i]);
				}
			}
			
			for(var i:int=0; i<mj.length; i++){
				num = 0;
				for(var j:int=0; j<mj.length; j++){
					if(mj[i] == mj[j]){
						num++;
						if(num >= 3){
							return true;
						}
					}
				}
				
			}
	
			return false;
		}
		
		private function findMahjongBySort(sort:int, list:Vector.<int>):int{
			var value:int = 0;
			for (var i:int = 0; i < list.length; i++) {
				if (int(list[i]/10) == sort) {
					value = list[i];
					break;
				}
			}
			
			if(value == 0){
				return sort*10;
			}
			
			return value;
		}
		
		
		public function getPutOneMahjongValue():int {
			// TODO Auto-generated method stub
			return 0;
		}
	
		public function checkDingZhang():Boolean{
			for (var i:int = 0; i < player.sparr.length; i++) {
				if (player.sparr[i] / 10 == player.dingzhangValue / 10) {
					return false;
				}
			}
			return true;
		}
		
		public function checkDingzhangIsOver():int {

			var value:int = 0;
			
			for (var i:int = 0; i < player.sparr.length; i++) {
				if (player.sparr[i] / 10 == player.dingzhangValue / 10) {
					value = player.sparr[i];
					break;
				}
			}
			
			if (value == 0) {
				value = player.sparr[player.sparr.length - 1];
			}
			return value;
		}
		
		public function huoDeMP():int{
			return 0;
		}
		
		public function huoDePaiXing():void{}
	}
}