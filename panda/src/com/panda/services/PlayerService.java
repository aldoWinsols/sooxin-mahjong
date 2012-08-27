package com.panda.services;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.URL;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;

import net.sf.json.JSONObject;

import org.springframework.security.core.codec.Base64;

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
	
	public static void main(String[] args) {
//		PlayerService pl = new PlayerService();
//		// TODO Auto-generated method stub
//		byte[] aa = {};
//		try {
//			System.out.println("======="+pl.verifyReceipt("sooxin"));
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		JSONObject result = JSONObject.fromObject("{/n'receipt':{'original_purchase_date_pst':'2012-08-06 06:40:47 America/Los_Angeles', 'unique_identifier':'15fb238587c8f4e9065c03139e7eedc552fef249', 'original_transaction_id':'1000000054051373', 'bvrs':'0.6.1', 'transaction_id':'1000000054051373', 'quantity':'1', 'product_id':'com.sooxin.test', 'item_id':'550976980', 'purchase_date_ms':'1344260447747', 'purchase_date':'2012-08-06 13:40:47 Etc/GMT', 'original_purchase_date':'2012-08-06 13:40:47 Etc/GMT', 'purchase_date_pst':'2012-08-06 06:40:47 America/Los_Angeles', 'bid':'com.sooxin.mahjongM', 'original_purchase_date_ms':'1344260447747'}, 'status':0}/n");
//	       System.out.println(result.getInt("status"));
		
//		String aa ="{/n'receipt':{'original_purchase_date_pst':'2012-08-06 06:40:47 America/Los_Angeles', 'unique_identifier':'15fb238587c8f4e9065c03139e7eedc552fef249', 'original_transaction_id':'1000000054051373', 'bvrs':'0.6.1', 'transaction_id':'1000000054051373', 'quantity':'1', 'product_id':'com.sooxin.test', 'item_id':'550976980', 'purchase_date_ms':'1344260447747', 'purchase_date':'2012-08-06 13:40:47 Etc/GMT', 'original_purchase_date':'2012-08-06 13:40:47 Etc/GMT', 'purchase_date_pst':'2012-08-06 06:40:47 America/Los_Angeles', 'bid':'com.sooxin.mahjongM', 'original_purchase_date_ms':'1344260447747'}, 'status':0}/n";
//		int f = aa.indexOf("status");
//		System.out.println(aa.substring(f, 1));
	}

	public Object login(Player player){
		Player player1 = playerDao.findByAcctNameUnique(player.getPlayerName());
		if (player1 == null) {
			player.setHaveMoney(600.0);
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
	
	public Object login(Player player, int intMoney){
//		System.out.println("login");
		Player player1 = playerDao.findByAcctNameUnique(player.getPlayerName());
		if (player1 == null) {
			return "系统查找无此用户,请您核对后再尝试！";
		} else {
			if(!player1.getPlayerPwd().equals(player.getPlayerPwd())){
				return "输入的密码有错误，请您核对后再尝试！，";
			}
		}
		return player1;
		
	}
	
	public boolean checkPlayerNameIsExist(String playerName){
		Player pl = (Player) playerDao.findByAcctNameUnique(playerName);
		
		if(pl != null){
			return true;
		}else{
			return false;
		}
	}
	
	
	public Object regeist(Player player){
		Player pl = (Player) playerDao.findByAcctNameUnique(player.getPlayerName());
		
		if(pl != null){
			return "当前用户名已被使用，请尝试其他名字！";
		}
		
		
		player.setHaveMoney(600.0);
		playerDao.save(player);
		return player;
	}
	
	public boolean checkPlayerNameIsHave(String playerName){
		Player player = (Player) playerDao.findByAcctNameUnique(playerName);
		if (player == null) {
			return false;
		}
		
		return true;
	}
	
	public Object changePwd(String playerName, String playerOldPwd, String playerNewPwd){
		Player player = (Player) playerDao.findByAcctNameUnique(playerName);
		if(player == null){
			return "系统查找无此用户！";
		}
		
		if(player.getPlayerPwd().equals(playerOldPwd)){
			player.setPlayerPwd(playerNewPwd);
			playerDao.merge(player);
			return player;
		}else{
			return "你输入的旧密码不正确!";
		}
	}
	
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
	
	public Object chongzhi(String playerName, Double chongzhiMoney, String receipt){
		System.out.println("====================="+receipt.toString());
		
		Player player;
		try{
			
			
			if(verifyReceipt(receipt) != 0){
				return "apple验证失败，请与客服联系！";
			}
			
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
		}catch(Exception e){
			e.printStackTrace();
			return "充值失败，请与客服联系！";
		}
		
		return player;
	}
	
	public int verifyReceipt(String receipt) throws IOException {
	       int status = -1;

	        //This is the URL of the REST webservice in iTunes App Store
	        URL url = new URL("https://buy.itunes.apple.com/verifyReceipt");
//	        URL url = new URL("https://sandbox.itunes.apple.com/verifyReceipt");
	        
	        
	        HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
	        connection.setRequestMethod("POST");
	        connection.setDoOutput(true);
	        connection.setAllowUserInteraction(false);

	        //Encode the binary receipt data into Base 64
	        //Here I'm using org.apache.commons.codec.binary.Base64 as an encoder, since commons-codec is already in Grails classpath
	        Base64 encoder = new Base64();
	        String encodedReceipt = new String(encoder.encode(receipt.getBytes()));

	        //Create a JSON query object
	        //Here I'm using Grails' org.codehaus.groovy.grails.web.json.JSONObject
	        Map map = new HashMap();
	        map.put("receipt-data", encodedReceipt);
	        JSONObject jsonObject =  JSONObject.fromObject(map);

	        //Write the JSON query object to the connection output stream
	        PrintStream ps = new PrintStream(connection.getOutputStream());
	        ps.print(jsonObject.toString());
	        ps.close();

	        //Call the service
	        BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	        //Extract response
	        String str;
	        StringBuffer sb = new StringBuffer();
	        while ((str = br.readLine()) != null) {
	            sb.append(str);
	            sb.append("/n");
	        }
	        br.close();
	        String response = sb.toString();

	        System.out.println("response:"+response);
	        //Deserialize response
	        JSONObject result = JSONObject.fromObject(response);
	        status = result.getInt("status");
	       
	       System.out.println("status:"+status);
//	       
//	        if (status == 0) {
//	            //provide content
//	        } else {
//	            //signal error, throw an exception, do your stuff honey!
//	        }

	        return status ;


	    }
	
	
	

}
