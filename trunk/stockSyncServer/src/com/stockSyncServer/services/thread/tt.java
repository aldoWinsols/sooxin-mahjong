package com.stockSyncServer.services.thread;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.stock.inter.IPlayerService;
import com.stockSyncServer.services.ConfigService;

public class tt {

	/**
	 * @param args
	 */
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ApplicationContext context = new ClassPathXmlApplicationContext(
		"classpath:rmi.xml"); 
		
		IPlayerService playerService = (IPlayerService) context.getBean("playerService");
		
		for(int i=0; i<10000; i++){
			playerService.regeist("m"+i, "");
		}

	}

}
