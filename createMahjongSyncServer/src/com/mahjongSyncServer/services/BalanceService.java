package com.mahjongSyncServer.services;

import java.util.ArrayList;
import java.util.List;

import com.mahjongSyncServer.model.Balance;
import com.mahjongSyncServer.util.HuPai;
import com.mahjongSyncServer.util.UtilProperties;

public class BalanceService {
	public int baseNum = UtilProperties.instance.getRoomNo();

	public List<Balance> balanceList;
	public int maxFunnum = UtilProperties.instance.getMaxFannum();

	
	public BalanceService(){
		balanceList = new  ArrayList<Balance>();
	}

	public PlayerService findUserByAzimuth(ArrayList<PlayerService> playerServices, int playerAzimuth) {
		PlayerService playerService = null;
		for (int i = 0; i < playerServices.size(); i++) {
			if (playerServices.get(i).getPlayer().getAzimuth() == playerAzimuth) {
				playerService = playerServices.get(i);
				break;
			}
		}
		return playerService;
	}

	// 添加杠上炮转移信息到balanceList集合里面去
	public Balance balanceMove(int moveAzimuth1, int moveAzimuth2){
		
		double aziumthNum = 0;
		Balance balance = new Balance();
		balance.balanceName = "转移";
		
		for (int i = balanceList.size() - 1; i >= 0 ; i --) {
			if(balanceList.get(i).playerAzimuth == moveAzimuth1){
				if(moveAzimuth1 == 1){
					aziumthNum = balanceList.get(i).azimuth1;
					balance.azimuth1 = -(aziumthNum);
				}
				else if(moveAzimuth1 == 2){
					aziumthNum = balanceList.get(i).azimuth2;
					balance.azimuth2 = -(aziumthNum);
				}
				else if(moveAzimuth1 == 3){
					aziumthNum = balanceList.get(i).azimuth3;
					balance.azimuth3 = -(aziumthNum);
				}
				else if(moveAzimuth1 == 4){
					aziumthNum = balanceList.get(i).azimuth4;
					balance.azimuth4 = -(aziumthNum);
				}
				break;
			}
		}
		
		if(moveAzimuth2 == 1){
			balance.azimuth1 = aziumthNum;
		}
		else if(moveAzimuth2 == 2){
			balance.azimuth2 = aziumthNum;
		}
		else if(moveAzimuth2 == 3){
			balance.azimuth3 = aziumthNum;	
		}
		else if(moveAzimuth2 == 4){
			balance.azimuth4 = aziumthNum;
		}
		balanceList.add(balance);
		return balance;
	}
	
