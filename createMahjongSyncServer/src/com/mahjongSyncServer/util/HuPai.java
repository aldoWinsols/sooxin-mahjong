package com.mahjongSyncServer.util;

import java.util.ArrayList;
import java.util.Collections;

import com.mahjongSyncServer.services.PlayerService;

public class HuPai {
	/**
	 * 填充数组
	 * @param arr
	 * @param list
	 * @return
	 */
	public static ArrayList<Integer> fillList(int[] arr, ArrayList<Integer> list) {
		for (int i = 0; i < arr.length; i++) {
			list.add(arr[i]);
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
	public static String[] getHuResult(ArrayList<Integer> sparr,
			ArrayList<Integer> pparr, ArrayList<Integer> gparr) {
		String[] results = new String[2];
		String huName = "";
		int fanNum = 0;
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
						fanNum = fanNum * 32 * (int)Math.pow(2, geiGenNum(sparr, pparr) - 1);
					}
					else{
						huName += "\n龙七对  ";
						fanNum = fanNum * 8 * (int)Math.pow(2, geiGenNum(sparr, pparr) - 1);
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
					fanNum = fanNum * (int)Math.pow(2, getGangNum(gparr));
				}
				if (geiGenNum(sparr, pparr) != 0) {
					fanNum = fanNum * (int)Math.pow(2, geiGenNum(sparr, pparr));
				}
			}
			// 2011-8-15 11:48 g
//			if(sparr.size() == 2){
//				huName += "\n金钩掉  ";
//				fanNum = fanNum * 2;
//			}
			if(huName.equals("")){
				huName = "\n平胡  ";
			}
		}
		results[0] = huName;
		results[1] = String.valueOf(fanNum);
		return results;
	}

	/**
	 * 将将牌提取出来再来判断是不是大对子
	 * @param sparr
	 * @return
	 */
	public static boolean daduizi(ArrayList<Integer> sparr) {
		for (int i = 0; i < sparr.size() - 1; i++) {
			ArrayList<Integer> arrT = new ArrayList<Integer>(sparr);
			if (sparr.get(i) == sparr.get(i + 1)) {
				arrT.remove(i);
				arrT.remove(i);
				if (checkDaduizi(arrT) == true && (checkKan(arrT) == true || arrT.size() == 0)) {
					return true;
				}
			}
		}

		return false;
	}

	/**
	 * @判断能否胡 sparr 手牌 pparr 碰牌 gparr 杠牌
	 */
	public static boolean checkHu(ArrayList<Integer> sparr) {

		// 对手牌数组进行排序
		Collections.sort(sparr);

		if (checkQidui(sparr)) {
			return true;
		} else {
			for (int i = 0; i < sparr.size() - 1; i++) {
				ArrayList<Integer> arrT = new ArrayList<Integer>(sparr);
				if (sparr.get(i) == sparr.get(i + 1)) {
					arrT.remove(i);
					arrT.remove(i);
					// System.out.println(arrT + "---判断能否胡--i-" + i);
					if (checkKan(arrT) == true || arrT.size() == 0) {
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
	public static String[] checkJiao(PlayerService playerService){
		
		String[] results = null;
		int fanNum = 0;
		
		for(int i=1;i <= 29; i ++){
			if((i != 10) && (i != 20) && (i / 10 != playerService.getPlayer().getDingzhangValue() / 10) && (playerService.getPlayer().getDingzhangValue() / 10 != playerService.getAction().checkDingzhangIsOver() / 10)){
				ArrayList<Integer> list = new ArrayList<Integer>(playerService.getPlayer().getSparr());
				list.add(new Integer(i).intValue());
				if(checkHu(list)){
					if(Integer.valueOf(getHuResult(list, playerService.getPlayer().getPparr(), playerService.getPlayer().getGparr())[1]) > fanNum){
						fanNum = Integer.valueOf(getHuResult(list, playerService.getPlayer().getPparr(), playerService.getPlayer().getGparr())[1]);
						results = getHuResult(list, playerService.getPlayer().getPparr(), playerService.getPlayer().getGparr());
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
	public static boolean checkKan(ArrayList<Integer> sparr) {
		ArrayList<Integer> arrT = new ArrayList<Integer>(sparr);
		for (int i = 0; i < sparr.size() - 2; i++) {
			for (int j = i + 1; j < sparr.size() - 1; j++) {
				for (int m = j + 1; m < sparr.size(); m++) {
					if (sparr.get(i) == sparr.get(j)
							&& sparr.get(i) == sparr.get(m)) {
						arrT.remove(i);
						arrT.remove(j - 1);
						arrT.remove(m - 2);
						if (arrT.size() == 0) {
							return true;
						} else {
							return checkKan(arrT);
						}
					} else if (sparr.get(i) == (sparr.get(j) - 1)
							&& (sparr.get(j) == sparr.get(m) - 1)) {
						arrT.remove(i);
						arrT.remove(j - 1);
						arrT.remove(m - 2);
						if (arrT.size() == 0) {
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
	public static boolean checkQys(ArrayList<Integer> sparr,
			ArrayList<Integer> pparr, ArrayList<Integer> gparr) {
		ArrayList<Integer> arr = new ArrayList<Integer>();
		arr.addAll(sparr);
		arr.addAll(pparr);
		arr.addAll(gparr);

		Collections.sort(arr);

		if ((0 < arr.get(0)) && (arr.get(arr.size() - 1) < 10)
				|| (10 < arr.get(0)) && (arr.get(arr.size() - 1) < 20)
				|| (20 < arr.get(0)) && (arr.get(arr.size() - 1) < 30)) {
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
	public static boolean checkJiangDui(ArrayList<Integer> sparr, ArrayList<Integer> pparr, ArrayList<Integer> gparr){
		
		boolean haveCheckKan = false;
		ArrayList<Integer> newSparr = null;
		
		for (int i = 0; i < sparr.size() - 1; i++) {
			ArrayList<Integer> arrT = new ArrayList<Integer>(sparr);
			if (sparr.get(i) == sparr.get(i + 1)) {
				if(sparr.get(i) == 2 || sparr.get(i) == 5 || sparr.get(i) == 8 
						|| sparr.get(i) == 12 || sparr.get(i) == 15 || sparr.get(i) == 18
						|| sparr.get(i) == 22 || sparr.get(i) == 25 || sparr.get(i) == 28){
					
				}
				else{
					return false;
				}
				arrT.remove(i);
				arrT.remove(i);
				// System.out.println(arrT + "---判断能否胡--i-" + i);
				if (checkKan(arrT) == true || arrT.size() == 0) {
					haveCheckKan = true;
					newSparr = arrT;
				}                                        
			}
		}
		
		if(haveCheckKan){
			
			for (int i = 0; i < newSparr.size(); i = i + 3) {
				if(newSparr.get(i) == 2 || newSparr.get(i) == 5 || newSparr.get(i) == 8 
						|| newSparr.get(i) == 12 || newSparr.get(i) == 15 || newSparr.get(i) == 18
						|| newSparr.get(i) == 22 || newSparr.get(i) == 25 || newSparr.get(i) == 28){
					
				}
				else{
					return false;
				}
			}
			
			for (int i = 0; i < pparr.size(); i = i + 3) {
				if(pparr.get(i) == 2 || pparr.get(i) == 5 || pparr.get(i) == 8 
						|| pparr.get(i) == 12 || pparr.get(i) == 15 || pparr.get(i) == 18
						|| pparr.get(i) == 22 || pparr.get(i) == 25 || pparr.get(i) == 28){
					
				}
				else{
					return false;
				}
			}
			
			for (int i = 0; i < gparr.size(); i = i + 4) {
				if(gparr.get(i) == 2 || gparr.get(i) == 5 || gparr.get(i) == 8 
						|| gparr.get(i) == 12 || gparr.get(i) == 15 || gparr.get(i) == 18
						|| gparr.get(i) == 22 || gparr.get(i) == 25 || gparr.get(i) == 28){
					
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
	public static boolean YaoJiuQiDui(ArrayList<Integer> sparr){
		for(int i=0;i < sparr.size(); i ++ ){
			if(sparr.get(i) == 1 || sparr.get(i) == 9 || sparr.get(i) == 11 || sparr.get(i) == 19
					|| sparr.get(i) == 21 || sparr.get(i) == 29){
				
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
	public static boolean checkQidui(ArrayList<Integer> sparr) {
		if (sparr.size() != 14) {
			return false;
		} else {
			for (int i = 0; i < sparr.size(); i = i + 2) {
				if (sparr.get(i) != sparr.get(i + 1)) {
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
	public static boolean checkDaduizi(ArrayList<Integer> sparr) {
		if (sparr.size() == 0) {
			return true;
		} else {
			for (int i = 0; i < sparr.size() - 1; i = i + 3) {
				// System.out.println(sparr+"检查大对");
				if ((sparr.get(i) != sparr.get(i + 1))
						|| (sparr.get(i + 1) != sparr.get(i + 2))) {
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
	public static boolean checkYj(ArrayList<Integer> sparr,
			ArrayList<Integer> pparr, ArrayList<Integer> gparr) {
		// 检查碰牌带幺九的情况
		if (pparr.size() > 0) {
			for (int i = 0; i < pparr.size(); i = i + 3) {
				if (pparr.get(i) != 1 && pparr.get(i) != 9
						&& pparr.get(i) != 11 && pparr.get(i) != 19
						&& pparr.get(i) != 21 && pparr.get(i) != 29) {
					return false;
				}
			}
		}
		// 检查杠牌带幺九的情况
		if (gparr.size() > 0) {
			for (int i = 0; i < gparr.size(); i = i + 4) {
				if (gparr.get(i) != 1 && gparr.get(i) != 9
						&& gparr.get(i) != 11 && gparr.get(i) != 19
						&& gparr.get(i) != 21 && gparr.get(i) != 29) {
					return false;
				}
			}
		}
		if (sparr.size() > 0) {
			for (int i = 0; i < sparr.size() - 1; i++) {
				ArrayList<Integer> arrT = new ArrayList<Integer>(sparr);
				if (sparr.get(i) == sparr.get(i + 1)) {
					if (sparr.get(i) == 1 || sparr.get(i) == 9
							|| sparr.get(i) == 11 || sparr.get(i) == 19
							|| sparr.get(i) == 21 || sparr.get(i) == 29) {
						arrT.remove(i);
						arrT.remove(i);
						if (arrT.size() == 0) {
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
	public static boolean kanHaveYj(ArrayList<Integer> arr) {
		for (int i = 0; i < arr.size(); i = i + 3) {

			if (arr.get(i + 1) - arr.get(i) > 1) {
				return false;
			} else if (arr.size() - i >= 6) {// 判断未判断的手牌有6张以上的

				if ((arr.size() - i) >= 9) {
					if ((arr.size() - i) == 12) {
						if ((arr.get(i) == arr.get(i + 1)
								&& arr.get(i + 1) == arr.get(i + 2)
								&& arr.get(i + 2) == arr.get(i + 3)
								&& (arr.get(i + 4) == arr.get(i) + 1)
								&& arr.get(i + 4) == arr.get(i + 5)
								&& arr.get(i + 5) == arr.get(i + 6)
								&& arr.get(i + 6) == arr.get(i + 7)
								&& (arr.get(i + 8) == arr.get(i) + 2)
								&& arr.get(i + 8) == arr.get(i + 9)
								&& arr.get(i + 9) == arr.get(i + 10)
								&& arr.get(i + 10) == arr.get(i + 11) && ((arr
								.get(i) == 1
								|| arr.get(i) == 11 || arr.get(i) == 21)
								|| arr.get(i) == 7 || arr.get(i) == 17 || arr
								.get(i) == 27))
								&& checkKan(arr)) {
							return true;

						}
					}
					if ((arr.get(i) == arr.get(i + 1)
							&& arr.get(i + 1) == arr.get(i + 2)
							&& (arr.get(i + 3) == arr.get(i) + 1)
							&& (arr.get(i + 3) == arr.get(i + 4))
							&& (arr.get(i + 4) == arr.get(i + 5))
							&& (arr.get(i + 6) == arr.get(i) + 2)
							&& (arr.get(i + 6) == arr.get(i + 7))
							&& (arr.get(i + 7) == arr.get(i + 8)) && ((arr
							.get(i) == 1
							|| arr.get(i) == 11 || arr.get(i) == 21)
							|| arr.get(i + 8) == 9 || arr.get(i + 8) == 19 || arr
							.get(i + 8) == 29))
							&& checkKan(arr)) {
						i = i + 6;
						continue;
					}
				}
				
	
				if ((arr.get(i) == arr.get(i + 1))
						&& (arr.get(i + 2) == arr.get(i) + 1)
						&& (arr.get(i + 4) == arr.get(i) + 2)
						&& ((arr.get(i) == 1) || (arr.get(i) == 7)
								|| (arr.get(i) == 11) || (arr.get(i) == 17)
								|| (arr.get(i) == 21) || (arr.get(i) == 27))
						&& checkKan(arr)) {
					i = i + 3;
				} else if (arr.get(i) != 1 && arr.get(i) != 7
						&& arr.get(i) != 9 && arr.get(i) != 19
						&& arr.get(i) != 29 && arr.get(i) != 11
						&& arr.get(i) != 17 && arr.get(i) != 21
						&& arr.get(i) != 27) {
					return false;
				} else if ((arr.get(i) != 1 && arr.get(i) == arr.get(i + 1) && arr
						.get(i + 1) == arr.get(i + 2))
						&& (arr.get(i) != 9 && arr.get(i) == arr.get(i + 1) && arr
								.get(i + 1) == arr.get(i + 2))
						&& (arr.get(i) != 11 && arr.get(i) == arr.get(i + 1) && arr
								.get(i + 1) == arr.get(i + 2))
						&& (arr.get(i) != 19 && arr.get(i) == arr.get(i + 1) && arr
								.get(i + 1) == arr.get(i + 2))
						&& (arr.get(i) != 21 && arr.get(i) == arr.get(i + 1)
								&& arr.get(i + 1) == arr.get(i + 2) && (arr
								.get(i) != 29
								&& arr.get(i) == arr.get(i + 1) && arr
								.get(i + 1) == arr.get(i + 2)))) {
					return false;
				}

			} else {
				if (arr.get(i) != 1 && arr.get(i) != 7 && arr.get(i) != 9
						&& arr.get(i) != 19 && arr.get(i) != 29
						&& arr.get(i) != 11 && arr.get(i) != 17
						&& arr.get(i) != 21 && arr.get(i) != 27) {
					return false;
				} else if ((arr.get(i) != 1 && arr.get(i) == arr.get(i + 1) && arr
						.get(i + 1) == arr.get(i + 2))
						&& (arr.get(i) != 9 && arr.get(i) == arr.get(i + 1) && arr
								.get(i + 1) == arr.get(i + 2))
						&& (arr.get(i) != 11 && arr.get(i) == arr.get(i + 1) && arr
								.get(i + 1) == arr.get(i + 2))
						&& (arr.get(i) != 19 && arr.get(i) == arr.get(i + 1) && arr
								.get(i + 1) == arr.get(i + 2))
						&& (arr.get(i) != 21 && arr.get(i) == arr.get(i + 1)
								&& arr.get(i + 1) == arr.get(i + 2) && (arr
								.get(i) != 29
								&& arr.get(i) == arr.get(i + 1) && arr
								.get(i + 1) == arr.get(i + 2)))) {
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
	public static int getGangNum(ArrayList<Integer> gparr) {
		return gparr.size() / 4;
	}

	/**
	 * 获得根的个数
	 * @param sparr
	 * @param pparr
	 * @return
	 */
	public static int geiGenNum(ArrayList<Integer> sparr,
			ArrayList<Integer> pparr) {
		int genNumber = 0;
		for (int i = 0; i < sparr.size(); i++) {
			int m = 0;
			for (int j = i + 1; j < sparr.size(); j++) {
				if (sparr.get(i) == sparr.get(j)) {
					m++;
					if (m == 3) {
						genNumber++;
						i = i + 3;
						break;
					}
				}
			}
		}
		ArrayList<Integer> arrT = new ArrayList<Integer>(sparr);
		for (int i = 0; i < pparr.size(); i = i + 3) {
			for (int j = 0; j < arrT.size() - 1; j++) {
				if (arrT.get(j) == arrT.get(j + 1)) {
					arrT.remove(j);
				}
			}
			for (int t = 0; t < arrT.size(); t++) {
				if (pparr.get(i) == arrT.get(t)) {
					genNumber++;
				}
			}
		}
		return genNumber;
	}


}
