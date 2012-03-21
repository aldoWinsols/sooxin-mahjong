package com.panda.services;

import java.util.List;

import com.panda.dao.NoticeDAO;

public class NoticeService {
	private NoticeDAO noticeDao;

	public NoticeDAO getNoticeDao() {
		return noticeDao;
	}

	public void setNoticeDao(NoticeDAO noticeDao) {
		this.noticeDao = noticeDao;
	}
	
	public List findAllNotice(){
		return noticeDao.findAll();
	}

}
