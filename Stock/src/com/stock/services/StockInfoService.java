package com.stock.services;

import java.util.List;

import com.stock.dao.AchievementDAO;
import com.stock.dao.CompanyinfoDAO;
import com.stock.dao.NewsDAO;
import com.stock.dao.NoticeDAO;
import com.stock.dao.ProfitDAO;
import com.stock.dao.TenplayerDAO;
import com.stock.inter.IStockInfoService;

public class StockInfoService implements IStockInfoService{
	private TenplayerDAO tenplayerDao;
	private NoticeDAO noticeDao;
	private NewsDAO newsDao;
	private ProfitDAO profitDao;
	private AchievementDAO achievementDao;
	private CompanyinfoDAO companyinfoDao;

	public TenplayerDAO getTenplayerDao() {
		return tenplayerDao;
	}

	public void setTenplayerDao(TenplayerDAO tenplayerDao) {
		this.tenplayerDao = tenplayerDao;
	}
	
	public NoticeDAO getNoticeDao() {
		return noticeDao;
	}

	public void setNoticeDao(NoticeDAO noticeDao) {
		this.noticeDao = noticeDao;
	}

	public NewsDAO getNewsDao() {
		return newsDao;
	}

	public void setNewsDao(NewsDAO newsDao) {
		this.newsDao = newsDao;
	}

	public ProfitDAO getProfitDao() {
		return profitDao;
	}

	public void setProfitDao(ProfitDAO profitDao) {
		this.profitDao = profitDao;
	}

	public AchievementDAO getAchievementDao() {
		return achievementDao;
	}

	public void setAchievementDao(AchievementDAO achievementDao) {
		this.achievementDao = achievementDao;
	}

	public CompanyinfoDAO getCompanyinfoDao() {
		return companyinfoDao;
	}

	public void setCompanyinfoDao(CompanyinfoDAO companyinfoDao) {
		this.companyinfoDao = companyinfoDao;
	}

	public List getTenPlayers(String stockCode){
		return tenplayerDao.findByStockCode(stockCode);
	}
	
	public List getNotie(){
		return noticeDao.findAll();
	}
	
	public List getNews(String stockCode){
		return newsDao.findByStockCode(stockCode);
	}
	
	public List getProfits(String stockCode){
		return profitDao.findByStockCode(stockCode);
	}
	
	public List getAchievements(String stockCode){
		return achievementDao.findByStockCode(stockCode);
	}
	
	public Object getCompanyInfo(String stockCode){
		return companyinfoDao.findByStockCode(stockCode).get(0);
	}
}
