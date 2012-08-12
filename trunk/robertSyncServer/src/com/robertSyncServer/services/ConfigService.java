package com.robertSyncServer.services;

import org.slf4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.robertSyncServer.util.UtilProperties;

public class ConfigService {
	private static ConfigService configService;
	private ApplicationContext context;
	private Logger log = null;
	private ConfigService(){
		log = UtilProperties.instance.getLogger(ConfigService.class);
		try{
		context = new ClassPathXmlApplicationContext(
		"classpath:rmi.xml"); 
		}catch(Exception e){
			System.out.println("获取 rmi.xml 出错 ： " + e.toString());
			log.info("获取 rmi.xml 出错 ： " + e.toString());
		}
	}
	
	public ApplicationContext getContext(){
		return context;
	}
	
	public static ConfigService getInstance(){
		if(configService == null){
			configService = new ConfigService();
		}
		return configService;
	}
	
}
