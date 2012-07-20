package com.mahjongSyncServer.services.action;

import java.util.ArrayList;

public class OnlineAction extends BaseAction {

	@Override
	public ArrayList<String> getOperationName(int azimuth, int value,
			int valueType) {
		ArrayList<String> res = new ArrayList<String>();
		if(valueType == 0 && getPlayer().getAzimuth() != azimuth){
			if(checkPeng(value)){
				res.add("peng");
			}
			if(checkGang(value)){
				res.add("gang");
			}
			if(checkHu(value) && this.checkFangHu(value)){
				res.add("hu");
			}
			if(res.size() > 0){
				return res;
			}
		}else if(valueType == 1 && getPlayer().getAzimuth() == azimuth){
			if(!checkGang(value, false).equals("")){
				res.add("zigang");
				getPlayer().setZigangValue(value);
			}
			if(checkHu(true)){
				res.add("zihu");
			}
			if(res.size() > 0){
				return res;
			}
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
}
