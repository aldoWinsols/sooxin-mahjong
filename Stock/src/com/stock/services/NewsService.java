package com.stock.services;

import java.util.List;

import com.stock.dao.NewsDAO;
import com.stock.inter.INewsService;

public class NewsService implements INewsService{
	
	private NewsDAO newsDao;

	public NewsDAO getNewsDao() {
		return newsDao;
	}


	public void setNewsDao(NewsDAO newsDao) {
		this.newsDao = newsDao;
	}


	public List getNews() {
		// TODO Auto-generated method stub
		return newsDao.findAll();
	}

}
