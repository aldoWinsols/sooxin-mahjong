package com.stock.services;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.stock.dao.Cjhistory;
import com.stock.dao.CjhistoryDAO;
import com.stock.inter.ICjhistoryService;

public class CjhistoryService implements ICjhistoryService {
	
	private CjhistoryDAO cjhistoryDao;

	public CjhistoryDAO getCjhistoryDao() {
		return cjhistoryDao;
	}

	public void setCjhistoryDao(CjhistoryDAO cjhistoryDao) {
		this.cjhistoryDao = cjhistoryDao;
	}

	public void saveCjhistory(String stockNum,String cjSort,Integer cjNum,Double cjPrice,String cjTime){
		
		Cjhistory cjhistory = new Cjhistory();
		cjhistory.setStockNum(stockNum);
		cjhistory.setCjSort(cjSort);
		cjhistory.setCjNum(cjNum);
		cjhistory.setCjPrice(cjPrice);
		cjhistory.setCjTime(Timestamp.valueOf(cjTime));
		cjhistoryDao.save(cjhistory);
	}

}
