package com.leafSyncServer.util;

import java.io.InputStream;
import java.math.BigInteger;
import java.util.Properties;

import org.red5.logging.Red5LoggerFactory;
import org.slf4j.Logger;

public class UtilProperties {

	private Properties properties = null;		//配置文件�?
	
	public static UtilProperties instance = null;

	public String stockSyncServerIp = "";
	public String stockSyncServerApp = "";
	
	private UtilProperties(String fileName){
		getProperties(fileName);
	
		stockSyncServerIp = properties.getProperty("stockSyncServerIp");
		stockSyncServerApp = properties.getProperty("stockSyncServerApp");
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
				System.out.println("IO错误" + e.toString());
			}
		}
	}
	
	/**
	 * 获得日志操作文件
	 * @param arg0
	 * @return
	 */
	public Logger getLogger(Class arg0){
		String contextName = "mahjongSyncServer" + stockSyncServerApp;
		return Red5LoggerFactory.getLogger(arg0, contextName);
	}
}
