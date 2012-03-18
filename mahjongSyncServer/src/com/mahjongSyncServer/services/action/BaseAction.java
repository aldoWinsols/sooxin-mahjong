package com.mahjongSyncServer.services.action;

import java.util.ArrayList;

import com.mahjongSyncServer.interfaces.IAction;
import com.mahjongSyncServer.model.Message;
import com.mahjongSyncServer.model.Player;
import com.mahjongSyncServer.model.Room;
import com.mahjongSyncServer.util.HuPai;
import com.mahjongSyncServer.util.Util;

public class BaseAction implements IAction {

	private Player player;
	private Room room;
	public Player getPlayer() {
		return player;
	}
	public Room getRoom(){
		return room;
	}
	@Override
	public void setPlayer(Player player) {
		// TODO Auto-generated method stub
		this.player = player;
	}
	@Override
	public void setRoom(Room room){
		this.room = room;
	}
	@Override
	public ArrayList<String> getOperationName(int azimuth, int value,
			int valueType) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getPutOneMahjong() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean checkPeng(int value) {
		if(value / 10 == player.getDingzhangValue() / 10){
			return false;
		}
		
		int num = 0;

		for (int i = 0; i < player.getSparr().size(); i++) {
			if (player.getSparr().get(i) == value) {
				num++;
			}
		}
		
		if(num >= 2){
			return true;
		}
		
		return false;
	}

	@Override
	public boolean checkGang(int value) {
		if(room.getMahjongList().size() == 0){
			return false;
		}
		if(value / 10 == player.getDingzhangValue() / 10){
			return false;
		}
		int num = 0;

		for (int i = 0; i < player.getSparr().size(); i++) {
			if (player.getSparr().get(i) == value) {
				num++;
			}
		}
		
		if(num == 3){
			return true;
		}
		
		return false;
	}

	public String checkGang(int value , boolean haveZigang){
		if(player.getDingzhangValue() == -1){
			return "";
		}
		if(room.getMahjongList().size() == 0){
			return "";
		}
		
		int haveNum = 0;
		for (int i = 0; i < player.getPparr().size(); i = i + 3) {
			if (player.getPparr().get(i) == value && 
					value / 10 != player.getDingzhangValue() / 10) { // 用手牌和碰牌数组比较，是否有杠,并且不是定章类
				return "wangang";
			}
		}

		for (int i = 0; i < this.getPlayer().getSparr().size(); i++) {
			//////System.out.print(sparr.get(i) + " ,");
			haveNum = 0;
			for (int j = 0; j < this.getPlayer().getSparr().size(); j++) {
				// 手上的牌循环比较，是否有相同的4张牌，并且不是定章类
				if (player.getSparr().get(i) / 10 != player.getDingzhangValue() / 10 &&
						player.getSparr().get(i) == player.getSparr().get(j)) {
					haveNum++;
					if (haveNum == 4) {
						return "angang";
					}
				}
			}
		}
		return "";
	}
	@Override
	public boolean checkWanGang(int value){
		if(value / 10 == player.getDingzhangValue() / 10){
			return false;
		}
		
		int valueNum = 0;
		
		for (int i = 0; i < player.getPparr().size(); i++) {
			if(player.getPparr().get(i) == value){
				valueNum ++;
			}
			if(valueNum == 3){
				return true;
			}
		}
		
		return false;
	}

	@Override
	public boolean checkHu(int value) {
		// TODO Auto-generated method stub
		
		if(checkDingzhangIsOver() / 10 == player.getDingzhangValue() / 10){
			return false;
		}
		
		boolean haveHu = false;
			
		ArrayList<Integer> sparrHu = new ArrayList<Integer>(player.getSparr());
		Util.sort(sparrHu);
		
		sparrHu.add(value);
		
		haveHu = HuPai.checkHu(sparrHu);
		
		return haveHu;
	}
	
	public boolean checkHu(boolean isZihu) {
		// TODO Auto-generated method stub
		
		if(checkDingzhangIsOver() / 10 == player.getDingzhangValue() / 10){
			return false;
		}
		
		boolean haveHu = false;
			
		ArrayList<Integer> sparrHu = new ArrayList<Integer>(player.getSparr());
		Util.sort(sparrHu);

		haveHu = HuPai.checkHu(sparrHu);
		
		return haveHu;
	}
	
