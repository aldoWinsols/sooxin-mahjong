package com.stockSyncServer.dataServices;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;

import com.stockSyncServer.util.UtilProperties;


/**
 * 
 * @author Administrator
 * 2012-3-5 14:09 gmr start 保存玩家扣除的金额
 */
public class DataService {
	private Logger log = null;
	private RemoteService remoteService = null;
	public DataService(){
		log = UtilProperties.instance.getLogger(DataService.class);
		remoteService = new RemoteService();
	}
	
}
