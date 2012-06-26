package com.panda.services;

import java.sql.Timestamp;
import java.util.Date;

import org.apache.log4j.Logger;

import com.panda.dao.Player;
import com.panda.dao.PlayerDAO;
import com.panda.dao.Playlog;
import com.panda.dao.PlaylogDAO;
import com.panda.inter.IBalanceChessGameService;
import com.panda.util.DateUtil;


/**
 * @author Pan Jin Feng
 * 
 *         when what who comments
 * 
 *         [2011-6-1_15:48:38 mod Pan Jin Feng] 添加积分体系 [2011-6-8_09:43:56 mod
 *         Pan Jin Feng] 棋牌分为5元麻将、10元麻将、20元麻将、50元麻将保存记录
 * 
 */
public class BalanceChessGameService implements IBalanceChessGameService {
	private static final Logger log = Logger
			.getLogger(BalanceChessGameService.class);

	private PlaylogDAO playLogDao;
	public PlaylogDAO getPlayLogDao() {
		return playLogDao;
	}

	public void setPlayLogDao(PlaylogDAO playLogDao) {
		this.playLogDao = playLogDao;
	}

	public PlayerDAO getPlayerDao() {
		return playerDao;
	}

	public void setPlayerDao(PlayerDAO playerDao) {
		this.playerDao = playerDao;
	}

	private PlayerDAO playerDao;

	// 公點比率
	private double taxationRate = 0;

	public boolean balanceMajong(Playlog playLogA, Playlog playLogB, Playlog playLogC, Playlog playLogD) {


		// 贏錢玩家所贏點數之和
		Double allWinMoney = getAllWinMoney(playLogA, playLogB, playLogC,
				playLogD);

		// -- 分別結算四位 玩家的輸贏
		// -- ①會員賬號A
		Player userAcctA = playerDao.findByAcctNameUnique(playLogA
				.getPlayerName());


		double paybackA = playLogA.getAllTouZhuMoney();
		playLogA.setAllTouZhuMoney(allWinMoney);
		savePlayLog(playLogA, userAcctA, taxationRate, paybackA);
//		saveReportForm(playLogA, userAcctA, allWinMoney);
		updateUserAcct(playLogA, userAcctA, paybackA);

		// --②會員賬號B
		double paybackB = playLogB.getAllTouZhuMoney();
		Player userAcctB = playerDao.findByAcctNameUnique(playLogB
				.getPlayerName());

		playLogB.setAllTouZhuMoney(allWinMoney);
		savePlayLog(playLogB, userAcctB, taxationRate, paybackB);
//		saveReportForm(playLogB, userAcctB, allWinMoney);
		updateUserAcct(playLogB, userAcctB, paybackB);

		// --③會員賬號C
		double paybackC = playLogC.getAllTouZhuMoney();
		Player userAcctC = playerDao.findByAcctNameUnique(playLogC
				.getPlayerName());

		playLogC.setAllTouZhuMoney(allWinMoney);
		savePlayLog(playLogC, userAcctC, taxationRate, paybackC);
//		saveReportForm(playLogC, userAcctC, allWinMoney);
		updateUserAcct(playLogC, userAcctC, paybackC);

		// --④會員賬號D
		double paybackD = playLogD.getAllTouZhuMoney();
		Player userAcctD = playerDao.findByAcctNameUnique(playLogD
				.getPlayerName());

		playLogD.setAllTouZhuMoney(allWinMoney);
		savePlayLog(playLogD, userAcctD, taxationRate, paybackD);
//		saveReportForm(playLogD, userAcctD, allWinMoney);
		updateUserAcct(playLogD, userAcctD, paybackD);

		return true;
	}

	private void updateUserAcct(Playlog playLogD, Player player,
			double payback) {
		player.setHaveMoney(player.getHaveMoney()
				+ playLogD.getWinLossMoneyAfterTax());
		playerDao.merge(player);
	}

	private double getAllWinMoney(Playlog playLogA, Playlog playLogB,
			Playlog playLogC, Playlog playLogD) {
		Double allWinMoney = 0d;
		if (playLogA.getWinLossMoneyBeforeTax() > 0) {
			allWinMoney += playLogA.getWinLossMoneyBeforeTax();
		}
		if (playLogB.getWinLossMoneyBeforeTax() > 0) {
			allWinMoney += playLogB.getWinLossMoneyBeforeTax();
		}
		if (playLogC.getWinLossMoneyBeforeTax() > 0) {
			allWinMoney += playLogC.getWinLossMoneyBeforeTax();
		}
		if (playLogD.getWinLossMoneyBeforeTax() > 0) {
			allWinMoney += playLogD.getWinLossMoneyBeforeTax();
		}
		return allWinMoney;
	}

	// [2012-3-6_15:26:11 pjf]将公点比率追加游戏内容中
	private void savePlayLog(Playlog playLog, Player player,
			double taxactoinRate, double payback) {
		Timestamp gameTime = DateUtil.getTimestamp(new Date());
		playLog.setGameClass(1);
		playLog.setPreMoney(player.getHaveMoney());

		// 如果是贏了要提交公點
		// -- 公點為負
		if (playLog.getWinLossMoneyBeforeTax() > 0) {
			playLog.setGameTaxaction(-playLog.getWinLossMoneyBeforeTax()
					* taxactoinRate);
		} else {
			playLog.setGameTaxaction(0d);
		}
		playLog.setWinLossMoneyAfterTax(playLog.getWinLossMoneyBeforeTax()
				+ playLog.getGameTaxaction());
		playLog.setAfterMoney(playLog.getPreMoney()
				+ playLog.getWinLossMoneyAfterTax());
		playLog.setGameTime(gameTime);
		// [2012-3-6_15:26:11 pjf start]
		playLog.setGameContent(playLog.getGameContent() + taxactoinRate);
		// [2012-3-6_15:26:11 pjf end]
		playLogDao.save(playLog);

	}
	
	public void setPlayerOfflineGameNo(String playerName, int offlineGameNo){
		Player userAcctA = playerDao.findByAcctNameUnique(playerName);
		if(userAcctA != null){
			userAcctA.setOfflineGameNo(offlineGameNo);
		}
		playerDao.merge(userAcctA);
	}

}