	@Override
	public int checkLessMahjongType(){
		int value = 0;
		
		int wm = 0; //万字个数
		int tm = 0; //筒字个数
		int ttm = 0; // 条字个数

		ArrayList<Integer> list = new ArrayList<Integer>(getPlayer().getSparr());
		Util.sort(list);

		for (int i = 0; i < list.size(); i++) {// 找出一类的个数
			if (list.get(i) / 10 == 0) {
				wm++;
			} else if (list.get(i) / 10 == 1) {
				tm++;
			} else if (list.get(i) / 10 == 2) {
				ttm++;
			}
		}
		
		//----------------------------------------------
		int dingzhangSort = 0;
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
	
	private boolean checkZhakou(int sort, ArrayList<Integer> list){
		ArrayList<Integer> mj = new ArrayList<Integer>();
		for(int i=0; i<list.size(); i++){
			if(list.get(i)/10 == sort){
				mj.add(list.get(i));
			}
		}
		
		if(mj.size()>3){
			for(int j=0; j<mj.size()-2; j++){
				if(((mj.get(j+2) - mj.get(j+1)) <= 1) || ((mj.get(j+1) - mj.get(j)) <= 1)){
					return false;
				}
			}
		}else{
			return false;
		}
		return true;
	}
	
	private boolean checkHaveTwoMore(int sort, ArrayList<Integer> list){
		int num = 0;
		ArrayList<Integer> mj = new ArrayList<Integer>();
		for(int i=0; i<list.size(); i++){
			if(list.get(i)/10 == sort){
				mj.add(list.get(i));
			}
		}
		
		for(int i=0; i<mj.size(); i++){
			num = 0;
			for(int j=0; j<mj.size(); j++){
				if(mj.get(i) == mj.get(j)){
					num++;
					if(num >= 2){
						return true;
					}
				}
			}
			
		}

		return false;
	}
	public boolean checkFangHu(int value){
		boolean haveHisturyValue = false;
		int histuryIndex = 0;
		
		if(player.isFangTuiDa()){
//			System.out.println("player.isFangTuiDa = " + player.isFangTuiDa);
//			System.out.println("histuryMessages.size() = " + histuryMessages.size());
			for (int i = room.getHistoryMessage().size()-1; i >= 0 ; i--) {
//				System.out.println("method = " + histuryMessages.get(i).methodName + " ,    azimuth = " + histuryMessages.get(i).playerAzimuth);

				Message message = room.getHistoryMessage().get(i);
				ArrayList<Object> list = (ArrayList<Object>) message.getContent();
				if(message.getHead().equals("pengI") && Integer.valueOf(list.get(0).toString()) == player.getAzimuth()){
					for(int j = i; j <room.getHistoryMessage().size() ; j++){
						Message message1 = room.getHistoryMessage().get(j);
						if(message1.getHead().equals("gangI")){
							return true;
						}
						ArrayList<Object> list1 = (ArrayList<Object>) message1.getContent();
						if(message1.getHead().equals("getOneMahjongI") && Integer.valueOf(list1.get(0).toString())==player.getAzimuth()){
							return true;
						}
					}
					break; // 2010-1-9 g 解决碰了后退打没过手就胡的问题
				}
			}
		}
		
		ArrayList<Integer> newSparr = new ArrayList<Integer>(player.getSparr());
		newSparr.add(value);
		
		//2010-11-15 11:40
		String[] strr = HuPai.getHuResult(newSparr,player.getPparr(),player.getGparr());
		int thisFanNum = Integer.parseInt(strr[1]);

		if(thisFanNum>player.getLastFangFanNum()){
			player.setLastFangFanNum(thisFanNum);
			return true;
		}

		for (int j = room.getHistoryMessage().size() - 2; j >= 0 ; j--) {	// 从消息历史记录倒数第二个向前查找打牌消息的值是否与当前胡的值相同
			Message message = room.getHistoryMessage().get(j);
			ArrayList<Object> list = (ArrayList<Object>) message.getContent();
			boolean haveHu = false;
			for (int i = 0; i < list.size(); i++) {
				if(list.get(i).toString().contains("hu")){
					haveHu = true;
					break;
				}
			}
			if(message.getHead().equals("showOperationI") && haveHu 
					&& Integer.valueOf(list.get(0).toString()) == player.getAzimuth()){
				haveHisturyValue = true;
				histuryIndex = j;
				break;
			}
		}
		
		
		//////System.out.println("haveHisturyValue == " + haveHisturyValue);
		if(haveHisturyValue){	// 如果此消息有
			for (int k = histuryIndex; k < room.getHistoryMessage().size(); k++) {	// 再从该位置查找到最后， 找到摸牌消息方位是否与提示可以胡牌的方位相同，如果相同则说明已经过了一圈了
				Message message = room.getHistoryMessage().get(k);
				ArrayList<Object> list = (ArrayList<Object>) message.getContent();
				if(message.getHead().equals("putOneMahjongI") && 
						Integer.valueOf(list.get(0).toString()) == player.getAzimuth()){
					return true;
				}
				
				//2010-10-22 15:22 s
				//-----------------------------------------------------------------
				if(message.getHead().equals("gangI")){
					return true;
				}
				//-----------------------------------------------------------------
			}
		}
			
		return false;
	}
	private boolean checkHaveThreeMore(int sort, ArrayList<Integer> list){
		int num = 0;
		ArrayList<Integer> mj = new ArrayList<Integer>();
		for(int i=0; i<list.size(); i++){
			if(list.get(i)/10 == sort){
				mj.add(list.get(i));
			}
		}
		
		for(int i=0; i<mj.size(); i++){
			num = 0;
			for(int j=0; j<mj.size(); j++){
				if(mj.get(i) == mj.get(j)){
					num++;
					if(num >= 3){
						return true;
					}
				}
			}
			
		}

		return false;
	}
	
	private int findMahjongBySort(int sort, ArrayList<Integer> list){
		int value = 0;
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i) / 10 == sort) {
				value = list.get(i);
				break;
			}
		}
		
		if(value == 0){
			return sort*10;
		}
		
		return value;
	}
	
	@Override
	public int officialTransformerPutOneMahjong() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int checkDingzhangIsOver() {
		int value = 0;

		for (int i = 0; i < player.getSparr().size(); i++) {
			if (player.getSparr().get(i) / 10 == player.getDingzhangValue() / 10) {
				value = player.getSparr().get(i);
				break;
			}
		}

		if (value == 0) {
			value = player.getSparr().get(player.getSparr().size() - 1);
		}
		return value;
	}
	@Override
	public int huoDeMP(){
		return 0;
	}
	@Override
	public void huoDePaiXing(){}
}