	// 杠结算
	public void balanceGang(int lastPlayerAzimuth, int thisPlayerAzimuth,
			ArrayList<PlayerService> playerServices, boolean haveWanGang) {
		Balance balance = new Balance();
		balance.playerAzimuth = thisPlayerAzimuth;
		if (lastPlayerAzimuth == thisPlayerAzimuth ) {
			int fanNum = 1;	// 默认值为1  弯杠为1 ， 暗杠为2
			
			if(!haveWanGang){	// 如果是暗杠
				fanNum = 2;
				balance.balanceName = "下雨";
			}
			else{
				balance.balanceName = "刮风";
				balance.haveWanGang = haveWanGang;
			}
			
			
			switch (thisPlayerAzimuth) {
			case 1:
				if (!findUserByAzimuth(playerServices, 2).getPlayer().getIshu()) {
					balance.azimuth2 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 3).getPlayer().getIshu()) {
					balance.azimuth3 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 4).getPlayer().getIshu()) {
					balance.azimuth4 = -baseNum * fanNum;
				}
				balance.azimuth1 = -(balance.azimuth2 + balance.azimuth3 + balance.azimuth4);
				break;

			case 2:
				if (!findUserByAzimuth(playerServices, 1).getPlayer().getIshu()) {
					balance.azimuth1 = -baseNum * fanNum;;
				}

				if (!findUserByAzimuth(playerServices, 3).getPlayer().getIshu()) {
					balance.azimuth3 = -baseNum * fanNum;;
				}

				if (!findUserByAzimuth(playerServices, 4).getPlayer().getIshu()) {
					balance.azimuth4 = -baseNum * fanNum;;
				}
				balance.azimuth2 = -(balance.azimuth1 + balance.azimuth3 + balance.azimuth4);
				break;

			case 3:
				if (!findUserByAzimuth(playerServices, 1).getPlayer().getIshu()) {
					balance.azimuth1 = -baseNum * fanNum;;
				}

				if (!findUserByAzimuth(playerServices, 2).getPlayer().getIshu()) {
					balance.azimuth2 = -baseNum * fanNum;;
				}

				if (!findUserByAzimuth(playerServices, 4).getPlayer().getIshu()) {
					balance.azimuth4 = -baseNum * fanNum;;
				}
				balance.azimuth3 = -(balance.azimuth1 + balance.azimuth2 + balance.azimuth4);
				break;

			case 4:
				if (!findUserByAzimuth(playerServices, 1).getPlayer().getIshu()) {
					balance.azimuth1 = -baseNum * fanNum;;
				}

				if (!findUserByAzimuth(playerServices, 2).getPlayer().getIshu()) {
					balance.azimuth2 = -baseNum * fanNum;;
				}

				if (!findUserByAzimuth(playerServices, 3).getPlayer().getIshu()) {
					balance.azimuth3 = -baseNum * fanNum;;
				}
				balance.azimuth4 = -(balance.azimuth1 + balance.azimuth2 + balance.azimuth3);
				break;
			}
		} else {
			balance.balanceName = "下雨";
			switch (lastPlayerAzimuth) {
			case 1:
				balance.azimuth1 = -(2 * baseNum);
				break;
			case 2:
				balance.azimuth2 = -(2 * baseNum);
				break;
			case 3:
				balance.azimuth3 = -(2 * baseNum);
				break;
			case 4:
				balance.azimuth4 = -(2 * baseNum);
				break;
			}

			switch (thisPlayerAzimuth) {
			case 1:
				balance.azimuth1 = 2 * baseNum;
				break;
			case 2:
				balance.azimuth2 = 2 * baseNum;
				break;
			case 3:
				balance.azimuth3 = 2 * baseNum;
				break;
			case 4:
				balance.azimuth4 = 2 * baseNum;
				break;
			}
		}
		balanceList.add(balance);
	}

	// 胡结算
	public void balanceHu(int lastPlayerAzimuth, int thisPlayerAzimuth,
			String huName, int fanNum, ArrayList<PlayerService> playerServices, boolean haveGangHua, boolean haveGangPao) {
		Balance balance = new Balance();
		if(fanNum > maxFunnum){
			fanNum = maxFunnum;
		}
		if (lastPlayerAzimuth == thisPlayerAzimuth) {
			balance.balanceName = "自摸";
			if(haveGangHua){
				balance.balanceName = "";
				balance.balanceName += "杠上花" + huName;
			}
			else if(haveGangPao){
				balance.balanceName = "";
				balance.balanceName += "杠上炮" + huName;
			}
			else{
				balance.balanceName += huName;
			}
			
			fanNum = fanNum * 2;    //自摸加一番

			if(fanNum > maxFunnum){
				fanNum = maxFunnum;
			}
			switch (thisPlayerAzimuth) {
			case 1:
				if (!findUserByAzimuth(playerServices, 2).getPlayer().getIshu()) {
					balance.azimuth2 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 3).getPlayer().getIshu()) {
					balance.azimuth3 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 4).getPlayer().getIshu()) {
					balance.azimuth4 = -baseNum * fanNum;
				}
				balance.azimuth1 = -(balance.azimuth2 + balance.azimuth3 + balance.azimuth4);
				break;

			case 2:
				if (!findUserByAzimuth(playerServices, 1).getPlayer().getIshu()) {
					balance.azimuth1 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 3).getPlayer().getIshu()) {
					balance.azimuth3 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 4).getPlayer().getIshu()) {
					balance.azimuth4 = -baseNum * fanNum;
				}
				balance.azimuth2 = -(balance.azimuth1 + balance.azimuth3 + balance.azimuth4);
				break;

			case 3:
				if (!findUserByAzimuth(playerServices, 1).getPlayer().getIshu()) {
					balance.azimuth1 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 2).getPlayer().getIshu()) {
					balance.azimuth2 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 4).getPlayer().getIshu()) {
					balance.azimuth4 = -baseNum * fanNum;
				}
				balance.azimuth3 = -(balance.azimuth1 + balance.azimuth2 + balance.azimuth4);
				break;

			case 4:
				if (!findUserByAzimuth(playerServices, 1).getPlayer().getIshu()) {
					balance.azimuth1 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 2).getPlayer().getIshu()) {
					balance.azimuth2 = -baseNum * fanNum;
				}

				if (!findUserByAzimuth(playerServices, 3).getPlayer().getIshu()) {
					balance.azimuth3 = -baseNum * fanNum;
				}
				balance.azimuth4 = -(balance.azimuth1 + balance.azimuth2 + balance.azimuth3);
				break;
			}
		} else {
			balance.balanceName = "放炮";
			if(haveGangHua){
				balance.balanceName = "";
				balance.balanceName += "杠上花" + huName;
			}
			else if(haveGangPao){
				balance.balanceName = "";
				balance.balanceName += "杠上炮" + huName;
			}
			else{
				balance.balanceName += huName;
			}
			
			switch (lastPlayerAzimuth) {
			case 1:
				balance.azimuth1 = -baseNum * fanNum;
				break;
			case 2:
				balance.azimuth2 = -baseNum * fanNum;
				break;
			case 3:
				balance.azimuth3 = -baseNum * fanNum;
				break;
			case 4:
				balance.azimuth4 = -baseNum * fanNum;
				break;
			}

			switch (thisPlayerAzimuth) {
			case 1:
				balance.azimuth1 = baseNum * fanNum;
				break;
			case 2:
				balance.azimuth2 = baseNum * fanNum;
				break;
			case 3:
				balance.azimuth3 = baseNum * fanNum;
				break;
			case 4:
				balance.azimuth4 = baseNum * fanNum;
				break;
			}
		}
		balanceList.add(balance);
	}

	// 赔叫结算
	public void balancePeiHu(ArrayList<PlayerService> playerServices) {
		Balance balance = new Balance();
		balance.balanceName = "赔叫";
		
		for(int i=0;i < playerServices.size();i ++){
			if(!playerServices.get(i).getPlayer().getIshu()){
				if(HuPai.checkJiao(playerServices.get(i)) != null){
					
					int fanNum = Integer.valueOf(HuPai.checkJiao(playerServices.get(i))[1]);
					//返回最大翻
					if(fanNum > maxFunnum){
						fanNum = maxFunnum;
					}
					
					playerServices.get(i).getPlayer().setFannum(fanNum);
					playerServices.get(i).getPlayer().setHaveJiao(fanNum == 0 ? false : true);
					
				}
			}
		}
		
		for(int i=0;i < playerServices.size();i ++){
			for(int j=0;j < playerServices.size();j ++){	
				if((!playerServices.get(i).getPlayer().getIshu() && playerServices.get(i).getPlayer().getHaveJiao()) 
					&& (!playerServices.get(j).getPlayer().getIshu() && !playerServices.get(j).getPlayer().getHaveJiao())){
					int peiNum = playerServices.get(i).getPlayer().getPeinum() + 
											(playerServices.get(i).getPlayer().getFannum()* this.baseNum);
					playerServices.get(i).getPlayer().setPeinum(peiNum);
					peiNum = playerServices.get(j).getPlayer().getPeinum() + 
											(-playerServices.get(i).getPlayer().getFannum()* this.baseNum);
					playerServices.get(j).getPlayer().setPeinum(peiNum);
					
					for (int k = 0; k < balanceList.size(); k++) {	// 查找没有下叫的用户，同时把没下叫的用户的所有杠牌结算移除
						//System.out.println(balanceList.get(k).balanceName + " === " + balanceList.get(k).playerAzimuth + "   , " + balanceList.get(k).azimuth1 + " , " + balanceList.get(k).azimuth2 + " , " + balanceList.get(k).azimuth3 + " , " + balanceList.get(k).azimuth4);
						if(balanceList.get(k).playerAzimuth == playerServices.get(j).getPlayer().getAzimuth()){
							balanceList.remove(k);
							k --;
						}
					}
				}
			}
		}
		
		boolean haveJiao = false;
		int huNum = 0;
		for(int i=0;i < playerServices.size();i ++){	// 检测所有没有胡牌用户是否有叫
			if(playerServices.get(i).getPlayer().getIshu()){
				huNum ++;
			}
			if(!playerServices.get(i).getPlayer().getIshu() && playerServices.get(i).getPlayer().getHaveJiao()){
				haveJiao = true;
				break;
			}
		}
		
		if(!haveJiao && huNum < 3){// 最后赔叫时，如果没有胡牌的几个用户都没有叫，则删除所有杠牌记录
			for(int i=0;i < playerServices.size();i ++){		
				for (int j = 0; j < balanceList.size(); j++){
					if(!playerServices.get(i).getPlayer().getIshu() && !playerServices.get(i).getPlayer().getHaveJiao()){
						if(balanceList.get(j).playerAzimuth == playerServices.get(i).getPlayer().getAzimuth()){
							balanceList.remove(j);
							j --;
						}
					}
				}
			}
		}
		
		balance.azimuth1 = playerServices.get(0).getPlayer().getPeinum();
		balance.azimuth2 = playerServices.get(1).getPlayer().getPeinum();
		balance.azimuth3 = playerServices.get(2).getPlayer().getPeinum();
		balance.azimuth4 = playerServices.get(3).getPlayer().getPeinum();
		
		if(balance.azimuth1 != 0 || balance.azimuth2 != 0 || balance.azimuth3 != 0 || balance.azimuth4 != 0){
			balanceList.add(balance);
		}

	}
}
