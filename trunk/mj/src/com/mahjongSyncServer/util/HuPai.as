package com.mahjongSyncServer.util{

import com.mahjongSyncServer.services.PlayerService;
import com.mahjongSyncServer.util.Util;

public class HuPai {
	/**
	 * 填充数组
	 * @param arr
	 * @param list
	 * @return
	 */
	public static function fillList(arr:Vector.<int>, list:Vector.<int> ):Vector.<int> {
		for (var i:int = 0; i < arr.length; i++) {
			list.push(arr[i]);
		}
		return list;
	}

	/**
	 * 获得胡的结果
	 * @param sparr
	 * @param pparr
	 * @param gparr
	 * @return
	 */
	public static function getHuResult(sparr:Vector.<int>,
			pparr:Vector.<int>, gparr:Vector.<int>):Vector.<String> {
		var results:Vector.<String> = new Vector.<String>(2);
		var huName:String = "";
		var fanNum:int = 0;
		if (checkHu(sparr)) {
			fanNum=1;
			
			if(checkQidui(sparr) && geiGenNum(sparr, pparr) > 0){
				if(YaoJiuQiDui(sparr)){
					huName += "\n幺九七对";
					fanNum = fanNum * 128;
				}
				else{
					if(checkQys(sparr, pparr, gparr)){
						huName += "\n清龙七对";
						fanNum = fanNum * 32 * int(Math.pow(2, geiGenNum(sparr, pparr) - 1));
					}
					else{
						huName += "\n龙七对  ";
						fanNum = fanNum * 8 * int(Math.pow(2, geiGenNum(sparr, pparr) - 1));
					}
				}
			}
			else if (checkYj(sparr, pparr, gparr)) {
				if(checkQys(sparr, pparr, gparr)){
					huName += "\n清带幺  ";
					fanNum = fanNum * 32;
				}else{
					huName += "\n带幺九  ";
					fanNum = fanNum * 4;
				}
			}
			else if (checkQidui(sparr)) {
				if(checkQys(sparr, pparr, gparr)){
					huName += "\n清七对  ";
					fanNum = fanNum * 16;
				}else{
					huName += "\n暗七对  ";
					fanNum = fanNum * 4;
				}
			}
			else if (daduizi(sparr) && checkQys(sparr, pparr, gparr)) {
				huName += "\n清对  ";
				fanNum = fanNum * 8;
			}
			else if (daduizi(sparr)) {
				if(checkJiangDui(sparr, pparr, gparr)){
					huName += "\n将对  ";
					fanNum = fanNum * 8;
				}
				else{
					huName += "\n大对子  ";
					fanNum = fanNum * 2;
				}
			}
			else if (checkQys(sparr, pparr, gparr)) {
				huName += "\n清一色  ";
				fanNum = fanNum * 4;
			}
			
			if(!checkQidui(sparr)){
				if (getGangNum(gparr) != 0) {
					fanNum = fanNum *  int(Math.pow(2, getGangNum(gparr)));
				}
				if (geiGenNum(sparr, pparr) != 0) {
					fanNum = fanNum * int(Math.pow(2, geiGenNum(sparr, pparr)));
				}
			}
			// 2011-8-15 11:48 g
//			if(sparr.size() == 2){
//				huName += "\n金钩掉  ";
//				fanNum = fanNum * 2;
//			}
			if(huName == ""){
				huName = "\n平胡  ";
			}
		}
		results[0] = huName;
		results[1] = String(fanNum);
		return results;
	}

	/**
	 * 将将牌提取出来再来判断是不是大对子
	 * @param sparr
	 * @return
	 */
	public static function daduizi(sparr:Vector.<int>):Boolean {
		for (var i:int = 0; i < sparr.length - 1; i++) {
			var arrT:Vector.<int> = sparr.concat();
			if (sparr[i] == sparr[i + 1]) {
				arrT.splice(i,1);
				arrT.splice(i,1);
				if (checkDaduizi(arrT) == true && (checkKan(arrT) == true || arrT.length == 0)) {
					return true;
				}
			}
		}

		return false;
	}
	
	/**
	 * @判断能否胡 sparr 手牌 pparr 碰牌 gparr 杠牌
	 */
	public static function checkHu(sparr:Vector.<int>):Boolean {

		// 对手牌数组进行排序
		sparr = Util.sortVector(sparr);

		if (checkQidui(sparr)) {
			return true;
		} else {
			for (var i:int = 0; i < sparr.length - 1; i++) {
				var arrT:Vector.<int> = sparr.concat();
				if (sparr[i] == sparr[i + 1]) {
					arrT.splice(i, 1);
					arrT.splice(i, 1);
					// System.out.println(arrT + "---判断能否胡--i-" + i);
					if (checkKan(arrT) == true || arrT.length == 0) {
						//System.out.println(arrT + "---判断能否胡---");
						return true;
					}                                        
				}
			}
		}
		return false;
	}
	/**
	 * 检测牌是否下叫
	 * @param actionService
	 * @return
	 */
	public static function checkJiao(playerService:PlayerService):Vector.<String>{
		
		var results:Vector.<String> = null;
		var fanNum:int = 0;
		
		for(var i:int = 1;i <= 29; i ++){
			if((i != 10) && (i != 20) && (i / 10 != playerService.player.dingzhangValue / 10) && (playerService.player.dingzhangValue / 10 != playerService.action.checkDingzhangIsOver() / 10)){
				var list:Vector.<int> = playerService.player.sparr.concat();
				list.push(i);
				if(checkHu(list)){
					if(int(getHuResult(list, playerService.player.pparr, playerService.player.gparr)[1]) > fanNum){
						fanNum = int(getHuResult(list, playerService.player.pparr, playerService.player.gparr)[1]);
						results = getHuResult(list, playerService.player.pparr, playerService.player.gparr);
					}
				}
			}
		}
		return results;
	}
	
	/**
	 * 判断是否成砍
	 * @param sparr
	 * @return
	 */
	public static function checkKan(sparr:Vector.<int>):Boolean {
		var arrT:Vector.<int> = sparr.concat();
		for (var i:int = 0; i < sparr.length - 2; i++) {
			for (var j:int = i + 1; j < sparr.length - 1; j++) {
				for (var m:int = j + 1; m < sparr.length; m++) {
					if (sparr[i] == sparr[j]
							&& sparr[i] == sparr[m]) {
						arrT.splice(i, 1);
						arrT.splice(j - 1, 1);
						arrT.splice(m - 2, 1);
						if (arrT.length == 0) {
							return true;
						} else {
							return checkKan(arrT);
						}
					} else if (sparr[i] == (sparr[j] - 1)
							&& (sparr[j] == sparr[m] - 1)) {
						arrT.splice(i, 1);
						arrT.splice(j - 1, 1);
						arrT.splice(m - 2, 1);
						if (arrT.length == 0) {
							return true;
						} else {
							return checkKan(arrT);
						}
					}
				}
			}
		}
		return false;
	}


	/**
	 * 判断是否清一色
	 * @param sparr
	 * @param pparr
	 * @param gparr
	 * @return
	 */
	public static function checkQys(sparr:Vector.<int>,
			pparr:Vector.<int>, gparr:Vector.<int>):Boolean {
//		var arr:Vector.<int> = new Vector.<int>();
		var arr:Vector.<int> = sparr.concat(pparr).concat(gparr);
//		arr.concat(pparr);
//		arr.concat(gparr);

		arr = Util.sortVector(arr);

		if ((0 < arr[0]) && (arr[arr.length - 1] < 10)
				|| (10 < arr[0]) && (arr[arr.length - 1] < 20)
				|| (20 < arr[0]) && (arr[arr.length - 1] < 30)) {
			return true;
		}
		return false;
	}

	/**
	 * 判断是否是将对
	 * @param sparr
	 * @param pparr
	 * @param gparr
	 * @return
	 */
	public static function checkJiangDui(sparr:Vector.<int>, pparr:Vector.<int>, gparr:Vector.<int>):Boolean{
		
		var haveCheckKan:Boolean = false;
		var newSparr:Vector.<int> = null;
		
		for (var i:int = 0; i < sparr.length - 1; i++) {
			var arrT:Vector.<int> = sparr.concat();
			if (sparr[i] == sparr[i + 1]) {
				if(sparr[i] == 2 || sparr[i] == 5 || sparr[i] == 8 
						|| sparr[i] == 12 || sparr[i] == 15 || sparr[i] == 18
						|| sparr[i] == 22 || sparr[i] == 25 || sparr[i] == 28){
					
				}
				else{
					return false;
				}
				arrT.splice(i, 1);
				arrT.splice(i, 1);
				// System.out.println(arrT + "---判断能否胡--i-" + i);
				if (checkKan(arrT) == true || arrT.length == 0) {
					haveCheckKan = true;
					newSparr = arrT;
				}                                        
			}
		}
		
		if(haveCheckKan){
			
			for (var i:int = 0; i < newSparr.length; i = i + 3) {
				if(newSparr[i] == 2 || newSparr[i] == 5 || newSparr[i] == 8 
						|| newSparr[i] == 12 || newSparr[i] == 15 || newSparr[i] == 18
						|| newSparr[i] == 22 || newSparr[i] == 25 || newSparr[i] == 28){
					
				}
				else{
					return false;
				}
			}
			
			for (var i:int = 0; i < pparr.length; i = i + 3) {
				if(pparr[i] == 2 || pparr[i] == 5 || pparr[i] == 8 
						|| pparr[i] == 12 || pparr[i] == 15 || pparr[i] == 18
						|| pparr[i] == 22 || pparr[i] == 25 || pparr[i] == 28){
					
				}
				else{
					return false;
				}
			}
			
			for (var i:int = 0; i < gparr.length; i = i + 4) {
				if(gparr[i] == 2 || gparr[i] == 5 || gparr[i] == 8 
						|| gparr[i] == 12 || gparr[i] == 15 || gparr[i] == 18
						|| gparr[i] == 22 || gparr[i] == 25 || gparr[i] == 28){
					
				}
				else{
					return false;
				}
			}
		}
		
		return true;
	}
	
	/**
	 * 判断是否是幺九七对
	 * @param sparr
	 * @return
	 */
	public static function YaoJiuQiDui(sparr:Vector.<int>):Boolean{
		for(var i:int=0;i < sparr.length; i ++ ){
			if(sparr[i] == 1 || sparr[i] == 9 || sparr[i] == 11 || sparr[i] == 19
					|| sparr[i] == 21 || sparr[i] == 29){
				
			}else{
				return false;
			}
		}
		
		return true;
	}
	
	/**
	 * 判断是否小七对
	 * @param sparr
	 * @return
	 */
	public static function checkQidui(sparr:Vector.<int>):Boolean {
		if (sparr.length != 14) {
			return false;
		} else {
			for (var i:int = 0; i < sparr.length; i = i + 2) {
				if (sparr[i] != sparr[i + 1]) {
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * 判断是否大对子
	 * @param sparr
	 * @return
	 */
	public static function checkDaduizi(sparr:Vector.<int>):Boolean {
		if (sparr.length == 0) {
			return true;
		} else {
			for (var i:int = 0; i < sparr.length - 1; i = i + 3) {
				// System.out.println(sparr+"检查大对");
				if ((sparr[i] != sparr[i + 1])
						|| (sparr[i + 1] != sparr[i + 2])) {
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * 判断带吆九情况
	 * @param sparr
	 * @param pparr
	 * @param gparr
	 * @return
	 */
	public static function checkYj(sparr:Vector.<int>, pparr:Vector.<int>, gparr:Vector.<int>):Boolean {
		// 检查碰牌带幺九的情况
		if (pparr.length > 0) {
			for (var i:int = 0; i < pparr.length; i = i + 3) {
				if (pparr[i] != 1 && pparr[i] != 9
						&& pparr[i] != 11 && pparr[i] != 19
						&& pparr[i] != 21 && pparr[i] != 29) {
					return false;
				}
			}
		}
		// 检查杠牌带幺九的情况
		if (gparr.length > 0) {
			for (var i = 0; i < gparr.length; i = i + 4) {
				if (gparr[i] != 1 && gparr[i] != 9
						&& gparr[i] != 11 && gparr[i] != 19
						&& gparr[i] != 21 && gparr[i] != 29) {
					return false;
				}
			}
		}
		if (sparr.length > 0) {
			for (var i:int = 0; i < sparr.length - 1; i++) {
				var arrT:Vector.<int> = sparr.concat();
				if (sparr[i] == sparr[i + 1]) {
					if (sparr[i] == 1 || sparr[i] == 9
							|| sparr[i] == 11 || sparr[i] == 19
							|| sparr[i] == 21 || sparr[i] == 29) {
						arrT.splice(i, 1);
						arrT.splice(i, 1);
						if (arrT.length == 0) {
							return true;
						} else if (checkKan(arrT) == true) {
							return kanHaveYj(arrT);
						}
					}
				}
			}
		}
		return false;
	}

	/**
	 * 判断砍牌是不是带幺九
	 * @param arr
	 * @return
	 */
	public static function kanHaveYj(arr:Vector.<int>):Boolean {
		for (var i:int = 0; i < arr.length; i = i + 3) {
			
			if (arr[i + 1] - arr[i] > 1) {
				return false;
			} else if (arr.length - i >= 6) {// 判断未判断的手牌有6张以上的
				
				if ((arr.length - i) >= 9) {
					if ((arr.length - i) == 12) {
						if ((arr[i] == arr[i + 1]
							&& arr[i + 1] == arr[i + 2]
							&& arr[i + 2] == arr[i + 3]
							&& (arr[i + 4] == arr[i] + 1)
							&& arr[i + 4] == arr[i + 5]
							&& arr[i + 5] == arr[i + 6]
							&& arr[i + 6] == arr[i + 7]
							&& (arr[i + 8] == arr[i] + 2)
							&& arr[i + 8] == arr[i + 9]
							&& arr[i + 9] == arr[i + 10]
							&& arr[i + 10] == arr[i + 11] && ((arr[i] == 1
								|| arr[i] == 11 || arr[i] == 21)
								|| arr[i] == 7 || arr[i] == 17 || arr[i] == 27))
							&& checkKan(arr)) {
							return true;
							
						}
					}
					if ((arr[i] == arr[i + 1]
						&& arr[i + 1] == arr[i + 2]
						&& (arr[i + 3] == arr[i] + 1)
						&& (arr[i + 3] == arr[i + 4])
						&& (arr[i + 4] == arr[i + 5])
						&& (arr[i + 6] == arr[i] + 2)
						&& (arr[i + 6] == arr[i + 7])
						&& (arr[i + 7] == arr[i + 8]) && ((arr[i] == 1
							|| arr[i] == 11 || arr[i] == 21)
							|| arr[i + 8] == 9 || arr[i + 8] == 19 || arr[i + 8] == 29)) && checkKan(arr)) {
						i = i + 6;
						continue;
					}
				}
				
				
				if ((arr[i] == arr[i + 1])
					&& (arr[i + 2] == arr[i] + 1)
					&& (arr[i + 4] == arr[i] + 2)
					&& ((arr[i] == 1) || (arr[i] == 7)
						|| (arr[i] == 11) || (arr[i] == 17)
						|| (arr[i] == 21) || (arr[i] == 27)) && checkKan(arr)) {
					i = i + 3;
				} else if (arr[i] != 1 && arr[i] != 7
					&& arr[i] != 9 && arr[i] != 19
					&& arr[i] != 29 && arr[i] != 11
					&& arr[i] != 17 && arr[i] != 21
					&& arr[i] != 27) {
					return false;
				} else if ((arr[i] != 1 && arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2])
					&& (arr[i] != 9 && arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2])
					&& (arr[i] != 11 && arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2])
					&& (arr[i] != 19 && arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2])
					&& (arr[i] != 21 && arr[i] == arr[i + 1]
						&& arr[i + 1] == arr[i + 2] && (arr[i] != 29
							&& arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2]))) {
					return false;
				}
				
			} else {
				if (arr[i] != 1 && arr[i] != 7 && arr[i] != 9
					&& arr[i] != 19 && arr[i] != 29
					&& arr[i] != 11 && arr[i] != 17
					&& arr[i] != 21 && arr[i] != 27) {
					return false;
				} else if ((arr[i] != 1 && arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2])
					&& (arr[i] != 9 && arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2])
					&& (arr[i] != 11 && arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2])
					&& (arr[i] != 19 && arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2])
					&& (arr[i] != 21 && arr[i] == arr[i + 1]
						&& arr[i + 1] == arr[i + 2] && (arr[i] != 29
							&& arr[i] == arr[i + 1] && arr[i + 1] == arr[i + 2]))) {
					return false;
				}
			}
		}
		return true;
	}



	// ------------------------------------------------------------------------

	/**
	 * 获得杠的个数
	 */
	public static function getGangNum(gparr:Vector.<int>):int {
		return gparr.length / 4;
	}

	/**
	 * 获得根的个数
	 * @param sparr
	 * @param pparr
	 * @return
	 */
	public static function geiGenNum(sparr:Vector.<int>, pparr:Vector.<int>):int {
		var genNumber:int = 0;
		for (var i:int = 0; i < sparr.length; i++) {
			var m:int = 0;
			for (var j:int = i + 1; j < sparr.length; j++) {
				if (sparr[i] == sparr[j]) {
					m++;
					if (m == 3) {
						genNumber++;
						i = i + 3;
						break;
					}
				}
			}
		}
		var arrT:Vector.<int> = sparr.concat();
		for (var i:int = 0; i < pparr.length; i = i + 3) {
			for (var j:int = 0; j < arrT.length - 1; j++) {
				if (arrT[j] == arrT[j + 1]) {
					arrT.splice(j, 1);
				}
			}
			for (var t:int = 0; t < arrT.length; t++) {
				if (pparr[i] == arrT[t]) {
					genNumber ++;
				}
			}
		}
		return genNumber;
	}
	}
}
