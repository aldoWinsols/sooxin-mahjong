package com.mainSyncServer.service;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ConfigService {
	private static ConfigService configService;
	private ApplicationContext context;
	private ConfigService(){
		try{
		context = new ClassPathXmlApplicationContext(
		"classpath:rmi.xml");
		}catch(Exception e){
			System.out.println(e.toString());
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
