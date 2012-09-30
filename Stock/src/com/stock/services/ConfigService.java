package com.stock.services;

import com.stock.dao.Config;
import com.stock.dao.ConfigDAO;
import com.stock.inter.IConfigService;

public class ConfigService implements IConfigService {
	private ConfigDAO configDao;

	public ConfigDAO getConfigDao() {
		return configDao;
	}

	public void setConfigDao(ConfigDAO configDao) {
		this.configDao = configDao;
	}

	public Config getConfig() {
		// TODO Auto-generated method stub
		return (Config) configDao.findAll().get(0);
	}
	
	

}
