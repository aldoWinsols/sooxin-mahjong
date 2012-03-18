package com.mahjongSyncServer.util;

import java.io.InputStream;
import java.math.BigInteger;
import java.util.Properties;

import org.red5.logging.Red5LoggerFactory;
import org.slf4j.Logger;

public class UtilProperties {

	private Properties properties = null;		//配置文件类
	
	public static UtilProperties instance = null;
	private int roomNo = 0;
	private int maxFannum = 0;
	private int limitMoney = 0;
	private int androidWaitTimer = 0;
	private int androidStartNum = 0;
	private String[] urls = null;
	private String mainServerIp = "";
	private String mainApp = "";
	
	private UtilProperties(String fileName){
		getProperties(fileName);
		roomNo = getPropertiesPropertyToInteger("roomNo");
		maxFannum = getPropertiesPropertyToInteger("maxFannum");
		limitMoney = getPropertiesPropertyToInteger("limitMoney");
		androidWaitTimer = getPropertiesPropertyToInteger("androidWaitTimer");
		androidStartNum = getPropertiesPropertyToInteger("androidStartNum");
		mainServerIp = properties.getProperty("mainServerIp");
		mainApp = properties.getProperty("mainApp");
		urls = getPropertyUrls("url");
	}
	
	public static UtilProperties getInstance(String fileName){
		if(instance == null){
			instance = new UtilProperties(fileName);
		}
		return instance;
	}
	
	/**
	 * 获得配置文件
	 * @param fileName
	 * @return
	 */
	private void getProperties(String fileName){
		if(properties == null){
			try{
				InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream(fileName);
				
				properties = new Properties();
				properties.load(inputStream);
			}catch(Exception e){
				System.out.println("一个IO错误： " + e.toString());
			}
		}
	}
	/**
	 * 获得属性  返回结果Integer
	 * @param key
	 * @return
	 */
	private int getPropertiesPropertyToInteger(String key){
		int property = 0; 
		try{
			property = Integer.valueOf(properties.getProperty(key));
		}catch(Exception e){
			System.out.println("转换Integer类型出错： " + e.toString());
		}
		return property;
	}
	
	private String[] getPropertyUrls(String key){
		String str = properties.getProperty(key);
		return str.split(",");
	}
	
	/**
	 * 获得房间编号
	 * @return
	 */
	public int getRoomNo(){
		return roomNo;
	}
	/**
	 * 获得封顶番数(这里是指倍数)
	 * @return
	 */
	public int getMaxFannum(){
		// 计算番数的倍数
		int fannum = new BigInteger("2").pow(maxFannum - 1).intValue();
		return fannum;
	}
	/**
	 * 获得限制的url地址
	 * @return
	 */
	public String[] getUrls(){
		return urls;
	}
	/**
	 * 获得房间限制金额
	 * @return
	 */
	public int getLimitMoney() {
		return limitMoney;
	}
	/**
	 * 获得机器人进入房间的时间
	 * @return
	 */
	public int getAndroidWaitTimer() {
		return androidWaitTimer;
	}
	/**
	 * 获得机器人起始值
	 * @return
	 */
	public int getAndroidStartNum() {
		return androidStartNum;
	}
	/**
	 * 获得连接主服务的IP地址
	 * @return
	 */
	public String getMainServerIp() {
		return mainServerIp;
	}
	/**
	 * 获得连接主服务的名称
	 * @return
	 */
	public String getMainApp() {
		return mainApp;
	}
	/**
	 * 获得日志操作文件
	 * @param arg0
	 * @return
	 */
	public Logger getLogger(Class arg0){
		String contextName = "mahjongSyncServer" + roomNo;
		return Red5LoggerFactory.getLogger(arg0, contextName);
	}
}
