package com.panda.services;

import java.util.List;

import com.panda.dao.ShangpinDAO;
import com.panda.inter.IShangpinService;

public class ShangpinService implements IShangpinService {
	
	private ShangpinDAO shangpinDao;

	public ShangpinDAO getShangpinDao() {
		return shangpinDao;
	}

	public void setShangpinDao(ShangpinDAO shangpinDao) {
		this.shangpinDao = shangpinDao;
	}
	
	public List huodeAllShangpin(){
		return getShangpinDao().findAll();
	}

}
