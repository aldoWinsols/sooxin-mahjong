package com.stock.inter;

import java.util.List;

public interface IStockInfoService {
	public List getTenPlayers(String stockCode);
	public List getNotie();
	
	public List getNews(String stockCode);
	
	public List getProfits(String stockCode);
	
	public List getAchievements(String stockCode);
	
	public Object getCompanyInfo(String stockCode);
}
