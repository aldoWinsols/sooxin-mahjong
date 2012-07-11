package com.mahjongSyncServer.dataServices;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;

import com.mahjongSyncServer.model.Balance;
import com.mahjongSyncServer.model.Message;
import com.mahjongSyncServer.model.Player;
import com.mahjongSyncServer.services.BalanceService;
import com.mahjongSyncServer.services.PlayerService;
import com.mahjongSyncServer.util.ConstClass;
import com.mahjongSyncServer.util.DateUtils;
import com.mahjongSyncServer.util.UtilProperties;

/**
 * 
 * @author Administrator
 * 2012-3-5 14:09 gmr start 保存玩家扣除的金额
 */
public class DataService {
	private Logger log = null;
	private RemoteService remoteService = null;
	public DataService(){
		log = UtilProperties.instance.getLogger(DataService.class);
		remoteService = new RemoteService();
	}
	
	public boolean balance(ArrayList<PlayerService> playerServices,
			BalanceService balanceService, ArrayList<Message> histuryMessages) throws Exception{

		boolean haveException = false;
		getZongjiByPlayerAzimuth(playerServices, balanceService.balanceList);

		for (int i = 0; i < playerServices.size(); i++) {
			playerServices.get(i).getPlayer().getPlayLog().setPlayerName(playerServices.get(i).getPlayer().getPlayerName());
			if(playerServices.get(i).getPlayer().getPlayerType() < 3){			//小于3表示  不是机器人
				playerServices.get(i).getPlayer().getPlayLog().setGameIp(playerServices.get(i).getPlayer().getUserIp());
				
				// 2012-3-5 14:09 gmr start 保存玩家扣除的金额
				playerServices.get(i).getPlayer().getPlayLog().setAllTouZhuMoney((double)UtilProperties.instance.getLimitMoney());
				// 2012-3-5 14:09 gmr end
			}else{
				playerServices.get(i).getPlayer().getPlayLog().setGameIp("127.0.0.1");
				
				// 2012-3-5 14:09 gmr start 保存玩家扣除的金额
				playerServices.get(i).getPlayer().getPlayLog().setAllTouZhuMoney(0.0);
				// 2012-3-5 14:09 gmr end
			}
			switch (balanceService.baseNum) {
				// V1.8 2011-8-24
				case 5:
					playerServices.get(i).getPlayer().getPlayLog().setGameSubClass(5);
					break;
				case 10:
					playerServices.get(i).getPlayer().getPlayLog().setGameSubClass(10);
					break;
				case 20:
					playerServices.get(i).getPlayer().getPlayLog().setGameSubClass(20);
					break;
				case 50:
					playerServices.get(i).getPlayer().getPlayLog().setGameSubClass(50);
					break;
				case 100:
					playerServices.get(i).getPlayer().getPlayLog().setGameSubClass(100);
					break;
				case 1000:
					playerServices.get(i).getPlayer().getPlayLog().setGameSubClass(1000);
					break;
				case 2000:
					playerServices.get(i).getPlayer().getPlayLog().setGameSubClass(2000);
					break;
				case 5000:
					playerServices.get(i).getPlayer().getPlayLog().setGameSubClass(5000);
					break;
			}
			playerServices.get(i).getPlayer().getPlayLog().setGameName(ConstClass.mahjong + balanceService.baseNum);
			playerServices.get(i).getPlayer().getPlayLog()
					.setGameNo(String.valueOf(playerServices.get(i).getPlayer().getRoomNo()));
			playerServices.get(i).getPlayer().getPlayLog().setGameTime(DateUtils
					.parser2Timestamp(new Date()));

			playerServices.get(i).getPlayer().getPlayLog().setPreMoney(playerServices.get(i).getPlayer().getHaveMoney());
			playerServices.get(i).getPlayer().getPlayLog()
					.setWinLossMoneyBeforeTax(playerServices.get(i).getPlayer().getChangeMoney());// 用户的输赢

			double changeMoney = playerServices.get(i).getPlayer().getChangeMoney() > 0 ? playerServices
					.get(i).getPlayer().getChangeMoney() * 0.95 : playerServices.get(i).getPlayer().getChangeMoney();

			playerServices.get(i).getPlayer().setChangeMoney(changeMoney); 
			
			log.info("局号： " + playerServices.get(i).getPlayer().getRoomNo() + "， 玩家 " + playerServices.get(i).getPlayer().getPlayerName() + "输赢 ： " + playerServices.get(i).getPlayer().getChangeMoney());
			playerServices.get(i).getPlayer().getPlayLog().setAfterMoney(playerServices.get(i).getPlayer().getHaveMoney()
					+ playerServices.get(i).getPlayer().getChangeMoney());
			playerServices.get(i).getPlayer().getPlayLog().setGameContent(getHistoryMessage(
					histuryMessages, playerServices, balanceService));

			playerServices.get(i).getPlayer().setHaveMoney(playerServices.get(i).getPlayer().getHaveMoney() - playerServices.get(i).getPlayer().getChangeMoney());
			
			playerServices.get(i).getPlayer().setBalance(true);
		}

		try {
			remoteService.getBalanceChessGameService().balanceMajong(
					playerServices.get(0).getPlayer().getPlayLog(), playerServices.get(1).getPlayer().getPlayLog(),
					playerServices.get(2).getPlayer().getPlayLog(), playerServices.get(3).getPlayer().getPlayLog());
		} catch (Exception e) {
			e.printStackTrace();
			haveException = true;
			for (int i = 0; i < playerServices.size(); i++) {
				if (playerServices.get(i).getPlayer().getIServer().isConnected()) {
					playerServices.get(0).sendServerExceptionMessage(e.toString());
				}
			}
			throw new Exception(e.toString());
		}

		return haveException;
	}
	
