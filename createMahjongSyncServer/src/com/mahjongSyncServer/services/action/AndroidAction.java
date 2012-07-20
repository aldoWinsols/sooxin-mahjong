package com.mahjongSyncServer.services.action;

import java.util.ArrayList;

import com.mahjongSyncServer.model.Message;
import com.mahjongSyncServer.util.HuPai;
import com.mahjongSyncServer.util.Util;

public class AndroidAction extends BaseAction {

	private int qingyiseType = 0;
	private int transformersPeiXing = 0;
	
	public ArrayList<String> getOperationName(int azimuth, int value, int valueType){
		ArrayList<String> res = new ArrayList<String>();
		if(valueType == 0 && getPlayer().getAzimuth() != azimuth){
			if(checkHu(value) && (judgeMahjongList() || checkHaveNum(value) < 2)){
				if(this.checkFangHu(value)){
					res.add("hu");
				}
			}
			if(checkGang(value)){
				res.add("gang");
			}
			if(!haveQiDui() && haveQingyisePeng(value) && !havePengGuize(value)){
				if(checkPeng(value)){
					res.add("peng");
				}
			}
			
			if(res.size() > 0){
				return res;
			}
		}else if(valueType == 1 && getPlayer().getAzimuth() == azimuth){
			if(!checkGang(value, false).equals("")){
				res.add("zigang");
				getPlayer().setZigangValue(huoDeZiGangValue(value));
			}
			if(checkHu(true)){
				res.add("zihu");
			}
			if(res.size() > 0){
				return res;
			}
		}
		if(getPlayer().getDingzhangValue() == -1){		//玩家定章
			res.add("dingzhang");
			return res;
		}
		if(res.size() == 0){
			if(getPlayer().getSparr().size() == 2 || getPlayer().getSparr().size() == 5 || getPlayer().getSparr().size() == 8
					|| getPlayer().getSparr().size() == 11 || getPlayer().getSparr().size() == 14){
				res.add("putOneMahjong");
			}
		}
		
		if(res.size() == 0 && getPlayer().getAzimuth() == azimuth){
			if(getPlayer().getSparr().size() == 1 || getPlayer().getSparr().size() == 4 || getPlayer().getSparr().size() == 7
					|| getPlayer().getSparr().size() == 10 || getPlayer().getSparr().size() == 13){
				res.add("getOneMahjong");
			}
		}
		return res;
	}
	/**
	 * 随机生成一个数与剩余的牌堆比较
	 * @return
	 */
	private boolean judgeMahjongList(){
		
		if(getRoom().getMahjongList().size() < (Math.round(Math.random()*4)+32)){
			return true;
		}
		
		return false;
	}
	/**
	 * 检查出牌里是否有某牌
	 * @param value
	 * @return
	 */
	private boolean checkHaveInOutarr(int value){
		for(int i=0; i<getPlayer().getOutarr().size(); i++){
			if(getPlayer().getOutarr().get(i) == value){
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
	private boolean havePengGuize(int value){
		
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
	private boolean haveQingyisePeng(int value){
		
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
	private boolean haveQiDui(){
		
		for(int i=1; i < 30; i ++){
			ArrayList<Integer> list = new ArrayList<Integer>(getPlayer().getSparr());
			if(i != 10 && i != 20){
				list.add(i);
			}
			Util.sort(list);
			String result = HuPai.getHuResult(list, getPlayer().getPparr(), getPlayer().getGparr())[1];
			if(result.contains("七对")){
				return true;
			}
		}
		
		return false;
	}
	
	/**
	 * 获得机器人的牌型
	 * @param sparr1
	 */
	public void huoDePaiXing(){
		
		ArrayList<Integer> allArr = new ArrayList<Integer>(getPlayer().getSparr());
		allArr.addAll(getPlayer().getPparr());
		allArr.addAll(getPlayer().getGparr());
		
		//  查找是否能够做成清一色
		int wannum = 0;
		int tongnum = 0;
		int tiaonum = 0;
		for(int i=0;i < allArr.size(); i++){
			if(allArr.get(i) < 10){
				wannum ++;
			}else if(allArr.get(i) > 10 && allArr.get(i) < 20){
				tongnum ++;
			}else if(allArr.get(i) > 20 && allArr.get(i) < 30){
				tiaonum ++;
			}
		}
		
		//如果万字大于10，并且碰杠里面没有万字 且桌上的牌个数大于8张
		if((wannum > 10) && checkHaveSortInPG(0) && (getRoom().getMahjongList().size() > 8)){
			transformersPeiXing = 1;
			qingyiseType = 0;
		}
		//如果筒字大于10，并且碰杠里面没有筒字 且桌上的牌个数大于8张
		else if((tongnum > 10) && checkHaveSortInPG(10)  && (getRoom().getMahjongList().size() > 8)){
			transformersPeiXing = 1;
			qingyiseType = 10;
		//如果条字大于10，并且碰杠里面没有条字 且桌上的牌个数大于8张
		}else if((tiaonum > 10) && checkHaveSortInPG(20)  && (getRoom().getMahjongList().size() > 8)){
			transformersPeiXing = 1;
			qingyiseType = 20;
		}else{
			transformersPeiXing = 0;
			qingyiseType = 30;
		}
	}
	
	//检查碰杠里没有此类型的牌
	public boolean checkHaveSortInPG(int value){
		for(int i=0; i<getPlayer().getPparr().size(); i++){
			if((value/10) != (getPlayer().getPparr().get(i)/10)){
				return false;
			}
		}
		
		for(int j=0; j<getPlayer().getGparr().size(); j++){
			if((value/10) != (getPlayer().getGparr().get(j)/10)){
				return false;
			}
		}
		
		return true;
	}

	public int officialTransformerPutOneMahjong() {
		int value = 0;

		if (getPlayer().getSparr().size() == 2 || 
				getPlayer().getSparr().size() == 5 || 
				getPlayer().getSparr().size() == 8 || 
				getPlayer().getSparr().size() == 11 || 
				getPlayer().getSparr().size() == 14) {

			for (int i = 0; i < getPlayer().getSparr().size(); i++) {
				if (getPlayer().getSparr().get(i) / 10 == getPlayer().getDingzhangValue() / 10) {
					value = getPlayer().getSparr().get(i);
					break;
				}
			}

			if (value == 0) {
				value = huoDeDP();
			}

		}

		return value;
	}
	//获得最该摸的牌
	public int huoDeMP(){
		ArrayList<Integer> xp = huoDeXP1();
		
		//删除定张类牌
		for(int j=0; j<xp.size(); j++){
			if((xp.get(j) / 10) == (getPlayer().getDingzhangValue() / 10)){
				xp.remove(j);
			}
		}
			
		for(int i=0; i<xp.size()-1; i++){
			if(xp.get(i) / 10 != getPlayer().getDingzhangValue() / 10){
				if(xp.get(i) == (xp.get(i+1)-1)){
					if(quMahjongInMahjongs(xp.get(i)-1)){
						return xp.get(i)-1;
					}
					
					if(quMahjongInMahjongs(xp.get(i)+1)){
						return xp.get(i)+1;
					}
				}else if(xp.get(i) == (xp.get(i+1)-2)){
					if(quMahjongInMahjongs(xp.get(i)+1)){
						return xp.get(i)+1;
					}
				}else{
					i++;
				}
			}else{
				
			}
		}
		
		//2010-10-17 14:54 s
		for(int i=xp.size() - 1; i>= 0; i--){
			if(xp.get(i) / 10 != getPlayer().getDingzhangValue() / 10){
				if(quMahjongInMahjongs(xp.get(i) - 1)){
					return xp.get(i) - 1;
				}
				
				if(quMahjongInMahjongs(xp.get(i) + 1)){
					return xp.get(i) + 1;
				}
				
				if(quMahjongInMahjongs(xp.get(i))){
					return xp.get(i);
				}
			}
			
		}
		
		return 0;
	}
	//获得闲牌 3，4不排开，供摸牌的时候找相关需要的牌用
	private ArrayList<Integer> huoDeXP1(){
		
		int xx = 0;// -将的个数
		int abc = 0;// 刻,顺的个数

		ArrayList<Integer> ja = new ArrayList<Integer>();// 将A的位置.
		ArrayList<Integer> jb = new ArrayList<Integer>();// 将B的位置.
		
		ArrayList<Integer> xp = new ArrayList<Integer>();// 将B的位置.
		
		ArrayList<Integer> mj = new ArrayList<Integer>(getPlayer().getSparr());
		Util.sort(mj);

		ArrayList<Integer> tempmj = new ArrayList<Integer>();

		tempmj.addAll(mj);
		// mj = tempmj.slice(0, 13);
		
		for (int i = 0; i < getPlayer().getSparr().size(); i++) {
			for (int j = i; j < getPlayer().getSparr().size(); j++) {
				for (int n = j; n < getPlayer().getSparr().size(); n++) {

					if (i != j && j != n && i != n
							&& mj.get(i) == mj.get(j)
							&& mj.get(j) == mj.get(n) && mj.get(i) != -1) {

						abc += 1;
						mj.set(i, -1);
						mj.set(j, -1);
						mj.set(n, -1);
					}
				}
			}
		}
		for (int i = 0; i < getPlayer().getSparr().size(); i++) {
			for (int j = i; j < getPlayer().getSparr().size(); j++) {
				for (int n = j; n < getPlayer().getSparr().size(); n++) {

					if (i != j && j != n && i != n && mj.get(i) != -1
							&& mj.get(j) != -1 && mj.get(n) != -1) {

						int a = mj.get(i);
						int b = mj.get(j);
						int c = mj.get(n);
						int temp = 0;
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
							mj.set(i, -1);
							mj.set(j, -1);
							mj.set(n, -1);
						}
					}
				}
			}
		}
		
		// 找将
		for (int i = 0; i < getPlayer().getSparr().size(); i++) {
			for (int j = i; j < getPlayer().getSparr().size(); j++) {
				if (i != j && mj.get(i) == mj.get(j) && mj.get(i) != -1) {
					ja.add(i);
					jb.add(j);
					mj.set(i, -1);
					mj.set(j, -1);
					xx++;

				}
			}
		}
		
		for(int i=0; i <mj.size(); i++){
			if(mj.get(i) != -1){
				if(checkHaveNum(mj.get(i)) != 3){
					xp.add(mj.get(i));
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
	private boolean quMahjongInMahjongs(int mahjongValue){
		for(int i=0; i<getRoom().getMahjongList().size(); i++){
			if(getRoom().getMahjongList().get(i) == mahjongValue){
				return true;
			}
		}
		return false;
	}
	/**
	 * 获得闲牌
	 * @return
	 */
	private int huoDeDP(){

		ArrayList<Integer> mj = new ArrayList<Integer>(getPlayer().getSparr());
		Util.sort(mj);
		
		//----------------------------------------
		//判断是否是清一色，如果是清一色并且有叫，再判断最后摸起来的一张牌是不是跟当前清一色的牌色相同，如果不相同，就把最后一张牌的值返回
		//g 2010-10-12 16:49
		ArrayList<Integer> newSparr = new ArrayList<Integer>(getPlayer().getSparr());
		newSparr.remove(newSparr.size() - 1);
		if(HuPai.checkQys(newSparr, getPlayer().getPparr(), getPlayer().getGparr()) && ((getPlayer().getSparr().get(0)) / 10 != (getPlayer().getSparr().get(getPlayer().getSparr().size() - 1) / 10))){
			//获得手上牌是否有叫，返回小于15的数字表示有叫，等于15表示没有叫
			int qysxiajiao = huodeXiajiaoPai();		
			if(qysxiajiao != 15){
				return getPlayer().getSparr().get(getPlayer().getSparr().size() - 1);
			}
		}
		//-----------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//如果可以打清一色，在打完非相关类牌后再执行下叫判断，或者不能打清一色时候就每次做下叫判断
		boolean bool = true;
		for(int i=0; i<getPlayer().getSparr().size(); i++){
			if((getPlayer().getSparr().get(i)/10) != (this.qingyiseType/10) ){
				bool = false;
				break;
			}
		}
		if(((this.transformersPeiXing == 1) && bool) || (this.transformersPeiXing == 0)){
			int xiajiaoPai = huodeXiajiaoPai();
			if(xiajiaoPai != 15){
				return getPlayer().getSparr().get(xiajiaoPai);
			}
		}
		//--------------------------------------------------------------------------
		
		ArrayList<Integer> xp = calXP();//里面包含了如果可以打清一色应该找出的闲置
		ArrayList<Integer> mj1 = new ArrayList<Integer>(mj); 
		if(xp.size() == 0) {
			for(int i=mj1.size() - 1; i >= 0; i--){
				if(mj1.get(i) != -1){
					return mj1.get(i);
				}
			}
		}else{

			//如找出的闲牌为 2，3  5，7 则考虑打5,7 2247应该打7
			for(int i=0;i<xp.size();i++){
				if(xp.get(i) != (xp.get(i)+1)){
					
					//2010-10-19 19:06
					//如手上的牌123243435465464 11,11,12 ，可以做清一色，但撤11,11,12，先撤12打，按以前的规则就会打11
					if(this.transformersPeiXing == 1){
						for(int j=0; j < xp.size(); j ++){
							if(xp.get(j)/10 != this.qingyiseType/10){
								if(checkHaveNum(xp.get(j))<2){
									return xp.get(j);
								}
							}
						}
					}
					
					//-------------------------------------------------------------------
					// 打牌之前是碰牌的话，就判断闲牌里面是否有大于（小于）1个数或者2个数跟碰牌值比较，如果有就返回这一张牌
					// 2010-10-24 00:58 s
					//如688，前面是碰的话，并且这个时候检查6为闲牌，就把6打出去
					Message msg = getRoom().getHistoryMessage().get(getRoom().getHistoryMessage().size() - 1);
					if(msg.getHead().equals("pengI")){
						ArrayList<Object> list = (ArrayList<Object>)msg.getContent();
						for(int j=0;j<xp.size();j++){
							if(Integer.valueOf(list.get(1).toString()) - 1 == xp.get(j) || 
									Integer.valueOf(list.get(1).toString()) - 2 == xp.get(j) || 
									Integer.valueOf(list.get(1).toString()) + 1 == xp.get(j) || 
									Integer.valueOf(list.get(1).toString()) + 2 == xp.get(j)){
								return xp.get(j);
							}
						}
					}
					
					//22345的情况，本身检查2,5为闲牌，但这里不为闲牌，做为修正
					//这里判断必须先于 124 689 的判断，不然两者有冲突
					//2010-10-19 18:47 s
					if((xp.size() - i) >=2){
						if(xp.get(i+1)/10 == xp.get(i)/10){
							if((xp.get(i+1)-xp.get(i) == 3) && (checkHaveNum(xp.get(i)) == 2) && (checkHaveNum(xp.get(i)+1) == 1) && (checkHaveNum(xp.get(i)+2) == 1)){
								i++;
								continue;
							}
						}
					}
					
					// 例如1，2,4 打1  2010-10-17 18:32 g
					if(xp.get(i) == 4 || xp.get(i) == 14 || xp.get(i) == 24){
						if(checkHaveNum(xp.get(i) - 3) == 1){
							return xp.get(i) - 3;
						}
					}
					// 例如6，8,9 打9  2010-10-17 18:32g
					if(xp.get(i) == 6 || xp.get(i) == 16 || xp.get(i) == 26){
						if(checkHaveNum(xp.get(i) + 3) == 1){
							return xp.get(i) + 3;
						}
					}

					//3456的情况，本身检查6为闲牌，但这里不首先为闲牌，如果找不到更好的闲牌，再打，做为修正
					//2010-10-19 18:47 s
					if((xp.size() - i) >=2){
						if(xp.get(i+1)/10 == xp.get(i)/10){
							if((checkHaveNum(xp.get(i)-1) > 0) || (checkHaveNum(xp.get(i)-2) > 0)){
								return xp.get(i+1);
							}
						}
					}
					
					//-------------------------------------------------------------------
					if((checkHaveNum(xp.get(i)-1) < 2) && (checkHaveNum(xp.get(i)+1) < 2) && (checkHaveNum(xp.get(i)-2) < 2) && (checkHaveNum(xp.get(i)+2) < 2)){
						return xp.get(i);
					}
				}else{
					i++;
				}
			}
			return xp.get(xp.size() - 1);
		}
		return getPlayer().getSparr().get(0);
    }
	
	//------------------------------------------------------------------
	//机器人打什么牌下叫最合适
	//获得下叫打什么牌最好
	private int huodeXiajiaoPai(){
		int maxGailv = 0;
		int shouldPutWeizhi = 15;
//		
		
		//判断下叫的个数不能大于最初的下叫个数，就按照最初的下叫个数来出牌
		//---------------------获得手上最初的下叫个数
		ArrayList<Integer> newSparr = new ArrayList<Integer>(getPlayer().getSparr());
		newSparr.remove(newSparr.size() - 1);
		maxGailv = huodeHupaiGailv(newSparr);
		if(maxGailv > 0){	//如果下叫个数大于0把最后一张牌的索引保存下来
			shouldPutWeizhi = getPlayer().getSparr().size() - 1;
		}
		//----------------------------------------
		
		ArrayList<Integer> mj;
		for(int i=0; i<getPlayer().getSparr().size(); i++){
			mj = new ArrayList<Integer>(getPlayer().getSparr());
			mj.remove(i);
			
			int gailv = huodeHupaiGailv(mj);
			
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
	private int huodeHupaiGailv(ArrayList<Integer> sp){
		int gailv = 0;
		
		for(int i=1; i<29; i++){
			ArrayList<Integer> mj = new ArrayList<Integer>(sp);
			if((i!=10) && (i!=20)){
				mj.add(i);
				Util.sort(mj);
				
				if(HuPai.checkHu(mj)){
					gailv += findMahjongNum(i);
				}
			}
		}
		
		return gailv;
	}
	
	private int findMahjongNum(int m){
		int num = 0;
		for(int i=0; i<getRoom().getMahjongList().size();i++){
			if(getRoom().getMahjongList().get(i) == m){
				num++;
			}
		}
		return num;
	}
	
	public ArrayList<Integer> calXP(){
		int xx = 0;// -将的个数
		int abc = 0;// 刻,顺的个数

		ArrayList<Integer> ja = new ArrayList<Integer>();// 将A的位置.
		ArrayList<Integer> jb = new ArrayList<Integer>();// 将B的位置.
		
		ArrayList<Integer> xp = new ArrayList<Integer>();// 将B的位置.
		
		ArrayList<Integer> mj = new ArrayList<Integer>(this.getPlayer().getSparr());
		Util.sort(mj);

		
		//--------------------------------------------------------------------
		if(transformersPeiXing == 1){
			ArrayList<Integer> mm = new ArrayList<Integer>();// 将B的位置.
			for (int i = 0; i < this.getPlayer().getSparr().size(); i++) {
				if((this.getPlayer().getSparr().get(i) / 10) != (qingyiseType / 10)){
					
					mm.add(this.getPlayer().getSparr().get(i));
					
				}
			}
			if(mm.size()>0){
				return mm;
			}
		}

		ArrayList<Integer> tempmj = new ArrayList<Integer>();

		tempmj.addAll(mj);
		// mj = tempmj.slice(0, 13);
		
		for (int i = 0; i < this.getPlayer().getSparr().size(); i++) {
			for (int j = i; j < this.getPlayer().getSparr().size(); j++) {
				for (int n = j; n < this.getPlayer().getSparr().size(); n++) {

					if (i != j && j != n && i != n
							&& mj.get(i) == mj.get(j)
							&& mj.get(j) == mj.get(n) && mj.get(i) != -1) {

						abc += 1;
						mj.set(i, -1);
						mj.set(j, -1);
						mj.set(n, -1);
					}
				}
			}
		}
		for (int i = 0; i < this.getPlayer().getSparr().size(); i++) {
			for (int j = i; j < this.getPlayer().getSparr().size(); j++) {
				for (int n = j; n < this.getPlayer().getSparr().size(); n++) {

					if (i != j && j != n && i != n && mj.get(i) != -1
							&& mj.get(j) != -1 && mj.get(n) != -1) {

						int a = mj.get(i);
						int b = mj.get(j);
						int c = mj.get(n);
						int temp = 0;
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
							mj.set(i, -1);
							mj.set(j, -1);
							mj.set(n, -1);
						}
					}
				}
			}
		}
		
		// 找将
		for (int i = 0; i < this.getPlayer().getSparr().size(); i++) {
			for (int j = i; j < this.getPlayer().getSparr().size(); j++) {
				if (i != j && mj.get(i) == mj.get(j) && mj.get(i) != -1) {
					ja.add(i);
					jb.add(j);
					mj.set(i, -1);
					mj.set(j, -1);
					xx++;

				}
			}
		}
		
		ArrayList<Integer> mj1 = new ArrayList<Integer>(mj);
		
		for(int i=0;i < this.getPlayer().getSparr().size(); i++){
			for(int j=i;j < this.getPlayer().getSparr().size(); j++){
				if(i != j && mj.get(i) != -1 && mj.get(j) != -1 
						&& mj.get(i) / 10 == mj.get(j) / 10
						&& Math.abs(mj.get(i) - mj.get(j)) < 2){
					mj.set(i, -1);
					mj.set(j, -1);
				}
			}
		}
		
		int num = 0;
		for(int i=0; i <mj.size(); i++){
			if(mj.get(i) != -1){
				num ++;
				if(checkHaveNum(mj.get(i)) != 3){
					xp.add(mj.get(i));
				}
			}
		}
		if(num == 0) {
			for(int i=0; i <mj1.size(); i++){
				if(mj1.get(i) != -1){
					xp.add(mj1.get(i));
				}
			}
		}
		return xp;
	}
	
	//查看手上有多少个一样的
	private int checkHaveNum(int value){
		int num = 0;
		for(int i=0; i<this.getPlayer().getSparr().size(); i++){
			if(this.getPlayer().getSparr().get(i) == value){
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
	private int huoDeZiGangValue(int value){
		int haveNum = 0;
		
		for (int i = 0; i < getPlayer().getPparr().size(); i = i + 3) {
			if (getPlayer().getPparr().get(i) == value && value / 10 != getPlayer().getDingzhangValue() / 10) { // 用手牌和碰牌数组比较，是否有杠,并且不是定章类
				return getPlayer().getPparr().get(i).intValue();
			}
		}
		
		for (int i = 0; i < getPlayer().getSparr().size(); i++) {
			haveNum = 0;
			for (int j = 0; j < getPlayer().getSparr().size(); j++) {
				if (getPlayer().getSparr().get(i) == getPlayer().getSparr().get(j)
						&& (getPlayer().getSparr().get(i) / 10 != getPlayer().getDingzhangValue() / 10)) {// 手上的牌循环比较，是否有相同的4张牌，并且不是定章类
					haveNum++;
					if (haveNum == 4) {
						return getPlayer().getSparr().get(i).intValue();
					}
				}
			}
		}
		return 0;
		
	}
}
