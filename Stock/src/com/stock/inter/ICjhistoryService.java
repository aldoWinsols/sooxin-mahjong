package com.stock.inter;

public interface ICjhistoryService {
	public void saveCjhistory(String stockNum, String cjSort, Integer cjNum,
			Double cjPrice, String cjTime);
}
