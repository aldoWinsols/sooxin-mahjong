package com.stock.services;

import java.util.List;

import com.stock.dao.Dline;
import com.stock.dao.DlineDAO;
import com.stock.dao.Hline;
import com.stock.dao.HlineDAO;
import com.stock.dao.Mline;
import com.stock.dao.MlineDAO;
import com.stock.dao.Wline;
import com.stock.dao.WlineDAO;
import com.stock.inter.ILineService;

public class LineService implements ILineService {

	private MlineDAO mlineDao;
	private HlineDAO hlineDao;
	private DlineDAO dlineDao;
	private WlineDAO wlineDao;
	
	public MlineDAO getMlineDao() {
		return mlineDao;
	}

	public void setMlineDao(MlineDAO mlineDao) {
		this.mlineDao = mlineDao;
	}

	public HlineDAO getHlineDao() {
		return hlineDao;
	}

	public void setHlineDao(HlineDAO hlineDao) {
		this.hlineDao = hlineDao;
	}

	public DlineDAO getDlineDao() {
		return dlineDao;
	}

	public void setDlineDao(DlineDAO dlineDao) {
		this.dlineDao = dlineDao;
	}

	public WlineDAO getWlineDao() {
		return wlineDao;
	}

	public void setWlineDao(WlineDAO wlineDao) {
		this.wlineDao = wlineDao;
	}

	
	//-----------------------------------------------------------
	public void addMline(Mline mline){
		mlineDao.save(mline);
	}
	public void addHline(Hline hline){
		hlineDao.save(hline);
	}
	public void addDline(Dline dline){
		dlineDao.save(dline);
	}
	public void addWline(Wline wline){
		wlineDao.save(wline);
	}
	
}
