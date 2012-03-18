package com.mahjongSyncServer.services.action;

import java.util.ArrayList;

import com.mahjongSyncServer.model.Message;

public class OfflineAction extends BaseAction {

	@Override
	public ArrayList<String> getOperationName(int azimuth, int value,
			int valueType) {
		ArrayList<String> res = new ArrayList<String>();
		if(valueType == 0 && getPlayer().getAzimuth() != azimuth){
			if(checkHu(value) && this.checkFangHu(value)){
				res.add("hu");
			}
			if(res.size() > 0){
				return res;
			}
		}else if(valueType == 1 && getPlayer().getAzimuth() == azimuth){
			if(checkHu(true)){
				res.add("zihu");
			}
			if(res.size() > 0){
				return res;
			}
		}else if(valueType == 3){
			if(getPlayer().getIsDealOver() &&
					getPlayer().getDingzhangValue() == -1){		//玩家定章
				res.add("dingzhang");
				return res;
			}else if(!getPlayer().getIsDealOver()){
				res.add("dealOver");
				return res;
			}
			
			int len = getRoom().getHistoryMessage().size();
			if(len > 0){
				Message lastMessage = getRoom().getHistoryMessage().get(len - 1);
				
				if(lastMessage.getHead().equals("showOperationI")){
					ArrayList<Object> list = (ArrayList<Object>) lastMessage.getContent();
					
					if(Integer.valueOf(list.get(0).toString()) == getPlayer().getAzimuth()){
						for (int i = 1; i < list.size(); i++) {
							if(list.get(i).toString().equals("zihu")){
								res.add("zihu");
								return res;
							}else if(list.get(i).toString().equals("hu")){
								res.add("hu");
								return res;
							}else if(list.get(i).toString().equals("zigang")){
								res.add("zigang");
								return res;
							}else if(list.get(i).toString().equals("gang")){
								res.add("gang");
								return res;
							}else if(list.get(i).toString().equals("peng")){
								res.add("peng");
								return res;
							}
						}
					}
				}
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
