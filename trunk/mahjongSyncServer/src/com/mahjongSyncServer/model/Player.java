package com.mahjongSyncServer.model;

import java.math.BigDecimal;
import java.util.ArrayList;

import org.red5.server.api.service.IServiceCapableConnection;

import com.panda.dao.Playlog;


/**
 * 玩家实体类
 * @author Administrator
 * 2012-3-5 14:23 gmr start 添加是否结算标识
 */
public class Player {
	
	private String playerName = null;								//用户
	private String randomPlayerName = null;							//随机生成的名字(只有两个字母)
	private String password = null;									//玩家的密码
	private String roomNo = null;									//玩家所在的房间编号
	private String userIp = null;									//玩家的IP
	private int azimuth = 0;										//玩家所在当前房间的座位号
	private int dingzhangValue = -1;								//玩家定章的值
	private int lastValue = 0;										//玩家最后一次摸牌的值
	private boolean ishu = false;									//玩家是否胡牌
	private boolean haveDingzhangFanpai = false;					//玩家是否定章翻牌
	private int onlineState = 0;									//玩家的在线状态		0：空闲状态  1：等待状态 2：游戏状态
	private int zigangValue = 0;									//玩家自杠的值
	private IServiceCapableConnection iserver = null;				//玩家连接对象
	private String clientID = "";									//玩家连接对象的ID
	private int playerType = 0;										//玩家类型
	private boolean isDealOver = false;								//是否发牌完毕
	private int operationMahjongNum = 0;							//操作次数
	private int dingzhangFanpai = 0;								//定章翻牌标识
	private String sparrStr = "";									//手牌数组的字符串
	private boolean isFangTuiDa = false;							//是否放牛
	private int lastFangFanNum = 0;									//放牛的番数
	
	private int dianhuAzimuth = 0;									//点炮的方位
	private int huCount = 0;										//多家同时胡牌的顺序编号
	private int huMahjongValue = 0;									//胡牌的麻将值
	
	private int fanNum = 0;											//玩家胡牌的翻数
	private boolean haveJiao = false;								//玩家是否下叫
	private int peiNum = 0;											//玩家配叫的翻数
	private int sparrNum = 0;										//玩家断线重连需要的字段
	private boolean isReconnection = false;							//玩家是否断线重接
	
	private ArrayList<String> couldOperationNames; 					//可以操作的方法
	private String needOperationName = "";							//需要操作的方法
	private String needOperationName1 = "";
	
	private Playlog playLog = null;									//用户日志
	private double changeMoney = 0;									//玩家的输赢
	private double haveMoney = 0;
	private double transformersWinMoney = 0;			
	private int lastSetTransformersWinMoneyDayNum = 0;
	
	private boolean isBalance = false;
	
	private ArrayList<Integer> sparr = null;						//玩家手上未打的牌
	private ArrayList<Integer> pparr = null;						//玩家的碰牌
	private ArrayList<Integer> gparr = null;						//玩家杠牌
	private ArrayList<Integer> outarr = null;						//玩家已经出了的牌
	