	private void getZongjiByPlayerAzimuth(ArrayList<PlayerService> playerServices,
			List<Balance> balanceList) {
		for (int j = 0; j < balanceList.size(); j++) {
			int i = 0;
			Player player = playerServices.get(i++).getPlayer();
			player.setChangeMoney(player.getChangeMoney() + balanceList.get(j).azimuth1);
			player = playerServices.get(i++).getPlayer();
			player.setChangeMoney(player.getChangeMoney() + balanceList.get(j).azimuth2);
			player = playerServices.get(i++).getPlayer();
			player.setChangeMoney(player.getChangeMoney() + balanceList.get(j).azimuth3);
			player = playerServices.get(i++).getPlayer();
			player.setChangeMoney(player.getChangeMoney() + balanceList.get(j).azimuth4);

			i = 0;
			player = playerServices.get(i++).getPlayer();
			player.setTransformersWinMoney(player.getTransformersWinMoney() + balanceList.get(j).azimuth1);
			player = playerServices.get(i++).getPlayer();
			player.setTransformersWinMoney(player.getTransformersWinMoney() + balanceList.get(j).azimuth2);
			player = playerServices.get(i++).getPlayer();
			player.setTransformersWinMoney(player.getTransformersWinMoney() + balanceList.get(j).azimuth3);
			player = playerServices.get(i++).getPlayer();
			player.setTransformersWinMoney(player.getTransformersWinMoney() + balanceList.get(j).azimuth4);

		}
	}
	
	public String getHistoryMessage(ArrayList<Message> historyMessages,ArrayList<PlayerService> playerServices, BalanceService balanceService){
		String str = "";
		
		for (int i = 0; i < playerServices.size(); i++) {
			if(playerServices.get(i).getPlayer().getPlayerType() == 3){
				str += playerServices.get(i).getPlayer().getRandomPlayerName() + "!" + 
					playerServices.get(i).getPlayer().getAzimuth() + "!" + 
					playerServices.get(i).getPlayer().getSparrStr() + ";";
			}else{
				str += playerServices.get(i).getPlayer().getPlayerName() + "!" + 
					playerServices.get(i).getPlayer().getAzimuth() + "!" + 
					playerServices.get(i).getPlayer().getSparrStr() + ";";
			}
		}
		
		for (int i = 0; i < historyMessages.size(); i++) {
			ArrayList<Object> list = (ArrayList<Object>)historyMessages.get(i).getContent();
			if(historyMessages.get(i).getHead().equals("showOperationI")){
				str += "so,";
			}else if(historyMessages.get(i).getHead().equals("gangI")){
				str += "gan,";
			}else if(historyMessages.get(i).getHead().equals("putOneMahjongI")){
				str += "put,";
			}else if(historyMessages.get(i).getHead().equals("getOneMahjongI")){
				str += "get,";
			}else if(historyMessages.get(i).getHead().equals("huI")){
				str += "huI,";
			}else if(historyMessages.get(i).getHead().equals("beginGameI")){
				str += "beg," + list.get(0) + "," + list.get(1) + "," + balanceService.baseNum;
			}else if(historyMessages.get(i).getHead().equals("pengI")){
				str += "pen,";
			}else if(historyMessages.get(i).getHead().equals("showDingzhangI")){
				str += "sd," + list.get(0);
			}else if(historyMessages.get(i).getHead().equals("dingzhangI")){
				str += "din,";
			}
			if(!historyMessages.get(i).getHead().equals("beginGameI") &&
					!historyMessages.get(i).getHead().equals("gameOverI") &&
					!historyMessages.get(i).getHead().equals("showDingzhangI")){
				for (int j = 0; j < list.size(); j++) {
					if(j == list.size() - 1){
						str += list.get(j);
					}else{
						str += list.get(j) + ",";
					}
				}
			}
			if(!historyMessages.get(i).getHead().equals("gameOverI")){
				str += ";";
			}
		}
		List<Balance> balanceList = balanceService.balanceList;
		str += "over,";
		for (int i = 0; i < balanceList.size(); i++) {
			if(i == balanceList.size() - 1){
				str += balanceList.get(i).balanceName + ":" + balanceList.get(i).azimuth1 + ":" + 
				balanceList.get(i).azimuth2 + ":" + balanceList.get(i).azimuth3 + ":" + balanceList.get(i).azimuth4 + ";";
			}else{
				str += balanceList.get(i).balanceName + ":" + balanceList.get(i).azimuth1 + ":" + 
				balanceList.get(i).azimuth2 + ":" + balanceList.get(i).azimuth3 + ":" + balanceList.get(i).azimuth4 + ",";
			}
		}
		if(balanceList.size() == 0){
			str += ";";
		}
		return str;
	}
	
}
