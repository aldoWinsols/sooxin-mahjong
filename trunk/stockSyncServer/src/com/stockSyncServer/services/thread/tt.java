package com.stockSyncServer.services.thread;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


public class tt {

	/**
	 * @param args
	 */
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		ApplicationContext context = new ClassPathXmlApplicationContext(
//		"classpath:rmi.xml"); 
//		
//		IPlayerService playerService = (IPlayerService) context.getBean("playerService");
//		
//		for(int i=0; i<10000; i++){
//			playerService.regeist("m"+i, "");
//		}
//		String ss = "2012-08-18 15:05:31";
//		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.sss");
//		String time = dateFormat.format(new Date().toLocaleString());
//		Timestamp ts = Timestamp.valueOf(ss);
//		System.out.println(ts);
//		
//		System.out.println("=="+new Date().toLocaleString());
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.sss");
//		dateFormat.format(new Date().toLocaleString());
		
		Timestamp.valueOf(dateFormat.format(new Date().toLocaleString()));

	}

}