	public Player(){
		//实例化
		sparr = new ArrayList<Integer>();
		pparr = new ArrayList<Integer>();
		gparr = new ArrayList<Integer>();
		outarr = new ArrayList<Integer>();
		
		couldOperationNames = new ArrayList<String>();
		playLog = new Playlog();
	}
	/**
	 * 清除所有数据
	 */
	public void clearAllData(){
		azimuth = 0;
		couldOperationNames.clear();
		dingzhangValue = -1;
		haveDingzhangFanpai = false;
		isDealOver = false;
		ishu =false;
		lastValue = 0;
		needOperationName = "";
		needOperationName1 = "";
		// V2.0 onlineState不在这里修改，改为在玩家开始游戏之前修改 2011-9-30 10:24
//		onlineState = 1;
		operationMahjongNum = 0;
		roomNo = "";
		zigangValue = 0;
		dianhuAzimuth = 0;
		huCount = 0;
		huMahjongValue = 0;
		fanNum = 0;
		peiNum = 0;
		haveJiao = false;
		sparrStr = "";
		isReconnection = false;
		changeMoney = 0;
		sparrNum = 0;
		sparr.clear();
		pparr.clear();
		gparr.clear();
		outarr.clear();
	}
	/**
	 * 获得用户名
	 * @return
	 */
	public String getPlayerName() {
		return playerName;
	}
	/**
	 * 设置用户名
	 * @param playerName
	 */
	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}
	/**
	 * 获得玩家所在的房间编号
	 * @return
	 */
	public String getRoomNo() {
		return roomNo;
	}
	/**
	 * 设置玩家所在的房间编号
	 * @param roomNo
	 */
	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}
	/**
	 * 获得玩家所在的房间座位号
	 * @return
	 */
	public int getAzimuth() {
		return azimuth;
	}
	/**
	 * 设置玩家所在的房间座位号
	 * @param azimuth
	 */
	public void setAzimuth(int azimuth) {
		this.azimuth = azimuth;
	}
	/**
	 * 获得玩家手上的牌
	 * @return
	 */
	public ArrayList<Integer> getSparr(){
		return sparr;
	}
	/**
	 * 设置玩家手上的牌
	 * @param sparr
	 */
	public void setSparr(ArrayList<Integer> sparr){
		this.sparr = sparr;
	}
	/**
	 * 获得玩家碰牌
	 * @return
	 */
	public ArrayList<Integer> getPparr(){
		return pparr;
	}
	/**
	 * 设置玩家碰牌
	 * @param sparr
	 */
	public void setPparr(ArrayList<Integer> pparr){
		this.pparr = pparr;
	}
	/**
	 * 获得玩家杠牌
	 * @return
	 */
	public ArrayList<Integer> getGparr(){
		return gparr;
	}
	/**
	 * 设置玩家杠牌
	 * @param sparr
	 */
	public void setGparr(ArrayList<Integer> gparr){
		this.gparr = gparr;
	}
	/**
	 * 获得玩家出了的牌
	 * @return
	 */
	public ArrayList<Integer> getOutarr(){
		return outarr;
	}
	/**
	 * 设置玩家出了的牌
	 * @param sparr
	 */
	public void setOutarr(ArrayList<Integer> outarr){
		this.outarr = outarr;
	}
	/**
	 * 获得定章的值
	 * @return
	 */
	public int getDingzhangValue(){
		return dingzhangValue;
	}
	/**
	 * 设置定章的值
	 * @param dingzhangValue
	 */
	public void setDingzhangValue(int dingzhangValue){
		this.dingzhangValue = dingzhangValue;
	}
	/**
	 * 获得玩家最后一次摸牌的值
	 */
	public int getLastValue(){
		return lastValue;
	}
	/**
	 * 设置玩家最后一次摸牌的值
	 */
	public void setLastValue(int lastValue){
		this.lastValue = lastValue;
	}
	/**
	 * 获得玩家是否胡牌
	 * @return
	 */
	public boolean getIshu(){
		return ishu;
	}
	/**
	 * 设置玩家是否胡牌
	 * @param ishu
	 */
	public void setIshu(boolean ishu){
		this.ishu = ishu;
	}
	/**
	 * 获得定章是否翻牌标识
	 * @return
	 */
	public boolean getHaveDingzhangFanpai(){
		return haveDingzhangFanpai;
	}
	/**
	 * 设置定章是否翻牌标识
	 * @param haveDingzhangFanpai
	 */
	public void setHaveDingzhangFanpai(boolean haveDingzhangFanpai){
		this.haveDingzhangFanpai = haveDingzhangFanpai;
	}
	/**
	 * 获得玩家在线状态  0：空闲状态  1：等待状态 2：游戏状态
	 * @return
	 */
	public int getOnlineState(){
		return onlineState;
	}
	/**
	 * 设置玩家在线状态  0：空闲状态  1：等待状态 2：游戏状态
	 * @param onlineState
	 */
	public void setOnlineState(int onlineState){
		this.onlineState = onlineState;
	}
	/**
	 * 获得玩家可以操作的方法
	 * @return
	 */
	public String getNeedOperationName() {
		return needOperationName;
	}
	
	/**
	 * 设置玩家可以操作的方法
	 * @param needOperationName
	 */
	public void setNeedOperationName(String needOperationName) {
		this.needOperationName = needOperationName;
	}
	
	/**
	 * 获得玩家可以操作的方法
	 * @return
	 */
	public String getNeedOperationName1() {
		return needOperationName1;
	}
	
	/**
	 * 设置玩家可以操作的方法
	 * @param needOperationName
	 */
	public void setNeedOperationName1(String needOperationName1) {
		this.needOperationName1 = needOperationName1;
	}
	/**
	 * 获得玩家当前可以操作的方法
	 * @return
	 */
	public ArrayList<String> getCouldOperationNames() {
		return couldOperationNames;
	}
	/**
	 * 设置玩家当前可以操作的方法
	 * @param couldOperationNames
	 */
	public void setCouldOperationNames(ArrayList<String> couldOperationNames) {
		this.couldOperationNames = couldOperationNames;
	}
	/**
	 * 获得玩家自杠的值
	 * @return
	 */
	public int getZigangValue(){
		return zigangValue;
	}
	/**
	 * 设置玩家自杠的值
	 * @param zigangValue
	 */
	public void setZigangValue(int zigangValue){
		this.zigangValue = zigangValue;
	}
	/**
	 * 获得玩家连接对象
	 * @return
	 */
	public IServiceCapableConnection getIServer(){
		return iserver;
	}
	/**
	 * 设置玩家连接对象
	 * @param iserver
	 */
	public void setIServer(IServiceCapableConnection iserver){
		this.iserver = iserver;
		if(playerType != 3){
			this.clientID = iserver.getClient().getId();
		}
	}
	/**
	 * 获得玩家类型
	 * @return
	 */
	public int getPlayerType(){
		return playerType;
	}
	/**
	 * 设置玩家类型
	 * @param playeType
	 */
	public void setPlayerType(int playerType){
		this.playerType = playerType;
	}
	/**
	 * 获得玩家是否发牌完毕
	 * @return
	 */
	public boolean getIsDealOver(){
		return isDealOver;
	}
	/**
	 * 设置玩家是否发牌完毕
	 * @param isDealOver
	 */
	public void setIsDealOver(boolean isDealOver){
		this.isDealOver = isDealOver;
	}
	/**
	 * 获得玩家操作次数(用来判断用户胡牌时是否是天胡或者地胡)
	 * @return
	 */
	public int getOperationMahjongNum(){
		return operationMahjongNum;
	}
	/**
	 * 设置玩家操作次数
	 * @param outMahjongNum
	 */
	public void setOperationMahjongNum(int operationMahjongNum){
		this.operationMahjongNum = operationMahjongNum;
	}
	/**
	 * 获得定章翻牌标识
	 * @return
	 */
	public int getDingzhangFanpai(){
		return dingzhangFanpai;
	}
	/**
	 * 设置定章翻牌标识
	 * @param dingzhangFanpai
	 */
	public void setDingzhangFanpai(int dingzhangFanpai){
		this.dingzhangFanpai = dingzhangFanpai;
	}
	/**
	 * 获得点跑的方位
	 * @return
	 */
	public int getDianhuAzimuth(){
		return dianhuAzimuth;
	}
	/**
	 * 设置点跑的方位
	 * @param dianhuAzimuth
	 */
	public void setDianhuAzimuth(int dianhuAzimuth){
		this.dianhuAzimuth = dianhuAzimuth;
	}
	/**
	 * 获得多家同时胡牌的顺序编号
	 * @return
	 */
	public int getHuCount(){
		return huCount;
	}
	/**
	 * 设置多家同时胡牌的顺序编号
	 * @param huCount
	 */
	public void setHuCount(int huCount){
		this.huCount = huCount;
	}
	/**
	 * 获得胡牌的麻将值
	 * @return
	 */
	public int getHuMahjongValue(){
		return huMahjongValue;
	}
	/**
	 * 设置胡牌的麻将值
	 * @param huMahjongValue
	 */
	public void setHuMahjongValue(int huMahjongValue){
		this.huMahjongValue = huMahjongValue;
	}
	/**
	 * 获得玩家胡牌的翻数
	 * @return
	 */
	public int getFannum(){
		return fanNum;
	}
	/**
	 * 设置玩家胡牌的翻数
	 * @param fanNum
	 */
	public void setFannum(int fanNum){
		this.fanNum = fanNum;
	}
	/**
	 * 获得玩家是否下叫
	 * @return
	 */
	public boolean getHaveJiao(){
		return haveJiao;
	}
	/**
	 * 设置玩家是否下叫
	 * @param haveJiao
	 */
	public void setHaveJiao(boolean haveJiao){
		this.haveJiao = haveJiao;
	}
	/**
	 * 获得玩家配叫的翻数
	 * @return
	 */
	public int getPeinum(){
		return peiNum;
	}
	/**
	 * 设置玩家配叫的翻数
	 * @param peiNum
	 */
	public void setPeinum(int peiNum){
		this.peiNum = peiNum;
	}
	/**
	 * 获得手牌数组的字符串
	 * @return
	 */
	public String getSparrStr(){
		return sparrStr;
	}
	/**
	 * 设置手牌数组的字符串
	 * @param sparrStr
	 */
	public void setSparrStr(String sparrStr){
		this.sparrStr = sparrStr;
	}
	/**
	 * 获得玩家手牌数组的个数
	 * @return
	 */
	public int getSparrNum(){
		return sparrNum;
	}
	/**
	 * 设置玩家手牌数据的个数
	 */
	public void setSparrNum(){
		this.sparrNum = sparr.size();
	}
	/**
	 * 玩家是否断线重接
	 * @return
	 */
	public boolean isReconnection(){
		return isReconnection;
	}
	/**
	 * 设置玩家是否断线重接
	 * @param isReconnection
	 */
	public void setIsReconnection(boolean isReconnection){
		this.isReconnection = isReconnection;
	}
	/**
	 * 获得玩家连接对象ID
	 * @return
	 */
	public String getClientID(){
		return clientID;
	}
	/**
	 * 获得玩家的IP
	 * @return
	 */
	public String getUserIp() {
		return userIp;
	}
	/**
	 * 设置玩家的IP
	 * @param userIp
	 */
	public void setUserIp(String userIp) {
		this.userIp = userIp;
	}
	/**
	 * 获得用户日志
	 * @return
	 */
	public Playlog getPlayLog() {
		return playLog;
	}
	
	public double getChangeMoney() {
		return changeMoney;
	}
	public void setChangeMoney(double changeMoney) {
		// 保留两位小数
		this.changeMoney = new BigDecimal(changeMoney).setScale(1, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
	
	public double getHaveMoney() {
		return haveMoney;
	}
	public void setHaveMoney(double haveMoney) {
		this.haveMoney = haveMoney;
	}
	
	public double getTransformersWinMoney() {
		return transformersWinMoney;
	}
	public void setTransformersWinMoney(double transformersWinMoney) {
		this.transformersWinMoney = transformersWinMoney;
	}
	
	public int getLastSetTransformersWinMoneyDayNum() {
		return lastSetTransformersWinMoneyDayNum;
	}
	public void setLastSetTransformersWinMoneyDayNum(
			int lastSetTransformersWinMoneyDayNum) {
		this.lastSetTransformersWinMoneyDayNum = lastSetTransformersWinMoneyDayNum;
	}
	public String getRandomPlayerName() {
		return randomPlayerName;
	}
	public void setRandomPlayerName(String randomPlayerName) {
		this.randomPlayerName = randomPlayerName;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public boolean isFangTuiDa() {
		return isFangTuiDa;
	}
	public void setFangTuiDa(boolean isFangTuiDa) {
		this.isFangTuiDa = isFangTuiDa;
	}
	public int getLastFangFanNum() {
		return lastFangFanNum;
	}
	public void setLastFangFanNum(int lastFangFanNum) {
		this.lastFangFanNum = lastFangFanNum;
	}
	// 2012-3-5 14:23 gmr start 添加是否结算标识
	/**
	 * 获得是否结算
	 * @return
	 */
	public boolean isBalance() {
		return isBalance;
	}
	/**
	 * 设置是否结算
	 * @param isBalance
	 */
	public void setBalance(boolean isBalance) {
		this.isBalance = isBalance;
	}
	// 2012-3-5 14:23 gmr end
	public Object clone(){
		Player player = new Player();
		player.azimuth = this.azimuth;
		player.dingzhangValue = this.dingzhangValue;
		player.playerName = this.playerName;
		player.userIp = this.userIp;
		player.ishu = this.ishu;
		player.sparr = new ArrayList<Integer>(this.sparr);
		player.pparr = new ArrayList<Integer>(this.pparr);
		player.gparr = new ArrayList<Integer>(this.gparr);
		player.outarr = new ArrayList<Integer>(this.outarr);
		player.haveDingzhangFanpai = this.haveDingzhangFanpai;
		player.huMahjongValue = this.huMahjongValue;
		player.dianhuAzimuth = this.dianhuAzimuth;
		player.huCount = this.huCount;
		return player;
	}
}
