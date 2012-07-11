package com.panda.services;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.panda.dao.Chongzhilog;
import com.panda.dao.ChongzhilogDAO;
import com.panda.dao.Duihuanlog;
import com.panda.dao.DuihuanlogDAO;
import com.panda.dao.Player;
import com.panda.dao.PlayerDAO;
import com.panda.inter.IPlayerService;

public class PlayerService implements IPlayerService {
	private PlayerDAO playerDao;
	private ChongzhilogDAO chongzhilogDao;
	private DuihuanlogDAO duihuanlogDao;
	
	public PlayerDAO getPlayerDao() {
		return playerDao;
	}

	public void setPlayerDao(PlayerDAO playerDao) {
		this.playerDao = playerDao;
	}

	public ChongzhilogDAO getChongzhilogDao() {
		return chongzhilogDao;
	}

	public void setChongzhilogDao(ChongzhilogDAO chongzhilogDao) {
		this.chongzhilogDao = chongzhilogDao;
	}

	public DuihuanlogDAO getDuihuanlogDao() {
		return duihuanlogDao;
	}

	public void setDuihuanlogDao(DuihuanlogDAO duihuanlogDao) {
		this.duihuanlogDao = duihuanlogDao;
	}

	public Object login(Player player){
		Player player1 = playerDao.findByAcctNameUnique(player.getPlayerName());
		if (player1 == null) {
			player.setHaveMoney(2500.0);
			playerDao.save(player);
			return player;
		} else {
			player1.setBirthday(player.getBirthday());
			player1.setBirthMonth(player.getBirthMonth());
			player1.setBirthYear(player.getBirthYear());
			player1.setCityCode(player.getCityCode());
			player1.setCountryCode(player.getCountryCode());
			player1.setEdu(player.getEdu());
			player1.setEmail(player.getEmail());
			player1.setFansNum(player.getFansNum());
			player1.setHead(player.getHead());
			player1.setIdolNum(player.getIdolNum());
			player1.setIntroduction(player.getIntroduction());
			player1.setIsent(player.getIsent());
			player1.setIsrealName(player.getIsrealName());
			player1.setIsvip(player.getIsvip());
			
			player1.setLocation(player.getLocation());
			player1.setNick(player.getNick());
//			player1.setOfflineGameNo(player.getOfflineGameNo());
			player1.setOpenid(player.getOpenid());
			player1.setProvinceCode(player.getProvinceCode());
			player1.setSex(player.getSex());
			player1.setTag(player.getTag());
			player1.setTweetnum(player.getTweetnum());
			player1.setVerifyinfo(player.getVerifyinfo());
			playerDao.merge(player1);
			
			return player1;
		}
		
	}
	
	public boolean checkPlayerNameIsExist(String playerName){
		Player pl = (Player) playerDao.findByAcctNameUnique(playerName);
		
		if(pl != null){
			return true;
		}else{
			return false;
		}
	}
	
//	public Object regeist(Player player){
//		Player pl = (Player) playerDao.findByAcctNameUnique(player.getPlayername());
//		
//		if(pl != null){
//			return "当前用户名已被使用，请尝试其他名字！";
//		}
//		
//		playerDao.save(player);
//		return player;
//	}
	
	public boolean checkPlayerNameIsHave(String playerName){
		Player player = (Player) playerDao.findByAcctNameUnique(playerName);
		if (player == null) {
			return false;
		}
		
		return true;
	}
	
//	public Object changePwd(String playerName, String playerOldPwd, String playerNewPwd){
//		Player player = (Player) playerDao.findByAcctNameUnique(playerName);
//		if(player.getPlayerpwd().equals(playerOldPwd)){
//			player.setPlayerpwd(playerNewPwd);
//			playerDao.merge(player);
//			return player;
//		}else{
//			return "你输入的旧密码不正确!";
//		}
//	}
	
	public void updateMoney(String playerName, Double changeMoney){
		Player player = (Player) playerDao.findByPlayerName(playerName);
		player.setHaveMoney(player.getHaveMoney() + changeMoney);
		playerDao.merge(player);
	}
	
	public Object duihuan(Duihuanlog duihuanlog){
		Player player = (Player) playerDao.findByAcctNameUnique(duihuanlog.getPlayerName());
		
		if(player.getHaveMoney() < duihuanlog.getDuihuanMoney()){
			return "你当前的点数不足，不能兑换奖品！";
		}
		
		player.setHaveMoney(player.getHaveMoney() - duihuanlog.getDuihuanMoney());
		
		duihuanlogDao.save(duihuanlog);
		playerDao.merge(player);
		
		return player;
	}
	
	
	public Object chongzhi(String playerName, Double chongzhiMoney){
		Player player;
		try{
			player = (Player) playerDao.findByPlayerName(playerName).get(0);
			
			Chongzhilog chongzhilog = new Chongzhilog();
			chongzhilog.setPlayerName(playerName);
			chongzhilog.setChongzhiTime(new Timestamp(new Date().getTime()));
			chongzhilog.setChongzhiMoney(chongzhiMoney);
			chongzhilog.setLastHaveMoney(player.getHaveMoney());
			chongzhilog.setNowHaveMoney(player.getHaveMoney() + chongzhiMoney);
			
			
			player.setHaveMoney(player.getHaveMoney() + chongzhiMoney);
			
			chongzhilogDao.save(chongzhilog);
			playerDao.merge(player);
		}catch(Error e){
			return e.toString();
		}
		
		return player;
	}
	
	
	

}
